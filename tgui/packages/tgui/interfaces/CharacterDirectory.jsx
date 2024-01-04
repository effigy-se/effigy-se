import { useState } from 'react';

import { useBackend } from '../backend';
import { Button, Icon, Section, Table } from '../components';
import { Window } from '../layouts';

const erpTagColor = {
  Unset: 'label',
  'Yes - Dom': '#43051f',
  'Yes - Sub': '#003647',
  'Yes - Switch': '#014625',
  Yes: '#014625',
  'Check OOC': '#222222',
  Ask: '#222222',
  No: '#000000',
};

export const CharacterDirectory = (props) => {
  const { act, data } = useBackend();

  const { prefsOnly } = data;

  const [overwritePrefs, setOverwritePrefs] = useState(prefsOnly);

  const sortIdState = useState('name');
  const sortOrderState = useState('name');

  return (
    <Window width={778} height={512} resizeable>
      <Window.Content scrollable>
        <CharacterDirectoryList
          sortIdState={sortIdState}
          sortOrderState={sortOrderState}
        />
      </Window.Content>
    </Window>
  );
};

const CharacterDirectoryList = (props) => {
  const { act, data } = useBackend();
  const { sortIdState, sortOrderState } = props;

  const { directory, canOrbit } = data;

  const [sortId] = sortIdState;
  const [sortOrder] = sortOrderState;

  return (
    <Section
      title="Character Directory"
      buttons={
        <Button icon="sync" content="Refresh" onClick={() => act('refresh')} />
      }
    >
      <Table>
        <Table.Row bold>
          <SortButton
            id="name"
            sortIdState={sortIdState}
            sortOrderState={sortOrderState}
          >
            Name
          </SortButton>
          <SortButton
            id="species"
            sortIdState={sortIdState}
            sortOrderState={sortOrderState}
          >
            Species
          </SortButton>
          <SortButton
            id="attraction"
            sortIdState={sortIdState}
            sortOrderState={sortOrderState}
          >
            Attraction
          </SortButton>
          <SortButton
            id="gender"
            sortIdState={sortIdState}
            sortOrderState={sortOrderState}
          >
            Gender
          </SortButton>
          <SortButton
            id="erp"
            sortIdState={sortIdState}
            sortOrderState={sortOrderState}
          >
            ERP
          </SortButton>
          <Table.Cell textAlign="right" />
        </Table.Row>
        {directory
          .sort((a, b) => {
            const i = sortOrder ? 1 : -1;
            return a[sortId].localeCompare(b[sortId]) * i;
          })
          .map((character, i) => (
            <Table.Row key={i} backgroundColor={erpTagColor[character.erp]}>
              <Table.Cell p={1}>
                {canOrbit ? (
                  <Button
                    color={erpTagColor[character.erp]}
                    icon="ghost"
                    tooltip="Orbit"
                    content={character.name}
                    onClick={() => act('orbit', { ref: character.ref })}
                  />
                ) : (
                  character.name
                )}
              </Table.Cell>
              <Table.Cell>{character.species}</Table.Cell>
              <Table.Cell>{character.attraction}</Table.Cell>
              <Table.Cell>{character.gender}</Table.Cell>
              <Table.Cell>{character.erp}</Table.Cell>
              <Table.Cell collapsing textAlign="right">
                <Button
                  onClick={() => act('view', { ref: character.ref })}
                  color="transparent"
                  icon="sticky-note"
                  mr={1}
                  content="View"
                />
              </Table.Cell>
            </Table.Row>
          ))}
      </Table>
    </Section>
  );
};

const SortButton = (props) => {
  const { act, data } = useBackend();

  const { id, children, sortIdState, sortOrderState } = props;

  // Hey, same keys mean same data~
  const [sortId, setSortId] = sortIdState;
  const [sortOrder, setSortOrder] = sortOrderState;

  return (
    <Table.Cell collapsing>
      <Button
        width="100%"
        color={sortId !== id && 'transparent'}
        onClick={() => {
          if (sortId === id) {
            setSortOrder(!sortOrder);
          } else {
            setSortId(id);
            setSortOrder(true);
          }
        }}
      >
        {children}
        {sortId === id && (
          <Icon name={sortOrder ? 'sort-up' : 'sort-down'} ml="0.25rem;" />
        )}
      </Button>
    </Table.Cell>
  );
};
