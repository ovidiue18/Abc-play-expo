import React, { useState, useEffect, useRef } from 'react';
import {
  View, Text, StyleSheet, TouchableOpacity, Image, ScrollView,
  Animated, Platform, useWindowDimensions, StatusBar
} from 'react-native';
import * as Speech from 'expo-speech';

// Alfabet complet RO/EN — fiecare litera are cuvant + emoji fallback daca imaginea lipseste
const LETTERS = [
  { letter: 'A', ro: 'Avion', en: 'Apple', image: require('./assets/a.png'), emoji: '✈️' },
  { letter: 'B', ro: 'Balon', en: 'Ball', image: require('./assets/b.png'), emoji: '🎈' },
  { letter: 'C', ro: 'Casă', en: 'Car', image: require('./assets/c.png'), emoji: '🚗' },
  { letter: 'D', ro: 'Delfin', en: 'Dog', image: null, emoji: '🐬' },
  { letter: 'E', ro: 'Elefant', en: 'Elephant', image: null, emoji: '🐘' },
  { letter: 'F', ro: 'Floare', en: 'Fish', image: null, emoji: '🌸' },
  { letter: 'G', ro: 'Girafă', en: 'Grapes', image: null, emoji: '🦒' },
  { letter: 'H', ro: 'Harta', en: 'House', image: null, emoji: '🗺️' },
  { letter: 'I', ro: 'Iepure', en: 'Ice-cream', image: null, emoji: '🐰' },
  { letter: 'J', ro: 'Jucărie', en: 'Juice', image: null, emoji: '🧸' },
  { letter: 'K', ro: 'Koala', en: 'Kite', image: null, emoji: '🐨' },
  { letter: 'L', ro: 'Leu', en: 'Lion', image: null, emoji: '🦁' },
  { letter: 'M', ro: 'Măr', en: 'Monkey', image: null, emoji: '🍎' },
  { letter: 'N', ro: 'Navă', en: 'Nest', image: null, emoji: '🚢' },
  { letter: 'O', ro: 'Ou', en: 'Orange', image: null, emoji: '🥚' },
  { letter: 'P', ro: 'Pisică', en: 'Panda', image: null, emoji: '🐱' },
  { letter: 'Q', ro: 'Quebec', en: 'Queen', image: null, emoji: '👑' },
  { letter: 'R', ro: 'Robot', en: 'Rainbow', image: null, emoji: '🤖' },
  { letter: 'S', ro: 'Soare', en: 'Sun', image: null, emoji: '☀️' },
  { letter: 'T', ro: 'Tren', en: 'Tiger', image: null, emoji: '🚂' },
  { letter: 'U', ro: 'Urs', en: 'Umbrella', image: null, emoji: '🐻' },
  { letter: 'V', ro: 'Vulpe', en: 'Volcano', image: null, emoji: '🦊' },
  { letter: 'W', ro: 'Wagon', en: 'Whale', image: null, emoji: '🐳' },
  { letter: 'X', ro: 'Xilofon', en: 'Xylophone', image: null, emoji: '🎵' },
  { letter: 'Y', ro: 'Yacht', en: 'Yak', image: null, emoji: '🛥️' },
  { letter: 'Z', ro: 'Zebră', en: 'Zebra', image: null, emoji: '🦓' },
];

