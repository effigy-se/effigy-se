import {
  CheckboxInput,
  Feature,
  FeatureChoiced,
  FeatureDropdownInput,
  FeatureNumeric,
  FeatureSliderInput,
  FeatureToggle,
  FeatureTriBoolInput,
  FeatureTriColorInput,
} from '../../base';

export const feature_penis: Feature<string> = {
  name: 'Penis',
  component: FeatureDropdownInput,
};

export const penis_skin_tone: FeatureToggle = {
  name: 'Penis Uses Skin Tone',
  component: CheckboxInput,
};

export const penis_skin_color: FeatureToggle = {
  name: 'Penis Uses Skin Colour',
  component: CheckboxInput,
};

export const penis_color: Feature<string[]> = {
  name: 'Penis Colour',
  component: FeatureTriColorInput,
};

export const penis_emissive: Feature<boolean[]> = {
  name: 'Penis Emissives',
  component: FeatureTriBoolInput,
};

export const penis_sheath: Feature<string> = {
  name: 'Penis Sheath',
  component: FeatureDropdownInput,
};

export const penis_length: FeatureNumeric = {
  name: 'Penis Length',
  component: FeatureSliderInput,
};

export const penis_girth: FeatureNumeric = {
  name: 'Penis Girth',
  component: FeatureSliderInput,
};

export const penis_taur_mode_toggle: FeatureToggle = {
  name: 'Penis Taur Mode',
  component: CheckboxInput,
};

export const feature_testicles: Feature<string> = {
  name: 'Testicles',
  component: FeatureDropdownInput,
};

export const testicles_skin_tone: FeatureToggle = {
  name: 'Testicles Use Skin Tone',
  component: CheckboxInput,
};

export const testicles_skin_color: FeatureToggle = {
  name: 'Testicles Use Skin Colour',
  component: CheckboxInput,
};

export const testicles_color: Feature<string[]> = {
  name: 'Testicle Colour',
  component: FeatureTriColorInput,
};

export const testicles_emissive: Feature<boolean[]> = {
  name: 'Testicles Emissives',
  component: FeatureTriBoolInput,
};

export const balls_size: FeatureNumeric = {
  name: 'Testicle Size',
  component: FeatureSliderInput,
};

export const feature_vagina: Feature<string> = {
  name: 'Vagina',
  component: FeatureDropdownInput,
};

export const vagina_skin_tone: FeatureToggle = {
  name: 'Vagina Uses Skin Tone',
  component: CheckboxInput,
};

export const vagina_skin_color: FeatureToggle = {
  name: 'Vagina Uses Skin Color',
  component: CheckboxInput,
};

export const vagina_color: Feature<string[]> = {
  name: 'Vagina Colour',
  component: FeatureTriColorInput,
};

export const vagina_emissive: Feature<boolean[]> = {
  name: 'Vagina Emissives',
  component: FeatureTriBoolInput,
};

export const feature_womb: Feature<string> = {
  name: 'Womb',
  component: FeatureDropdownInput,
};

export const feature_breasts: Feature<string> = {
  name: 'Breasts',
  component: FeatureDropdownInput,
};

export const breasts_skin_tone: FeatureToggle = {
  name: 'Breasts Use Skin Tone',
  component: CheckboxInput,
};

export const breasts_skin_color: FeatureToggle = {
  name: 'Breasts Use Skin Color',
  component: CheckboxInput,
};

export const breasts_color: Feature<string[]> = {
  name: 'Breast Colour',
  component: FeatureTriColorInput,
};

export const breasts_emissive: Feature<boolean[]> = {
  name: 'Breast Emissives',
  component: FeatureTriBoolInput,
};

export const breasts_lactation_toggle: FeatureToggle = {
  name: 'Breast Lactation',
  component: CheckboxInput,
};

export const breasts_size: Feature<string> = {
  name: 'Breast Size',
  component: FeatureDropdownInput,
};

export const feature_anus: Feature<string> = {
  name: 'Anus',
  component: FeatureDropdownInput,
};

export const body_size: FeatureNumeric = {
  name: 'Body Size',
  component: FeatureSliderInput,
};

export const erp_status_pref: FeatureChoiced = {
  name: 'ERP Status',
  component: FeatureDropdownInput,
};

export const erp_status_pref_mechanics: FeatureChoiced = {
  name: 'ERP Status (Mechanical)',
  component: FeatureDropdownInput,
};
