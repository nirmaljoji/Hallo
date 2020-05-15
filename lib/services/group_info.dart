class GroupInfo {
  GroupInfo(String uid) {
    selectedFriends.add(uid);
    print(selectedFriends);
  }

  static List<String> selectedFriends = [];
}
