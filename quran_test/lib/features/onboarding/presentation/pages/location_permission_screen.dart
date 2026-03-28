import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/services/location_service.dart';
import '../../../../core/widgets/custom_button.dart';
import '../providers/onboarding_provider.dart';
import 'package:easy_localization/easy_localization.dart';

class LocationPermissionScreen extends StatefulWidget {
  final VoidCallback onNext;

  const LocationPermissionScreen({super.key, required this.onNext});

  @override
  State<LocationPermissionScreen> createState() =>
      _LocationPermissionScreenState();
}

class _LocationPermissionScreenState extends State<LocationPermissionScreen> {
  final LocationService _locationService = LocationService();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _locationService.init();
  }

  Future<void> _requestLocation() async {
    setState(() => _isLoading = true);

    final position = await _locationService.getCurrentPosition();

    if (position != null && mounted) {
      context.read<OnboardingProvider>().updateLocation(
        position.latitude,
        position.longitude,
        'auto_location'.tr(),
      );
      widget.onNext();
    } else {
      // Show offline city search fallback
      if (mounted) {
        _showCitySearchFallback();
      }
    }

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  void _showCitySearchFallback() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return const SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [Text("Offline search to be implemented")],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            Text(
              'location_permission_title'.tr(),
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'location_permission_desc'.tr(),
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            CustomButton(
              label: 'enable_location'.tr(),
              onPressed: _requestLocation,
              isLoading: _isLoading,
            ),
            TextButton(onPressed: widget.onNext, child: Text('skip'.tr())),
          ],
        ),
      ),
    );
  }
}
