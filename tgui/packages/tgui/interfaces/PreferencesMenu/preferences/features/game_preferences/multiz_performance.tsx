import { createDropdownInput, Feature } from '../base';

export const multiz_performance: Feature<number> = {
  name: 'Multi-Z Performance Rendering',
  category: 'GAMEPLAY',
  component: createDropdownInput({
    0: 'Enabled',
  }),
};
