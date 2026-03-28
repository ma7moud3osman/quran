# AI Implementation Guide — Islamic App (Offline-First)

> **ALWAYS** follow `~/.gemini/GEMINI.md` rules.

---

## Architecture Rules Reminder

```
lib/features/<feature>/
  data/ {models/, data_source/, repositories/}
  presentation/ {providers/, pages/, widgets/}
```

- **State**: Provider (ChangeNotifier), private fields, public getters, `LoadStatus` enum
- **Models**: Equatable, `fromJson`/`toJson`, **MUST** `factory Model.fake()`
- **UI**: `SmartScreen` mandatory, `LoadingType.skeleton`
- **Widgets**: `VerticalSpacer`, `HorizontalSpacer`, `MainButton`, `AppPadding`, `AppRadius`
- **Typography**: `context.titleLarge` etc. NO manual `TextStyle`
- **Colors**: `context.primaryColor` etc. NO hardcoded colors
- **i18n**: `'key'.tr()` → `en-US.json` & `ar-SA.json`
- **Navigation**: GoRouter — `pushToNamed`, `goToNamed`, `popRoute`, args via `extra`
- **DI**: `get_it` in `feature_injection.dart`
- **Files**: `snake_case.dart`, `_screen.dart`, `_widget.dart`, `_section.dart`
- **Limits**: UI < 250 lines, functions < 50 lines
- **After changes**: `dart format .` & `dart analyze` — ZERO errors
- **Domain layer**: SKIP (all features score <10, no API endpoints)

---

## Storage Strategy

| Data | Storage | Why |
|------|---------|-----|
| Settings, toggles, onboarding | `shared_preferences` | Simple key-value |
| Last-read page, cached location | `shared_preferences` | Single values |
| Notification settings | `shared_preferences` (JSON) | One serialized blob |
| Azkar counters | **In-memory** (Provider) | Session-scoped, resets per prayer |
| Daily sunnah checklist | `shared_preferences` | Date-keyed, small |
| Quran bookmarks | **Hive** | Structured, grows over time |

---

## Feature Split Overview

```
lib/
├── core/
│   └── services/
│       ├── location_service.dart         # GPS + offline city lookup
│       ├── prayer_time_service.dart      # adhan_dart wrapper
│       ├── hijri_service.dart            # hijri_calendar + ±2 day offset
│       ├── notification_service.dart     # flutter_local_notifications + budget
│       ├── audio_service.dart            # just_audio + just_audio_background
│       └── quran_metadata_service.dart   # qcf_quran_plus API wrapper
│
├── features/
│   ├── onboarding/               ← Phase 0 (method, location, madhab)
│   ├── quran/                    ← Phase 1 (standalone)
│   ├── prayer_times/             ← Phase 2 (uses core/services)
│   ├── azkar/                    ← Phase 3 (reads prayer state from prayer_times)
│   ├── sunnah/                   ← Phase 4 (reads prayer state from prayer_times)
│   ├── prayer_education/         ← Phase 5 (fully standalone, static data)
│   ├── notifications/            ← Phase 6 (reads prayer times, 2-day budget)
│   └── prayer_shell/             ← TabBar host composing 5 prayer tabs
│
assets/data/
├── cities.json                   # Offline GeoNames (~500KB)
├── azkar_after_prayer.json       # From Hisn Al-Muslim dataset
├── prayer_azkar.json             # From Hisn Al-Muslim dataset
├── sunnah_nawafil.json           # Hisn Al-Muslim + manual curation
├── prayer_actions.json           # Manual (no dataset exists for fiqh categories)
└── card_quotes.json              # Manual (UX-specific)
```

### Cross-Feature Dependencies

```
prayer_shell ──uses──▶ prayer_times, azkar, sunnah, prayer_education, notifications
azkar ─────────reads──▶ prayer_times (current prayer state)
sunnah ────────reads──▶ prayer_times (Fajr time for daily reset)
notifications ─reads──▶ prayer_times (computed times for scheduling)
quran ─────────────────▶ fully independent
prayer_education ──────▶ fully independent
onboarding ────────────▶ fully independent (writes to shared_preferences)
```

> Cross-feature reads use **provider injection** — never direct imports between feature data layers.

---

## Phase 0: Onboarding Feature

### Feature: `lib/features/onboarding/`

