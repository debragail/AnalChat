import React from 'react';
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

