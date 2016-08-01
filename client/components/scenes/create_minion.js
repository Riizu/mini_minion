import React, { Component } from 'react';
import {
  View,
  Text,
  TextInput,
  StyleSheet,
  TouchableHighlight,
  AsyncStorage
} from 'react-native';

export default class CreateMinionScene extends Component {
  constructor(props) {
    super(props);
    this.state = {
      name: ""
    }
  }

  createMinion() {
    fetch('http://10.0.2.2:3000/api/v1/minion', {
      method: 'POST',
      headers: {
        'Authorization': this.state.jwt,
      },
      body: JSON.stringify({
        name: this.state.name
      })
    })
  }

  componentWillMount() {
    AsyncStorage.getItem("jwt").then((value) => {
      this.setState({jwt: value})
    })
  }

  onSubmitEdit() {
    this.createMinion()
  }

  render() {
    return(
      <View style={styles.container}>
        <Text>{this.state.jwt}</Text>
        <Text>Name:</Text>
        <TextInput
          style={{height: 40}}
          placeholder="Enter Name Here"
          onChangeText={(text) => this.setState({name: text})}
          onSumbitEditing={this.onSubmitEdit()}
        />
        <TouchableHighlight onPress={this.onSubmitEdit()}>
          <Text>Submit</Text>
        </TouchableHighlight>
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
