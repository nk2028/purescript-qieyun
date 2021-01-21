-- | A PureScript library for the Qieyun phonological system (切韻音系).

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
  , satisfies
  -- Constructor
  , phonologicalLocation
  , fromPhonologicalDescription
  , fromPhonologicalEncoding
  -- Queries
  , representativeCharacter
  , fanqie
  , entries
  , queryCharacter
  -- List all phonological locations
  , getPhonologicalLocations
  ) where

import Prelude

import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe, toNullable)

foreign import data PhonologicalLocation :: Type

-- Instances

foreign import eqPhonologicalLocation1 :: PhonologicalLocation -> PhonologicalLocation -> Boolean

instance eqPhonologicalLocation :: Eq PhonologicalLocation where
  eq = eqPhonologicalLocation1

instance showPhonologicalLocation :: Show PhonologicalLocation where
  show pl = "#" <> phonologicalDescription pl

-- The six elements of a phonological location (音韻地位)

-- | Get the initial (母) from a phonological location (音韻地位).
-- |
-- | ```purescript
-- | initial $ fromPhonologicalDescription "幫三凡入" = "幫"
-- | initial $ fromPhonologicalDescription "羣開三A支平" = "羣"
-- | ```
foreign import initial :: PhonologicalLocation -> String

foreign import rounding1 :: PhonologicalLocation -> Nullable String

-- | Get the rounding (開合) from a phonological location (音韻地位).
-- |
-- | ```purescript
-- | rounding $ fromPhonologicalDescription "幫三凡入" = Nothing
-- | rounding $ fromPhonologicalDescription "羣開三A支平" = Just "開"
-- | ```
rounding :: PhonologicalLocation -> Maybe String
rounding = toMaybe <$> rounding1

-- | Get the division (等) from a phonological location (音韻地位).
-- |
-- | ```purescript
-- | division $ fromPhonologicalDescription "幫三凡入" = "三"
-- | division $ fromPhonologicalDescription "羣開三A支平" = "三"
-- | ```
foreign import division :: PhonologicalLocation -> String

foreign import repeatedInitial1 :: PhonologicalLocation -> Nullable String

-- | Get the repeated initial (重紐) from a phonological location (音韻地位).
-- |
-- | ```purescript
-- | repeatedInitial $ fromPhonologicalDescription "幫三凡入" = Nothing
-- | repeatedInitial $ fromPhonologicalDescription "羣開三A支平" = Just "A"
-- | ```
repeatedInitial :: PhonologicalLocation -> Maybe String
repeatedInitial = toMaybe <$> repeatedInitial1

-- | Get the rhyme (韻) from a phonological location (音韻地位).
-- |
-- | ```purescript
-- | rhyme $ fromPhonologicalDescription "幫三凡入" = "凡"
-- | rhyme $ fromPhonologicalDescription "羣開三A支平" = "支"
-- | ```
foreign import rhyme :: PhonologicalLocation -> String

-- | Get the tone (聲) from a phonological location (音韻地位).
-- |
-- | ```purescript
-- | tone $ fromPhonologicalDescription "幫三凡入" = "入"
-- | tone $ fromPhonologicalDescription "羣開三A支平" = "平"
-- | ```
foreign import tone :: PhonologicalLocation -> String

-- Extended phonological attributes

-- | Get the place of articulation (音) from a phonological location (音韻地位).
-- |
-- | ```purescript
-- | placeOfArticulation $ fromPhonologicalDescription "幫三凡入" = "脣"
-- | placeOfArticulation $ fromPhonologicalDescription "羣開三A支平" = "牙"
-- | ```
foreign import placeOfArticulation :: PhonologicalLocation -> String

-- | Get the voicing (清濁) from a phonological location (音韻地位).
-- |
-- | ```purescript
-- | voicing $ fromPhonologicalDescription "幫三凡入" = "全清"
-- | voicing $ fromPhonologicalDescription "羣開三A支平" = "全濁"
-- | ```
foreign import voicing :: PhonologicalLocation -> String

-- | Get the class (攝) from a phonological location (音韻地位).
-- |
-- | ```purescript
-- | phonologicalClass $ fromPhonologicalDescription "幫三凡入" = "咸"
-- | phonologicalClass $ fromPhonologicalDescription "羣開三A支平" = "止"
-- | ```
foreign import phonologicalClass :: PhonologicalLocation -> String

-- | Check if a phonological location (音韻地位) satisfies the given phonological expression (音韻表達式).
-- |
-- | ```purescript
-- | fromPhonologicalDescription "幫三凡入" `satisfies` "章母" = false
-- | fromPhonologicalDescription "幫三凡入" `satisfies` "一四等" = false
-- | fromPhonologicalDescription "幫三凡入" `satisfies` "幫組 或 陽韻" = true
-- | ```
foreign import satisfies :: PhonologicalLocation -> String -> Boolean

-- Phonological description and encoding

-- | Get the phonological description (音韻描述) of a phonological location (音韻地位).
-- |
-- | ```purescript
-- | phonologicalDescription $ fromPhonologicalDescription "幫三凡入" = "幫三凡入"
-- | phonologicalDescription $ fromPhonologicalDescription "羣開三A支平" = "羣開三A支平"
-- | ```
foreign import phonologicalDescription :: PhonologicalLocation -> String

