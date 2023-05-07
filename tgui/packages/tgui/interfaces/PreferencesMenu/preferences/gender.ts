export enum Gender {
  Male = 'male',
  Female = 'female',
  Other = 'plural',
}

export const GENDERS = {
  [Gender.Male]: {
    icon: 'male',
    text: 'Male',
  },

  [Gender.Female]: {
    icon: 'female',
    text: 'Female',
  },

  [Gender.Other]: {
    icon: 'question', // EFFIGY EDIT CHANGE (#3 Customization - Ported from Skyrat)
    text: 'Other',
  },
};
