import React, { Component } from 'react';
import {
  AppRegistry,
  Navigator,
  AsyncStorage
} from 'react-native';

import InitialScene from './components/scenes/initial';
import MinionScene from './components/scenes/minion';

class MiniMinionClient extends Component {
  constructor(props) {
    super(props);
    this.state = {
      jwt: ""
    }
  }

  check_for_valid_JWT() {
    if(this.state.jwt !== null) {
      return "minion"
    } else {
      return "initial"
    }
  }

  componentWillMount() {
    AsyncStorage.getItem("jwt").then((value) => {
        this.setState({jwt: value});
    }).done();
  }

  render() {
    return (
      <Navigator
        initialRoute={{id: "initial" }}
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
   }
 }
}

AppRegistry.registerComponent('MiniMinionClient', () => MiniMinionClient);
