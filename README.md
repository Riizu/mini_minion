# Mini Minion
> A mobile app built in React Native that leverages League of Legends data to interact with a digital minion pet.

Written in React Native and powered by a Rails 5 API backend, Mini Minion signs people in through Facebook and then syncs with a user's League of Legends account to create and manage a personalized 'minion'. This minion updates its statistics with a simple call to the server that then does the following:

* Checks for new matches
* Applies XP for matches found
* Adjusts health and happiness based on frequency of matches played

To counteract periods of inactivity users can also feed their minions, providing short stamina and health boosts until they can play again.

[App Screenshot Album](http://imgur.com/a/j9wMz)

### Current Status

At this time, the app is currently in active development though updates may be sporadic. The app is in a very early *ALPHA* build, so final UX and polish items are far from implemented. That said, all syncing and communication is already implemented, and it is close to a release. Built in rate limiting has also been added, but in a somewhat hacky fashion. This will eventually be moved to some sort of job handler.

### Contributing

Anyone interested in contributing to the project is more than welcome to open an issue, fork the repo and submit a PR with any changes or bugfixes they may have. All PR's must have a passing test suite and are under a pending status until deemed appropriate for the project.

### Installation

In order to install the code base it is assumed that you have the following:
* Rails 5 / ruby 2.3
* Bundler
* A local postgreSQL installation
* React Native 0.30.0
* A Riot API key

The project also relies upon installed npm packages for the React Native Facebook SDK. These are auto-required, but further details and manual installation can be found [here](https://github.com/facebook/react-native-fbsdk).

#### Setting up the codebase

1. Clone the repo
2. Install all required Rails dependencies by running `bundle install`
3. Verify it worked by running `rspec`. All tests should be passing.
4. Run `cd client` to move into the client directory
5. Run `npm install` to install all required npm modules for the react native application

#### Setting up the application environment

At this time, the application will assume that you wish to connect to the production links hosted on Heroku. These will work, but they are inherently slow. Until unique build environments are added, it is recommended that you change all API calls to your locally running Rails 5 app. This should be `<hostname>/api/v1/<endpoint>`. As far as which method to run the client app goes, I personally recommend the android or iOS simulators. Local device testing is useable too, though your mileage may vary.

*NOTE: Setting up Android Studio, configuring it with the proper versions, and the like can be a pain. Please consult additional tutorials for that, as they explain it far better than I. As long as you have a simulator running Android 2.2 or higher, you should be okay. Furthermore, on Android you will need to run the Packager service, which auto builds your app on file change. This can be found in the Android Studio files.*

Afterwards, running `react-native run-android` or `react-native run-ios` should start the app, either by pushing a new build to the running simulator over Packager, or starting up the simulator respectively.

### Testing

All production tests are currently written for the server only. This is due to the unfamiliarity I have with React Native, and the inherent difficulty in testing a mobile app. With that in min, please run `rspec` to check current test coverage. Eventually tests will also exist for the client, but its largely a learning experience.

The test suite currently relies upon the included VCR cassettes due to manual changes to their headers. Please note that the API key within them will only work for the tests as its a dummy key. This will eventually be changed to a more advanced WebMock implementation.
