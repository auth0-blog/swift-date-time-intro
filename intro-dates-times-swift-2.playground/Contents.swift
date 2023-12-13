/*:
 # Introduction to Date and Time Programming in Swift, Part 2
 
 This playground contains all the code in the article in the Auth0 by Okta blog post titled [_Introduction to Date and Time Programming in Swift, Part 2_](https://auth0.com/blog/introduction-date-time-programming-swift-2/).
 */


import Cocoa

/*:
 ## Turning `Date`s into Strings with the `formatted()` Method
 
 ### Getting the date and time in predefined string formats
 */

// Create a variable that always contains the user’s current
// `Locale` setting, even when the user changes it
var userLocale = Locale.autoupdatingCurrent
// We need a calendar instance to add context to `Date` objects,
// which can only tell time as a number of seconds
// before or after January 1, 2001, 00:00:00 UTC
var gregorianCalendar = Calendar(identifier: .gregorian)
gregorianCalendar.locale = userLocale

var swiftDebutComponents = DateComponents(
  year: 2014,
  month: 6,
  day: 2
)
var swiftDebutDate = gregorianCalendar.date(from: swiftDebutComponents)!
print("Swift's debut date: \(swiftDebutDate.formatted())")

print("\nJust the date, in all its forms:")
print("1. Complete: \(swiftDebutDate.formatted(date: .complete, time: .omitted))")
print("2. Abbreviated: \(swiftDebutDate.formatted(date: .abbreviated, time: .omitted))")
print("3. Long: \(swiftDebutDate.formatted(date: .long, time: .omitted))")
print("4. Numeric: \(swiftDebutDate.formatted(date: .numeric, time: .omitted))")

print("\nJust the time, in all its forms:")
print("1. Complete: \(swiftDebutDate.formatted(date: .omitted, time: .complete))")
print("2. Shortened: \(swiftDebutDate.formatted(date: .omitted, time: .shortened))")
print("3. Standard: \(swiftDebutDate.formatted(date: .omitted, time: .standard))")

print("\nJust a few date and time combinations:")
print("1. Complete/Complete: \(swiftDebutDate.formatted(date: .complete, time: .complete))")
print("2. Abbreviated/Shortened: \(swiftDebutDate.formatted(date: .abbreviated, time: .shortened))")
print("3. Numeric/Shortened: \(swiftDebutDate.formatted(date: .numeric, time: .shortened))")

/*:
 ### Getting very specific about `formatted()`’s date and time formats
 */

let fancyDateString = swiftDebutDate.formatted(
    Date.FormatStyle()
        .year(.twoDigits)
        .month(.wide)
        .day(.twoDigits)
)
print("\n• Fancy date string: \(fancyDateString)")

let superFancyDateString = swiftDebutDate.formatted(
    .dateTime // The `dateTime` property returns a `Date.FormatStyle` object
        .year(.defaultDigits)
        .month(.abbreviated)
        .day(.twoDigits)
        .hour(.defaultDigits(amPM: .abbreviated))
        .minute(.twoDigits)
        .timeZone(.identifier(.long))
        .era(.wide)
        .dayOfYear(.defaultDigits)
        .weekday(.abbreviated)
        .week(.defaultDigits)
)
print("• Super fancy date string: \(superFancyDateString)")


/*:
 ## Turning `Date`s into ISO8601 Strings with the `ISO8601Format()` method
 */

print("\nDates to ISO8601 strings:")
print("• ISO 8601 format for Swift’s debut date: \(swiftDebutDate.ISO8601Format()).")
swiftDebutDate.ISO8601Format()

let customizedISO8601DebutDate = swiftDebutDate.ISO8601Format(
    .iso8601
    .weekOfYear()     // Include week of the year, followed by “W”
    .year()           // Include year, omit month and day
    // .month()       // Uncomment to include the month
    // .day()         // Uncomment to include the day
    .dateSeparator(.omitted) // `.omitted` parameter removes data separator character
    .time(includingFractionalSeconds: true) // Include time and display fractions of seconds
    .timeSeparator(.colon) // `.colon` includes hour/minute separator
)
print("• Customized ISO 8601 format for Swift’s debut date: \(customizedISO8601DebutDate).")


