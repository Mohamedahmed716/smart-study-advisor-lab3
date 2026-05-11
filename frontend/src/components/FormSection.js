import React from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { Chip } from './Chip';
import { theme as colors } from '../theme/colors';

export const FormSection = ({ title, items, selectedState, onToggle, singleSelect = false }) => {
  return (
    <View style={styles.section}>
      <Text style={[styles.sectionTitle, { color: colors.textSecondary }]}>{title}</Text>
      <View style={styles.chipContainer}>
        {items.map(item => (
          <Chip 
            key={item} 
            label={item} 
            colors={colors}
            isSelected={singleSelect ? selectedState === item : selectedState.includes(item)}
            onPress={() => onToggle(item)}
          />
        ))}
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  section: { marginBottom: 24 },
  sectionTitle: { fontSize: 14, fontWeight: '700', textTransform: 'uppercase', letterSpacing: 1, marginBottom: 12 },
  chipContainer: { flexDirection: 'row', flexWrap: 'wrap' },
});