-- | Get the phonological encoding (音韻編碼) of a phonological location (音韻地位).
-- |
-- | ```purescript
-- | phonologicalEncoding $ fromPhonologicalDescription "幫三凡入" = "A5T"
-- | phonologicalEncoding $ fromPhonologicalDescription "羣開三A支平" = "fEQ"
-- | ```
foreign import phonologicalEncoding :: PhonologicalLocation -> String

-- | Get the phonological expression (音韻表達式) of a phonological location (音韻地位).
-- |
-- | ```purescript
-- | phonologicalExpression $ fromPhonologicalDescription "幫三凡入" = "幫母 三等 凡韻 入聲"
-- | phonologicalExpression $ fromPhonologicalDescription "羣開三A支平" = "羣母 開口 三等 重紐A類 支韻 平聲"
-- | ```
foreign import phonologicalExpression :: PhonologicalLocation -> String

-- Constructor

foreign import phonologicalLocation1 :: String -> Nullable String -> String -> Nullable String -> String -> String -> PhonologicalLocation

-- | Construct a phonological location (音韻地位) by the given six elements of a phonological location.
-- |
-- | ```purescript
-- | phonologicalLocation "幫" Nothing "三" Nothing "凡" "入" = #幫三凡入
-- | phonologicalLocation "羣" (Just "開") "三" (Just "A") "支" "平" = #羣開三A支平
-- | ```
-- |
-- | **Unsafe:** throw a runtime exception if the given six elements of a phonological location is invalid.
phonologicalLocation :: String -> Maybe String -> String -> Maybe String -> String -> String -> PhonologicalLocation
phonologicalLocation a b c d e f = phonologicalLocation1 a (toNullable b) c (toNullable d) e f

-- | Convert a phonological description (音韻描述) to the corresponding phonological location (音韻地位).
-- |
-- | ```purescript
-- | fromPhonologicalDescription "幫三凡入" = #幫三凡入
-- | fromPhonologicalDescription "羣開三A支平" = #羣開三A支平
-- | ```
-- |
-- | **Unsafe:** throw a runtime exception if the given phonological description is invalid.
foreign import fromPhonologicalDescription :: String -> PhonologicalLocation

-- | Convert a phonological encoding (音韻編碼) to the corresponding phonological location (音韻地位).
-- |
-- | ```purescript
-- | fromPhonologicalEncoding "A5T" = #幫三凡入
-- | fromPhonologicalEncoding "fEQ" = #羣開三A支平
-- | ```
-- |
-- | **Unsafe:** throw a runtime exception if the given phonological encoding is invalid.
foreign import fromPhonologicalEncoding :: String -> PhonologicalLocation

-- Queries

foreign import representativeCharacter1 :: PhonologicalLocation -> Nullable String

-- | Get the representative character (代表字) of a phonological location (音韻地位).
-- |
-- | ```purescript
-- | representativeCharacter $ fromPhonologicalDescription "幫三凡入" = Just "法"
-- | representativeCharacter $ fromPhonologicalDescription "羣開三A支平" = Just "祇"
-- | representativeCharacter $ fromPhonologicalDescription "常開三麻去" = Nothing
-- | ```
representativeCharacter ::  PhonologicalLocation -> Maybe String
representativeCharacter pl = toMaybe $ representativeCharacter1 pl

foreign import fanqie1 :: String -> PhonologicalLocation -> Nullable String

-- | Get the fanqie (反切) of a phonological location (音韻地位).
-- |
-- | ```purescript
-- | fanqie "法" $ fromPhonologicalDescription "幫三凡入" = Just "方乏"
-- | fanqie "祇" $ fromPhonologicalDescription "羣開三A支平" = Just "巨支"
-- | ```
-- |
-- | If you want to get the default fanqie of a phonological location, you can provide some random characters
-- | as the first parameter, such as `"?"`.
-- |
-- | ```purescript
-- | fanqie "?" $ fromPhonologicalDescription "幫三凡入" = Just "方乏"
-- | fanqie "?" $ fromPhonologicalDescription "羣開三A支平" = Just "巨支"
-- | fanqie "?" $ fromPhonologicalDescription "常開三麻去" = Nothing
-- | ```
fanqie :: String -> PhonologicalLocation -> Maybe String
fanqie ch pl = toMaybe $ fanqie1 ch pl

-- | Get the corresponding characters and their explanations of a phonological location (音韻地位).
-- |
-- | ```purescript
-- | entries $ fromPhonologicalDescription "影開二銜去" = [{ character: "𪒠", explanation: "叫呼仿佛𪒠然自得音黯去聲一" }]
-- | entries $ fromPhonologicalDescription "常開三麻去" = []
-- | ```
foreign import entries :: PhonologicalLocation -> Array { character :: String, explanation :: String }

-- | Get the explanations and phonological locations (音韻地位) of a character.
-- |
-- | ```purescript
-- | queryCharacter "結" = [{ explanation: "締也古屑切十五", phonologicalLocation: #見開四先入 }]
-- | ```
foreign import queryCharacter :: String -> Array { explanation :: String, phonologicalLocation :: PhonologicalLocation }

-- List all phonological locations

-- | Get an array of all the phonological locations (音韻地位) which correspond to at least one character.
foreign import getPhonologicalLocations :: Unit -> Array PhonologicalLocation
