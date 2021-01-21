module Test.Main where

import Prelude

import Data.Maybe (Maybe(..))
import Effect (Effect)
import Qieyun
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
  )

foreign import exit :: String -> Effect Unit

shouldEqual :: forall a. Show a => Eq a => a -> a -> Effect Unit
shouldEqual a b =
  if a /= b
    then exit $ show a <> " should be equal to " <> show b
    else pure unit

x :: PhonologicalLocation
x = fromPhonologicalEncoding "A5T"

main :: Effect Unit
main = do
  let pl = fromPhonologicalDescription "幫三凡入"

  initial pl `shouldEqual` "幫"
  rounding pl `shouldEqual` Nothing
  division pl `shouldEqual` "三"
  repeatedInitial pl `shouldEqual` Nothing
  rhyme pl `shouldEqual` "凡"
  tone pl `shouldEqual` "入"

  placeOfArticulation pl `shouldEqual` "脣"
  voicing pl `shouldEqual` "全清"
  phonologicalClass pl `shouldEqual` "咸"

  phonologicalDescription pl `shouldEqual` "幫三凡入"
  phonologicalEncoding pl `shouldEqual` "A5T"
  phonologicalExpression pl `shouldEqual` "幫母 三等 凡韻 入聲"

  representativeCharacter pl `shouldEqual` Just "法"
  fanqie "法" pl `shouldEqual` Just "方乏"

  satisfies pl "脣音" `shouldEqual` true
  satisfies pl "三等 平聲" `shouldEqual` false

  pl `shouldEqual` fromPhonologicalEncoding "A5T"
  pl `shouldEqual` phonologicalLocation "幫" Nothing "三" Nothing "凡" "入"
