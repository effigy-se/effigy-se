import { createDropdownInput, Feature } from '../base';

export const antag_target: Feature<number> = {
  name: 'Allow Antagonist Target',
  component: createDropdownInput({
    3: 'Yes - Round Remove',
    2: 'Yes - Kill',
    1: 'Yes - Temporary/Inconvienence',
    0: 'No',
  }),
};
