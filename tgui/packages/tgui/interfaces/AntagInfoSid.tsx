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

export const AntagInfoSid = (props) => {
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
                        titleMessage="As a Demon-Class Slasher; it's in your nature to accomplish these goals:"
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
                        <span style={jauntstyle}>Cookie Monster:</span> Every
                        cookie you eat is a sweet sweet treat! For every cookie
                        consumed; you gain a shot in your gun. Be careful;
                        however - you lose your ability to kill after eating a
                        cookie; briefly...
                      </Stack.Item>
                      <Stack.Divider />
                      <Stack.Item>
                        <span style={injurestyle}>Gun:</span> Put one between
                        their eyes. Only available after consuming a cookie;
                        unless the shuttle is coming or you have eaten at least
                        four cookies.
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
        C<br />O<br />O<br />K<br />I<br />E<br />S<br />!<br />
        C<br />O<br />O<br />K<br />I<br />E<br />S<br />!<br />
        C<br />O<br />O<br />K<br />I<br />E<br />S<br />!<br />
        C<br />O<br />O<br />K<br />I<br />E<br />S<br />!
      </Box>
    </Section>
  );
};
