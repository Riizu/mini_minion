import React, { Component } from 'react';
import {
  View,
  StyleSheet,
  AsyncStorage
} from 'react-native';

var Status = require('../status');
var Login = require('../login');

export default class InitialScene extends Component {
  constructor(props) {
    super(props);
  }

  render() {
    return(
      <View style={styles.container}>
        <Status/>
        <Login navigator={this.props.navigator}/>
      </View>
    )
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F5FCFF'
  }
});
