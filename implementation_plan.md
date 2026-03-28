# Prayer & Quran Section — Full Implementation Plan (Offline-First)

Based on **pray-section-v1.0.pdf** design document.

> [!IMPORTANT]
> **100% Offline-First.** Zero API/network dependencies. All calculations, Quran rendering, and Islamic content work without internet.

---

## Design Reference

````carousel
![Page 1 — Prayer Times (المواقيت): Dynamic 4-state prayer card, location header, prayer list, bottom nav](/Users/othman/.gemini/antigravity/brain/cbc43c7b-99b0-46b4-813d-056fb82d8474/pdf_page_1_1774686194901.png)
<!-- slide -->
![Pages 2-3 — Azkar After Prayer & Sunnah/Nawafil: Counter widgets, auto-prayer filter, expandable checklists](/Users/othman/.gemini/antigravity/brain/cbc43c7b-99b0-46b4-813d-056fb82d8474/pdf_page_2_3_1774686205643.png)
<!-- slide -->
![Pages 4-5 — Prayer Actions & Prayer Azkar: Categorized pillars/duties/sunnahs/invalidators, Wudu/Athan/Sujood categories](/Users/othman/.gemini/antigravity/brain/cbc43c7b-99b0-46b4-813d-056fb82d8474/pdf_page_4_5_1774686216132.png)
<!-- slide -->
![Pages 6-7 — Notification Settings & Section Structure: Per-prayer config, auto-silent, nawafil alerts, full section tree](/Users/othman/.gemini/antigravity/brain/cbc43c7b-99b0-46b4-813d-056fb82d8474/notification_settings_focus_1774686271108.png)
<!-- slide -->
![Page 7 — Settings continued + Section Diagram: Auto-silent mode, reset defaults, save, full prayer section mind-map](/Users/othman/.gemini/antigravity/brain/cbc43c7b-99b0-46b4-813d-056fb82d8474/pdf_page_7_last_1774686231277.png)
````

---

## Flutter Packages

| Package | Purpose | Offline? |
|---------|---------|----------|
| `qcf_quran_plus` | Quran Mushaf rendering + Tajweed colors + search | ✅ |
| `adhan_dart` | Prayer time calculation (astronomical algorithms) | ✅ |
| `hijri_calendar` | Hijri ↔ Gregorian date conversion | ✅ |
| `geolocator` | GPS coordinates | ✅ GPS + cached |
| `flutter_qiblah` | Qibla compass (magnetometer) | ✅ Device sensors |
| `flutter_local_notifications` | Prayer & azkar alerts | ✅ |
| `timezone` | Timezone-aware notification scheduling | ✅ |
| `just_audio` | Athan playback (background-capable) | ✅ Bundled files |
| `just_audio_background` | Background audio session management | ✅ |
| `permission_handler` | Location & notification permissions | ✅ |
| `shared_preferences` | Settings, cached location, counters, checklists | ✅ |
| `hive` / `hive_flutter` | Quran bookmarks (structured, growing data) | ✅ |
| `scrollable_positioned_list` | Quran surah list scroll | ✅ |
| `provider` + `equatable` + `intl` | State, models, formatting | ✅ |
| `workmanager` | Background task scheduling (notification safety net) | ✅ |



---

## Phase 0 — Onboarding Feature

Required to avoid 40%+ GPS permission denial rate.

