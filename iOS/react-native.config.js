const path = require('path');

module.exports = {
  project: {
    ios: {
      project: path.join(__dirname, 'poclink-app.xcodeproj'),
    },
    android: null, // we don't need Android right now
  },
  dependencies: {},
  // Tell React Native where to find the JS code
  reactNativePath: path.join(__dirname, '../poclink-js/node_modules/react-native'),
};