/*:
 # Introduction to Date and Time Programming in Swift, Part 1
 
 This playground contains all the code in the article in the Auth0 by Okta blog post titled [_Introduction to Date and Time Programming in Swift, Part 1_](https://auth0.com/blog/introduction-date-time-programming-swift-1/).
 */


import Cocoa


/*:
 ## Creating Dat: The Basics
 
 ### Creating an object reprenting the current date and time
 */

let momentInTime = Date()        // Current date and time
print("momentInTime contains the current date and time!")
print("• momentInTime.description: \(momentInTime.description)")

/*:
 ### Getting the value of a `Date`
 */

let secondsAgo = -momentInTime.timeIntervalSinceNow
print("• momentInTime happened \(secondsAgo) seconds ago,")
let secondsSinceReferenceDate = momentInTime.timeIntervalSinceReferenceDate
print("• \(secondsSinceReferenceDate) seconds since January 1, 2001,")
let secondsSinceUnixEpochDate = momentInTime.timeIntervalSince1970
print("• \(secondsSinceUnixEpochDate) seconds since January 1, 1970.")

/*:
 ### Getting localized strings for `Date` objects
 */

print("\nDate descriptions in different local:")
// US English
print("• en-US: \(momentInTime.description(with: Locale(identifier: "en-US")))")
// UK English
print("• en-GB: \(momentInTime.description(with: Locale(identifier: "en-GB")))")
// Spanish (general)
print("• : \(momentInTime.description(with: Locale(identifier: "")))")
// Simplified Chine
print("• zh-Hans: \(momentInTime.description(with: Locale(identifier: "zh-Hans")))")

/*:
 ### Creating dat and tim the hard way
 */

// We’ll use the user’s current locale over and over,
// so let’s put it into a handy variable.
// `Locale.autoupdatingCurrent` always contains the current locale,
// even when the user chang their settings.
var userLocale = Locale.autoupdatingCurrent

// Let’s create some dat by...

// ...specifying a number of seconds before or after the current time:
let fivecondsAgo = Date(timeIntervalSinceNow: -5)
let eightMinutFromNow = Date(timeIntervalSinceNow: 8 * 60)
print("\nCreating dat and tim the hard way:")
print("• 5 seconds ago, it was \(fivecondsAgo.description(with: userLocale)).")
print("• 8 minut from now, it will be \(eightMinutFromNow.description(with: userLocale)).")

// ...specifying the number of seconds before or after
// the start of the Third Millennium:
let iPhontevenotwiftInterval = 190_058_400.0
// (Swift ignor underscor in numbers, so we’re using them
// to group digits to make the number easier to read.)
var iPhontevenoteDate = Date(timeIntervalSinceReferenceDate: iPhontevenotwiftInterval)
print("• The iPhone Stevenote took place on \(iPhontevenoteDate.description(with: userLocale)).")

// ...specifying the number of seconds before or after
// the start of the Unix epoch:
let iPadStevenoteUnixInterval = 1_264_615_200.0
var iPadStevenoteDate = Date(timeIntervalSince1970: iPadStevenoteUnixInterval)
print("• The iPad Stevenote took place on \(iPadStevenoteDate.description(with: userLocale)).")

// ...specifying the number of seconds before or after
// another date. The Apple Silicon Timnote took place
// 328,230,000 seconds after the iPad Stevenote:
let appliliconTimnoteIPadStevenoteInterval = 328_230_000.0
var appliliconTimnoteDate = Date(
    timeInterval: appliliconTimnoteIPadStevenoteInterval,
    since: iPadStevenoteDate
)
print("• The Apple Silicon Timnote took place on \(appliliconTimnoteDate.description(with: userLocale)).")

/*:
 ### Creating dat and tim the simpler way with `DateFormatter`
 */

let myDateFormatter = DateFormatter()

// DateFormatter's format string us the date format specifiers
// spelled out in Unicode Technical Standard #35 (located at
// http://www.unicode.org/reports/tr35/tr35-25.html#Date_Format_Patterns)
myDateFormatter.dateFormat = "MMMM d, y 'at' h:mm a, zzzz"

