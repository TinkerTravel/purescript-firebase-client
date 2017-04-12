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
import Control.Monad.Aff as Aff
import Control.Monad.Eff (Eff)
import Firebase (FIREBASE)
import Prelude
import Data.Maybe (Maybe (..))

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

foreign import signInWithPopupAff
  :: ∀ ui eff
   . Aff.Canceler (firebase :: FIREBASE | eff)
  -> Provider (popup :: PopupUI | ui)
  -> Aff (firebase :: FIREBASE | eff) Unit

signInWithPopup
  :: ∀ ui eff
   . Provider (popup :: PopupUI | ui)
  -> Aff (firebase :: FIREBASE | eff) Unit
signInWithPopup = signInWithPopupAff Aff.nonCanceler

--------------------------------------------------------------------------------

foreign import data User :: Type

foreign import userID :: User -> String

foreign import userDisplayNameMay :: Maybe String
                                  -> (String -> Maybe String)
                                  -> User
                                  -> Maybe String
foreign import userEmailMay :: Maybe String
                            -> (String -> Maybe String)
                            -> User
                            -> Maybe String
foreign import currentUserMay
  :: ∀ eff
   . (Maybe User)
  -> (User -> Maybe User)
  -> Eff (firebase :: FIREBASE | eff) (Maybe User)

currentUser
  :: ∀ eff. Eff (firebase :: FIREBASE | eff) (Maybe User)
currentUser = currentUserMay Nothing Just

userDisplayName :: User -> Maybe String
userDisplayName = userDisplayNameMay Nothing Just

userEmail :: User -> Maybe String
userEmail = userEmailMay Nothing Just
