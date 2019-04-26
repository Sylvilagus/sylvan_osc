/**
 * Created by Sylva Lee
 */

typedef ResponseEntityToEntityList<Entity, ResponseEntity> = List<Entity>
Function(ResponseEntity responseEntity);
typedef ResponseEntityIsSuccess<ResponseEntity> = bool Function(
    ResponseEntity entity);
typedef ResponseEntityErrorDescription<ResponseEntity> = String Function(
    ResponseEntity entity);
typedef MsgOutput = Function(String msg);
typedef ResponseIteratorBuilder<ResponseEntity> = Iterator<Future<ResponseEntity>> Function();