/*:
 ## Turning `Date`s into Strings with `DateFormatter`
 
 ### Turning just the date into a string
 */

print("\nDates to strings:")

var myFormatter = DateFormatter()
print("• Swift’s debut date, via the DateFormatter: \(myFormatter.string(from: swiftDebutDate))")

myFormatter.dateStyle = .short
print("• Swift’s debut date, “short” style: \(myFormatter.string(from: swiftDebutDate)).")
myFormatter.dateStyle = .medium
print("• Swift’s debut date, “medium” style: \(myFormatter.string(from: swiftDebutDate))")
myFormatter.dateStyle = .long
print("• Swift’s debut date, “long” style: \(myFormatter.string(from: swiftDebutDate))")
myFormatter.dateStyle = .full
print("• Swift’s debut date, “full” style: \(myFormatter.string(from: swiftDebutDate))")
myFormatter.dateStyle = .none
print("• Swift’s debut date, “none” style: \(myFormatter.string(from: swiftDebutDate))")

/*:
 ### Turning a date and time into a string
 */

print("\nThe Swift debut date and time, converted into a string:")

let swiftUIDebutDateComponents = DateComponents(
  timeZone: TimeZone(abbreviation: "PDT"),
  year: 2019,
  month: 6,
  day: 3,
  hour: 12,
  minute: 8
)
var swiftUIDebutDate = gregorianCalendar.date(from: swiftUIDebutDateComponents)!
print("• The newly-created date: \(swiftUIDebutDate.description(with: userLocale)).")

myFormatter.dateStyle = .short
myFormatter.timeStyle = .short
print("• Swift’s debut date and time, “short” style: \(myFormatter.string(from: swiftUIDebutDate)).")

myFormatter.dateStyle = .medium
myFormatter.timeStyle = .medium
print("• Swift’s debut date and time, “medium” style: \(myFormatter.string(from: swiftUIDebutDate)).")

myFormatter.dateStyle = .long
myFormatter.timeStyle = .long
print("• Swift’s debut date and time, “long” style: \(myFormatter.string(from: swiftUIDebutDate)).")

myFormatter.dateStyle = .full
myFormatter.timeStyle = .full
print("• Swift’s debut date and time, “full” style: \(myFormatter.string(from: swiftUIDebutDate)).")

myFormatter.dateStyle = .full
myFormatter.timeStyle = .short
print("• Swift’s debut date and time, with “full” style date and “short” style time: \(myFormatter.string(from: swiftUIDebutDate)).")

// Show only the time
myFormatter.dateStyle = .none
myFormatter.timeStyle = .medium
print("• Swift’s debut time: \(myFormatter.string(from: swiftUIDebutDate)).")

// Show only the date
myFormatter.dateStyle = .full
myFormatter.timeStyle = .none
print("• Swift’s debut date: \(myFormatter.string(from: swiftUIDebutDate)).")

/*:
 ### Expressing dates and times in languages other than English
 */

print("\nDates and times in languages other than English")

// We want to see as much of these languages as possible,
// so let’s set both dateStyle and timeStyle to .full.
myFormatter.dateStyle = .full
myFormatter.timeStyle = .full

myFormatter.locale = Locale(identifier: "fr")
print("• International French: \(myFormatter.string(from: swiftUIDebutDate)).")

myFormatter.locale = Locale(identifier: "fr-CA")
print("• Canadian French: \(myFormatter.string(from: swiftUIDebutDate)).")

myFormatter.locale = Locale(identifier: "hr")
print("• Croatian: \(myFormatter.string(from: swiftUIDebutDate)).")

myFormatter.locale = Locale(identifier: "ko_KR")
print("• Korean: \(myFormatter.string(from: swiftUIDebutDate)).")

/*:
### Expressing dates and times in custom formats
 */

print("\nDates and times in custom formats")

// Setting the locale to POSIX ensures that the user's locale
// won't be used to format the Date.
myFormatter.locale = Locale(identifier: "en_US_POSIX")