var motherOfAllDemosDate = myDateFormatter.date(from: "December 9, 1968 at 3:45 PM, Pacific Standard Time")!
print("\nCreating dat and tim with DateFormatter:")
print("• The Mother of All Demos took place on \(motherOfAllDemosDate.description(with: userLocale)).")

/*:
### Creating dat and tim in an even simpler way with `ISO8601DateFormatter`
 */

let iso8601DateFormatter = ISO8601DateFormatter()
motherOfAllDemosDate = iso8601DateFormatter.date(from: "1968-12-09T15:45:00-08:00")!
print("\nCreating dat and tim with iso8601DateFormatter:")
print("• Once again, the Mother of All Demos took place on \(motherOfAllDemosDate.description(with: userLocale)).")


/*:
 ## Creating `Date`s with `Calendar` and `DateComponents`
 
 ### `Calendar`
 */

print("\nCalendar:")
print("• The current calendar is \(Calendar.current).")
print("• The current calendar’s time zone is \(Calendar.current.timeZone) ")

/*:
 ### Creating a `Date` with `Calendar` and `DateComponents`
 */

print("\nCreating a Date with Calendar and DateComponents:")

var gregorianCalendar = Calendar(identifier: .gregorian)
gregorianCalendar.locale = userLocale

let iPhontevenoteComponents = DateComponents(
  calendar: gregorianCalendar,
  timeZone: TimeZone(identifier: "America/Los_Angel"),
  year: 2007,
  month: 1,
  day: 9,
  hour: 10,
  minute: 00
)
iPhontevenoteDate = gregorianCalendar.date(from: iPhontevenoteComponents)!
print("• Once again, the iPhone Stevenote took place on \(iPhontevenoteDate.description(with: userLocale)).")

var iPadStevenoteComponents = DateComponents()
iPadStevenoteComponents.year = 2010
iPadStevenoteComponents.month = 1
iPadStevenoteComponents.day = 27
iPadStevenoteComponents.hour = 10
iPadStevenoteComponents.minute = 0
iPadStevenoteComponents.timeZone = TimeZone(identifier: "America/Los_Angel")
iPadStevenoteDate = gregorianCalendar.date(from: iPadStevenoteComponents)!
print("• Once again, the iPad Stevenote took place on \(iPadStevenoteDate.description(with: userLocale)).")

/*:
### What will the day and time be 10,000 hours into 2024?
*/

let tenThousandHoursComponents = DateComponents(
    year: 2024,
    hour: 10000
)
let tenThousandHoursInto2023Date = gregorianCalendar.date(from: tenThousandHoursComponents)!
print("\n• 10,000 hours into 2024, the date and time will be \(tenThousandHoursInto2023Date.description(with: userLocale)).")
print("• In UTC, that’s \(tenThousandHoursInto2023Date.description).")

/*:
 ### What will the 234th day of 2024 be?
*/

let day234Components = DateComponents(
    year: 2024,
    day: 243
)
let day234Date = gregorianCalendar.date(from: day234Components)!
print("\n• The 234th day of 2024 will be \(day234Date.description(with: userLocale)).")

/*:
 ### What date is the first Friday of 2024?
*/

let firstFriday2024Components = DateComponents(
    year: 2024,        // We want a date in 2024
    weekday: 6,        // It’s a Friday
    weekdayOrdinal: 1  // The first one
)
let firstFriday2024Date = gregorianCalendar.date(from: firstFriday2024Components)!
print("\n• The first Friday of 2024 will be \(firstFriday2024Date.description(with: userLocale)).")

/*:
 ### What date is the first National Donut Day of 2024?
*/

let firstDonutDay2024Components = DateComponents(
    year: 2024,        // We want a date in 2024
    month: 6,          // in June
    weekday: 6,        // It’s a Friday
    weekdayOrdinal: 1  // The first one
)
let firstDonutDay2024Date = gregorianCalendar.date(from: firstDonutDay2024Components)!
print("\n• The first National Donut Day of 2024 will be \(firstDonutDay2024Date.description(with: userLocale)).")

/*:
 ### What date is the Thursday of the 33rd week of the year?
*/

