import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  Modal,
  TouchableHighlight
} from 'react-native';

class ActionModal extends Component {
  constructor(props) {
    super(props);
    this.state = {
      last_update: '',
      modalVisible: false
    };
  }

  setModalVisible(visible) {
    this.setState({modalVisible: visible});
  }

  updateMinion() {
    fetch('http://mini-minion.herokuapp.com/api/v1/minion/update', {
      headers: {
        'Authorization': this.props.jwt
      }
    })
    .then((response) => response.json())
    .then((responseJson) => {
      this.props.parent.setState({
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

  feedMinion() {
    fetch('http://mini-minion.herokuapp.com/api/v1/minion/feed', {
      headers: {
        'Authorization': this.props.jwt
      }
    })
    .then((response) => response.json())
    .then((responseJson) => {
      this.updateMinion()
    })
    .catch((error) => {
      console.error(error);
    });
  }


  render() {
    return (
      <View>
      <Modal
        animationType={"slide"}
        transparent={false}
        visible={this.state.modalVisible}
        onRequestClose={() => {alert("Modal has been closed.")}}
        >
       <View style={{marginTop: 22}}>
        <View>
          <TouchableHighlight onPress={() => {
            this.updateMinion();
          }}>
            <Text>Update Minion Data</Text>
          </TouchableHighlight>

          <TouchableHighlight onPress={() => {
            this.feedMinion();
          }}>
            <Text>Feed Minion</Text>
          </TouchableHighlight>

          <TouchableHighlight onPress={() => {
            this.setModalVisible(!this.state.modalVisible)
          }}>
            <Text>Hide Modal</Text>
          </TouchableHighlight>

        </View>
       </View>
      </Modal>

      <TouchableHighlight onPress={() => {
        this.setModalVisible(true)
      }}>
        <Text>Show Modal</Text>
      </TouchableHighlight>
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

module.exports = ActionModal;
