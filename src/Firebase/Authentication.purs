module Firebase.Authentication
  ( kind ProviderUI
  , PopupUI

  , Provider
  , newEmailProvider
  , newFacebookProvider
  , newGitHubProvider
  , newGoogleProvider
  , newTwitterProvider
  , addScope
  , signInWithPopup

  , User
  , userID
  , userEmail
  , userDisplayName
  , currentUser
  ) where

import Control.Monad.Aff (Aff)
import Control.Monad.Eff (Eff)
import Data.Maybe (Maybe)
import Firebase (FIREBASE)
import Prelude

--------------------------------------------------------------------------------

foreign import kind ProviderUI
foreign import data PopupUI :: ProviderUI

foreign import data Provider :: # ProviderUI -> Type

foreign import newEmailProvider
  :: ∀ eff. Eff (firebase :: FIREBASE | eff) (Provider ())

foreign import newFacebookProvider
  :: ∀ eff. Eff (firebase :: FIREBASE | eff) (Provider (popup :: PopupUI))

foreign import newGitHubProvider
  :: ∀ eff. Eff (firebase :: FIREBASE | eff) (Provider (popup :: PopupUI))

foreign import newGoogleProvider
  :: ∀ eff. Eff (firebase :: FIREBASE | eff) (Provider (popup :: PopupUI))

foreign import newTwitterProvider
  :: ∀ eff. Eff (firebase :: FIREBASE | eff) (Provider (popup :: PopupUI))

foreign import addScope
  :: ∀ ui eff
   . Provider ui
  -> String
  -> Eff (firebase :: FIREBASE | eff) Unit

foreign import signInWithPopup
  :: ∀ ui eff
   . Provider (popup :: PopupUI | ui)
  -> Aff (firebase :: FIREBASE | eff) Unit

--------------------------------------------------------------------------------

foreign import data User :: Type

foreign import userID :: User -> String
foreign import userDisplayName :: User -> String
foreign import userEmail :: User -> String

foreign import currentUser
  :: ∀ eff. Eff (firebase :: FIREBASE | eff) (Maybe User)
