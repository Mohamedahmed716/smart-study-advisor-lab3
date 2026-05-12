import React, { useState } from 'react';
import { StyleSheet, Text, View, ScrollView, TouchableOpacity, Switch, ActivityIndicator, SafeAreaView } from 'react-native';
import { theme as colors } from '../theme/colors';
import { LEVELS, TOPICS, COURSES } from '../utils/constants';
import { fetchCourseRecommendations } from '../api/client';
import { FormSection } from '../components/FormSection';
import { CourseList } from '../components/CourseList';

export const AdvisorScreen = () => {
  // State
  const [level, setLevel] = useState('intermediate');
  const [interests, setInterests] = useState([]);
  const [completed, setCompleted] = useState([]);
  const [isAiMode, setIsAiMode] = useState(false);
  
  const [recommendations, setRecommendations] = useState(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);

  // Handlers
  const toggleArrayItem = (item, state, setState) => {
    setState(state.includes(item) ? state.filter(i => i !== item) : [...state, item]);
  };

  const handleFetch = async () => {
    setLoading(true);
    setError(null);
    try {
      const data = await fetchCourseRecommendations({
        use_ai: isAiMode,
        preferences: { level, interests, completed_courses: completed }
      });
      setRecommendations(data.recommendations || []);
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  // Rendering
  return (
    <SafeAreaView style={[styles.safeArea, { backgroundColor: colors.background }]}>
      <View style={styles.container}>
        
        {recommendations !== null ? (
          <CourseList 
            recommendations={recommendations} 
            onReset={() => setRecommendations(null)} 
          />
        ) : (
          <ScrollView 
            contentContainerStyle={{ paddingBottom: 100 }} 
            showsVerticalScrollIndicator={false}
          >
            <Text style={[styles.header, { color: colors.text }]}>Smart Advisor</Text>

            <View style={[styles.toggleCard, { backgroundColor: colors.surface, borderColor: colors.border }]}>
              <Text style={{ color: colors.text, fontWeight: '600', fontSize: 16 }}>
                Engine: <Text style={{ color: colors.primary }}>{isAiMode ? 'Llama 3.3' : 'Prolog Inference'}</Text>
              </Text>
              <Switch value={isAiMode} onValueChange={setIsAiMode} trackColor={{ true: colors.primary }} />
            </View>

            <FormSection title="1. Current Level" items={LEVELS} selectedState={level} onToggle={setLevel} singleSelect={true} />
            <FormSection title="2. Topics of Interest" items={TOPICS} selectedState={interests} onToggle={(item) => toggleArrayItem(item, interests, setInterests)} />
            <FormSection title="3. Completed Courses" items={COURSES} selectedState={completed} onToggle={(item) => toggleArrayItem(item, completed, setCompleted)} />

            {error && <Text style={[styles.errorText, { color: colors.error }]}>{error}</Text>}

            <TouchableOpacity 
              style={[styles.btn, { backgroundColor: colors.primary, marginTop: 20 }]} 
              onPress={handleFetch} 
              disabled={loading}
            >
              {loading ? <ActivityIndicator color="#fff" /> : <Text style={[styles.btnText, { color: '#fff' }]}>Generate Syllabus</Text>}
            </TouchableOpacity>
          </ScrollView>
        )}

      </View>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  safeArea: { flex: 1 },
  container: { flex: 1, paddingTop: 40, paddingHorizontal: 20 },
  header: { fontSize: 28, fontWeight: '800', marginBottom: 24, letterSpacing: -0.5 },
  toggleCard: { flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center', padding: 16, borderRadius: 12, borderWidth: 1, marginBottom: 24 },
  btn: { padding: 16, borderRadius: 12, alignItems: 'center', borderWidth: 1, borderColor: 'transparent' },
  btnText: { fontSize: 16, fontWeight: '700' },
  errorText: { marginTop: 12, textAlign: 'center', fontWeight: '500' },
});