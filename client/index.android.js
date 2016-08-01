import React, { Component } from 'react';
import {
  AppRegistry,
  Navigator,
  AsyncStorage
} from 'react-native';

import InitialScene from './components/scenes/initial';
import MinionScene from './components/scenes/minion';
import CreateMinionScene from './components/scenes/create_minion';

class MiniMinionClient extends Component {
  constructor(props) {
    super(props);
    this.state = {
      jwt: ''
    }
  }

  check_for_valid_JWT() {
    if(this.state.jwt !== null) {
      return "minion"
    } else {
      return "initial"
    }
  }

  render() {
    return (
      <Navigator
        initialRoute={{id: "create" }}
        renderScene={this.navigatorRenderScene}/>
    )
  }

  navigatorRenderScene(route, navigator) {
   _navigator = navigator;
   switch (route.id) {
     case 'initial':
       return (<InitialScene navigator={navigator}/>);
     case 'minion':
       return (<MinionScene navigator={navigator}/>);
     case 'create':
       return (<CreateMinionScene navigator={navigator}/>);
   }
 }
}

AppRegistry.registerComponent('MiniMinionClient', () => MiniMinionClient);
