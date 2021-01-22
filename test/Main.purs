module Test.Main where

import Prelude

import Data.Maybe (Maybe(..))
import Effect (Effect)
import Qieyun
  ( PhonologicalPosition
  -- The six elements of a phonological position
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
  , phonologicalPosition
  , fromPhonologicalDescription
  , fromPhonologicalEncoding
  -- Queries
  , representativeCharacter
  , fanqie
  )

foreign import exit :: String -> Effect Unit

shouldEqual :: forall a. Show a => Eq a => a -> a -> Effect Unit
shouldEqual a b =
  if a /= b
    then exit $ show a <> " should be equal to " <> show b
    else pure unit

x :: PhonologicalPosition
x = fromPhonologicalEncoding "A5T"

main :: Effect Unit
main = do
  let pp = fromPhonologicalDescription "幫三凡入"

  initial pp `shouldEqual` "幫"
  rounding pp `shouldEqual` Nothing
  division pp `shouldEqual` "三"
  repeatedInitial pp `shouldEqual` Nothing
  rhyme pp `shouldEqual` "凡"
  tone pp `shouldEqual` "入"

  placeOfArticulation pp `shouldEqual` "脣"
  voicing pp `shouldEqual` "全清"
  phonologicalClass pp `shouldEqual` "咸"

  phonologicalDescription pp `shouldEqual` "幫三凡入"
  phonologicalEncoding pp `shouldEqual` "A5T"
  phonologicalExpression pp `shouldEqual` "幫母 三等 凡韻 入聲"

  representativeCharacter pp `shouldEqual` Just "法"
  fanqie "法" pp `shouldEqual` Just "方乏"

  satisfies pp "脣音" `shouldEqual` true
  satisfies pp "三等 平聲" `shouldEqual` false

  pp `shouldEqual` fromPhonologicalEncoding "A5T"
  pp `shouldEqual` phonologicalPosition "幫" Nothing "三" Nothing "凡" "入"
