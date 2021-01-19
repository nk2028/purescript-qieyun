module Qieyun
  ( PhonologicalLocation
  -- The six elements of a phonological location
  , initial
  , rounding
  , division
  , repeatedInitial
  , rhyme
  , tone
  -- Extended phonological attributes
  , placeOfArticulation
  , voicing
  , phonologicalClass
  -- Phonological description and encoding
  , phonologicalDescription
  , phonologicalEncoding
  , phonologicalExpression
  -- Constructor
  , fromPhonologicalDescription
  , fromPhonologicalEncoding

  , representativeCharacter
  , fanqie
  , entries
  , belongsTo
  , queryCharacter
  , getPhonologicalLocations
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

-- Phonological description and encoding

-- | Get the phonological description (音韻描述) of a phonological location.
foreign import phonologicalDescription :: PhonologicalLocation -> String

-- | Get the phonological encoding (音韻編碼) of a phonological location.
foreign import phonologicalEncoding :: PhonologicalLocation -> String

-- | Get the phonological expression (音韻表達式) of a phonological location.
foreign import phonologicalExpression :: PhonologicalLocation -> String

-- Constructor

-- | Convert a phonological description (音韻描述) to the corresponding phonological location (音韻地位).
foreign import fromPhonologicalDescription1 :: String -> Nullable PhonologicalLocation

fromPhonologicalDescription :: String -> Maybe PhonologicalLocation
fromPhonologicalDescription = toMaybe <$> fromPhonologicalDescription1

-- | Convert a phonological encoding (音韻編碼) to the corresponding phonological location (音韻地位).
foreign import fromPhonologicalEncoding1 :: String -> Nullable PhonologicalLocation

fromPhonologicalEncoding :: String -> Maybe PhonologicalLocation
fromPhonologicalEncoding = toMaybe <$> fromPhonologicalEncoding1

-- representative character and fanqie

foreign import representativeCharacter1 :: PhonologicalLocation -> Nullable String

representativeCharacter ::  PhonologicalLocation -> Maybe Char
representativeCharacter pl = map char $ toMaybe $ representativeCharacter1 pl

foreign import fanqie1 :: PhonologicalLocation -> String -> Nullable String

fanqie :: PhonologicalLocation -> Char -> Maybe String
fanqie pl ch = toMaybe $ fanqie1 pl $ singleton ch

-- entries

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
