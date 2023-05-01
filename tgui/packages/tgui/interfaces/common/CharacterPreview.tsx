import { ByondUi } from '../../components';

export const CharacterPreview = (props: {
  width?: string; // EFFIGY EDIT CHANGE (#3 Customization - Ported from Skyrat)
  height: string;
  id: string;
}) => {
  // EFFIGY EDIT CHANGE START (#3 Customization - Ported from Skyrat)
  const { width = '220px' } = props;
  // EFFIGY EDIT CHANGE END (#3 Customization - Ported from Skyrat)
  return (
    <ByondUi
      width={width} // EFFIGY EDIT CHANGE (#3 Customization - Ported from Skyrat)
      height={props.height}
      params={{
        id: props.id,
        type: 'map',
      }}
    />
  );
};