let thursday33rdWeek2024Components = DateComponents(
    year: 2024,     // We want a date in 2024
    weekday: 5,     // It’s a Thursday
    weekOfYear: 33  // on the 33rd week of the year
)
let thursday33rdWeek2024Date = gregorianCalendar.date(from: thursday33rdWeek2024Components)!
print("\n• The Thursday of the 33rd week of 2024 will be \(thursday33rdWeek2024Date.description(with: userLocale)).")

/*:
 ### What happens if you set `DateComponents` to September 50, 2024?
*/

var sept50DateComponents = DateComponents(
  year: 2024,
  month: 9,
  day: 50)
let sept50Date = gregorianCalendar.date(from: sept50DateComponents)!
print("\n• September 50, 2024 is actually \(sept50Date.description(with: userLocale)).")


/*:
 ## Extracting `DateComponents` from a `Date` with `Calendar`
 
 ### Extracting all the components from a `Date`
 */

var iPhontevenoteDateComponents = gregorianCalendar.dateComponents(
    [
        .calendar,
        .day,
        .era,
        .hour,
        .minute,
        .month,
        .nanosecond,
        .quarter,
        .second,
        .timeZone,
        .weekday,
        .weekdayOrdinal,
        .weekOfMonth,
        .weekOfYear,
        .year,
        .yearForWeekOfYear
    ],
    from: iPhontevenoteDate
)
print("\nThe date components for the iPhone Stevenote date:")
print("• Calendar: \(iPhontevenoteDateComponents.calendar!.identifier)")
print("• Day: \(iPhontevenoteDateComponents.day!)")
print("• Era: \(iPhontevenoteDateComponents.era!)")
print("• Hour: \(iPhontevenoteDateComponents.hour!)")
print("• Minute: \(iPhontevenoteDateComponents.minute!)")
print("• Month: \(iPhontevenoteDateComponents.month!)")
print("• Nanosecond: \(iPhontevenoteDateComponents.nanosecond!)")
print("• Quarter: \(iPhontevenoteDateComponents.quarter!)")
print("• Second: \(iPhontevenoteDateComponents.second!)")
print("• Time zone: \(iPhontevenoteDateComponents.timeZone!)")
print("• Weekday: \(iPhontevenoteDateComponents.weekday!)")
print("• Weekday ordinal: \(iPhontevenoteDateComponents.weekdayOrdinal!)")
print("• Week of month: \(iPhontevenoteDateComponents.weekOfMonth!)")
print("• Week of year: \(iPhontevenoteDateComponents.weekOfYear!)")
print("• Year: \(iPhontevenoteDateComponents.year!)")
print("• Year for week of year: \(iPhontevenoteDateComponents.yearForWeekOfYear!)")

var pacificCalendar = Calendar(identifier: .gregorian)
pacificCalendar.timeZone = TimeZone(identifier: "America/Los_Angeles")!
pacificCalendar.locale = Locale.autoupdatingCurrent
iPhontevenoteDateComponents = pacificCalendar.dateComponents(
    [
        .calendar,
        .day,
        .era,
        .hour,
        .minute,
        .month,
        .nanosecond,
        .quarter,
        .second,
        .timeZone,
        .weekday,
        .weekdayOrdinal,
        .weekOfMonth,
        .weekOfYear,
        .year,
        .yearForWeekOfYear
    ],
    from: iPhontevenoteDate
)
print("\nThe date components for the iPhone Stevenote date - for the Pacific Calendar — are:")
print("• Calendar: \(iPhontevenoteDateComponents.calendar!.identifier)")
print("• Day: \(iPhontevenoteDateComponents.day!)")
print("• Era: \(iPhontevenoteDateComponents.era!)")
print("• Hour: \(iPhontevenoteDateComponents.hour!)")
print("• Minute: \(iPhontevenoteDateComponents.minute!)")
print("• Month: \(iPhontevenoteDateComponents.month!)")
print("• Nanosecond: \(iPhontevenoteDateComponents.nanosecond!)")
print("• Quarter: \(iPhontevenoteDateComponents.quarter!)")
print("• Second: \(iPhontevenoteDateComponents.second!)")
print("• Time zone: \(iPhontevenoteDateComponents.timeZone!)")
print("• Weekday: \(iPhontevenoteDateComponents.weekday!)")
print("• Weekday ordinal: \(iPhontevenoteDateComponents.weekdayOrdinal!)")
print("• Week of month: \(iPhontevenoteDateComponents.weekOfMonth!)")
print("• Week of year: \(iPhontevenoteDateComponents.weekOfYear!)")
print("• Year: \(iPhontevenoteDateComponents.year!)")
print("• Year for week of year: \(iPhontevenoteDateComponents.yearForWeekOfYear!)")