3-screen flow:
1. **Calculation Method Picker** — Egyptian General Authority, Umm Al-Qura, Muslim World League, Karachi, ISNA, etc.
2. **Location Permission** — explanation screen ("We need your location to calculate accurate prayer times") → GPS request
3. **Optional Settings** — Madhab (Hanafi/Shafi'i for Asr), Hijri date adjustment (±2 days)

All stored in `shared_preferences`. One-time only, with "Edit" accessible from settings.

---

## Phase 1 — Quran Feature (`qcf_quran_plus`)

### What the Package Provides (No Work Needed)
- ✅ 604-page authentic Madinah Mushaf layout
- ✅ **Tajweed coloring** in Light & Dark modes — native, no performance drops
- ✅ Smart Arabic search (diacritic-insensitive, automatic normalization)
- ✅ Dynamic ayah highlighting (for bookmarks, audio sync)
- ✅ Vertical Surah List Mode (scrollable reading)
- ✅ Full metadata API: Surah names (AR/EN), Juz, Hizb/Quarter, Makki/Madani, page lookups, verse count

### What Must Be Built

| Task | Details |
|------|---------|
| Font initialization | `QcfFontLoader.setupFontsAtStartup()` in splash screen |
| Mushaf PageView screen | `QuranPageView` with `pageController`, `isTajweed: true` |
| Surah list screen | `QuranSurahListView` with `ayahBuilder` for custom styling |
| Search screen | `normalise()` + `searchWords()` for offline search |
| Bookmark system | Save bookmarks to **Hive** with `HighlightVerse` model |
| Last-read tracking | Persist last page/surah in `shared_preferences` |
| Surah index | List of 114 surahs using `getSurahNameArabic()`, `getVerseCount()` etc. |
| Metadata service | Wrap package data APIs in `QuranMetadataService` for future swapability |

### Data Requirements
- **None extra** — `qcf_quran_plus` bundles all Quran text, fonts, and metadata internally

---

## Phase 2 — Prayer Times Core Engine

### What the Design Shows (Page 1)

- **Location header**: City name + GPS refresh icon
- **Hijri date display** with ±2 day manual adjustment
- **Dynamic prayer card** — hero element with **4 distinct states**:

| State | Arabic | Visual | Content |
|-------|--------|--------|---------|
| **Upcoming** (التالي) | Green gradient | Prayer name + countdown + motivational hadith |
| **Approaching** (اقتربت) | Teal gradient | "متبقي ٩ دقائق" + progress bar filling |
| **Active** (قائمة) | Purple/lilac | From athan time through iqama buffer — "صلاة الظهر قائمة" |
| **Ended** (انتهت) | Gray/muted | Reminder for congregation & sunnah |

> [!NOTE]
> **"Approaching" is the key UX differentiator** — the "get ready" prompt that no other prayer app provides. "Active" covers the entire window from athan through iqama buffer.

- **Prayer list**: Fajr, Sunrise, Dhuhr, Asr, Maghrib, Isha — each showing exact time
- **Bottom action bar**: icons for QR/grid, smiley, share, Quran, notification bell

### What Must Be Built

| Task | Details |
|------|---------|
| Location service | `geolocator` GPS → cache coords + city in `shared_preferences` |
| Offline city lookup | Ship ~500KB GeoNames JSON → Haversine nearest-city match (NO network) |
| Prayer time engine | `adhan_dart` — configurable method from onboarding |
| Hijri date | `hijri_calendar` + ±2 day user offset from `shared_preferences` |
| 4-state machine | Timer-based: upcoming → approaching (configurable threshold) → active → ended |
| Countdown timer | `Timer.periodic(1s)` computing remaining seconds |
| Prayer time model | `PrayerTimeModel` with `fake()`, DateTime fields |
| Dynamic card widget | Stateful widget switching gradient/text per state |
| Error boundaries | GPS denied → manual city selection; sensor absent → static Qibla degree |

### Data — All Computed Locally
| Data | Source |
|------|--------|
| 6 daily prayer times | `adhan_dart` from GPS coords |
| Current/next prayer | 4-state machine + device clock |
| Hijri date | `hijri_calendar` + user offset |
| City name | **Offline city DB** (GeoNames JSON, ~500KB) |
| Motivational quotes | Bundled `assets/data/card_quotes.json` |

---

## Phase 3 — Azkar After Prayer Tab

### What the Design Shows (Page 2)

- Recommendation banner, auto-filters to current prayer
- Zikr cards with Arabic text, tap counter, "الدليل" (Proof) + "الفضل" (Benefit) sections
- Counter shows current vs. required count (e.g., ×33)

### What Must Be Built

| Task | Details |
|------|---------|
| Azkar data | **Hisn Al-Muslim dataset** (pre-verified JSON from GitHub) — NOT manually authored |
| Counter state | **In-memory Map in Provider** (session-scoped, resets per prayer — no Hive needed) |
| Auto-filter logic | Determine current prayer from state machine |
| Counter widget | Circular progress + count, tap increment, haptic |
| Proof/Benefit sections | Expandable per card |

### Data Source

> [!CAUTION]
> **Use pre-verified Hisn Al-Muslim datasets** — NOT manual authoring. Source: [github.com/osamayy/hisn-almuslim-db](https://github.com/osamayy/hisn-almuslim-db). Every entry must include `"source"` field with hadith reference.

~30 azkar items: `{id, text_ar, repetition_count, proof_ar, benefit_ar, source, applicable_prayers[]}`

---

## Phase 4 — Sunnah & Nawafil Tab

### What the Design Shows (Page 3)

- Per-prayer expandable sections with checklists (sunnah before, fard, sunnah after)
- Proof section with hadith reference
- Visual completion indicators

### What Must Be Built

| Task | Details |
|------|---------|
| Sunnah data | `assets/data/sunnah_nawafil.json` with mandatory `source` field |
| Daily checklist | **`shared_preferences`** — date-keyed, auto-reset at Fajr (no Hive needed) |
| Expandable sections | Per-prayer collapsible cards |
| Progress tracking | Completion % per prayer and daily total |

### Data — Partially from Hisn Al-Muslim + Manual Curation
~15 entries with `source` field referencing hadith number

---

## Phase 5 — Educational Tabs

### Prayer Actions Tab (أفعال الصلاة) — Grid Menu
| Category | Items |
|----------|-------|
| Pillars (الأركان) | ~14 — mandatory acts |
| Duties (الواجبات) | ~8 — covered by Sujood as-Sahw |
| Sunnahs (السنن) | ~20 — recommended acts |
| Disliked (المكروهات) | Acts disliked during prayer |
| Invalidators (المبطلات) | ~8 — acts that break prayer |

### Prayer Azkar Tab (أذكار الصلاة) — List Menu
11 categories: Athan, Wudu, Entering/Exiting mosque, Opening du'a, Ruku', Rising from Ruku', Sujood, Between Sujood, Tashahhud, After Tashahhud

### Data — Manual Authoring Required (No Dataset Exists)

> [!IMPORTANT]
> Fiqh categorization data (pillars, duties, sunnahs) has no pre-built dataset. Manual authoring required with **mandatory `source` field** for every item. All content must reference hadith grade + book + number.

~90+ items total across all categories

---

## Phase 6 — Notification Settings (Detailed)

### iOS 64-Notification Hard Limit

> [!CAUTION]
> **iOS limits apps to 64 pending local notifications.** 5 prayers × 3 alerts × 7 days = 105 → IMPOSSIBLE. Must schedule max **2 days** (30 notifications, safely under 64).

### Scheduling Strategy (Production-Grade)

| Aspect | Strategy |
|--------|----------|
| **Window** | Schedule next **2 days only** (max ~30 prayer notifications) |
| **Reschedule on** | App foreground (primary), after notification tap (secondary), `workmanager` periodic ~12h (safety net), timezone/location change |
| **Priority** | Athan alerts first → Before-athan if budget remains → Iqama if budget remains |
| **Nawafil** | Separate budget — only schedule if prayer alerts leave room in 64-slot limit |

### Per-Prayer Configuration (from PDF)

| Setting | Details |
|---------|---------|
| Before Athan alert | Toggle + minutes stepper + sound picker |
| At Athan alert | Toggle + Muezzin picker (المنشاوي, مشارى راشد, سعد الغامدي) |
| Iqama alert | Toggle + minutes after athan + sound picker |

### Auto-Silent Mode
| Setting | Details |
|---------|---------|
| Enable | Master toggle |
| Start condition | Radio: Near prayer / Athan / Iqama |
| End condition | Minutes after Iqama (stepper) |

### Nawafil Alerts
Duha, Qiyam al-Layl, Morning/Evening Azkar, Sleep Azkar, Last third of night

### Athan Audio Strategy (Production-Grade)

> [!WARNING]
> **iOS notification sounds capped at 30 seconds.** Full Athan (~3 min) CANNOT play through notification sound. Must use `just_audio` + `just_audio_background`.

| Scenario | Behavior |
|----------|----------|
| Notification fires | Short sound: takbir.mp3 (≤30s) |
| User taps notification | App opens → `just_audio` plays full Athan |
| Background Audio enabled | `just_audio_background` plays Athan in background via `AVAudioSession.playback` |

### Audio Assets
- 3 Athan recordings — placed in `android/app/src/main/res/raw/` + iOS bundle
- 1-2 short alert sounds — same locations
- iOS: Configure "Audio, AirPlay, and Picture in Picture" background mode in Xcode

---

## Phase Summary & Local Data Index

### Implementation Order — Feature per Phase

| Phase | Feature Folder | Content | Est. Time |
|-------|---------------|---------|-----------|
| 0 | `features/onboarding/` | Calculation method, location, madhab, Hijri offset | Week 1 |
| 1 | `features/quran/` | Mushaf, tajweed, search, bookmarks | Week 1-2 |
| 2 | `features/prayer_times/` + `core/services/` | Prayer engine, 4-state card, location, Hijri | Week 2-3 |
| 3 | `features/azkar/` | Azkar after prayer, counters, proof/benefit | Week 3 |
| 4 | `features/sunnah/` | Sunnah checklists, daily reset, progress | Week 4 |
| 5 | `features/prayer_education/` | Actions grid + Azkar categories (static) | Week 5 |
| 6 | `features/notifications/` | Notification settings, auto-silent, 2-day scheduling | Week 6 |
| — | `features/prayer_shell/` | Thin TabBar host composing all 5 prayer tabs | Built in Phase 2 |

### Data Sources

| Content | Source | Format |
|---------|--------|--------|
| Azkar after prayer (~30) | **Hisn Al-Muslim dataset** (GitHub) | `assets/data/azkar_after_prayer.json` |
| Azkar during prayer (~20) | **Hisn Al-Muslim dataset** | `assets/data/prayer_azkar.json` |
| Sunnah Rawatib (~15) | Hisn Al-Muslim + manual curation | `assets/data/sunnah_nawafil.json` |
| Prayer actions (~60+) | **Manual authoring** (no dataset exists) | `assets/data/prayer_actions.json` |
| Card state quotes (~10) | Manual | `assets/data/card_quotes.json` |
| City database (~8K cities) | GeoNames extract | `assets/data/cities.json` |
| Athan audio (3 Muezzins) | Bundled MP3 | `android/res/raw/`, iOS bundle |
| Alert sounds (2) | Bundled MP3 | Same |

### Storage Strategy

| Data | Storage | Reasoning |
|------|---------|-----------|
| Settings, toggles, onboarding | `shared_preferences` | Simple key-value |
| Last-read page, cached location | `shared_preferences` | Single values |
| Notification settings | `shared_preferences` (JSON string) | One serialized blob |
| Azkar counters | **In-memory** (Provider) | Session-scoped, resets per prayer |
| Daily sunnah checklist | `shared_preferences` | Date-keyed, small data |
| Quran bookmarks | **Hive** | Structured, grows over time |

---

## Verification Plan

### Automated Tests
- Prayer 4-state machine transitions, countdown logic, counter increment/reset, daily checklist reset
- Widget tests for dynamic card states, notification settings form
- Notification budget calculator (never exceeds 64)

### Manual Verification
- ✈️ **Airplane mode test** — entire app works with no network
- Compare prayer times against local mosque schedule
- Test Quran tajweed rendering in light & dark modes
- Test all 4 card states by simulating time progression
- Verify Athan playback on physical iOS (background mode) and Android (foreground service)
- Verify Qibla accuracy on physical device
- Test auto-silent mode triggers and restores
- Verify daily sunnah checklist reset at Fajr
- Confirm notification count stays under 64 on iOS
- Test GPS denial → offline city fallback
