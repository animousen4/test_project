abstract class ToEntityMapper<M, E> {
  E mapToEntity(M model);
}

abstract class ToModelMapper<M, E> {
  M mapToModel(E entity);
}
