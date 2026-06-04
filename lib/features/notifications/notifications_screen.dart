import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../providers/notification_provider.dart';

/// Screen that displays all in-app notifications.
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: AppColors.primaryRed,
        foregroundColor: AppColors.white,
        actions: [
          Consumer<NotificationProvider>(
            builder: (context, notifProvider, _) {
              if (notifProvider.notifications.isEmpty) {
                return const SizedBox.shrink();
              }
              return IconButton(
                icon: const Icon(Icons.done_all_rounded, size: 22),
                tooltip: 'Mark all as read',
                onPressed: () => notifProvider.markAllAsRead(),
              );
            },
          ),
          Consumer<NotificationProvider>(
            builder: (context, notifProvider, _) {
              if (notifProvider.notifications.isEmpty) {
                return const SizedBox.shrink();
              }
              return IconButton(
                icon: const Icon(Icons.delete_sweep_rounded, size: 22),
                tooltip: 'Clear all',
                onPressed: () => notifProvider.clearAll(),
              );
            },
          ),
        ],
      ),
      body: Consumer<NotificationProvider>(
        builder: (context, notifProvider, _) {
          final notifications = notifProvider.notifications;

          if (notifications.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_none_rounded,
                    size: 80,
                    color: AppColors.mediumGrey.withValues(alpha: 0.4),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No notifications yet',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkCharcoal,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Notifications about your orders and\ncart activity will appear here.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.mediumGrey.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: notifications.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final notification = notifications[index];
              return _buildNotificationTile(
                context,
                notification,
                notifProvider,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildNotificationTile(
    BuildContext context,
    AppNotification notification,
    NotificationProvider provider,
  ) {
    final isUnread = !notification.isRead;

    // Icon & color based on type
    IconData icon;
    Color iconColor;
    switch (notification.type) {
      case NotificationType.order:
        icon = Icons.receipt_long_rounded;
        iconColor = AppColors.infoBlue;
      case NotificationType.cart:
        icon = Icons.shopping_cart_rounded;
        iconColor = AppColors.successGreen;
      case NotificationType.promo:
        icon = Icons.local_offer_rounded;
        iconColor = AppColors.accentGold;
      case NotificationType.info:
        icon = Icons.info_outline_rounded;
        iconColor = AppColors.mediumGrey;
    }

    return GestureDetector(
      onTap: () {
        if (isUnread) {
          provider.markAsRead(notification.id);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isUnread
              ? AppColors.primaryRed.withValues(alpha: 0.04)
              : AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: isUnread
              ? Border.all(
                  color: AppColors.primaryRed.withValues(alpha: 0.1))
              : null,
          boxShadow: [
            BoxShadow(
              color: AppColors.darkCharcoal.withValues(alpha: 0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 12),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notification.title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight:
                                isUnread ? FontWeight.w700 : FontWeight.w600,
                            color: AppColors.darkCharcoal,
                          ),
                        ),
                      ),
                      if (isUnread)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryRed,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification.message,
                    style: TextStyle(
                      fontSize: 13,
                      color: isUnread
                          ? AppColors.darkCharcoal.withValues(alpha: 0.8)
                          : AppColors.mediumGrey,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _formatTimestamp(notification.timestamp),
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.mediumGrey.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final diff = now.difference(timestamp);

    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
  }
}