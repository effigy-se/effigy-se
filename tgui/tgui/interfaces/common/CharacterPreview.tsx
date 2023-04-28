import { ByondUi } from '../../components';

export const CharacterPreview = (props: {
  width?: string; // EFFIGY EDIT CHANGE
  height: string;
  id: string;
}) => {
  // EFFIGY EDIT CHANGE START
  const { width = '220px' } = props;
  // EFFIGY EDIT CHANGE END
  return (
    <ByondUi
      width={width} // EFFIGY EDIT CHANGE
      height={props.height}
      params={{
        id: props.id,
        type: 'map',
      }}
    />
  );
};
