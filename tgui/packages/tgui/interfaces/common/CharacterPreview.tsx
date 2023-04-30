import { ByondUi } from '../../components';

export const CharacterPreview = (props: {
  width?: string; // EFFIGY EDIT CHANGE - CUSTOMIZATION
  height: string;
  id: string;
}) => {
  // EFFIGY EDIT CHANGE START - CUSTOMIZATION
  const { width = '220px' } = props;
  // EFFIGY EDIT CHANGE END - CUSTOMIZATION
  return (
    <ByondUi
      width={width} // EFFIGY EDIT CHANGE - CUSTOMIZATION
      height={props.height}
      params={{
        id: props.id,
        type: 'map',
      }}
    />
  );
};
