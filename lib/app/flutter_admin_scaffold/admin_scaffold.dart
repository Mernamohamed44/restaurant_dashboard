import 'package:flutter/material.dart';
import 'package:restaurant_dashboard/app/flutter_admin_scaffold/side_bar.dart';
import 'package:restaurant_dashboard/app/utils/colors.dart';

class AdminScaffold extends StatefulWidget {
  const AdminScaffold({
    super.key,
    this.appBar,
    this.sideBar,
    required this.body,
    this.backgroundColor,
    this.mobileThreshold = 377,
  });

  final AppBar? appBar;
  final SideBar? sideBar;
  final Widget body;
  final Color? backgroundColor;
  final double mobileThreshold;

  @override
  AdminScaffoldState createState() => AdminScaffoldState();
}

class AdminScaffoldState extends State<AdminScaffold>
    with SingleTickerProviderStateMixin {
  late AppBar? _appBar;
  late AnimationController animationController;
  late Animation _animation;
  bool _isMobile = false;
  bool _isOpenSidebar = false;
  bool _canDragged = false;
  double _screenWidth = 0;

  @override
  void initState() {
    super.initState();
    _appBar = _buildAppBar(widget.appBar, widget.sideBar);
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOutQuad,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final mediaQuery = MediaQuery.of(context);
    if (_screenWidth == mediaQuery.size.width) {
      return;
    }

    setState(() {
      _isMobile = mediaQuery.size.width < widget.mobileThreshold;
      _isOpenSidebar = !_isMobile;
      animationController.value = _isMobile ? 0 : 1;
      _screenWidth = mediaQuery.size.width;
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void toggleSidebar() {
    setState(() {
      _isOpenSidebar = !_isOpenSidebar;
      if (_isOpenSidebar) {
        animationController.forward();
      } else {
        animationController.reverse();
      }
    });
  }

  void _onDragStart(DragStartDetails details) {
    final isClosed = animationController.isDismissed;
    final isOpen = animationController.isCompleted;
    _canDragged = (isClosed && details.globalPosition.dx < 60) || isOpen;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canDragged) {
      final delta =
          (details.primaryDelta ?? 0.0) / (widget.sideBar?.width ?? 1.0);
      animationController.value += delta;
    }
  }

  void _dragCloseDrawer(DragUpdateDetails details) {
    final delta = details.primaryDelta ?? 0.0;
    if (delta < 0) {
      _isOpenSidebar = false;
      animationController.reverse();
    }
  }

  void _onDragEnd(DragEndDetails details) async {
    const minFlingVelocity = 365.0;

    if (details.velocity.pixelsPerSecond.dx.abs() >= minFlingVelocity) {
      final visualVelocity =
          details.velocity.pixelsPerSecond.dx / (widget.sideBar?.width ?? 1.0);

      await animationController.fling(velocity: visualVelocity);
      if (animationController.isCompleted) {
        setState(() {
          _isOpenSidebar = true;
        });
      } else {
        setState(() {
          _isOpenSidebar = false;
        });
      }
    } else {
      if (animationController.value < 0.5) {
        animationController.reverse();
        setState(() {
          _isOpenSidebar = false;
        });
      } else {
        animationController.forward();
        setState(() {
          _isOpenSidebar = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: _appBar,
      body: AnimatedBuilder(
        animation: _animation,
        builder: (_, __) => widget.sideBar == null
            ? Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: widget.body,
                    ),
                  ),
                ],
              )
            : _isMobile
                ? Stack(
                    children: [
                      GestureDetector(
                        onHorizontalDragStart: _onDragStart,
                        onHorizontalDragUpdate: _onDragUpdate,
                        onHorizontalDragEnd: _onDragEnd,
                      ),
                      widget.body,
                      if (_animation.value > 0)
                        Container(
                          color: Colors.black
                              .withAlpha((150 * _animation.value).toInt()),
                        ),
                      if (_animation.value == 1)
                        GestureDetector(
                          onTap: toggleSidebar,
                          onHorizontalDragUpdate: _dragCloseDrawer,
                        ),
                      ClipRect(
                        child: SizedOverflowBox(
                          size: Size(
                              (widget.sideBar?.width ?? 1.0) * _animation.value,
                              double.infinity),
                          child: widget.sideBar,
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      widget.sideBar != null
                          ? ClipRect(
                              child: SizedOverflowBox(
                                size: Size(
                                    (widget.sideBar?.width ?? 1.0) *
                                        _animation.value,
                                    double.infinity),
                                child: widget.sideBar,
                              ),
                            )
                          : const SizedBox(),
                      Expanded(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: widget.body,
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }

  AppBar? _buildAppBar(AppBar? appBar, SideBar? sideBar) {
    if (appBar == null) {
      return null;
    }

    final leading = sideBar != null
        ? IconButton(
            icon: const Icon(Icons.menu, size: 20),
            color: AppColors.textColor,
            onPressed: toggleSidebar,
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
          )
        : appBar.leading;
    final shadowColor = appBar.shadowColor ?? Colors.transparent;

    return AppBar(
      leading: leading,
      automaticallyImplyLeading: appBar.automaticallyImplyLeading,
      title: appBar.title,
      actions: appBar.actions,
      flexibleSpace: appBar.flexibleSpace,
      bottom: appBar.bottom,
      elevation: appBar.elevation,
      scrolledUnderElevation: appBar.scrolledUnderElevation,
      notificationPredicate: appBar.notificationPredicate,
      shadowColor: shadowColor,
      surfaceTintColor: appBar.surfaceTintColor,
      shape: appBar.shape,
      backgroundColor: appBar.backgroundColor,
      foregroundColor: appBar.foregroundColor,
      iconTheme: appBar.iconTheme,
      actionsIconTheme: appBar.actionsIconTheme,
      primary: appBar.primary,
      centerTitle: appBar.centerTitle ?? false,
      excludeHeaderSemantics: appBar.excludeHeaderSemantics,
      titleSpacing: appBar.titleSpacing,
      toolbarOpacity: appBar.toolbarOpacity,
      bottomOpacity: appBar.bottomOpacity,
      toolbarHeight: appBar.toolbarHeight,
      leadingWidth: appBar.leadingWidth,
      toolbarTextStyle: appBar.toolbarTextStyle,
      titleTextStyle: appBar.titleTextStyle,
      systemOverlayStyle: appBar.systemOverlayStyle,
    );
  }
}
