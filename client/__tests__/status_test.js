import 'react-native';
import React from 'react';
import Status from './components/status';

// Note: test renderer must be required after react-native.
import renderer from 'react-test-renderer';

describe('Status', () => {

  it('renders correctly', () => {
    const tree = renderer.create(
      <Status />
    ).toJSON();
    expect(tree).toMatchSnapshot();
  });

});
