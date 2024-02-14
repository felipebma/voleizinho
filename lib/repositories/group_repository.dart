import "package:get_it/get_it.dart";
import "package:voleizinho/model/group.dart";
import "package:voleizinho/object_box.dart";
import "package:voleizinho/objectbox.g.dart";

class GroupRepository {
  final Box<Group> groupBox = GetIt.I<ObjectBox>().store.box<Group>();

  GroupRepository();

  int addGroup(Group group) {
    return groupBox.put(group);
  }

  void updateGroup(Group newGroup) {
    groupBox.put(newGroup);
  }

  void removeGroup(Group group) {
    groupBox.remove(group.id);
  }

  void removeGroupByName(String name) {
    groupBox.query(Group_.name.equals(name)).build().remove();
  }

  Group? getGroupById(int id) {
    return groupBox.get(id);
  }

  List<Group> getGroups() {
    return groupBox.getAll();
  }
}
