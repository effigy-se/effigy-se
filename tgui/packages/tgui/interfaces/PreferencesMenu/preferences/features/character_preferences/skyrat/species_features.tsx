import {
  CheckboxInput,
  Feature,
  FeatureChoiced,
  FeatureChoicedServerData,
  FeatureColorInput,
  FeatureDropdownInput,
  FeatureNumberInput,
  FeatureShortTextInput,
  FeatureTextInput,
  FeatureToggle,
  FeatureTriBoolInput,
  FeatureTriColorInput,
  FeatureValueProps,
} from '../../base';

export const feature_leg_type: FeatureChoiced = {
  name: 'Leg type',
  component: FeatureDropdownInput,
};

export const feature_mcolor2: Feature<string> = {
  name: 'Mutant color 2',
  component: FeatureColorInput,
};
export const feature_mcolor3: Feature<string> = {
  name: 'Mutant color 3',
  component: FeatureColorInput,
};

export const flavor_text: Feature<string> = {
  name: 'Flavor Text',
  description: 'Describe your character!',
  component: FeatureTextInput,
};

export const silicon_flavor_text: Feature<string> = {
  name: 'Flavor Text (Silicon)',
  description: 'Describe your cyborg/AI shell!',
  component: FeatureTextInput,
};

export const ooc_notes: Feature<string> = {
  name: 'OOC Notes',
  description: 'Talk about your character OOCly!',
  component: FeatureTextInput,
};

export const custom_species: Feature<string> = {
  name: 'Custom Species Name',
  description:
    "Want to have a fancy species name? Put it here, or leave it blank if you want to use your species' default name.",
  component: FeatureShortTextInput,
};

export const custom_species_lore: Feature<string> = {
  name: 'Custom Species Lore',
  description:
    "Add some lore for your species! Won't show up if there's no custom species.",
  component: FeatureTextInput,
};
// EffigyEdit Add - Customization
export const general_record: Feature<string> = {
  name: 'Records - General',
  description:
    'Your general records! These are records that are for general viewing-things like employment, qualifications, etc. By default, anyone with a HUD/records access can view these.',
  component: FeatureTextInput,
};

export const security_record: Feature<string> = {
  name: 'Records - Security',
  description:
    'Your security records! These are records for criminal records, arrest history, things like that. Sec officers can view these.',
  component: FeatureTextInput,
};

export const medical_record: Feature<string> = {
  name: 'Records - Medical',
  description:
    'Your medical records! These are records for things like medical history, prescriptions, DNR orders, etc. Medical staff can view these.',
  component: FeatureTextInput,
};

export const exploitable_info: Feature<string> = {
  name: 'Records - Exploitable',
  description:
    "This section is for information antagonists can use, IN CHARACTER AND OUT. If you are willing to be disrupted by antagonists MORE than the average player (this is usually a very fun experience, if you're into that kind of roleplay), put it here! Also for things antagonists can use against your character.",
  component: FeatureTextInput,
};

export const pda_ringer: Feature<string> = {
  name: 'PDA Ringer Message',
  description:
    'Want your PDA to say something other than "beep"? Accepts the first 20 characters.',
  component: FeatureShortTextInput,
};

export const background_info: Feature<string> = {
  name: 'Records - Background',
  description: 'nobody uses this lmao',
  component: FeatureTextInput,
};

export const pda_writing: Feature<string> = {
  name: 'PDA Writing',
  description:
    "What's written down on your character's PDA. This can be anything they'll have written down for later - from shopping lists all the way to saucy fanfiction. Anyone with your PDA can read these with the notepad app, so keep it close!",
  component: FeatureTextInput,
};
// EffigyEdit Add End

export const allow_genitals_toggle: FeatureToggle = {
  name: 'Allow Genital Parts',
  description: 'Enables if you want to have genitals on your character.',
  component: CheckboxInput,
};

export const allow_emissives_toggle: FeatureToggle = {
  name: 'Allow Emissives',
  description: 'Time to become a glowstick.',
  component: CheckboxInput,
};

export const eye_emissives: FeatureToggle = {
  name: 'Eye Emissives',
  description: 'Turn your eyes into sparklers.',
  component: CheckboxInput,
};

export const mutant_colors_color: Feature<string[]> = {
  name: 'Mutant Colours',
  description: 'Legacy colors for controlling shit.',
  component: FeatureTriColorInput,
};

