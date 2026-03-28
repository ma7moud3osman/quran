import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/enums.dart';
import '../providers/onboarding_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/widgets/custom_button.dart';

class CalculationMethodScreen extends StatelessWidget {
  final VoidCallback onNext;

  const CalculationMethodScreen({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OnboardingProvider>();
    final currentMethod = provider.settings.calculationMethod;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            Text(
              'calculation_method_title'.tr(),
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Expanded(
              child: ListView(
                children: CalculationMethodEnum.values.map((method) {
                  return RadioListTile<CalculationMethodEnum>(
                    title: Text('calc_${method.name}'.tr()),
                    value: method,
                    groupValue: currentMethod,
                    onChanged: (val) {
                      if (val != null) {
                        provider.updateCalculationMethod(val);
                      }
                    },
                  );
                }).toList(),
              ),
            ),
            CustomButton(
              label: 'next'.tr(),
              onPressed: onNext,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
