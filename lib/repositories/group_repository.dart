import "package:voleizinho/model/group.dart";
import "package:voleizinho/objectbox.g.dart";

class GroupRepository {
  static Box<Group>? groupBox;

  static void init(Box<Group> box) {
    groupBox = box;
  }

  void addGroup(Group group) async {
    List<Group> groups = groupBox!.getAll();
    groups.add(group);
    groupBox!.put(group);
  }

  void updateGroup(Group oldGroup, Group newGroup) async {
    groupBox!.put(newGroup);
  }

  void removeGroup(Group group) async {
    groupBox!.remove(group.id);
  }

  List<Group> getGroups() {
    return groupBox!.getAll();
  }
}
