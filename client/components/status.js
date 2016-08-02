import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View
} from 'react-native';

class Status extends Component {
  constructor(props) {
    super(props);
    this.state = {
      version: '',
      last_update: ''
    };
  }

  getStatus() {
    fetch('http://10.0.2.2:3000/api/v1/status.json')
    .then((response) => response.json())
    .then((responseJson) => {
      this.setState({
        version: responseJson.version,
        last_update: responseJson.last_update
      });
    })
    .catch((error) => {
      console.error(error);
    });
  }

  componentWillMount() {
    this.getStatus();
  }

  render() {
    return (
      <View style={styles.status}>
        <Text>Version {this.state.version}</Text>
        <Text>Last Update: {this.state.last_update}</Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  status: {
    position: 'absolute',
    bottom: 10,
    left: 10,
    right: 0
  }
});

module.exports = Status;
