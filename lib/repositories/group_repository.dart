import "package:voleizinho/model/group.dart";
import "package:voleizinho/objectbox.g.dart";

class GroupRepository {
  static Box<Group>? groupBox;

  static void init(Box<Group> box) {
    groupBox = box;
  }

  int addGroup(Group group) {
    return groupBox!.put(group);
  }

  void updateGroup(Group newGroup) {
    groupBox!.put(newGroup);
  }

  void removeGroup(Group group) {
    groupBox!.remove(group.id);
  }

  Group getGroupById(int id) {
    return groupBox!.get(id)!;
  }

  List<Group> getGroups() {
    return groupBox!.getAll();
  }
}
