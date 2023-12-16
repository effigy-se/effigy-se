import { CheckboxInput, FeatureToggle } from '../../base';

export const manifest_preview: FeatureToggle = {
  name: 'Visible on manifest preview',
  category: 'GAMEPLAY',
  description: 'Toggles whether your readied job shows in the pre-game lobby.',
  component: CheckboxInput,
};
