import { CheckboxInput, FeatureToggle } from '../../base';

export const subtler_sound: FeatureToggle = {
  name: 'Enable subtle/r notification',
  category: 'SOUND',
  description:
    'Receive audio notification when a subtle/r message is received.',
  component: CheckboxInput,
};
