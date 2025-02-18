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

export const AntagInfoBababooey = (props) => {
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
                        <span style={jauntstyle}>Cloak:</span> You are freely
                        able to toggle invisibility at will. Take heed; however,
                        that uncloaking will paralyze you shortly.
                      </Stack.Item>
                      <Stack.Divider />
                      <Stack.Item>
                        <span style={injurestyle}>Cloning:</span> At any time;
                        you can place a clone to act as a proximity-based trap.
                        Any survivor that gets too close to your invisible clone
                        will cause them to reveal themselves - and alert you.
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
      <Box className="HellishRunes__demonrune">
        B<br />A<br />B<br />A<br />Y<br />A<br />G<br />A<br />
        B<br />A<br />B<br />A<br />Y<br />A<br />G<br />A<br />
        B<br />A<br />B<br />A<br />Y<br />A<br />G<br />A<br />
        B<br />A<br />B<br />A<br />Y<br />A<br />G<br />A
      </Box>
    </Section>
  );
};
