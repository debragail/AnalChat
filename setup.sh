#!/bin/bash

# Ensure script is executed from the root of the React Native project
if [ ! -f "package.json" ]; then
  echo "Please run this script from the root of your React Native project."
  exit 1
fi

# Create src directory and subdirectories
mkdir -p src/{components,navigation,screens,services,assets/{images,icons},styles,utils}

# Create basic files in src/
touch src/App.js

# Create components directory and a basic component
echo "import React from 'react';
import { TouchableOpacity, Text, StyleSheet } from 'react-native';

export default function CustomButton({ title, onPress }) {
  return (
    <TouchableOpacity style={styles.button} onPress={onPress}>
      <Text style={styles.buttonText}>{title}</Text>
    </TouchableOpacity>
  );
}

const styles = StyleSheet.create({
  button: {
    backgroundColor: '#007bff',
    padding: 10,
    borderRadius: 5,
    alignItems: 'center',
  },
  buttonText: {
    color: '#fff',
    fontSize: 16,
  },
});
" > src/components/CustomButton.js

# Create basic navigation setup
echo "import * as React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import HomeScreen from '../screens/HomeScreen';
import InstagramLoginScreen from '../screens/InstagramLoginScreen';

const Stack = createStackNavigator();

export default function AppNavigator() {
  return (
    <NavigationContainer>
      <Stack.Navigator initialRouteName='Home'>
        <Stack.Screen name='Home' component={HomeScreen} />
        <Stack.Screen name='InstagramLogin' component={InstagramLoginScreen} />
      </Stack.Navigator>
    </NavigationContainer>
  );
}
" > src/navigation/AppNavigator.js

# Create screens
echo "import React from 'react';
import { View, Text, Button } from 'react-native';

export default function HomeScreen({ navigation }) {
  return (
    <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
      <Text>Welcome to InstaLoginApp!</Text>
      <Button
        title='Login with Instagram'
        onPress={() => navigation.navigate('InstagramLogin')}
      />
    </View>
  );
}
" > src/screens/HomeScreen.js

echo "import React, { useState } from 'react';
import { WebView } from 'react-native-webview';

const CLIENT_ID = 'YOUR_INSTAGRAM_CLIENT_ID';
const REDIRECT_URI = 'YOUR_REDIRECT_URI';

export default function InstagramLoginScreen({ navigation }) {
  const [isLoggedIn, setIsLoggedIn] = useState(false);

  const onNavigationStateChange = (webViewState) => {
    const { url } = webViewState;

    if (url.includes('access_token=')) {
      const accessToken = url.split('access_token=')[1];
      console.log('Access Token:', accessToken);
      setIsLoggedIn(true);
      navigation.navigate('Home');
    }
  };

  return (
    <WebView
      source={{
        uri: \`https://api.instagram.com/oauth/authorize?client_id=\${CLIENT_ID}&redirect_uri=\${REDIRECT_URI}&scope=user_profile,user_media&response_type=token\`,
      }}
      onNavigationStateChange={onNavigationStateChange}
      startInLoadingState={true}
    />
  );
}
" > src/screens/InstagramLoginScreen.js

# Create services directory with an API file
echo "import axios from 'axios';

const api = axios.create({
  baseURL: 'https://api.instagram.com',
});

export const getUserProfile = async (accessToken) => {
  try {
    const response = await api.get('/me', {
      params: {
        access_token: accessToken,
      },
    });
    return response.data;
  } catch (error) {
    console.error('Error fetching user profile', error);
  }
};
" > src/services/api.js

# Create styles directory with a global styles file
echo "import { StyleSheet } from 'react-native';

export const globalStyles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
    backgroundColor: '#fff',
  },
  text: {
    fontSize: 18,
    color: '#333',
  },
});
" > src/styles/globalStyles.js

# Create utils directory with a helpers file
echo "export const formatDate = (dateString) => {
  const options = { year: 'numeric', month: 'long', day: 'numeric' };
  return new Date(dateString).toLocaleDateString(undefined, options);
};
" > src/utils/helpers.js

# Create the main App.js file
echo "import React from 'react';
import AppNavigator from './navigation/AppNavigator';

export default function App() {
  return <AppNavigator />;
}
" > src/App.js

echo "All files and directories have been created successfully!"

