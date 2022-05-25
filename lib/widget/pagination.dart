import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:legalis/theme.dart';
import 'package:legalis/widget/action_icon.dart';

class Pagination extends StatefulWidget {
  final Function(int) onPageChange;
  final int totalResults;
  final int pageSize;
  final int currentPage;

  const Pagination(
      {required this.totalResults,
      required this.pageSize,
      required this.onPageChange,
      required this.currentPage,
      Key? key})
      : super(key: key);

  @override
  State<Pagination> createState() => _PaginationState();
}

class _PaginationState extends State<Pagination> {
  final height = 42;

  int get totalPages => widget.totalResults ~/ widget.pageSize;
  int get currentPage => widget.currentPage;

  void _onPageChange(int page) => widget.onPageChange(page);

  void _onNext() {
    if (currentPage != totalPages) {
      _onPageChange(currentPage + 1);
    }
  }

  void _onPrev() {
    if (currentPage != 1) {
      _onPageChange(currentPage - 1);
    }
  }

  void _setCurrent(page) {
    _onPageChange(page);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Container(
        //margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
        padding: const EdgeInsets.only(left: 8, right: 8),
        width: MediaQuery.of(context).size.width,
        height: height.toDouble(),
        decoration: BoxDecoration(
            color: HexColor("#ffffff"),
            borderRadius: BorderRadius.circular(32)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ActionIcon(
              icon: Icons.keyboard_double_arrow_left_rounded,
              onClick: _onPrev,
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(6),
                itemCount: totalPages,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return PaginationButton(
                      page: index + 1,
                      isActive: currentPage == index + 1,
                      onTap: _setCurrent);
                },
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            ActionIcon(
              icon: Icons.keyboard_double_arrow_right_rounded,
              onClick: _onNext,
            )
          ],
        ),
      ),
    );
  }
}

class PaginationButton extends StatelessWidget {
  final bool isActive;
  final int page;
  final Function(int) onTap;

  const PaginationButton(
      {required this.page,
      required this.isActive,
      required this.onTap,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      margin: const EdgeInsets.only(left: 4, right: 4),
      child: Material(
        child: Ink(
          decoration: BoxDecoration(
              color: isActive
                  ? AppTheme.accent.withOpacity(.15)
                  : AppTheme.accent.withOpacity(.01),
              borderRadius: BorderRadius.circular(4)),
          child: InkWell(
            onTap: () => onTap(page),
            child: Center(
              child: Text(page.toString(),
                  style: TextStyle(color: AppTheme.accent)),
            ),
          ),
        ),
      ),
    );
  }
}
