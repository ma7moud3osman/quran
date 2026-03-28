import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jhijri/jhijri.dart';
import '../../../../core/utils/enums.dart';
import '../providers/onboarding_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/extension/go_router_extension.dart';
import '../../../../core/routes/routes_name.dart';
import '../../../../core/widgets/custom_button.dart';

class OptionalSettingsScreen extends StatelessWidget {
  const OptionalSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OnboardingProvider>();
    final currentMadhab = provider.settings.madhab;
    final currentOffset = provider.settings.hijriOffset;

    // Calculate current Hijri date with offset
    final now = DateTime.now();
    final adjustedDate = now.add(Duration(days: currentOffset));
    final hijriDate = JHijri(fDate: adjustedDate);
    final hijriString =
        '${hijriDate.day} ${hijriDate.monthName} ${hijriDate.year}';

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            Text(
              'optional_settings_title'.tr(),
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Text('madhab'.tr(), style: Theme.of(context).textTheme.titleMedium),
            RadioListTile<MadhabEnum>(
              title: Text('madhab_shafii'.tr()),
              value: MadhabEnum.shafii,
              groupValue: currentMadhab,
              onChanged: (val) {
                if (val != null) provider.updateMadhab(val);
              },
            ),
            RadioListTile<MadhabEnum>(
              title: Text('madhab_hanafi'.tr()),
              value: MadhabEnum.hanafi,
              groupValue: currentMadhab,
              onChanged: (val) {
                if (val != null) provider.updateMadhab(val);
              },
            ),
            const SizedBox(height: 24),
            Text(
              'hijri_offset'.tr(),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    hijriString,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    DateFormat.yMMMMd(context.locale.toString()).format(now),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  iconSize: 32,
                  color: Theme.of(context).primaryColor,
                  onPressed: currentOffset > -3
                      ? () => provider.updateHijriOffset(currentOffset - 1)
                      : null,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    currentOffset >= 0 ? '+$currentOffset' : '$currentOffset',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  iconSize: 32,
                  color: Theme.of(context).primaryColor,
                  onPressed: currentOffset < 3
                      ? () => provider.updateHijriOffset(currentOffset + 1)
                      : null,
                ),
              ],
            ),
            const Spacer(),
            CustomButton(
              label: 'finish'.tr(),
              onPressed: () async {
                await provider.saveAndComplete();
                if (context.mounted) {
                  context.goToNamed(AppRoutes.quranIndex);
                }
              },
              isLoading: provider.status == LoadStatus.loading,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
