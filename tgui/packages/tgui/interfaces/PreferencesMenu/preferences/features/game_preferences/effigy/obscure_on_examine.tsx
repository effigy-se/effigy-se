import { CheckboxInput, FeatureToggle } from '../../base';

export const obscure_on_examine: FeatureToggle = {
  name: 'Examine hidden when unknown',
  category: 'GAMEPLAY',
  description: 'Toggles whether your examine panel is hidden when unknown.',
  component: CheckboxInput,
};
