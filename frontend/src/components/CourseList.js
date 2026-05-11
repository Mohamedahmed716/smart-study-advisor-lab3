import React from 'react';
import { View, Text, ScrollView, TouchableOpacity, StyleSheet } from 'react-native';
import { theme as colors } from '../theme/colors';

export const CourseList = ({ recommendations, onReset }) => {
  return (
    <View style={styles.container}>
      <Text style={[styles.header, { color: colors.text }]}>Your Recommendations</Text>
      
      <ScrollView 
        style={styles.resultsList}
        contentContainerStyle={{ paddingBottom: 100 }}
        showsVerticalScrollIndicator={false}
      >
        {recommendations.length === 0 ? (
          <Text style={{ color: colors.textSecondary, textAlign: 'center' }}>No courses match your criteria.</Text>
        ) : (
          recommendations.map((item, index) => (
            <View key={index} style={[styles.card, { backgroundColor: colors.surface, borderColor: colors.border }]}>
              <Text style={[styles.courseTitle, { color: colors.text }]}>{item.course_name}</Text>
              <Text style={{ color: colors.textSecondary, marginTop: 4 }}>Difficulty: {item.difficulty}</Text>
              {item.match_reason && <Text style={{ color: colors.primary, marginTop: 8 }}>{item.match_reason}</Text>}
            </View>
          ))
        )}
      </ScrollView>

      <TouchableOpacity 
        style={[styles.btn, { backgroundColor: colors.surface, borderColor: colors.border }]} 
        onPress={onReset}
      >
        <Text style={[styles.btnText, { color: colors.text }]}>Go Back</Text>
      </TouchableOpacity>
    </View>
  );
};

const styles = StyleSheet.create({
  container: { flex: 1 },
  header: { fontSize: 28, fontWeight: '800', marginBottom: 24, letterSpacing: -0.5 },
  resultsList: { flex: 1, marginBottom: 10 },
  card: { padding: 16, borderRadius: 12, borderWidth: 1, marginBottom: 12 },
  courseTitle: { fontSize: 18, fontWeight: '700' },
  btn: { padding: 16, borderRadius: 12, alignItems: 'center', borderWidth: 1, marginBottom: 20 },
  btnText: { fontSize: 16, fontWeight: '700' },
});