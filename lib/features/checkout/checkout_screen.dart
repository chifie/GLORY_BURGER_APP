import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/helpers.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_field.dart';
import '../../providers/cart_provider.dart';
import '../../providers/order_provider.dart';
import '../../routes/app_routes.dart';

/// Checkout screen for collecting customer details and confirming orders.
/// Validates inputs and places the order via OrderProvider.
class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  String _selectedPaymentMethod = 'M-Pesa';
  bool _isPlacing = false;

  static const _paymentMethods = [
    {
      'name': 'M-Pesa',
      'icon': Icons.phone_android,
      'color': Color(0xFF4CAF50),
      'subtitle': 'Pay via M-Pesa mobile money',
    },
    {
      'name': 'HaloPesa',
      'icon': Icons.account_balance_wallet,
      'color': Color(0xFF1565C0),
      'subtitle': 'Pay via HaloPesa mobile wallet',
    },
    {
      'name': 'Mix by Yas',
      'icon': Icons.swap_horiz,
      'color': Color(0xFFE91E63),
      'subtitle': 'Pay via Mix by Yas',
    },
    {
      'name': 'Airtel Money',
      'icon': Icons.sim_card,
      'color': Color(0xFFFF1744),
      'subtitle': 'Pay via Airtel Money',
    },
    {
      'name': 'Cash on Delivery',
      'icon': Icons.money,
      'color': Color(0xFFFF9800),
      'subtitle': 'Pay when you receive your order',
    },
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: AppColors.primaryRed,
        foregroundColor: AppColors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Delivery Information ─────────────────────
                    const Text(
                      'Delivery Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.darkCharcoal,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Customer name
                    CustomTextField(
                      label: 'Full Name',
                      hint: 'Enter your full name',
                      controller: _nameController,
                      prefixIcon: const Icon(Icons.person_outline, size: 20),
                      validator: (value) {
                        if (value == null || !Helpers.isValidName(value)) {
                          return 'Please enter a valid name (at least ${AppConstants.minNameLength} characters)';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Phone number
                    CustomTextField(
                      label: 'Phone Number',
                      hint: 'e.g. 0712 345 678',
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      prefixIcon: const Icon(Icons.phone_outlined, size: 20),
                      validator: (value) {
                        if (value == null || !Helpers.isValidPhone(value)) {
                          return 'Please enter a valid phone number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Delivery address
                    CustomTextField(
                      label: 'Delivery Address',
                      hint: 'Enter your delivery address',
                      controller: _addressController,
                      maxLines: 2,
                      prefixIcon:
                          const Icon(Icons.location_on_outlined, size: 20),
                      validator: (value) {
                        if (value == null || !Helpers.isValidAddress(value)) {
                          return 'Please enter a valid address (at least ${AppConstants.minAddressLength} characters)';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    // ── Payment Method ──────────────────────────
                    const Text(
                      'Payment Method',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.darkCharcoal,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: _paymentMethods.map((method) {
                          final isSelected =
                              _selectedPaymentMethod == method['name'];
                          return InkWell(
                            onTap: () {
                              setState(() {
                                _selectedPaymentMethod =
                                    method['name'] as String;
                              });
                            },
                            borderRadius: BorderRadius.circular(14),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 10),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? (method['color'] as Color)
                                        .withValues(alpha: 0.06)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                                border: isSelected
                                    ? Border.all(
                                        color: (method['color'] as Color)
                                            .withValues(alpha: 0.3),
                                        width: 1.5,
                                      )
                                    : null,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: (method['color'] as Color)
                                          .withValues(alpha: 0.12),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Icon(
                                      method['icon'] as IconData,
                                      color: method['color'] as Color,
                                      size: 18,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          method['name'] as String,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.darkCharcoal,
                                          ),
                                        ),
                                        Text(
                                          method['subtitle'] as String,
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: AppColors.mediumGrey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (isSelected)
                                    Container(
                                      width: 22,
                                      height: 22,
                                      decoration: BoxDecoration(
                                        color: method['color'] as Color,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.check,
                                        color: AppColors.white,
                                        size: 14,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ── Order Summary ────────────────────────────
                    const Text(
                      'Order Summary',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.darkCharcoal,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // List of items in the order
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cartProvider.cartItems.length,
                        separatorBuilder: (_, __) => const Divider(
                          height: 1,
                          indent: 16,
                          endIndent: 16,
                        ),
                        itemBuilder: (context, index) {
                          final item = cartProvider.cartItems[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            child: Row(
                              children: [
                                // Item icon
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: AppColors.offWhite,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      _getCategoryIcon(item.food.category),
                                      size: 20,
                                      color: AppColors.primaryRed,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),

                                // Item name and quantity
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.food.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.darkCharcoal,
                                        ),
                                      ),
                                      Text(
                                        '${item.quantity}× ${item.food.price.toInt()} TZS',
                                        style: const TextStyle(
                                          fontSize: 11,
                                          color: AppColors.mediumGrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Line total
                                Text(
                                  Helpers.formatPrice(item.total),
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.darkCharcoal,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Price breakdown
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          _buildPriceRow(
                            'Subtotal',
                            Helpers.formatPrice(cartProvider.subtotal),
                          ),
                          const SizedBox(height: 8),
                          _buildPriceRow(
                            'Delivery Fee',
                            cartProvider.deliveryFee == 0
                                ? 'FREE'
                                : Helpers.formatPrice(cartProvider.deliveryFee),
                            valueColor: cartProvider.deliveryFee == 0
                                ? AppColors.successGreen
                                : null,
                          ),
                          const Divider(height: 24),
                          _buildPriceRow(
                            'Total',
                            Helpers.formatPrice(cartProvider.total),
                            isBold: true,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Free delivery message
                    if (cartProvider.deliveryFee > 0)
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.accentGold.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.accentGold.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.info_outline,
                              color: AppColors.accentGold,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Add ${Helpers.formatPrice(AppConstants.freeDeliveryThreshold - cartProvider.subtotal)} more for FREE delivery!',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.darkCharcoal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),

          // ── Place Order Button ─────────────────────────────────
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.darkCharcoal,
                  blurRadius: 8,
                  offset: Offset(0, -4),
                ),
              ],
            ),
            child: SafeArea(
              child: CustomButton(
                label: 'Place Order',
                icon: Icons.check_circle,
                isLoading: _isPlacing,
                onPressed: () => _placeOrder(context, cartProvider),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a row in the price breakdown
  Widget _buildPriceRow(String label, String value,
      {Color? valueColor, bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isBold ? 16 : 14,
            fontWeight: isBold ? FontWeight.w800 : FontWeight.w400,
            color: isBold ? AppColors.darkCharcoal : AppColors.mediumGrey,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isBold ? 18 : 14,
            fontWeight: isBold ? FontWeight.w900 : FontWeight.w600,
            color: valueColor ??
                (isBold ? AppColors.primaryRed : AppColors.darkCharcoal),
          ),
        ),
      ],
    );
  }

  /// Validates the form and places the order
  Future<void> _placeOrder(
      BuildContext context, CartProvider cartProvider) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isPlacing = true);

    // Simulate a short processing delay
    await Future.delayed(const Duration(seconds: 1));

    if (!context.mounted) return;

    final orderProvider = context.read<OrderProvider>();
    final orderId = orderProvider.placeOrder(
      cartItems: cartProvider.cartItems,
      subtotal: cartProvider.subtotal,
      deliveryFee: cartProvider.deliveryFee,
      total: cartProvider.total,
      customerName: _nameController.text.trim(),
      phone: _phoneController.text.trim(),
      address: _addressController.text.trim(),
      paymentMethod: _selectedPaymentMethod,
    );

    // Clear the cart after successful order
    cartProvider.clearCart();

    setState(() => _isPlacing = false);

    if (!context.mounted) return;

    // Show success dialog
    _showOrderSuccessDialog(context, orderId);
  }

  /// Shows a success dialog after order placement
  void _showOrderSuccessDialog(BuildContext context, String orderId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Success icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.successGreen.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle,
                color: AppColors.successGreen,
                size: 50,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Order Placed!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AppColors.darkCharcoal,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Order ID: $orderId',
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.primaryRed,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Your order is being prepared. Track it in the Orders section.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: AppColors.mediumGrey,
              ),
            ),
          ],
        ),
        actions: [
          CustomButton(
            label: 'Track Order',
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pushReplacementNamed(AppRoutes.home);
              // Navigate to orders tab
            },
          ),
        ],
      ),
    );
  }

  /// Returns an icon for each food category
  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Burgers':
        return Icons.lunch_dining;
      default:
        return Icons.restaurant;
    }
  }
}