// DateFormatter's format string uses the date format specifiers
// spelled out in Unicode Technical Standard #35 (located at
// http://www.unicode.org/reports/tr35/tr35-25.html#Date_Format_Patterns)
myFormatter.dateFormat = "y-MM-dd"
print("• y-MM-dd format: \(myFormatter.string(from: swiftUIDebutDate)).")

myFormatter.dateFormat = "MM/dd/yy"
print("• MM/dd/yy format: \(myFormatter.string(from: swiftUIDebutDate)).")

myFormatter.dateFormat = "MMM dd, yyyy"
print("• MMM dd, yyyy format: \(myFormatter.string(from: swiftUIDebutDate)).")

myFormatter.dateFormat = "EEEE, MMMM dd, yyyy' at 'h:mm a zzzz"
print("• EEEE, MMMM dd, yyyy' at 'h:mm a zzzz format: \(myFormatter.string(from: swiftUIDebutDate)).")

// You can get really experimental with formatting strings.
// (Don’t know what “Zero Wing” is? See this article:
// https://tvtropes.org/pmwiki/pmwiki.php/VideoGame/ZeroWing
myFormatter.dateFormat = "'🚀 In' G y', SwiftUI was beginning. All your UI are belong to us! 🚀"
print("• Zero Wing format: \(myFormatter.string(from: swiftUIDebutDate)).")


/*:
 ## Turning Strings into `Date`s with `DateFormatter`
 */

print("\nTurning strings into Dates with DateFormatter")

// Let’s define the format for date strings we want to parse:
myFormatter.dateFormat = "yyyy/MM/dd hh:mm Z"

// Here's a date in the specified format.
// DateFormatter’s date(from:) method will be able to parse it.
let newDate1 = myFormatter.date(from: "2019/06/03 12:08 -0700")
print("• newDate1’s value is: \(newDate1?.description ?? "nil").")

// And here's the same date, but in a different format.
// The formatter won’t be able to convert it into a date.
let newDate2 = myFormatter.date(from: "Jun 6, 2019, 12:08 PM PDT")
print("• newDate2’s value is: \(newDate2?.description ?? "nil").")

// Let's change the date format strings and try
// date(from:) with the same two strings:
myFormatter.dateFormat = "MMM d, yyyy, hh:mm a zz"

let newDate3 = myFormatter.date(from: "2019/06/03 12:08 -0700")
print("• newDate3’s value is: \(newDate3?.description ?? "nil").")

let newDate4 = myFormatter.date(from: "Jun 6, 2019, 12:08 PM PDT")
print("• newDate4’s value is: \(newDate4?.description ?? "nil").")

// Don’t forget that you can get unconventional if you expect to
// parse dates in unconventional formats!
// (D is the format string for “day of year”, which can be 1...366)
myFormatter.dateFormat = "y 😍 D"
let emojiDate = myFormatter.date(from: "2024 😍 333")
print("• emojiDate’s value is: \(emojiDate?.description ?? "nil").")


/*:
 ## The Big Challenge, Once Again
 */

print("\nThe Big Challenge, once again")

// First, create the the date —
// third Wednesday of July at 3:30 p.m. Pacific Time
let challengeDateComponents = DateComponents(
    calendar: gregorianCalendar,
    timeZone: TimeZone(identifier: "America/Los_Angeles")!,
    year: 2023,
    month: 7,
    hour: 15,
    minute: 30,
    weekday: 4,
    weekdayOrdinal: 3
)
let challengeDate = gregorianCalendar.date(from: challengeDateComponents)!
print("• The challenge date in the Gregorian calendar and the US Pacific time zone is \(challengeDate.description(with: userLocale)).")

// Then, we’ll need a Coptic calendar set Melbourne, Australia’s time zone:
var copticCalendar = Calendar(identifier: .coptic)
copticCalendar.locale = Locale(identifier: "ar_EG")
copticCalendar.timeZone = TimeZone(identifier: "Australia/Melbourne")!

// And finally, we’ll use a `DateFormatter` to display the date
// in the desired format
myFormatter.calendar = copticCalendar
myFormatter.timeZone = copticCalendar.timeZone
myFormatter.dateStyle = .full
myFormatter.timeStyle = .full
print("• The challenge date is \(myFormatter.string(from: challengeDate)).")
