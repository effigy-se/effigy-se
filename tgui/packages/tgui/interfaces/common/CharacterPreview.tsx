import { ByondUi } from '../../components';

export const CharacterPreview = (props: {
  width?: string; // EffigyEdit Change Customization
  height: string;
  id: string;
}) => {
  // EffigyEdit Change START Customization
  const { width = '220px' } = props;
  // EffigyEdit Change END Customization
  return (
    <ByondUi
      width={width} // EffigyEdit Change Customization
      height={props.height}
      params={{
        id: props.id,
        type: 'map',
      }}
    />
  );
};
