# Test Navbar Admin

## Langkah Testing:

1. **Buka aplikasi** di browser
2. **Login sebagai admin:**
   - Email: `admin@guitarestore.com`
   - Password: `password123`

3. **Yang harus muncul setelah login admin:**
   - ✅ Bottom navbar dengan 2 tab: "Dashboard" dan "Profile"
   - ✅ Tab aktif berwarna putih, non-aktif abu-abu
   - ✅ Label text muncul di bawah icon
   - ✅ Admin Page sebagai halaman pertama

4. **Saat klik tab "Profile":**
   - ✅ Nama: "Administrator"
   - ✅ Email: admin@guitarestore.com
   - ✅ Badge orange: "👑 Admin Account"

## Kode yang sudah diperbaiki:

### MainNavigation (main_navigation.dart):
```dart
// Admin navbar dengan 2 items
navItems = const [
  BottomNavigationBarItem(
    icon: Icon(Icons.dashboard_rounded),
    label: "Dashboard",
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.person_rounded),
    label: "Profile",
  ),
];

// Labels ditampilkan
showSelectedLabels: true,
showUnselectedLabels: true,
```

### ProfilePage (profile_page.dart):
```dart
// Deteksi admin
Text(
  authState.role == 'admin' ? 'Administrator' : 'Guitar Enthusiast',
  ...
),
Text(
  authState.email, // Email dari state
  ...
),
Container(
  color: authState.role == 'admin' ? Colors.orange : Colors.green,
  child: Text(
    authState.role == 'admin' ? '👑 Admin Account' : '✓ Verified Member',
    ...
  ),
)
```

## Troubleshooting:

Jika navbar tidak muncul:
1. Hot restart (tekan R di terminal)
2. Clear cache: `flutter clean` lalu `flutter run`
3. Check console log untuk: `🔐 MainNavigation - User logged in as: admin`
