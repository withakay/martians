import qualified Data.Set as S
import Data.Char (isSpace)
import Data.List (dropWhileEnd)
import System.IO
import System.Exit

trim :: String -> String
trim = dropWhileEnd isSpace . dropWhile isSpace

splitWS :: String -> [String]
splitWS s = words s

dirs :: [Char]
dirs = ['N','E','S','W']

left, right :: Char -> Char
left d = dirs !! ((idx d + 3) `mod` 4) where idx c = maybe 0 id (lookup c (zip dirs [0..]))
right d = dirs !! ((idx d + 1) `mod` 4) where idx c = maybe 0 id (lookup c (zip dirs [0..]))

step :: Char -> (Int,Int)
step 'N' = (0,1)
step 'E' = (1,0)
step 'S' = (0,-1)
step 'W' = (-1,0)
step _   = (0,0)

inside :: Int -> Int -> Int -> Int -> Bool
inside x y mx my = 0<=x && x<=mx && 0<=y && y<=my

type Scent = (Int,Int,Char)

runOne :: Int -> Int -> S.Set Scent -> (Int,Int,Char,String) -> ((Int,Int,Char,Bool), S.Set Scent)
runOne mx my sc (x0,y0,d0,instr) = go x0 y0 d0 False sc instr
  where
    go x y d lost s [] = ((x,y,d,lost), s)
    go x y d True s _  = ((x,y,d,True), s)
    go x y d False s (c:cs)
      | c=='L' = go x y (left d) False s cs
      | c=='R' = go x y (right d) False s cs
      | c=='F' = let (dx,dy)=step d; nx=x+dx; ny=y+dy in
                 if inside nx ny mx my
                   then go nx ny d False s cs
                   else if (x,y,d) `S.member` s
                     then go x y d False s cs
                     else go x y d True (S.insert (x,y,d) s) cs
      | otherwise = go x y d False s cs

main :: IO ()
main = do
  contents <- getContents
  if all isSpace contents then hPutStrLn stderr "No input provided" >> exitWith (ExitFailure 1) else return ()
  let ls = filter (not . null) $ map trim $ lines contents
  if null ls then hPutStrLn stderr "Empty input" >> exitWith (ExitFailure 1) else return ()
  let hdr = splitWS (head ls)
  if length hdr < 2 then hPutStrLn stderr "Invalid header" >> exitWith (ExitFailure 1) else return ()
  let mx = read (hdr!!0) :: Int
      my = read (hdr!!1) :: Int
      pairs = takeWhile ((==2) . length) $ map (take 2) $ iterate (drop 2) (tail ls)
      robots = [ let [p,i] = pr; ws = splitWS p in (read (ws!!0), read (ws!!1), head (ws!!2), i)
               | pr <- pairs]
      (results, _) = foldl (\(acc,sc) r -> let (res, sc') = runOne mx my sc r in (acc++[res], sc')) ([], S.empty) robots
  mapM_ (\(x,y,d,lost) -> putStrLn $ show x ++ " " ++ show y ++ " " ++ [d] ++ (if lost then " LOST" else "")) results
  putStrLn ""

