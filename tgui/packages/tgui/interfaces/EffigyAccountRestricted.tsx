import { useBackend } from '../backend';
import { Button, NoticeBox, Section } from '../components';
import { Window } from '../layouts';

export const EffigyAccountRestricted = (props) => {
  const { act } = useBackend();
  return (
    <Window
      title="Not Authorized [2F173/2]"
      width={950}
      height={550}
      theme="dark"
    >
      <Window.Content>
        <NoticeBox info fontSize="2em">
          Whitelisting Required
        </NoticeBox>
      </Window.Content>
      <Window.Content scrollable mt={10}>
        <Section title="New Player Information" fontSize="1.25em">
          Effigy uses a player whitelist and your account was not found!
          <br />
          <br />
          Effigy is an 18+ only roleplay focused Space Station 13 server. To
          avoid getting banned, make sure you have a clear understanding of our
          Server and Discord Rules.
          <br />
          <br />
          We&apos;re an MRP mixed RP/action server that believes in player
          agency. Players should not feel overly restricted within the gameplay
          policy or giant list of rules to the extent that they feel compelled
          to actively pursue antagonist status.
          <br />
          <br />
          Players should not feel compelled to actively pursue antagonist status
          or staff approval to create opportunities for engagement and
          enjoyment, nor solely relying on becoming an antagonist.
          <br />
          <br />
          If you&apos;re looking for anthro/furry friendly character
          customisation, roleplay focused gameplay, and light antag/action:
          Welcome!
          <br />
          <br />
          Access to this server is regulated through a whitelisting system,
          which means you will need to submit an application to join our
          community.
        </Section>
        <Section title="Discord Verification" fontSize="1.25em">
          We require that you be a member of our Discord server in order to be a
          member of the community.
          <br />
          <br />
          Hit the button to verify your Discord account and create an Effigy
          profile.
          <br />
          <br />
          <Button
            onClick={() => act('registration')}
            color="green"
            textColor="black"
            lineHeight={2}
            minWidth="100%"
            content="View Terms of Service and Verify"
          />
        </Section>
      </Window.Content>
    </Window>
  );
};
