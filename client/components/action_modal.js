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
          <Text>Hello World!</Text>

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