export default function App() {
  const [language, setLanguage] = useState('ro');
  const [index, setIndex] = useState(0);
  const [isSpeaking, setIsSpeaking] = useState(false);
  const scale = useRef(new Animated.Value(1)).current;
  const fade = useRef(new Animated.Value(1)).current;
  const { width } = useWindowDimensions();

  const current = LETTERS[index];
  const isWide = width > 600;

  const speak = async (text) => {
    try {
      const speaking = await Speech.isSpeakingAsync?.();
      if (speaking) await Speech.stop();
    } catch {}
    setIsSpeaking(true);
    // animatie
    Animated.sequence([
      Animated.timing(scale, { toValue: 1.08, duration: 150, useNativeDriver: true }),
      Animated.timing(scale, { toValue: 1, duration: 150, useNativeDriver: true }),
    ]).start();

    Speech.speak(text, {
      language: language === 'ro' ? 'ro-RO' : 'en-US',
      rate: 0.9,
      pitch: 1.1,
      onDone: () => setIsSpeaking(false),
      onStopped: () => setIsSpeaking(false),
      onError: () => setIsSpeaking(false),
    });
    // fallback daca onDone nu vine (web)
    setTimeout(() => setIsSpeaking(false), 2500);
  };

  const goTo = (next) => {
    Animated.timing(fade, { toValue: 0, duration: 120, useNativeDriver: true }).start(() => {
      setIndex(next);
      Animated.timing(fade, { toValue: 1, duration: 180, useNativeDriver: true }).start();
    });
  };

  const next = () => goTo((index + 1) % LETTERS.length);
  const prev = () => goTo((index - 1 + LETTERS.length) % LETTERS.length);
  const random = () => {
    let r;
    do { r = Math.floor(Math.random() * LETTERS.length); } while (r === index && LETTERS.length > 1);
    goTo(r);
  };

  const word = language === 'ro' ? current.ro : current.en;

  return (
    <View style={styles.root}>
      <StatusBar barStyle="light-content" backgroundColor="#4A90E2" />
      
      {/* Header */}
      <View style={styles.header}>
        <Text style={styles.headerTitle}>ABC Play</Text>
        <Text style={styles.headerSub}>{language === 'ro' ? 'Învață alfabetul jucându-te' : 'Learn the alphabet by playing'}</Text>
        <TouchableOpacity
          style={[styles.langBtn, language === 'en' && styles.langBtnActive]}
          onPress={() => setLanguage(l => l === 'ro' ? 'en' : 'ro')}
          activeOpacity={0.8}
        >
          <Text style={styles.langText}>{language === 'ro' ? '🇷🇴 Română' : '🇬🇧 English'}</Text>
          <Text style={styles.langHint}>{language === 'ro' ? 'tap → English' : 'tap → Română'}</Text>
        </TouchableOpacity>
      </View>

      {/* Progress dots */}
      <ScrollView horizontal showsHorizontalScrollIndicator={false} style={styles.dotsScroll} contentContainerStyle={styles.dotsRow}>
        {LETTERS.map((l, i) => (
          <TouchableOpacity key={l.letter} onPress={() => goTo(i)} style={[styles.dot, i === index && styles.dotActive]}>
            <Text style={[styles.dotText, i === index && styles.dotTextActive]}>{l.letter}</Text>
          </TouchableOpacity>
        ))}
      </ScrollView>

      {/* Card */}
      <View style={[styles.cardWrap, isWide && styles.cardWrapWide]}>
        <Animated.View style={[styles.card, { opacity: fade, transform: [{ scale }] }]}>
          
          {/* Imagine / emoji fallback */}
          <View style={styles.imageBox}>
            {current.image ? (
              <Image source={current.image} style={styles.image} resizeMode="contain" />
            ) : (
              <Text style={styles.emoji}>{current.emoji}</Text>
            )}
            {/* badge litera */}
            <View style={styles.badge}>
              <Text style={styles.badgeText}>{current.letter}</Text>
            </View>
          </View>

          <Text style={styles.letter}>{current.letter}</Text>
          <Text style={styles.word}>{word}</Text>
          <Text style={styles.translit}>{language === 'ro' ? LETTERS[index].en + ' (EN)' : LETTERS[index].ro + ' (RO)'}</Text>

          <TouchableOpacity
            style={[styles.speakBtn, isSpeaking && styles.speakBtnActive]}
            onPress={() => speak(word)}
            activeOpacity={0.85}
          >
            <Text style={styles.speakText}>{isSpeaking ? '🔊 ...' : '🔊 ' + (language === 'ro' ? 'Spune cuvântul' : 'Say the word')}</Text>
          </TouchableOpacity>

          <TouchableOpacity style={styles.speakBtnSecondary} onPress={() => speak(current.letter)} activeOpacity={0.85}>
            <Text style={styles.speakTextSecondary}>{language === 'ro' ? '🔤 Spune litera' : '🔤 Say the letter'}</Text>
          </TouchableOpacity>
        </Animated.View>

        {/* Controale */}
        <View style={styles.controls}>
          <TouchableOpacity style={styles.ctrlBtn} onPress={prev} activeOpacity={0.8}>
            <Text style={styles.ctrlText}>‹</Text>
            <Text style={styles.ctrlLabel}>{language === 'ro' ? 'Înapoi' : 'Back'}</Text>
          </TouchableOpacity>

          <TouchableOpacity style={[styles.ctrlBtn, styles.ctrlPrimary]} onPress={next} activeOpacity={0.8}>
            <Text style={[styles.ctrlText, { color: '#fff' }]}>›</Text>
            <Text style={[styles.ctrlLabel, { color: '#fff' }]}>{language === 'ro' ? 'Următoarea' : 'Next'}</Text>
          </TouchableOpacity>
        </View>

        <View style={styles.bottomRow}>
          <TouchableOpacity onPress={random} style={styles.randomBtn} activeOpacity={0.8}>
            <Text style={styles.randomText}>🎲 {language === 'ro' ? 'Aleatoriu' : 'Random'}</Text>
          </TouchableOpacity>
          <Text style={styles.counter}>{index + 1} / {LETTERS.length}</Text>
        </View>
      </View>

      <View style={styles.footer}>
        <Text style={styles.footerText}>Expo • {Platform.OS} • {language === 'ro' ? 'Atinge o literă sus pentru a sări direct' : 'Tap a letter above to jump'}</Text>
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  root: { flex: 1, backgroundColor: '#EEF4FF' },
  header: {
    backgroundColor: '#4A90E2',
    paddingTop: Platform.OS === 'android' ? 36 : 48,
    paddingBottom: 18,
    paddingHorizontal: 20,
    borderBottomLeftRadius: 24,
    borderBottomRightRadius: 24,
    alignItems: 'center',
  },
  headerTitle: { color: '#fff', fontSize: 28, fontWeight: '800', letterSpacing: 1 },
  headerSub: { color: 'rgba(255,255,255,0.85)', fontSize: 13, marginTop: 2, fontWeight: '500' },
  langBtn: {
    marginTop: 14, backgroundColor: 'rgba(255,255,255,0.18)', paddingVertical: 8, paddingHorizontal: 18,
    borderRadius: 20, borderWidth: 1, borderColor: 'rgba(255,255,255,0.35)', alignItems: 'center',
  },
  langBtnActive: { backgroundColor: '#fff', borderColor: '#fff' },
  langText: { color: '#fff', fontWeight: '700', fontSize: 14 },
  langHint: { color: 'rgba(255,255,255,0.7)', fontSize: 10, marginTop: 1 },

  dotsScroll: { maxHeight: 46, marginTop: 10, flexGrow: 0 },
  dotsRow: { paddingHorizontal: 12, gap: 6, alignItems: 'center', paddingVertical: 6 },
  dot: {
    width: 34, height: 34, borderRadius: 17, backgroundColor: '#fff',
    alignItems: 'center', justifyContent: 'center',
    borderWidth: 1, borderColor: '#D6E6FF', marginHorizontal: 2,
  },
  dotActive: { backgroundColor: '#4A90E2', borderColor: '#4A90E2', transform: [{ scale: 1.12 }] },
  dotText: { fontWeight: '700', color: '#4A90E2', fontSize: 13 },
  dotTextActive: { color: '#fff' },

  cardWrap: { flex: 1, padding: 16, justifyContent: 'center' },
  cardWrapWide: { maxWidth: 520, alignSelf: 'center', width: '100%' },
  card: {
    backgroundColor: '#fff', borderRadius: 28, padding: 22, alignItems: 'center',
    shadowColor: '#4A90E2', shadowOpacity: 0.12, shadowRadius: 18, shadowOffset: { width: 0, height: 8 },
    elevation: 6, borderWidth: 1, borderColor: '#E6F0FF',
  },
  imageBox: {
    width: 180, height: 180, borderRadius: 20, backgroundColor: '#F7F9FF',
    alignItems: 'center', justifyContent: 'center', marginBottom: 12, overflow: 'hidden',
    borderWidth: 1, borderColor: '#EAF0FF',
  },
  image: { width: 160, height: 160 },
  emoji: { fontSize: 84 },
  badge: {
    position: 'absolute', top: 8, right: 8, backgroundColor: '#FF7A45', width: 36, height: 36,
    borderRadius: 18, alignItems: 'center', justifyContent: 'center', borderWidth: 2, borderColor: '#fff',
  },
  badgeText: { color: '#fff', fontWeight: '800', fontSize: 16 },
  letter: { fontSize: 52, fontWeight: '900', color: '#1A2B4A', marginTop: 4, letterSpacing: 2 },
  word: { fontSize: 26, fontWeight: '700', color: '#2B5BAA', marginTop: 2 },
  translit: { fontSize: 12, color: '#8AA0C6', marginTop: 2, fontStyle: 'italic' },

  speakBtn: {
    marginTop: 16, backgroundColor: '#FFCC33', paddingVertical: 14, paddingHorizontal: 28,
    borderRadius: 16, minWidth: 200, alignItems: 'center',
    shadowColor: '#FFCC33', shadowOpacity: 0.35, shadowRadius: 8, shadowOffset: { width: 0, height: 4 },
    elevation: 3,
  },
  speakBtnActive: { backgroundColor: '#4A90E2' },
  speakText: { fontSize: 16, fontWeight: '800', color: '#1A2B4A' },
  speakBtnSecondary: {
    marginTop: 10, backgroundColor: '#EEF4FF', paddingVertical: 10, paddingHorizontal: 22,
    borderRadius: 12, borderWidth: 1, borderColor: '#D6E6FF',
  },
  speakTextSecondary: { fontSize: 13, fontWeight: '600', color: '#4A90E2' },

  controls: { flexDirection: 'row', gap: 12, marginTop: 16 },
  ctrlBtn: {
    flex: 1, backgroundColor: '#fff', paddingVertical: 14, borderRadius: 16,
    alignItems: 'center', justifyContent: 'center', flexDirection: 'row', gap: 6,
    borderWidth: 1, borderColor: '#D6E6FF',
  },
  ctrlPrimary: { backgroundColor: '#4A90E2', borderColor: '#4A90E2' },
  ctrlText: { fontSize: 22, fontWeight: '800', color: '#4A90E2' },
  ctrlLabel: { fontSize: 14, fontWeight: '700', color: '#4A90E2' },

  bottomRow: { flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center', marginTop: 12, paddingHorizontal: 4 },
  randomBtn: { backgroundColor: '#fff', paddingVertical: 8, paddingHorizontal: 14, borderRadius: 20, borderWidth: 1, borderColor: '#E6F0FF' },
  randomText: { fontSize: 13, fontWeight: '700', color: '#6B86B5' },
  counter: { fontSize: 13, fontWeight: '700', color: '#8AA0C6' },

  footer: { padding: 12, alignItems: 'center' },
  footerText: { fontSize: 11, color: '#9AB0D6' },
});
