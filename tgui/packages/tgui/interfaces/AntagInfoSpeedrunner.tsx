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

export const AntagInfoSpeedrunner = (props) => {
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
                        titleMessage="As a Umbra-Class Slasher; it's in your nature to accomplish these goals:"
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
                        <span style={jauntstyle}>Speedrun:</span> while you
                        start incredibly slow; each step you take slows
                        accumulates further and further speed, allowing you to
                        catch up to your prey.
                      </Stack.Item>
                      <Stack.Divider />
                      <Stack.Item>
                        <span style={injurestyle}>RNG Sacrifice:</span> after a
                        point; you will reach your maximum speed. Fret not; as
                        while this does reset your accumulated speed - it will
                        also increase the rate you gain further; how fast you
                        can go in total - and ramp up the music. It also has
                        additional effects on the round...
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
        S<br />P<br />E<br />E<br />D<br />R<br />U<br />N<br />
        S<br />P<br />E<br />E<br />D<br />R<br />U<br />N<br />
        S<br />P<br />E<br />E<br />D<br />R<br />U<br />N<br />
        S<br />P<br />E<br />E<br />D<br />R<br />U<br />N
      </Box>
    </Section>
  );
};
