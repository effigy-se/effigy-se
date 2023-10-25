import { createDropdownInput, Feature } from '../base';

export const multiz_performance: Feature<number> = {
  name: 'Multi-Z Performance Rendering',
  category: 'GAMEPLAY',
  description: 'Rendering mode for Multi-Z maps.',
  component: createDropdownInput({
    [-1]: 'Quality',
    0: 'Performance',
    2: 'Debug',
  }),
};
