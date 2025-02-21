import { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Box, Section, Stack } from '../components';
import { Window } from '../layouts';
import { Objective, ObjectivePrintout } from './common/Objectives';

const jauntstyle = {
  color: 'lightblue',
};

const injurestyle = {
  color: 'yellow',
};

type Info = {
  fluff: string;
  explain_attack: BooleanLike;
  objectives: Objective[];
};

export const AntagInfoBorgmire = (props) => {
  const { data } = useBackend<Info>();
  const { fluff, objectives, explain_attack } = data;
  return (
    <Window width={725} height={356} theme="syndicate">
      <Window.Content style={{ backgroundImage: 'none' }}>
        <Stack fill>
          <Stack.Item>
            <DemonRunes />
          </Stack.Item>
          <Stack.Item grow>
            <Stack vertical width="544px" fill>
              <Stack.Item grow>
                <Section fill scrollable={objectives.length > 2}>
                  <Stack vertical>
                    <Stack.Item
                      textAlign="center"
                      textColor="red"
                      fontSize="20px"
                    >
                      {fluff}
                    </Stack.Item>
                    <Stack.Item>
                      <ObjectivePrintout
                        titleMessage="As a Cryptid-Class Slasher; it's in your nature to accomplish these goals:"
                        objectiveTextSize="20px"
                        objectives={objectives}
                      />
                    </Stack.Item>
                  </Stack>
                </Section>
              </Stack.Item>
              {!!explain_attack && (
                <Stack.Item>
                  <Section fill title="Special Abilities:">
                    <Stack vertical>
                      <Stack.Item>
                        <span style={jauntstyle}>Mechanical Malevolence:</span>
                        Your actuators and pistons were designed with the
                        express intent to punch your enemies into pulp; and that
                        is full well what you intend to do. You trade your
                        jumpscare for two hands; and the know-how to use them.
                      </Stack.Item>
                      <Stack.Divider />
                      <Stack.Item>
                        <span style={injurestyle}>CQC:</span> You know what to
                        do.
                      </Stack.Item>
                    </Stack>
                  </Section>
                </Stack.Item>
              )}
            </Stack>
          </Stack.Item>
          <Stack.Item>
            <DemonRunes />
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

const DemonRunes = (props) => {
  return (
    <Section height="102%" mt="-6px" fill>
      {/*
      amog nus
      */}
      <Box className="HellishRunes__demonrune">
        B<br />O<br />R<br />G<br />M<br />I<br />R<br />E<br />
        B<br />O<br />R<br />G<br />M<br />I<br />R<br />E<br />
        B<br />O<br />R<br />G<br />M<br />I<br />R<br />E<br />
        B<br />O<br />R<br />G<br />M<br />I<br />R<br />E
      </Box>
    </Section>
  );
};
