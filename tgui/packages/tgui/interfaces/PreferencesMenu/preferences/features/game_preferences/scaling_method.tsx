import { createDropdownInput, Feature } from '../base';

export const scaling_method: Feature<string> = {
  name: 'Point sampling',
  category: 'UI',
  component: createDropdownInput({
    normal: 'Enabled',
    distort: 'Disabled',
  }),
};
