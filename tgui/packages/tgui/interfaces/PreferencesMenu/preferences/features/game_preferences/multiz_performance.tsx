import { createDropdownInput, Feature } from '../base';

export const multiz_performance: Feature<number> = {
  name: 'Multi-Z detail level',
  category: 'GAMEPLAY',
  description: 'How detailed multi-z is. Lower this to improve performance',
  component: createDropdownInput({
    2: 'High',
    1: 'Medium',
    0: 'Low',
    [-1]: 'Disabled',
  }),
};
