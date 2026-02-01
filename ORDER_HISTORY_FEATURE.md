## 📋 ORDER HISTORY FEATURE

### Overview
Fitur Order History memungkinkan user untuk melihat semua order yang pernah dibuat, dengan detail lengkap tentang item, harga, diskon, dan status pengiriman.

### 🎯 Features

#### 1. **Order History Page** (`lib/pages/order_history_page.dart`)
- ✅ Halaman dedicated untuk melihat semua order
- ✅ Tampilan order list dengan status tracking
- ✅ Expandable order cards untuk detail lengkap
- ✅ Empty state dengan CTA "Continue Shopping"

#### 2. **Order Card Features**
- **Status Badge**: Color-coded status (Pending, Processing, Shipped, Delivered, Cancelled)
- **Quick Summary**: Jumlah item dan total price
- **Expandable Details**:
  - List semua item dalam order
  - Subtotal & Discount calculation
  - Total price
  - Download Invoice button
  - Reorder button

#### 3. **Status Colors**
| Status | Color |
|--------|-------|
| Pending | Orange |
| Processing | Blue |
| Shipped | Purple |
| Delivered | Green |
| Cancelled | Red |

#### 4. **Integration Points**

**Checkout Flow**:
```dart
// 1. User places order at CheckoutPage
final order = Order(...);
context.read<OrderHistoryCubit>().addOrder(order);

// 2. Order ditambahkan ke history
// 3. Cart di-clear
context.read<CartCubit>().clearCart();
```

**Profile Menu**:
```dart
_MenuItem(
  icon: Icons.history,
  title: "Order History",
  subtitle: "View past orders & receipts",
  onTap: () {
    Navigator.pushNamed(context, AppRoutes.orderHistory);
  },
)
```

### 📁 Files Structure

```
lib/
├── pages/
│   ├── order_history_page.dart (NEW)
│   ├── checkout_page.dart (UPDATED - integrates with OrderHistoryCubit)
│   └── profile_page.dart (UPDATED - navigation)
├── blocs/
│   └── order_history_cubit.dart (EXISTING)
├── models/
│   └── order_model.dart (EXISTING)
└── core/
    └── app_routes.dart (UPDATED - added orderHistory route)
```

### 🔧 OrderHistoryCubit Methods

```dart
// Add new order
void addOrder(Order order)

// Update order status
void updateOrderStatus(String orderId, String newStatus)

// Clear all orders
void clearOrderHistory()
```

### 📊 Order Data Structure

```dart
Order(
  id: 'ORD-1704067200000',           // Auto-generated with timestamp
  items: [OrderItem(...), ...],       // List of items
  totalPrice: 53000000,              // Final price after discount
  orderDate: DateTime.now(),         // Order creation time
  status: 'Pending',                 // Pending|Processing|Shipped|Delivered|Cancelled
)

OrderItem(
  guitar: Guitar(...),               // Guitar object
  qty: 2,                            // Quantity
)
```

### 🎨 UI Components

#### OrderCard
- Expandable with animation
- Status indicator with color coding
- Items count & total price
- Order date & time
- Expand/collapse icon

#### _SummaryItem
- Icon + label + value
- Used in order cards header

#### _OrderItemTile
- Guitar name & brand
- Quantity
- Discounted price

#### _OrderDetailRow
- Label-value pair
- Supports total styling
- Custom value colors

### 🚀 Usage Flow

1. **After Successful Checkout**
   ```
   CheckoutPage → Place Order → OrderHistoryCubit.addOrder()
   ```

2. **View Order History**
   ```
   ProfilePage (Menu) → Order History (MenuItem) 
   → OrderHistoryPage → Display all orders
   ```

3. **Expand Order Details**
   ```
   OrderCard (Tap) → Expands to show:
   - All items
   - Subtotal
   - Discount saved
   - Total price
   - Action buttons
   ```

### 🔮 Future Enhancements

- [ ] Real database integration (Firebase/SQL)
- [ ] Push notifications on status change
- [ ] Order tracking with map
- [ ] Actual invoice PDF download
- [ ] Real reorder functionality (add to cart)
- [ ] Contact seller/customer support chat
- [ ] Order filters (by date, status)
- [ ] Order search
- [ ] Cancel order option
- [ ] Return/refund management

### ✅ Testing Checklist

- [ ] Order created successfully at checkout
- [ ] Order appears in order history
- [ ] Order card expands/collapses smoothly
- [ ] All order details display correctly
- [ ] Status badge shows correct color
- [ ] Empty state displays when no orders
- [ ] Navigate from profile menu works
- [ ] Invoice button triggers action
- [ ] Reorder button triggers action

### 📝 Notes

- Order ID auto-generated: `ORD-{timestamp}`
- Order status initially set to 'Pending'
- Cart cleared after successful order
- All prices formatted with Rupiah currency
- Discount calculation per-item basis
