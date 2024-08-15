import React, { useState } from 'react';
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
        uri: `https://api.instagram.com/oauth/authorize?client_id=${CLIENT_ID}&redirect_uri=${REDIRECT_URI}&scope=user_profile,user_media&response_type=token`,
      }}
      onNavigationStateChange={onNavigationStateChange}
      startInLoadingState={true}
    />
  );
}

