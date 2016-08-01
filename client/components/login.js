import React, { Component } from 'react';

import {
  View,
  AsyncStorage,
  StyleSheet
} from 'react-native';

const FBSDK = require('react-native-fbsdk');
const {
  LoginButton,
  AccessToken
} = FBSDK;

var MiniMinionClient = require('../index.android');

class Login extends Component {
  constructor(props) {
    super(props);
  }

  getJWT(access_token) {
    fetch(("http://10.0.2.2:3000/access_token?code=" + access_token))
    .then((response) => response.json())
    .then((responseJson) => {
        AsyncStorage.setItem('jwt', responseJson.jwt);
    })
    .catch((error) => {
      console.error(error);
    });
  }

  render() {
    return (
      <View style={styles.button}>
        <LoginButton
          publishPermissions={["publish_actions"]}
          onLoginFinished={
            (error, result) => {
              if (error) {
                alert("login has error: " + result.error);
              } else if (result.isCancelled) {
                alert("login is cancelled.");
              } else {
                AccessToken.getCurrentAccessToken().then(
                  (data) => {
                    this.getJWT(data.accessToken.toString())
                  }
                )
              }
            }
          }
          onLogoutFinished={() => alert("logout.")}/>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  button: {
    flex: 1,
    flexDirection: 'column',
    justifyContent: 'center',
    alignItems: 'center',
  }
});

module.exports = Login;
