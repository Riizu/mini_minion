import React, { Component } from 'react';
import {
  View,
  Text,
  Alert,
  StyleSheet,
  AsyncStorage
} from 'react-native';

export default class MinionScene extends Component {
  constructor(props) {
    super(props);
    this.state = {
      jwt: ""
    }
  }

  navActions(){
    this.props.navigator.push({
      id: 'minion'
    })
  }

  render() {
    return(
      <View>
        <Text>Test</Text>
      </View>
    )
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F5FCFF'
  },
});
