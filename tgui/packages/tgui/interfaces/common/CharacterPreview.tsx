import { ByondUi } from '../../components';

export const CharacterPreview = (props: {
  width?: string; // EffigyEdit Change (#3 Customization - Ported from Skyrat)
  height: string;
  id: string;
}) => {
  // EffigyEdit Change START (#3 Customization - Ported from Skyrat)
  const { width = '220px' } = props;
  // EffigyEdit Change END (#3 Customization - Ported from Skyrat)
  return (
    <ByondUi
      width={width} // EffigyEdit Change (#3 Customization - Ported from Skyrat)
      height={props.height}
      params={{
        id: props.id,
        type: 'map',
      }}
    />
  );
};
