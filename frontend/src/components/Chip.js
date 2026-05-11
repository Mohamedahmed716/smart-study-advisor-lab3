import React from 'react';
import { TouchableOpacity, Text, StyleSheet } from 'react-native';

export const Chip = ({ label, isSelected, onPress, colors }) => {
  return (
    <TouchableOpacity 
      style={[
        styles.chip, 
        { backgroundColor: colors.chipBg },
        isSelected && { backgroundColor: colors.chipSelectedBg }
      ]}
      onPress={onPress}
      activeOpacity={0.7}
    >
      <Text style={[
        styles.text, 
        { color: colors.chipText },
        isSelected && { color: colors.chipSelectedText, fontWeight: 'bold' }
      ]}>
        {label.replace('_', ' ')}
      </Text>
    </TouchableOpacity>
  );
};

const styles = StyleSheet.create({
  chip: {
    paddingVertical: 8,
    paddingHorizontal: 16,
    borderRadius: 20,
    marginRight: 8,
    marginBottom: 8,
  },
  text: {
    fontSize: 14,
    textTransform: 'capitalize',
  }
});