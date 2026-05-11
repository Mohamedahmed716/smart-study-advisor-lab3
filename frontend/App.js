import React from 'react';
import { StatusBar } from 'expo-status-bar';
import { AdvisorScreen } from './src/screens/AdvisorScreen';

export default function App() {
  return (
    <>
      <StatusBar style="light" />
      <AdvisorScreen />
    </>
  );
}