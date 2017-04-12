'use strict'

exports.newEmailProvider = function () {
  return new firebase.auth.EmailAuthProvider()
}

exports.newFacebookProvider = function () {
  return new firebase.auth.FacebookAuthProvider()
}

exports.newGitHubProvider = function () {
  return new firebase.auth.GithubAuthProvider()
}

exports.newGoogleProvider = function () {
  return new firebase.auth.GoogleAuthProvider()
}

exports.newTwitterProvider = function () {
  return new firebase.auth.TwitterAuthProvider()
}

exports.addScope = function (provider) {
  return function (scope) {
    return function () {
      provider.addScope(scope)
    }
  }
}

exports.signInWithPopupAff = function (nonCanceler) {
  return function (provider) {
    return function (onSuccess, onError) {
      firebase.auth().signInWithPopup(provider)
        .then(function (response) { onSuccess({}) })
        .catch(function (error) { onError(error) })
      return nonCanceler
    }
  }
}

/*----------------------------------------------------------------------------*/

exports.userID = function(user) {
  return user.uid;
};

var toMaybe = function (nothing, just, value) {
  if (value === null) return nothing else return just(value)
}

exports.userDisplayNameMay = function(nothing) {
  return function(just) {
    return function(user) {
      return toMaybe(nothing, just, user.displayName)
    }
  }
}

exports.userEmailMay = function(user) {
  return function(just) {
    return function(user) {
      return toMaybe(nothing, just, user.email)
    }
  }
}

exports.currentUserMay = function() {
  return function(just) {
    return function(user) {
      var user = firebase.auth().currentUser
      return toMaybe(nothing, just, user)
    }
  }
}
