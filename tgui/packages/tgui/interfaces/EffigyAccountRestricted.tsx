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
        </Section>
        <Section
          title="Before gaining access to our server, please read and agree to the following terms of service."
          fontSize="1.25em"
        >
          Access to this server is regulated through a whitelisting system,
          which means you will need to submit an application to join our
          community. By applying and joining, you acknowledge and agree to the
          following:
          <br />
          <br />- Staff members reserve the right to accept or deny applications
          for any reason. Their decision is final, and no further discussion or
          appeal will be entertained.
          <br />
          <br />- To gain access, you are required to submit an application to
          our staff team. The application should include accurate and relevant
          information about yourself. Any false or misleading information may
          result in the rejection of your application.
          <br />
          <br />- Our staff members have the authority to accept or deny
          applications based on their judgment. They are not obligated to
          provide an explanation for their decision. However, they may choose to
          share information as a courtesy to the applicant.
          <br />
          <br />- Upon joining the community, you are expected to adhere to our
          Server and Community Rules. These rules are in place to ensure a safe
          and enjoyable environment for all community members. Failure to comply
          with these rules may result in temporary or permanent removal from the
          community, at the discretion of the staff. The decision will be based
          on the severity and frequency of the violations.
          <br />
          <br />- Please note that conversational level English is required to
          participate in discussions and activities here.
          <br />
          <br />- Effigy cannot be held responsible for any actions or
          interactions that occur within the community. You acknowledge that
          participation in this community may expose you to various types of
          content and interactions, which may not always be suitable or
          desirable. We do our best to provide content moderation and a safe,
          enjoyable space for all members.
          <br />
          <br />- By applying and joining our community, you confirm that you
          have read, understood, and agreed to these terms of service as well as
          our Server and Community rules, which are found on the
          &apos;Rules&apos; tab on the navigation bar. Failure to comply with
          these terms may result in denial of access or removal from the
          community. We hope you enjoy your experience in our community!
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
            color="good"
            textColor="black"
            lineHeight={2}
            minWidth={15}
            content="Verify Discord"
          />
        </Section>
      </Window.Content>
    </Window>
  );
};
