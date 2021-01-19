module Test.Main where

import Prelude

import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Class.Console (log)
import Node.Process (exit)
import Qieyun (
  initial,
  rounding,
  division,
  repeatedInitial,
  rhyme,
  tone,

  voicing,
  phonologicalClass,
  placeOfArticulation,

  phonologicalDescription,
  phonologicalEncoding,
  phonologicalExpression,
  fromPhonologicalDescription,

  representativeCharacter,
  fanqie,
  belongsTo
)

shouldEqual :: forall a. Show a => Eq a => a -> a -> Effect Unit
shouldEqual a b =
  if a /= b
    then do
      log $ "Error: " <> (show a) <> " should be equal to " <> (show b)
      exit 1
    else pure unit

main :: Effect Unit
main = do
  case fromPhonologicalDescription "幫三凡入" of
    Nothing -> log "Error"
    Just pl -> do
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

      representativeCharacter pl `shouldEqual` Just '法'
      fanqie pl '法' `shouldEqual` Just "方乏"

      belongsTo pl "脣音" `shouldEqual` true
      belongsTo pl "三等 平聲" `shouldEqual` false
