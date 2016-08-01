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
    this.state = {
      current_user_status: ""
    }
  }

  determineNav() {
    if(this.state.current_user_status == "registered") {
      this.navCreateMinion();
    } else if(this.state.current_user_status == "active") {
      this.navMinion();
    }
  }

  navMinion() {
    this.props.navigator.push({
      id: 'minion'
    })
  }

  navCreateMinion() {
    this.props.navigator.push({
      id: 'create'
    })
  }

  setCurrentUser(access_token) {
    this.getJwt(access_token).then((jwt) => {
      fetch('http://10.0.2.2:3000/api/v1/current_user', {
        headers: {
          'Authorization': jwt
        }
      })
      .then((response) => response.json())
      .then((responseJson) => {
        this.setState({current_user_status: responseJson.status})
        this.determineNav()
      })
      .catch((error) => {
        console.error(error);
      });
    })
  }

  getJwt(access_token) {
    return fetch(("http://10.0.2.2:3000/access_token?code=" + access_token))
    .then((response) => response.json())
    .then((responseJson) => {
        return responseJson.jwt
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
                    this.setCurrentUser(data.accessToken.toString())
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
