import { CheckboxInput, FeatureToggle } from '../../base';

export const soulcatcher_join_action: FeatureToggle = {
  name: 'Enable soulcatcher notifications',
  category: 'GHOST',
  description:
    'Toggles whether you wish to have the action to join a soulcatcher as a ghost shown to you. You still have access to the verb regardless.',
  component: CheckboxInput,
};
