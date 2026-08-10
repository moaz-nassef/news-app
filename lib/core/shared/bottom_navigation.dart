import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/features/home/views/home_view.dart';

import '../../features/category/views/category_selection_view.dart';
import '../../features/home/views/favorite_news.dart';
import '../themes/my_theme.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key, this.currentIndex = 0});

  /// Which tab is currently active: 0 home, 1 categories, 2 explore, 3 favorites.
  final int currentIndex;

  void _goHome(BuildContext context) {
    // Replace the whole stack so returning home always shows fresh news.
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const HomeView()),
      (route) => false,
    );
  }

  void _goCategories(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CategorySelectionView()),
    );
  }

  void _goFavorites(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FavoriteNews()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: [
              _NavItem(
                icon: CupertinoIcons.house_fill,
                label: 'Home',
                selected: currentIndex == 0,
                onTap: () => _goHome(context),
              ),
              _NavItem(
                icon: CupertinoIcons.square_grid_2x2_fill,
                label: 'Categories',
                selected: currentIndex == 1,
                onTap: () => _goCategories(context),
              ),
              _NavItem(
                icon: CupertinoIcons.globe,
                label: 'Explore',
                selected: currentIndex == 2,
                onTap: () => _goHome(context),
              ),
              _NavItem(
                icon: CupertinoIcons.heart_fill,
                label: 'Favorites',
                selected: currentIndex == 3,
                onTap: () => _goFavorites(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    const inactiveColor = Color(0xFF9CA3AF);

    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutBack,
              width: 46,
              height: 30,
              decoration: BoxDecoration(
                gradient: selected
                    ? MyTheme.brandGradient
                    : const LinearGradient(
                        colors: [Colors.white, Colors.white],
                      ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: AnimatedScale(
                scale: selected ? 1 : 0.88,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutBack,
                child: Icon(
                  icon,
                  size: 19,
                  color: selected ? Colors.white : inactiveColor,
                ),
              ),
            ),
            const SizedBox(height: 3),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                color: selected ? MyTheme.primary : inactiveColor,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}