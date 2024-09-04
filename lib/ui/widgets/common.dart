import 'package:flutter/material.dart';

import 'package:guardian_keyper/consts.dart';
import 'package:guardian_keyper/ui/utils/screen_size.dart';

export 'package:flutter/material.dart';

const paddingAll20 = EdgeInsets.all(20);
const paddingH20 = EdgeInsets.symmetric(horizontal: 20);
const paddingV6 = EdgeInsets.symmetric(vertical: 6);
const paddingV20 = EdgeInsets.symmetric(vertical: 20);
const paddingT12 = EdgeInsets.only(top: 12);
const paddingT20 = EdgeInsets.only(top: 20);
const paddingB12 = EdgeInsets.only(bottom: 12);
const paddingB20 = EdgeInsets.only(bottom: 20);

const styleW600 = TextStyle(fontWeight: FontWeight.w600);

class ScaffoldSafe extends StatelessWidget {
  const ScaffoldSafe({
    this.header,
    this.appBar,
    this.drawer,
    this.child,
    this.children,
    this.bottomNavigationBar,
    this.isSeparated = false,
    this.isSeparatorSmall = false,
    this.minimumPadding = EdgeInsets.zero,
    super.key,
  });

  final PreferredSizeWidget? appBar;
  final Widget? header;
  final Widget? drawer;
  final Widget? child;
  final EdgeInsets minimumPadding;
  final List<Widget>? children;
  final Widget? bottomNavigationBar;
  final bool isSeparatorSmall;
  final bool isSeparated;

  @override
  Widget build(BuildContext context) => ColoredBox(
        color: Theme.of(context).colorScheme.surfaceTint,
        child: SafeArea(
          minimum: minimumPadding,
          child: Scaffold(
            appBar: appBar,
            body: child ??
                (children == null
                    ? null
                    : (isSeparated
                        ? ListView.separated(
                            padding: paddingAll20,
                            itemCount: children!.length,
                            itemBuilder: (_, i) => children![i],
                            separatorBuilder: (_, __) => isSeparatorSmall
                                ? const Padding(padding: paddingT12)
                                : const Padding(padding: paddingT20),
                          )
                        : ListView(
                            padding: paddingAll20,
                            children: children!,
                          ))),
            bottomNavigationBar: bottomNavigationBar,
            resizeToAvoidBottomInset: true,
            primary: true,
            drawer: drawer,
          ),
        ),
      );
}

class PageTitle extends StatelessWidget {
  const PageTitle({
    super.key,
    this.icon,
    this.title,
    this.subtitle,
    this.subtitleSpans,
    this.color,
  });

  final Widget? icon;
  final String? title;
  final String? subtitle;
  final List<TextSpan>? subtitleSpans;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final paddingTop = switch (ScreenSize(context)) {
      ScreenSmall _ => paddingT12,
      ScreenMedium _ => paddingT20,
      _ => const EdgeInsets.only(top: 32),
    };
    final theme = Theme.of(context);
    final textColor = color ?? theme.colorScheme.onSurface;
    return Padding(
      padding: paddingH20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon
          if (icon != null)
            Padding(
              padding: paddingTop,
              child: icon,
            ),
          // Title
          if (title != null)
            Padding(
              padding: paddingTop,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: title,
                  style: theme.textTheme.titleLarge!.copyWith(color: textColor),
                ),
              ),
            ),
          // Subtitle
          if (subtitle != null || subtitleSpans != null)
            Padding(
              padding: paddingT20,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: subtitle,
                  children: subtitleSpans,
                  style: TextStyle(
                    height: 1.5,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: textColor,
                  ),
                ),
              ),
            ),
          Padding(padding: paddingTop),
        ],
      ),
    );
  }
}

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({
    super.key,
    this.icon,
    this.titleString,
    this.textString,
    this.textSpan,
    this.body,
    this.footer,
  });

  final Widget? icon;
  final String? titleString;
  final String? textString;
  final List<TextSpan>? textSpan;
  final Widget? body;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: paddingAll20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Icon
          if (icon != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: icon,
            ),
          // Title
          if (titleString != null)
            Padding(
              padding: paddingB12,
              child: Text(
                titleString!,
                style: textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
          // Text
          if (textString != null || textSpan != null)
            Padding(
              padding: paddingB12,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: textTheme.bodyMedium,
                  text: textString,
                  children: textSpan,
                ),
              ),
            ),
          // Body
          if (body != null) Padding(padding: paddingT20, child: body),
          // Footer
          if (footer != null) Padding(padding: paddingT20, child: footer),
          const Padding(padding: paddingB20),
        ],
      ),
    );
  }
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
  BuildContext context, {
  String? text,
  List<TextSpan>? textSpans,
  Duration duration = snackBarDuration,
  bool isFloating = false,
  bool isError = false,
}) {
  final theme = Theme.of(context);
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: duration,
    behavior: isFloating ? SnackBarBehavior.floating : null,
    margin: paddingAll20,
    backgroundColor:
        isError ? theme.colorScheme.error : theme.snackBarTheme.backgroundColor,
    content: RichText(
      text: TextSpan(
        text: text,
        children: textSpans,
        style: isError
            ? theme.snackBarTheme.contentTextStyle!.copyWith(
                color: theme.colorScheme.onError,
              )
            : theme.snackBarTheme.contentTextStyle,
      ),
    ),
  ));
}
