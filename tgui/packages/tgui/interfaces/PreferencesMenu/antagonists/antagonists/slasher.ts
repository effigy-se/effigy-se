import { Antagonist, Category } from '../base';
import { multiline } from 'common/string';

export const SLASHER_MECHANICAL_DESCRIPTION = multiline`
      Become a randomized killer set loose onto the station to terrorize the \
      SlashCo employees, with a unique set of tools depending on the type of slasher.
   `;

const Slasher: Antagonist = {
  key: 'slasher',
  name: 'Slasher',
  description: [
    multiline`
      A hostile force. A nightmare in the dark. A folk tale, passed to scare the \
      generations. Whatever the case, you have taken the Station as your new haunt...
    `,
    SLASHER_MECHANICAL_DESCRIPTION,
  ],
  category: Category.Roundstart,
  priority: -1,
};

export default Slasher;
