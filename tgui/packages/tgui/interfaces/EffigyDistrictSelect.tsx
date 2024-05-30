import { NoticeBox } from '../components';
import { Window } from '../layouts';

export const EffigyDistrictSelect = (props) => {
  return (
    <Window title="District Select" width={778} height={512} theme="dark">
      <Window.Content>
        <NoticeBox info>District Select</NoticeBox>
      </Window.Content>
    </Window>
  );
};
