import React, { useState } from 'react';
import { View, Text, Button, Image, StyleSheet, TouchableOpacity } from 'react-native';
import * as Speech from 'expo-speech';

const letters = [
  { letter: 'A', ro: 'Avion', en: 'Apple', image: require('./assets/a.png') },
  { letter: 'B', ro: 'Balon', en: 'Ball', image: require('./assets/b.png') },
  { letter: 'C', ro: 'Car', en: 'Car', image: require('./assets/c.png') },
];

export default function App() {
  const [language, setLanguage] = useState('ro');
  const [currentIndex, setCurrentIndex] = useState(0);

  const current = letters[currentIndex];

  const nextLetter = () => {
    setCurrentIndex((prev) => (prev + 1) % letters.length);
  };

  const speak = (text) => {
    const options = {
      language: language === 'ro' ? 'ro-RO' : 'en-US',
    };
    Speech.speak(text, options);
  };

  return (
    <View style={styles.container}>
      <View style={styles.languageSwitch}>
        <Button title={language === 'ro' ? 'Română' : 'English'} onPress={() => setLanguage(language === 'ro' ? 'en' : 'ro')} />
        <Button title="Next" onPress={nextLetter} />
      </View>
      <View style={styles.card}>
        <Image source={current.image} style={styles.image} />
        <Text style={styles.letter}>{current.letter}</Text>
        <Text style={styles.word}>{language === 'ro' ? current.ro : current.en}</Text>
        <TouchableOpacity style={styles.speakButton} onPress={() => speak(language === 'ro' ? current.ro : current.en)}>
          <Text style={styles.speakText}>🔊 Spune cuvântul</Text>
        </TouchableOpacity>
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: { flex: 1, justifyContent: 'center', alignItems: 'center', padding: 20 },
  languageSwitch: { flexDirection: 'row', justifyContent: 'space-between', width: '80%', marginBottom: 20 },
  card: { backgroundColor: '#fff', padding: 20, borderRadius: 20, alignItems: 'center', shadowColor: '#000', shadowOpacity: 0.1, shadowRadius: 10 },
  image: { width: 200, height: 200, marginBottom: 20 },
  letter: { fontSize: 48, fontWeight: 'bold' },
  word: { fontSize: 24, marginVertical: 10 },
  speakButton: { marginTop: 10, backgroundColor: '#ffcc00', padding: 10, borderRadius: 10 },
  speakText: { fontSize: 16 }
});