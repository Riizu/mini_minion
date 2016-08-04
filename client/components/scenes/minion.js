import React, { Component } from 'react';
import {
  View,
  Text,
  Alert,
  StyleSheet,
  AsyncStorage,
  TouchableHighlight,
  Modal
} from 'react-native';

var ActionModal = require('../action_modal');

export default class MinionScene extends Component {
  constructor(props) {
    super(props);
    this.state = {
      name: "",
      level: "",
      xp: "",
      current_health: "",
      current_stamina: "",
      current_happiness: "",
      total_health: "",
      total_stamina: "",
      total_happiness: "",
      jwt: ""
    }
  }

  componentDidMount() {
    this.getData()
  }

  getData() {
    this.getMinion(this.props.jwt)
  }

  getMinion(jwt) {
    return fetch('http://mini-minion.herokuapp.com/api/v1/minion', {
      headers: {
        'Authorization': jwt
      }
    })
    .then((response) => response.json())
    .then((responseJson) => {
      this.setState({
        name: responseJson.name,
        level: responseJson.level,
        xp: responseJson.xp,
        current_health: responseJson.current_health,
        current_stamina: responseJson.current_stamina,
        current_happiness: responseJson.current_happiness,
        total_health: responseJson.total_health,
        total_stamina: responseJson.total_stamina,
        total_happiness: responseJson.total_happiness
      });
    })
    .catch((error) => {
      console.error(error);
    });
  }

  render() {
    return(
      <View>
        <Text>Name: {this.state.name}</Text>
        <Text>Level: {this.state.level}</Text>
        <Text>XP: {this.state.xp}</Text>
        <Text>Health: {this.state.current_health}/{this.state.total_health}</Text>
        <Text>Stamina: {this.state.current_stamina}/{this.state.total_stamina}</Text>
        <Text>Happiness: {this.state.current_happiness}/{this.state.total_happiness}</Text>
        <ActionModal jwt={this.props.jwt} parent={this}/>
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
