# Soundex
Swift implementation of the original Soundex algorithm.

Soundex is a simple algorithm to convert a string into a coded representation that helps categorize a string by its sound in US English.

The Soundex algorithm was invented in 1918 and was used by the US Census. More information on Wikipedia https://en.wikipedia.org/wiki/Soundex

## Usage

let c = Soundex()

c.soundex(of:"Christopher") // C631
