import React, { Component } from 'react';
import {
  View,
  Text,
  Alert,
  StyleSheet,
  AsyncStorage
} from 'react-native';

var Status = require('../status');
var Login = require('../login');

export default class InitialScene extends Component {
  constructor(props) {
    super(props);
    this.state = {
      jwt: ""
    }
  }

  navMinion(){
    this.props.navigator.push({
      id: 'minion'
    })
  }

  componentDidMount() {
    AsyncStorage.getItem("jwt").then((value) => {
        this.setState({jwt: value});
    }).done();
  }

  render() {
    return(
      <View style={styles.container}>
        <Text>{this.props.title}</Text>
        <Status/>
        <Login/>
        <Text style={styles.jwt}>jwt: {this.state.jwt}</Text>
      </View>
    )
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