/*:
 ### What day of the week and week of the year will April Fools’ Day 2024 fall on?
 */

// Create the date
let aprilFoolsDay2024Components = DateComponents(
    year: 2024,
    month: 4,
    day: 1
)
let aprilFoolsDay2024Date = gregorianCalendar.date(from: aprilFoolsDay2024Components)!

// Extract the weekday and week of the year from the date
let wantedComponents = gregorianCalendar.dateComponents(
    [
        .weekday,
        .weekOfYear,
    ],
    from: aprilFoolsDay2024Date
)
let aprilFools2024Weekday = wantedComponents.weekday!
let aprilFools2024WeekdayName = gregorianCalendar.weekdaySymbols[aprilFools2024Weekday - 1]
let aprilFools2024WeekOfYear = wantedComponents.weekOfYear!
print("\nApril Fools’ Day 2024:")
print("• happens on day \(aprilFools2024Weekday) of the week (\(aprilFools2024WeekdayName)),")
print("• on week \(aprilFools2024WeekOfYear) of 2024.")


/*:
 ## The Big Challenge
 */

print("\nThe Big Challenge!")

// First, create the the date —
// third Wednday of July at 3:30 p.m. Pacific Time
let challengeDateComponents = DateComponents(
    calendar: gregorianCalendar,
    timeZone: TimeZone(identifier: "America/Los_Angeles")!,
    year: 2024,
    month: 7,
    hour: 15,
    minute: 30,
    weekday: 4,
    weekdayOrdinal: 3
)
let challengeDate = gregorianCalendar.date(from: challengeDateComponents)!
print("• The challenge date in the Gregorian calendar is \(challengeDate.description(with: userLocale)).")

var melbourneCalendar = Calendar(identifier: .gregorian)
melbourneCalendar.timeZone = TimeZone(identifier: "Australia/Melbourne")!
let melbourneDateComponents = melbourneCalendar.dateComponents(
  [
    .year,
    .month,
    .day,
    .weekday,
    .hour,
    .minute
  ],
  from: challengeDate)
print("• melbourneDateComponents: \(melbourneDateComponents)")

// Create the Coptic calendar and set its locale to Arabic(Egypt)
// so that it us Arabic month nam,
// and its time zone to Melbourne.
var copticCalendar = Calendar(identifier: .coptic)
copticCalendar.locale = Locale(identifier: "ar_EG")
copticCalendar.timeZone = TimeZone(identifier: "Australia/Melbourne")!

// Extract the date components from the date using the Coptic calendar
let challengeCopticComponents = copticCalendar.dateComponents(
  [
    .year,
    .month,
    .day,
    .weekday,
    .hour,
    .minute
  ],
  from: challengeDate)
let challengeYear = challengeCopticComponents.year!
let challengeMonth = challengeCopticComponents.month!
let challengeMonthName = copticCalendar.monthSymbols[challengeMonth - 1]
let challengeDay = challengeCopticComponents.day!
let challengeWeekday = challengeCopticComponents.weekday!
let challengeWeekdayName = copticCalendar.weekdaySymbols[challengeWeekday - 1]
let challengeHour = challengeCopticComponents.hour!
let challengeMinute = challengeCopticComponents.minute!
print("• The challenge date in the Coptic calendar happens on: ")
print("••• year \(challengeYear)")
print("••• month \(challengeMonth) (\(challengeMonthName))")
print("••• day \(challengeDay)")
print("••• weekday \(challengeWeekday) (\(challengeWeekdayName))")
print("••• hour \(challengeHour)")
print("••• minute \(challengeMinute) (Melbourne time).")
