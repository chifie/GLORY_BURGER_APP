import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/helpers.dart';
import '../../models/order_model.dart';
import '../../providers/order_provider.dart';
import '../../routes/app_routes.dart';

/// Orders screen displaying the user's order history with status tracking.
/// Each order shows a visual status tracker (Pending → Preparing → On Delivery → Delivered).
class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        title: const Text('My Orders'),
        backgroundColor: AppColors.primaryRed,
        foregroundColor: AppColors.white,
      ),
      body: Consumer<OrderProvider>(
        builder: (context, orderProvider, _) {
          // No orders state
          if (!orderProvider.hasOrders) {
            return _buildEmptyOrders(context);
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: orderProvider.orders.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final order = orderProvider.orders[index];
              return _buildOrderCard(context, order);
            },
          );
        },
      ),
    );
  }

  /// Builds the empty orders placeholder
  Widget _buildEmptyOrders(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.receipt_long_outlined,
            size: 80,
            color: AppColors.lightGrey,
          ),
          const SizedBox(height: 16),
          const Text(
            'No orders yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.darkCharcoal,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Place your first order and it will appear here!',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.mediumGrey,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(AppRoutes.home);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryRed,
                foregroundColor: AppColors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Browse Menu',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a card for a single order with status tracker
  Widget _buildOrderCard(BuildContext context, OrderModel order) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.darkCharcoal.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Order Header ────────────────────────────────────
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primaryRed.withValues(alpha: 0.05),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Order ID
                Expanded(
                  child: Text(
                    order.id,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkCharcoal,
                    ),
                  ),
                ),
                // Status badge
                _buildStatusBadge(order.status),
              ],
            ),
          ),

          // ── Order Details ───────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Order date and items count
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 14,
                      color: AppColors.mediumGrey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _formatDate(order.orderDate),
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.mediumGrey,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Icon(
                      Icons.shopping_bag_outlined,
                      size: 14,
                      color: AppColors.mediumGrey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${order.items.length} item${order.items.length > 1 ? 's' : ''}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.mediumGrey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Items preview (first 3 items)
                ...order.items.take(3).map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        children: [
                          Text(
                            '${item.quantity}×',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.darkCharcoal,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              item.food.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.darkCharcoal,
                              ),
                            ),
                          ),
                          Text(
                            Helpers.formatPrice(item.total),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.darkCharcoal,
                            ),
                          ),
                        ],
                      ),
                    )),

                // "more items" indicator
                if (order.items.length > 3)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      '+ ${order.items.length - 3} more item${order.items.length - 3 > 1 ? 's' : ''}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.primaryRed,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                const SizedBox(height: 16),

                // ── Status Tracker ─────────────────────────────
                _buildStatusTracker(order.status),

                const SizedBox(height: 16),

                // ── Payment & Total ───────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.payment,
                          size: 14,
                          color: AppColors.mediumGrey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          order.paymentMethod,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.mediumGrey,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      Helpers.formatPrice(order.total),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primaryRed,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a colored badge showing the current order status
  Widget _buildStatusBadge(String status) {
    Color badgeColor;
    Color textColor;

    switch (status) {
      case AppConstants.statusPending:
        badgeColor = AppColors.infoBlue.withValues(alpha: 0.1);
        textColor = AppColors.infoBlue;
        break;
      case AppConstants.statusPreparing:
        badgeColor = AppColors.warningOrange.withValues(alpha: 0.1);
        textColor = AppColors.warningOrange;
        break;
      case AppConstants.statusOnDelivery:
        badgeColor = AppColors.accentGold.withValues(alpha: 0.15);
        textColor = AppColors.darkGold;
        break;
      case AppConstants.statusDelivered:
        badgeColor = AppColors.successGreen.withValues(alpha: 0.1);
        textColor = AppColors.successGreen;
        break;
      default:
        badgeColor = AppColors.mediumGrey.withValues(alpha: 0.1);
        textColor = AppColors.mediumGrey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
      ),
    );
  }

  /// Builds a visual step tracker showing order progress
  Widget _buildStatusTracker(String status) {
    final currentStep = Helpers.getOrderStatusIndex(status);
    final steps = [
      AppConstants.statusPending,
      AppConstants.statusPreparing,
      AppConstants.statusOnDelivery,
      AppConstants.statusDelivered,
    ];

    return Row(
      children: List.generate(steps.length, (index) {
        final isCompleted = index <= currentStep;
        final isCurrent = index == currentStep;
        final isLast = index == steps.length - 1;

        return Expanded(
          child: Row(
            children: [
              // Step dot
              Container(
                width: isCurrent ? 28 : 22,
                height: isCurrent ? 28 : 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      isCompleted ? AppColors.primaryRed : AppColors.lightGrey,
                  border: isCurrent
                      ? Border.all(
                          color: AppColors.primaryRed.withValues(alpha: 0.3),
                          width: 3,
                        )
                      : null,
                ),
                child: Center(
                  child: isCompleted && !isCurrent
                      ? const Icon(
                          Icons.check,
                          color: AppColors.white,
                          size: 12,
                        )
                      : isCurrent
                          ? Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.white,
                              ),
                            )
                          : null,
                ),
              ),

              // Connecting line (except for last step)
              if (!isLast)
                Expanded(
                  child: Container(
                    height: 2,
                    color: index < currentStep
                        ? AppColors.primaryRed
                        : AppColors.lightGrey,
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }

  /// Formats a DateTime into a readable string
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
