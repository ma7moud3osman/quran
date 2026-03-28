import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
            Text('hijri_offset'.tr(), style: Theme.of(context).textTheme.titleMedium),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: currentOffset > -2
                      ? () => provider.updateHijriOffset(currentOffset - 1)
                      : null,
                ),
                Text(
                  currentOffset.toString(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: currentOffset < 2
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
