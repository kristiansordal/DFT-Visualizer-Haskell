{-# OPTIONS_GHC -Wno-name-shadowing #-}
{-# OPTIONS_GHC -Wno-unused-local-binds #-}

module Wave where

import Data.List

type Sample = (Float, Float)

data Wave = Wave
  { amplitude :: Float,
    frequency :: Integer,
    phase :: Float,
    translation :: Float,
    len :: Float,
    samples :: [Sample]
  }
  deriving (Read, Show)



createWave :: Float -> Integer -> Float -> Float -> Float -> Float -> Wave
createWave amp freq phase trans len sampling =
  Wave
    { amplitude = amp,
      frequency = freq,
      phase = phase,
      translation = trans,
      len = len,
      samples = zip xCoords yCoords
    }
  where
    xCoords = [0.0, 1 / sampling .. len]
    yCoords = map (\x -> amp * sin (2 * pi * fromIntegral freq * x + phase) + trans) xCoords

interference :: [Wave] -> [Sample]
interference ws = zip (map fst (samples $ head ws)) yCoords
  where
    s = map samples ws
    yCoords = map sum (transpose $ map (map snd) s)
