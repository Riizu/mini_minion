import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  Alert,
  AsyncStorage
} from 'react-native';

var Status = require('./components/status');
var Login = require('./components/login');

class MiniMinionClient extends Component {
  constructor(props) {
    super(props);
    this.state = {
      jwt: ""
    }
  }

  componentDidMount() {
    AsyncStorage.getItem("jwt").then((value) => {
        this.setState({jwt: value});
    }).done();
  }

  render() {
    return (
      <View style={styles.container}>
        <Status/>
        <Login/>
        <Text style={styles.jwt}>jwt: {this.state.jwt}</Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F5FCFF'
  },
  jwt: {
    position: 'absolute',
    top: 0,
    left: 0
  }
});

AppRegistry.registerComponent('MiniMinionClient', () => MiniMinionClient);
