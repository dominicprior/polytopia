import Text.Parsec
import Text.Printf

main = interact $ unlines . map f . lines

-- e.g. f "w w" = "4.5  4.5"
f :: String -> String
f s = fromRight $ parse p "" s

p :: Parsec String () String
p = do
  (aStr, dStr) <- split
  let (aType, ah, amax, _) = fromRight $ parse q "" aStr
  let (dType, dh, dmax, multiplier) = fromRight $ parse q "" dStr
  let a = getA aType
  let d = getD dType
  let af = a * ah / amax
  let df = d * dh / dmax
  let df' = d * dh * multiplier / dmax
  let aDmg = a * 4.5 * af / (af + df')
  -- let dDmg = d * 4.5 * df / (af + df)
  let dDmg = d * 4.5 * df' / (af + df')
  return $ printf "%.1f  %.1f" aDmg dDmg

-- Returns (type, health, maxHealth, multiplier)
-- e.g. ('w', 8, 10, 1.5)  -- warrior in a forest
q :: Parsec String () (Char, Double, Double, Double)
q = do
  t <- anyChar
  v <- many $ char 'v'
  f <- many $ char 'f'
  healthStr <- many digit
  let h = if healthStr == ""
          then getH t
          else read healthStr
  let maxH = if v == "v"
             then getH t + 5
             else getH t
  return (t, h, maxH,
    if f == "ff" then 4.0 else if f == "f" then 1.5 else 1.0)

getA 'w' = 2
getA 'a' = 2
getA 'r' = 2
getA 's' = 3
getA 'd' = 1
getA 'b' = 1
getA 'k' = 3.5
getA 'g' = 5
getA 'h' = 2   -- ship
getA 'z' = 4   -- battle ship
getA 'c' = 4
getA 'm' = 0

getD 'w' = 2
getD 'a' = 1
getD 'r' = 1
getD 's' = 3
getD 'd' = 3
getD 'b' = 1
getD 'k' = 1
getD 'g' = 4
getD 'h' = 2   -- ship
getD 'z' = 3   -- battle ship
getD 'c' = 0
getD 'm' = 1

getH 'w' = 10
getH 'a' = 10
getH 'r' = 10
getH 's' = 15
getH 'd' = 15
getH 'b' = 10
getH 'k' = 15
getH 'g' = 40
getH 'h' = 10   -- ship
getH 'z' = 10   -- battle ship
getH 'c' = 10
getH 'm' = 10


split :: Parsec String () (String, String)
split = (,) <$> (many $ noneOf " ")
  <*> (many1 (char ' ') >> (many $ noneOf " "))

fromRight (Left e) = error $ show e
fromRight (Right x) = x
