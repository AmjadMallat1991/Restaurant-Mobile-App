import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mongodb_app/constant/colors.dart';
import 'package:mongodb_app/provider/app_provider.dart';
import 'package:mongodb_app/screens/orders/oreder_item_description_screen.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with SingleTickerProviderStateMixin {
  bool loading = false;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
    getOrders('complete'); // Load initial tab orders
  }

  Future<void> getOrders(String status) async {
    final appProvider = Provider.of<AppProvider>(context, listen: false);

    setState(() {
      loading = true;
    });

    await appProvider.getOrders(status: status);

    setState(() {
      loading = false;
    });
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      // Prevent multiple API calls when the user quickly changes tabs
      return;
    }

    setState(() {
      loading = true;
    });

    switch (_tabController.index) {
      case 0:
        getOrders('complete');
        break;
      case 1:
        getOrders('processing');
        break;
      case 2:
        getOrders('trash');
        break;
    }

    setState(() {
      loading = false;
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        scrolledUnderElevation: 0,
        elevation: 0,
        title: const Text(
          "My Orders",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white,
                  indicator: const BubbleTabIndicator(
                    indicatorHeight: 35.0,
                    indicatorColor: mainYellow,
                    tabBarIndicatorSize: TabBarIndicatorSize.tab,
                  ),
                  indicatorColor: Colors.transparent,
                  tabs: const [
                    Tab(
                      text: 'Completed',
                    ),
                    Tab(
                      text: 'Processing',
                    ),
                    Tab(
                      text: 'Cancelled',
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 12,
              child: loading
                  ? const Center(
                      child: SpinKitPulse(
                        color: Colors.white,
                      ),
                    )
                  : TabBarView(
                      controller: _tabController,
                      children: [
                        _buildOrderList(appProvider, 'complete'),
                        _buildOrderList(appProvider, 'processing'),
                        _buildOrderList(appProvider, 'trash'),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderList(AppProvider appProvider, String status) {
    if (loading) {
      return const Center(
        child: SpinKitPulse(
          color: Colors.white,
        ),
      );
    }

    if (appProvider.orderList.isEmpty) {
      return _buildEmptyOrdersMessage(status);
    }

    return ListView.separated(
        physics: const ClampingScrollPhysics(),
        itemCount: appProvider.orderList.length,
        separatorBuilder: (final context, final index) => const SizedBox(
              height: 10,
            ),
        itemBuilder: (final context, final index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderItemDescriptionScreen(
                      orderItem: appProvider.orderList[index]),
                ),
              );
            },
            child: Container(
              width: double.maxFinite,
              margin: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 5,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color.fromARGB(255, 238, 238, 238),
                  width: 0.7,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "Order № ${appProvider.orderList[index].orderId}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          appProvider.orderList[index].date,
                          maxLines: 1,
                          textAlign: TextAlign.end,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name: ",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey[200],
                        ),
                      ),
                      Flexible(
                        child: Text(
                          appProvider.orderList[index].fullName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email: ",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey[200],
                        ),
                      ),
                      Flexible(
                        child: Text(
                          appProvider.orderList[index].email,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Quantity: ",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                color: Colors.grey[200],
                              ),
                            ),
                            Flexible(
                              child: Text(
                                appProvider.orderList[index].items.length
                                    .toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Total Amount: ",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                color: Colors.grey[200],
                              ),
                            ),
                            Flexible(
                              child: Text(
                                appProvider.orderList[index].total,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _buildEmptyOrdersMessage(String status) {
    String message;
    if (status == 'complete') {
      message = 'You have no completed orders yet.';
    } else if (status == 'processing') {
      message = 'You have no processing orders yet.';
    } else {
      message = 'You have no trashed orders yet.';
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/empty_cart.png',
          width: 150,
          height: 150,
        ),
        const SizedBox(
          height: 4,
        ),
        Center(
          child: Column(
            children: [
              const Text(
                'You don\'t have any orders yet',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    message,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(10, 10),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Start Shopping!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BubbleTabIndicator extends Decoration {
  final double indicatorHeight;
  final Color indicatorColor;
  final double indicatorRadius;
  @override
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry insets;
  final TabBarIndicatorSize tabBarIndicatorSize;

  const BubbleTabIndicator({
    this.indicatorHeight = 20.0,
    this.indicatorColor = Colors.transparent,
    this.indicatorRadius = 100.0,
    this.tabBarIndicatorSize = TabBarIndicatorSize.label,
    this.padding = const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
    this.insets = const EdgeInsets.symmetric(horizontal: 5.0),
  });

  @override
  Decoration? lerpFrom(final Decoration? a, final double t) {
    if (a is BubbleTabIndicator) {
      return BubbleTabIndicator(
        padding: EdgeInsetsGeometry.lerp(a.padding, padding, t)!,
        insets: EdgeInsetsGeometry.lerp(a.insets, insets, t)!,
      );
    }

    return super.lerpFrom(a, t);
  }

  @override
  Decoration? lerpTo(final Decoration? b, final double t) {
    if (b is BubbleTabIndicator) {
      return BubbleTabIndicator(
        padding: EdgeInsetsGeometry.lerp(padding, b.padding, t)!,
        insets: EdgeInsetsGeometry.lerp(insets, b.insets, t)!,
      );
    }

    return super.lerpTo(b, t);
  }

  @override
  BubblePainter createBoxPainter([final VoidCallback? onChanged]) =>
      BubblePainter(this, onChanged);
}

class BubblePainter extends BoxPainter {
  BubblePainter(this.decoration, final VoidCallback? onChanged)
      : super(onChanged);

  final BubbleTabIndicator decoration;

  double get indicatorHeight => decoration.indicatorHeight;

  Color get indicatorColor => decoration.indicatorColor;

  double get indicatorRadius => decoration.indicatorRadius;

  EdgeInsetsGeometry get padding => decoration.padding;

  EdgeInsetsGeometry get insets => decoration.insets;

  TabBarIndicatorSize get tabBarIndicatorSize => decoration.tabBarIndicatorSize;

  Rect _indicatorRectFor(final Rect rect, final TextDirection textDirection) {
    var indicator = padding.resolve(textDirection).inflateRect(rect);

    if (tabBarIndicatorSize == TabBarIndicatorSize.tab) {
      indicator = insets.resolve(textDirection).deflateRect(rect);
    }

    return Rect.fromLTWH(
      indicator.left,
      indicator.top,
      indicator.width,
      indicator.height,
    );
  }

  @override
  void paint(
    final Canvas canvas,
    final Offset offset,
    final ImageConfiguration configuration,
  ) {
    assert(configuration.size != null);
    final rect = Offset(
          offset.dx,
          (configuration.size!.height / 2) - indicatorHeight / 2,
        ) &
        Size(configuration.size!.width, indicatorHeight);
    final textDirection = configuration.textDirection!;
    final indicator = _indicatorRectFor(rect, textDirection);
    final paint = Paint();
    paint.color = indicatorColor;
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(indicator, Radius.circular(indicatorRadius)),
      paint,
    );
  }
}