```
onboarding/
├── data/
│   ├── models/
│   │   └── onboarding_settings_model.dart
│   └── data_source/
│       └── onboarding_data_source.dart      # shared_preferences
└── presentation/
    ├── providers/
    │   └── onboarding_provider.dart
    ├── pages/
    │   ├── calculation_method_screen.dart     # Screen 1
    │   ├── location_permission_screen.dart    # Screen 2
    │   └── optional_settings_screen.dart      # Screen 3 (madhab + Hijri offset)
    └── widgets/
```

### Key Steps
1. `OnboardingSettingsModel`: `calculationMethod` (enum), `madhab` (enum), `hijriOffset` (int, -2 to +2), `isComplete` (bool) — `fake()`
2. 3-step PageView with progress indicator
3. Screen 1: Calculation method radio list (Egyptian, UmmAlQura, MWL, Karachi, ISNA)
4. Screen 2: Explanation text + "Enable Location" button → `permission_handler` → GPS → cache
5. Screen 3: Madhab picker (Hanafi/Shafi'i) + Hijri ±2 day stepper
6. Mark `isComplete = true`, navigate to main app
7. Accessible later from Settings to edit

### Error Handling
- GPS denied → Show "Enter city manually" with search field → offline city DB lookup
- GPS denied permanently → Direct to OS settings with explanation

---

## Phase 1: Quran Feature

### Feature: `lib/features/quran/`

```
quran/
├── data/
│   ├── models/
│   │   ├── bookmark_model.dart
│   │   └── quran_search_result_model.dart
│   ├── data_source/
│   │   └── quran_local_data_source.dart     # Hive: bookmarks only
│   └── repositories/
│       └── quran_repository.dart
└── presentation/
    ├── providers/
    │   └── quran_provider.dart
    ├── pages/
    │   ├── surah_index_screen.dart
    │   ├── quran_mushaf_screen.dart
    │   ├── quran_surah_list_screen.dart
    │   └── quran_search_screen.dart
    └── widgets/
```

### Key Steps
1. `QcfFontLoader.setupFontsAtStartup()` in splash screen
2. `BookmarkModel`: `surahNumber`, `verseNumber`, `pageNumber`, `createdAt` — Equatable, `fake()`
3. `QuranSearchResultModel`: `surahNumber`, `surahName`, `verseNumber`, `text` — Equatable, `fake()`
4. `quran_local_data_source.dart`: **Hive** for bookmarks (structured, growing), `shared_preferences` for last-read page
5. `QuranMetadataService` in `core/services/`: wraps `getSurahNameArabic()`, `getPageNumber()` etc.
6. Mushaf: `QuranPageView(isTajweed: true, isDarkMode: ..., highlights: _bookmarks)`
7. Surah list: `QuranSurahListView(surahNumber: X, isTajweed: true)` with custom `ayahBuilder`
8. Search: `normalise(query)` → `searchWords(query)` → display results
9. DI in `quran_injection.dart`, GoRouter routes, i18n keys

### Data: None extra — `qcf_quran_plus` bundles everything

---

## Phase 2: Prayer Times Feature

### Feature: `lib/features/prayer_times/`

```
prayer_times/
├── data/
│   ├── models/
│   │   ├── prayer_time_model.dart
│   │   └── prayer_state_model.dart
│   ├── data_source/
│   │   └── prayer_times_local_data_source.dart  # card quotes JSON
│   └── repositories/
│       └── prayer_times_repository.dart
└── presentation/
    ├── providers/
    │   └── prayer_time_provider.dart             # 4-state machine + countdown
    ├── pages/
    │   └── prayer_times_screen.dart
    └── widgets/
        ├── prayer_state_card_widget.dart          # 4-state dynamic card
        └── prayer_time_row_widget.dart
```

### Core Services (in `lib/core/services/`)
```
location_service.dart        → geolocator + offline city DB (GeoNames JSON)
prayer_time_service.dart     → adhan_dart, uses CalculationMethod from onboarding
hijri_service.dart           → hijri_calendar + user offset from shared_preferences
```

### Packages
```yaml
adhan_dart: latest
hijri_calendar: latest
geolocator: latest
permission_handler: latest
shared_preferences: latest
```

### Key Steps
1. **Core services** — Location (GPS + offline city fallback), PrayerTime (adhan_dart), Hijri (+ offset)
2. `PrayerTimeModel`: `fajr`, `sunrise`, `dhuhr`, `asr`, `maghrib`, `isha` (DateTime), `cityName`, `hijriDate` — `fake()`
3. `PrayerStateModel`: enum `PrayerState { upcoming, approaching, active, ended }`, `currentPrayer`, `remainingDuration`, `quoteText` — `fake()`
4. **4-state machine logic:**
   ```
   if (remaining > threshold)       → upcoming    (green)
   if (remaining > 0)               → approaching (teal, progress bar)
   if (elapsed < iqamaBuffer)       → active      (purple)
   else                             → ended       (gray)
   ```
5. `prayer_time_provider.dart`: `Timer.periodic(1s)`, public: `currentPrayerState`, `prayerTimes`, `remainingTime`
6. `prayer_state_card_widget.dart`: 4 gradients, prayer name, countdown, quote, progress bar
7. `prayer_times_screen.dart`: `SmartScreen` + skeleton, location header, Hijri date, state card, prayer list

### Error Handling
- GPS denied → offline city DB search
- No location at all → show times for Mecca (default) with prompt to set location

### Seed Data
`assets/data/card_quotes.json` — ~10 quotes per state
`assets/data/cities.json` — ~8K cities from GeoNames (~500KB)

---

## Phase 3: Azkar Feature

### Feature: `lib/features/azkar/`

```
azkar/
├── data/
│   ├── models/
│   │   └── zikr_model.dart
│   ├── data_source/
│   │   └── azkar_local_data_source.dart     # bundled JSON (Hisn Al-Muslim)
│   └── repositories/
│       └── azkar_repository.dart
└── presentation/
    ├── providers/
    │   └── azkar_provider.dart
    ├── pages/
    │   └── azkar_after_prayer_screen.dart
    └── widgets/
        └── zikr_counter_widget.dart
```

### Key Steps
1. `ZikrModel`: `id`, `textAr`, `repetitionCount`, `proofAr`, `benefitAr`, `source`, `applicablePrayers[]` — `fake()`
   - **`source` field is mandatory** (hadith reference)
2. `azkar_local_data_source.dart`: loads from **Hisn Al-Muslim** JSON
3. `azkar_provider.dart`:
   - **Reads** `PrayerTimeProvider` for current prayer auto-filter
   - Counter state: **in-memory `Map<int, int>`** (NOT Hive) — resets when prayer changes
   - `incrementZikr(id)`, `resetAll()`
4. `zikr_counter_widget.dart`: circular progress, tap increment, haptic, expandable "الدليل" + "الفضل"
5. `azkar_after_prayer_screen.dart`: `SmartScreen`, recommendation banner, prayer filter chips

### Data Source
**Hisn Al-Muslim dataset** — pre-verified, ~30 items with hadith references

---

## Phase 4: Sunnah Feature

### Feature: `lib/features/sunnah/`

```
sunnah/
├── data/
│   ├── models/
│   │   └── sunnah_item_model.dart
│   ├── data_source/
│   │   └── sunnah_local_data_source.dart
│   └── repositories/
│       └── sunnah_repository.dart
└── presentation/
    ├── providers/
    │   └── sunnah_provider.dart
    ├── pages/
    │   └── sunnah_nawafil_screen.dart
    └── widgets/
        └── sunnah_checklist_widget.dart
```

### Key Steps
1. `SunnahItemModel`: `prayer`, `prayerNameAr`, `items[]` (sub: name, type enum, rakaat), `proofAr`, `rewardAr`, `source` — `fake()`
2. `sunnah_local_data_source.dart`: loads JSON, daily checklist in **`shared_preferences`** (date-keyed)
3. Auto-reset at Fajr: compare `lastResetDate` in shared_preferences, reset if new day
4. `sunnah_provider.dart`:
   - **Reads** `PrayerTimeProvider` for Fajr time
   - `toggleItem(prayer, index)`, `resetDaily()`
   - Completion % per prayer and total
5. `sunnah_checklist_widget.dart`: per-prayer expandable card, checkbox per item, progress bar

### Data
`assets/data/sunnah_nawafil.json` — Hisn Al-Muslim + manual curation, ~15 entries with `source` field

---

## Phase 5: Prayer Education Feature

### Feature: `lib/features/prayer_education/`

```
prayer_education/
├── data/
│   ├── models/
│   │   ├── prayer_action_model.dart
│   │   └── prayer_azkar_category_model.dart
│   ├── data_source/
│   │   └── education_local_data_source.dart
│   └── repositories/
│       └── education_repository.dart
└── presentation/
    ├── providers/
    │   └── prayer_education_provider.dart
    ├── pages/
    │   ├── prayer_actions_screen.dart
    │   ├── prayer_actions_detail_screen.dart
    │   ├── prayer_azkar_screen.dart
    │   └── prayer_azkar_detail_screen.dart
    └── widgets/
        └── prayer_action_grid_widget.dart
```

**Fully standalone** — no cross-feature dependencies.

### Key Steps
1. `PrayerActionModel`: category (`id`, `nameAr`, `icon`, `items[]`), item (`nameAr`, `descriptionAr`, `proofAr`, `source`) — `fake()`
2. `PrayerAzkarCategoryModel`: category (`id`, `nameAr`, `azkar[]`), zikr (`textAr`, `proofAr`, `source`) — `fake()`
3. All items **MUST** have `source` field (hadith grade + book + number)
4. Grid menu → detail page, List menu → detail page
5. DI, routes, i18n

### Data — Manual authoring required (no dataset exists for fiqh categories)

---

## Phase 6: Notifications Feature

### Feature: `lib/features/notifications/`

```
notifications/
├── data/
│   ├── models/
│   │   └── notification_settings_model.dart
│   ├── data_source/
│   │   └── notification_settings_data_source.dart  # shared_preferences
│   └── repositories/
│       └── notification_settings_repository.dart
└── presentation/
    ├── providers/
    │   └── notification_settings_provider.dart
    ├── pages/
    │   └── notification_settings_screen.dart
    └── widgets/
        └── notification_prayer_config_widget.dart
```

### Packages
```yaml
flutter_local_notifications: latest
timezone: latest
just_audio: latest
just_audio_background: latest
workmanager: latest
```

### Key Steps — Notification Budget System
1. **iOS 64-notification hard limit** — schedule max **2 days** (~30 prayer notifications)
2. `NotificationBudgetCalculator`: counts scheduled, prioritizes athan > before > iqama > nawafil
3. Reschedule triggers:
   - App foreground (primary, reliable)
   - After notification tap (secondary, reliable)
   - `workmanager` periodic task ~12h (safety net, best-effort on iOS)
   - Timezone/location change
4. Enums:
   ```dart
   enum AlertSound { systemNotification, takbir, shortAlert, vibrateSilent }
   enum MuezzinChoice { minshawi, mishariRashed, saadAlGhamdi }
   enum SilentStartCondition { nearPrayer, athan, iqama }
   ```
5. `NotificationSettingsModel`: `masterEnabled`, `applyToAll`, `perPrayerSettings`, `autoSilent`, `nawafil` — Equatable, `fake()`
6. `notification_service.dart` (core/services): schedule, cancel, reschedule with budget check
7. `audio_service.dart` (core/services): `just_audio` + `just_audio_background` for full Athan playback

### Athan Audio Pattern
```
Notification fires → short sound (takbir.mp3, ≤30s)
  ├── User taps → app opens → just_audio plays full Athan
  └── Background Audio enabled → just_audio_background plays in background
```

### iOS Setup Required
- Xcode: Enable "Audio, AirPlay, and Picture in Picture" background mode
- Configure `AVAudioSession.playback` category via `just_audio`

### Audio Assets
```
android/app/src/main/res/raw/
├── athan_minshawi.mp3
├── athan_mishari.mp3
├── athan_ghamdi.mp3
├── takbir.mp3
└── alert_short.mp3
```
+ Same in iOS bundle resources

---

## Prayer Shell (TabBar Host)

### Feature: `lib/features/prayer_shell/`

```
prayer_shell/
└── presentation/
    └── pages/
        └── prayer_main_screen.dart
```

Thin host — `DefaultTabController` + `TabBar` + `TabBarView`:
- Tab 1: `PrayerTimesScreen` from `prayer_times`
- Tab 2: `AzkarAfterPrayerScreen` from `azkar`
- Tab 3: `SunnahNawafilScreen` from `sunnah`
- Tab 4: `PrayerActionsScreen` from `prayer_education`
- Tab 5: `PrayerAzkarScreen` from `prayer_education`

Uses `MultiProvider` to inject shared `PrayerTimeProvider`.

---

## Post-Phase Checklist (Run After EVERY Phase)

- [ ] `dart format .`
- [ ] `dart analyze` — fix ALL issues
- [ ] All new strings in `en-US.json` & `ar-SA.json` (real values, not placeholders)
- [ ] All models have `factory Model.fake()`
- [ ] All data screens use `SmartScreen` with `LoadingType.skeleton`
- [ ] No hardcoded colors, padding, radius, or text styles
- [ ] DI registered in `<feature>_injection.dart`
- [ ] GoRouter routes added
- [ ] UI files < 250 lines
- [ ] No duplicate widgets/models — search codebase first
- [ ] All Islamic content has `source` field (hadith reference)
- [ ] Error handling: GPS denial, sensor absence, data corruption
- [ ] Notification count verified under 64 (iOS)
