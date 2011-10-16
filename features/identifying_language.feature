Feature: Identifying language

Scenario Outline: Guess the language of file with one given language file
Given A language identifier built with the words from the given <language_file>
When  Give a file <test_file> in the same format with unknown origin
Then  I will identify its language as <language>

Scenarios:
| language_file    |  test_file        | language  |
| "ENGLISH.1"      |  "ENGLISH1.txt"   | "ENGLISH"  |
| "ENGLISH.2"      |  "ENGLISH2.txt"   | "ENGLISH"  |
| "FRENCH.1"       |  "FRENCH.txt"     | "FRENCH"  |
| "GAELIC.1"       |  "GAELIC.txt"     | "GAELIC"  |
| "GAELIC.1"       |  "UNKNOWN.txt"    | "UNKNOWN"  |

Scenario Outline: Guess the language of a given file with a number of languages files
Given A language identifier built with a number of language files in the seeds folder,
When  Give a file <test_file> in the same format with unknown origin
Then  I will identify its language as <language>

Scenarios:
|  test_file    | language  |
|  "TEXT.txt"   |  "JAPANESE" |




