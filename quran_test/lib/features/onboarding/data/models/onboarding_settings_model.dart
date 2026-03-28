import 'package:equatable/equatable.dart';
import '../../../../core/utils/enums.dart';

class OnboardingSettingsModel extends Equatable {
  final CalculationMethodEnum calculationMethod;
  final MadhabEnum madhab;
  final int hijriOffset;
  final bool isComplete;
  final double? latitude;
  final double? longitude;
  final String? cityName;

  const OnboardingSettingsModel({
    required this.calculationMethod,
    required this.madhab,
    required this.hijriOffset,
    required this.isComplete,
    this.latitude,
    this.longitude,
    this.cityName,
  });

  factory OnboardingSettingsModel.fake() => const OnboardingSettingsModel(
        calculationMethod: CalculationMethodEnum.egyptian,
        madhab: MadhabEnum.shafii,
        hijriOffset: 0,
        isComplete: false,
        latitude: 21.422487, // Mecca
        longitude: 39.826206, // Mecca
        cityName: 'Mecca',
      );

  factory OnboardingSettingsModel.fromJson(Map<String, dynamic> json) =>
      OnboardingSettingsModel(
        calculationMethod: CalculationMethodEnum.values.firstWhere(
          (e) => e.name == json['calculationMethod'],
          orElse: () => CalculationMethodEnum.egyptian,
        ),
        madhab: MadhabEnum.values.firstWhere(
          (e) => e.name == json['madhab'],
          orElse: () => MadhabEnum.shafii,
        ),
        hijriOffset: json['hijriOffset'] as int? ?? 0,
        isComplete: json['isComplete'] as bool? ?? false,
        latitude: json['latitude'] as double?,
        longitude: json['longitude'] as double?,
        cityName: json['cityName'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'calculationMethod': calculationMethod.name,
        'madhab': madhab.name,
        'hijriOffset': hijriOffset,
        'isComplete': isComplete,
        'latitude': latitude,
        'longitude': longitude,
        'cityName': cityName,
      };

  OnboardingSettingsModel copyWith({
    CalculationMethodEnum? calculationMethod,
    MadhabEnum? madhab,
    int? hijriOffset,
    bool? isComplete,
    double? latitude,
    double? longitude,
    String? cityName,
  }) {
    return OnboardingSettingsModel(
      calculationMethod: calculationMethod ?? this.calculationMethod,
      madhab: madhab ?? this.madhab,
      hijriOffset: hijriOffset ?? this.hijriOffset,
      isComplete: isComplete ?? this.isComplete,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      cityName: cityName ?? this.cityName,
    );
  }

  @override
  List<Object?> get props => [
        calculationMethod,
        madhab,
        hijriOffset,
        isComplete,
        latitude,
        longitude,
        cityName,
      ];
}
