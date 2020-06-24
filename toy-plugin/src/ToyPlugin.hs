
module ToyPlugin where


import GHC
import GHC.Paths (libdir)
import TcRnTypes
import Plugins


plugin :: Plugin
plugin = defaultPlugin { pluginRecompile = purePlugin
                       , typeCheckResultAction = typecheckHook
                       }


typecheckHook :: [CommandLineOption] -> ModSummary -> TcGblEnv -> TcM TcGblEnv
typecheckHook _ modSummary gblEnv = do
  _ <- runGhcT (Just libdir) $ do
    parsed <- parseModule cleanedSummary
    typecheckModule parsed
  pure gblEnv
  where
    -- Avoids loops in Ghci
    cleanedSummary :: ModSummary
    cleanedSummary = modSummary { ms_hspp_opts = (ms_hspp_opts modSummary) { cachedPlugins = []
                                                                           , staticPlugins = []
                                                                           }
                                }
