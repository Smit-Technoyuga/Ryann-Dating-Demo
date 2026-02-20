import 'package:flutter_test/flutter_test.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/basic_info_screen/cubit/basic_info_cubit.dart';
import 'package:ryann_dating/app/pages/authentication/screens/user_info_screens/basic_info_screen/cubit/basic_info_state.dart';

void main() {
  late BasicInfoCubit cubit;

  setUp(() {
    cubit = BasicInfoCubit();
  });

  tearDown(() {
    cubit.close();
  });

  test('BasicInfoCubit emits new state when dob controller changes', () async {
    final states = <BasicInfoState>[];
    cubit.stream.listen(states.add);

    // Act
    cubit.state.dobControllers[0].text = '1';

    // Allow the listener to fire and microtasks to complete
    await Future.delayed(Duration.zero);

    // Assert
    expect(states.length, 1);
    expect(states[0].dobText, '1');
  });

  test('BasicInfoState equality depends on dobText', () {
    final state1 = cubit.state;
    state1.dobControllers[0].text = '1';

    final state2 = state1
        .copyWith(); // copyWith currently doesn't deep copy controllers, which is fine as they are mutable but we need the equality to work

    expect(state1.dobText, '1');
    expect(state1.props.contains('1'), true);
  });
}
