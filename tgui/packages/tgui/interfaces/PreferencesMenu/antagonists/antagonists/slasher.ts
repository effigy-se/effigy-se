import { Antagonist, Category } from '../base';

export const SLASHER_MECHANICAL_DESCRIPTION = `
      Become a randomized killer set loose onto the station to terrorize the
      power recovery technicians, with a unique set of tools depending on
      the type of slasher.
    `;

const Slasher: Antagonist = {
  key: 'slasher',
  name: 'Slasher',
  description: [
    `
      A hostile force. A nightmare in the dark. A folk tale, passed to scare
      the generations. Whatever the case, you have taken the Station as your
      new haunt.
    `,
    SLASHER_MECHANICAL_DESCRIPTION,
  ],
  category: Category.Roundstart,
};

export default Slasher;