export const body_markings_toggle: FeatureToggle = {
  name: 'Body Markings',
  description:
    "Add some lore for your species! Won't show up if there's no custom species.",
  component: CheckboxInput,
};

export const feature_body_markings: Feature<string> = {
  name: 'Body Markings Selection',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const body_markings_color: Feature<string[]> = {
  name: 'Body Markings Colours',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: FeatureTriColorInput,
};

export const body_markings_emissive: Feature<boolean[]> = {
  name: 'Body Markings Emissives',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: FeatureTriBoolInput,
};

export const tail_toggle: FeatureToggle = {
  name: 'Tail',
  description:
    "Add some lore for your species! Won't show up if there's no custom species.",
  component: CheckboxInput,
};

export const feature_tail: Feature<string> = {
  name: 'Tail Style',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const tail_color: Feature<string[]> = {
  name: 'Tail Colours',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: FeatureTriColorInput,
};

export const tail_emissive: Feature<boolean[]> = {
  name: 'Tail Emissives',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: FeatureTriBoolInput,
};

export const snout_toggle: FeatureToggle = {
  name: 'Snout',
  description:
    "Add some lore for your species! Won't show up if there's no custom species.",
  component: CheckboxInput,
};

export const feature_snout: Feature<string> = {
  name: 'Snout Style',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const snout_color: Feature<string[]> = {
  name: 'Snout Colours',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: FeatureTriColorInput,
};

export const snout_emissive: Feature<boolean[]> = {
  name: 'Snout Emissives',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: FeatureTriBoolInput,
};

export const horns_toggle: FeatureToggle = {
  name: 'Horns',
  description:
    "Add some lore for your species! Won't show up if there's no custom species.",
  component: CheckboxInput,
};

export const feature_horns: Feature<string> = {
  name: 'Horn Style',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const horns_color: Feature<string[]> = {
  name: 'Horn Colours',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: FeatureTriColorInput,
};

export const horns_emissive: Feature<boolean[]> = {
  name: 'Horns Emissives',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: FeatureTriBoolInput,
};

export const ears_toggle: FeatureToggle = {
  name: 'Ears',
  description:
    "Add some lore for your species! Won't show up if there's no custom species.",
  component: CheckboxInput,
};

export const feature_ears: Feature<string> = {
  name: 'Ear Style',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const ears_color: Feature<string[]> = {
  name: 'Ear Colours',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: FeatureTriColorInput,
};

export const ears_emissive: Feature<boolean[]> = {
  name: 'Ears Emissives',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: FeatureTriBoolInput,
};

export const wings_toggle: FeatureToggle = {
  name: 'Wings',
  description:
    "Add some lore for your species! Won't show up if there's no custom species.",
  component: CheckboxInput,
};

export const feature_wings: Feature<string> = {
  name: 'Wings Style',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const wings_color: Feature<string[]> = {
  name: 'Wings Colours',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: FeatureTriColorInput,
};

export const wings_emissive: Feature<boolean[]> = {
  name: 'Wings Emissives',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: FeatureTriBoolInput,
};

export const frills_toggle: FeatureToggle = {
  name: 'Frills',
  description:
    "Add some lore for your species! Won't show up if there's no custom species.",
  component: CheckboxInput,
};

export const feature_frills: Feature<string> = {
  name: 'Frill Style',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const frills_color: Feature<string[]> = {
  name: 'Frill Colours',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: FeatureTriColorInput,
};

export const frills_emissive: Feature<boolean[]> = {
  name: 'Frills Emissives',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: FeatureTriBoolInput,
};

export const spines_toggle: FeatureToggle = {
  name: 'Spines',
  description:
    "Add some lore for your species! Won't show up if there's no custom species.",
  component: CheckboxInput,
};

export const feature_spines: Feature<string> = {
  name: 'Spines Style',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const spines_color: Feature<string[]> = {
  name: 'Spines Colour',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: FeatureTriColorInput,
};

export const spines_emissive: Feature<boolean[]> = {
  name: 'Spines Emissives',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: FeatureTriBoolInput,
};

export const digitigrade_legs: FeatureChoiced = {
  name: 'Legs',
  component: FeatureDropdownInput,
};

export const caps_toggle: FeatureToggle = {
  name: 'Cap',
  description:
    "Add some lore for your species! Won't show up if there's no custom species.",
  component: CheckboxInput,
};

export const feature_caps: Feature<string> = {
  name: 'Cap Style',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const caps_color: Feature<string[]> = {
  name: 'Cap Colours',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: FeatureTriColorInput,
};

export const caps_emissive: Feature<boolean[]> = {
  name: 'Caps Emissives',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: FeatureTriBoolInput,
};

export const moth_antennae_toggle: FeatureToggle = {
  name: 'Moth Antennae',
  description:
    "Add some lore for your species! Won't show up if there's no custom species.",
  component: CheckboxInput,
};

export const feature_moth_antennae: Feature<string> = {
  name: 'Moth Antennae Style',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const moth_antennae_color: Feature<string[]> = {
  name: 'Moth Antennae Colours',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: FeatureTriColorInput,
};

export const moth_antennae_emissive: Feature<boolean[]> = {
  name: 'Moth Antennae Emissives',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: FeatureTriBoolInput,
};

export const moth_markings_toggle: FeatureToggle = {
  name: 'Moth Markings',
  description:
    "Add some lore for your species! Won't show up if there's no custom species.",
  component: CheckboxInput,
};

export const feature_moth_markings: Feature<string> = {
  name: 'Moth Markings Selection',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const moth_markings_color: Feature<string[]> = {
  name: 'Moth Markings Colours',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: FeatureTriColorInput,
};

export const moth_markings_emissive: Feature<boolean[]> = {
  name: 'Moth Markings Emissives',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: FeatureTriBoolInput,
};

export const fluff_toggle: FeatureToggle = {
  name: 'Fluff',
  description:
    "Add some lore for your species! Won't show up if there's no custom species.",
  component: CheckboxInput,
};

export const feature_fluff: Feature<string> = {
  name: 'Fluff Style',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const fluff_color: Feature<string[]> = {
  name: 'Fluff Colours',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: FeatureTriColorInput,
};

export const fluff_emissive: Feature<boolean[]> = {
  name: 'Fluff Emissives',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: FeatureTriBoolInput,
};

export const head_acc_toggle: FeatureToggle = {
  name: 'Head Accessories',
  description:
    "Add some lore for your species! Won't show up if there's no custom species.",
  component: CheckboxInput,
};

export const feature_head_acc: Feature<string> = {
  name: 'Head Accessories Style',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const head_acc_color: Feature<string[]> = {
  name: 'Head Accessories Colours',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: FeatureTriColorInput,
};

export const head_acc_emissive: Feature<boolean[]> = {
  name: 'Head Accessories Emissives',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: FeatureTriBoolInput,
};

export const feature_ipc_screen: Feature<string> = {
  name: 'Screen Style',
  description:
    'The screen you wish to have displayed. If you have this set to "None", you won\'t get any screen at all.',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const ipc_screen_color: Feature<string> = {
  name: 'Screen Colour',
  description:
    "If your screen is greyscale enabled, then it'll take on this color.",
  component: FeatureColorInput,
};

export const ipc_screen_emissive: Feature<boolean> = {
  name: 'Screen Emissive',
  description: 'Want your screen to glow in the dark?',
  component: CheckboxInput,
};

export const ipc_antenna_toggle: FeatureToggle = {
  name: 'Synth Antennae',
  description: 'Want antennae?',
  component: CheckboxInput,
};

export const feature_ipc_antenna: Feature<string> = {
  name: 'Synth Antennae Selection',
  description: 'The antennae you want attached to your head.',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const ipc_antenna_color: Feature<string[]> = {
  name: 'Synth Antennae Colours',
  description:
    'The color you want your antenna to be. Some support multiple colors.',
  component: FeatureTriColorInput,
};

export const ipc_antenna_emissive: Feature<boolean[]> = {
  name: 'Synth Antenna Emissives',
  description: 'Want your antenna to glow in the dark?.',
  component: FeatureTriBoolInput,
};

export const feature_ipc_chassis: Feature<string> = {
  name: 'Chassis Style',
  description:
    "Allows customization of an Synth's chassis! Only works for Synths.",
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const ipc_chassis_color: Feature<string> = {
  name: 'Synth Chassis Colours',
  description:
    "Allows customization of an Synth's chassis! Only works for Synths, for chassis that support greyscale coloring.",
  component: FeatureColorInput,
};

export const feature_ipc_head: Feature<string> = {
  name: 'Synth Head Style',
  description:
    "Allows customization of an Synth's chassis! Only works for Synths.",
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const ipc_head_color: Feature<string> = {
  name: 'Synth Head Colours',
  description:
    "Allows customization of an Synth's head! Only works for Synths, for heads that support greyscale coloring.",
  component: FeatureColorInput,
};

export const feature_hair_opacity_toggle: Feature<boolean> = {
  name: 'Hair Opacity',
  description: 'Enable the ability to override your hair opacity!',
  component: CheckboxInput,
};

export const feature_hair_opacity: Feature<number> = {
  name: 'Hair Opacity',
  description: 'Change your hair opacity! Hardlight hair, anyone?',
  component: FeatureNumberInput,
};

export const neck_acc_toggle: FeatureToggle = {
  name: 'Neck Accessories',
  description:
    "Add some lore for your species! Won't show up if there's no custom species.",
  component: CheckboxInput,
};

export const feature_neck_acc: Feature<string> = {
  name: 'Neck Accessories Style',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const neck_acc_color: Feature<string[]> = {
  name: 'Neck Accessories Colours',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: FeatureTriColorInput,
};

export const neck_acc_emissive: Feature<boolean[]> = {
  name: 'Neck Accessories Emissives',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: FeatureTriBoolInput,
};

export const skrell_hair_toggle: FeatureToggle = {
  name: 'Skrell Hair',
  description:
    "Add some lore for your species! Won't show up if there's no custom species.",
  component: CheckboxInput,
};

export const feature_skrell_hair: Feature<string> = {
  name: 'Skrell Hair Style',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const skrell_hair_color: Feature<string[]> = {
  name: 'Skrell Hair Colours',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: FeatureTriColorInput,
};

export const skrell_hair_emissive: Feature<boolean[]> = {
  name: 'Skrell Hair Emissives',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: FeatureTriBoolInput,
};

export const taur_toggle: FeatureToggle = {
  name: 'Taur',
  description:
    "Add some lore for your species! Won't show up if there's no custom species.",
  component: CheckboxInput,
};

export const feature_taur: Feature<string> = {
  name: 'Taur Style',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const taur_color: Feature<string[]> = {
  name: 'Taur Colours',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: FeatureTriColorInput,
};

export const taur_emissive: Feature<boolean[]> = {
  name: 'Taur Emissives',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: FeatureTriBoolInput,
};

export const xenodorsal_toggle: FeatureToggle = {
  name: 'Xenodorsal',
  description:
    "Add some lore for your species! Won't show up if there's no custom species.",
  component: CheckboxInput,
};

export const feature_xenodorsal: Feature<string> = {
  name: 'Xenodorsal Style',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const xenodorsal_color: Feature<string[]> = {
  name: 'Xenodorsal Colours',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: FeatureTriColorInput,
};

export const xenodorsal_emissive: Feature<boolean[]> = {
  name: 'Xenodorsal Emissives',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: FeatureTriBoolInput,
};

export const xenohead_toggle: FeatureToggle = {
  name: 'Xeno Head',
  description:
    "Add some lore for your species! Won't show up if there's no custom species.",
  component: CheckboxInput,
};

export const feature_xenohead: Feature<string> = {
  name: 'Xeno Head Style',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};

export const xenohead_color: Feature<string[]> = {
  name: 'Xeno Head Colours',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: FeatureTriColorInput,
};

export const xenohead_emissive: Feature<boolean[]> = {
  name: 'Xeno Head Emissives',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: FeatureTriBoolInput,
};

export const undershirt_color: Feature<string> = {
  name: 'Undershirt Colour',
  component: FeatureColorInput,
};

export const socks_color: Feature<string> = {
  name: 'Socks Colour',
  component: FeatureColorInput,
};

export const heterochromia_toggle: FeatureToggle = {
  name: 'Heterochromia',
  description:
    "Add some lore for your species! Won't show up if there's no custom species.",
  component: CheckboxInput,
};

export const feature_heterochromia: Feature<string> = {
  name: 'Heterochromia Selection',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: FeatureDropdownInput,
};

export const heterochromia_color: Feature<string[]> = {
  name: 'Heterochromia Colours',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: FeatureTriColorInput,
};

export const heterochromia_emissive: Feature<boolean[]> = {
  name: 'Heterochromia Emissives',
  description:
    'Want to have a fancy species name? Put it here, or leave it blank.',
  component: FeatureTriBoolInput,
};

export const vox_bodycolor: Feature<string> = {
  name: 'Vox Bodycolor',
  component: FeatureDropdownInput,
};
