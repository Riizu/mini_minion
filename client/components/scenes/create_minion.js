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
      name: "",
      jwt: "",
      summoner_name: ""
    }
  }

  navMinion() {
    this.props.navigator.push({
      id: 'minion',
      jwt: this.state.jwt
    })
  }

  createMinion() {
    return fetch('http://10.0.2.2:3000/api/v1/minion?name=' + this.state.name + '&summoner_name=' + this.state.summoner_name,  {
      method: 'POST',
      headers: {
        'Authorization': this.state.jwt,
      }
    })
  }

  componentWillMount() {
    AsyncStorage.getItem("jwt").then((value) => {
      this.setState({jwt: value})
    })
  }

  onSubmitMinion() {
    this.createMinion().then(() => this.navMinion())
  }

  render() {
    return(
      <View style={styles.container}>
        <Text>Name:</Text>

        <TextInput
          style={{height: 40}}
          placeholder="Enter Minion"
          onChangeText={(text) => this.setState({name: text})}
        />

        <TextInput
          style={{height: 40}}
          placeholder="Enter Summoner Name"
          onChangeText={(text) => this.setState({name: text})}
        />
        <TouchableHighlight onPress={() => this.onSubmitMinion()}>
          <Text>Press this button to submit</Text>
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
