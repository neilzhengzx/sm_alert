
# react-native-sm-alert

## Getting started

`$ npm install react-native-sm-alert --save`

### Mostly automatic installation

`$ react-native link react-native-sm-alert`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-sm-alert` and add `SMOSmAlert.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libSMOSmAlert.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.reactlibrary.sm_alert.SMOSmAlertPackage;` to the imports at the top of the file
  - Add `new SMOSmAlertPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-sm-alert'
  	project(':react-native-sm-alert').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-sm-alert/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-sm-alert')
  	```


## Usage
```javascript
import SMOSmAlert from 'react-native-sm-alert';

// TODO: What to do with the module?
SMOSmAlert;
```
  