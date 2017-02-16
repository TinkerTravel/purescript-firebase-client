module Firebase.Database
  ( onValue
  ) where

import Control.Monad.Eff (Eff)
import Data.Argonaut.Core (Json)
import Firebase (FIREBASE)
import Prelude

foreign import onValue
  :: ∀ eff
   . String
  -> (Json -> Eff (firebase :: FIREBASE | eff) Unit)
  -> Eff (firebase :: FIREBASE | eff) (Eff (firebase :: FIREBASE | eff) Unit)
