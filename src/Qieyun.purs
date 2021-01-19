module Qieyun (
  PhonologicalLocation,

  initial,
  rounding,
  division,
  repeatedInitial,
  rhyme,
  tone,

  placeOfArticulation,
  voicing,
  phonologicalClass,

  phonologicalDescription,
  phonologicalEncoding,
  phonologicalExpression,
  fromPhonologicalDescription,

  representativeCharacter,
  fanqie,
  entries,
  belongsTo,
  queryCharacter,
  getPhonologicalLocations
) where

import Prelude

import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import Data.String.CodeUnits (singleton)
import Data.String.Unsafe (char)

foreign import data PhonologicalLocation :: Type

-- The six elements of a phonological location

-- | Get the initial (母) from a phonological location.
foreign import initial :: PhonologicalLocation -> String

foreign import rounding1 :: PhonologicalLocation -> Nullable String

-- | Get the rounding (開合) from a phonological location.
rounding ::  PhonologicalLocation -> Maybe String
rounding = toMaybe <$> rounding1

-- | Get the division (等) from a phonological location.
foreign import division :: PhonologicalLocation -> String

foreign import repeatedInitial1 :: PhonologicalLocation -> Nullable String

-- | Get the repeated initial (重紐) from a phonological location.
repeatedInitial :: PhonologicalLocation -> Maybe String
repeatedInitial = toMaybe <$> repeatedInitial1

-- | Get the rhyme (韻) from a phonological location.
foreign import rhyme :: PhonologicalLocation -> String

-- | Get the tone (聲) from a phonological location.
foreign import tone :: PhonologicalLocation -> String

-- Extended phonological attributes

-- | Get the place of articulation (音) from a phonological location.
foreign import placeOfArticulation :: PhonologicalLocation -> String

-- | Get the voicing (清濁) from a phonological location.
foreign import voicing :: PhonologicalLocation -> String

-- | Get the class (攝) from a phonological location.
foreign import phonologicalClass :: PhonologicalLocation -> String

-- 其他音韻屬性

foreign import phonologicalDescription :: PhonologicalLocation -> String
foreign import phonologicalEncoding :: PhonologicalLocation -> String
foreign import phonologicalExpression :: PhonologicalLocation -> String
foreign import fromPhonologicalDescription1 :: String -> Nullable PhonologicalLocation

fromPhonologicalDescription :: String -> Maybe PhonologicalLocation
fromPhonologicalDescription = toMaybe <$> fromPhonologicalDescription1

-- 代表字

foreign import representativeCharacter1 :: PhonologicalLocation -> Nullable String

representativeCharacter ::  PhonologicalLocation -> Maybe Char
representativeCharacter pl = map char $ toMaybe $ representativeCharacter1 pl

-- 反切

foreign import fanqie1 :: PhonologicalLocation -> String -> Nullable String

fanqie :: PhonologicalLocation -> Char -> Maybe String
fanqie pl ch = toMaybe $ fanqie1 pl $ singleton ch

foreign import entries :: PhonologicalLocation -> Array { character :: String, explanation :: String }

-- 屬於

foreign import belongsTo :: PhonologicalLocation -> String -> Boolean

-- 等於

foreign import eqPhonologicalLocation1 :: PhonologicalLocation -> PhonologicalLocation -> Boolean

instance eqPhonologicalLocation :: Eq PhonologicalLocation where
  eq = eqPhonologicalLocation1

-- show

instance showPhonologicalLocation :: Show PhonologicalLocation where
  show pl = "#" <> phonologicalDescription pl

-- query字頭

foreign import queryCharacter1 :: String -> Array { explanation :: String, phonologicalLocation :: PhonologicalLocation }

queryCharacter :: Char -> Array { explanation :: String, phonologicalLocation :: PhonologicalLocation }
queryCharacter ch = queryCharacter1 $ singleton ch

-- iter音韻地位

foreign import getPhonologicalLocations :: Unit -> Array PhonologicalLocation
