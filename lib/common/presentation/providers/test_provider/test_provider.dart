import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'test_provider.g.dart';
part 'test_provider.freezed.dart';

// Freezed se utiliza para hacer una clase inmutable y con soporte para igualdad estructural
@freezed
abstract class TestState with _$TestState {
  const factory TestState({
    @Default(false) bool isLoading,
    @Default([]) List<String> items,
    @Default('') String errorMessage,
  }) = _TestState;
}

@riverpod
class TestProvider extends _$TestProvider {
  // Siempre utilizar el @override en el método build
  @override
  Future<TestState> build() async {
    // Indicar que la carga ha comenzado
    state = const AsyncValue.loading();

    // Realizar la operación asíncrona
    final result = await AsyncValue.guard(() async {
      await Future.delayed(const Duration(seconds: 2));
      // Retornar el estado inicial, en este punto se puede devolver un estado con datos cargados o asignar valores por defecto
      return const TestState();
    });

    // Verificar si el provider todavía está montado -> Esto evita errores si el provider se desmonta antes de completar la operación asíncrona
    if (!ref.mounted) return TestState();

    // Actualizar el estado solo si el provider sigue montado
    state = result;
    return state.value!;
  }

  /// Carga una lista de ítems de prueba
  Future<void> loadItems() async {
    // Indicar que la carga ha comenzado
    state = const AsyncValue.loading();

    // Realizar la operación asíncrona
    final result = await AsyncValue.guard(() async {
      await Future.delayed(const Duration(seconds: 2));

      // Retornar una lista de ítems de prueba
      // result = estado actualizado (todavía no asignado)
      return TestState(
        items: List.generate(10, (index) => 'Item ${index + 1}'),
      );
    });

    // Verificar si el provider todavía está montado -> Esto evita errores si el provider se desmonta antes de completar la operación asíncrona
    if (!ref.mounted) return;
    // Actualizar el estado solo si el provider sigue montado
    state = result;
  }
}
