class GroupInfo {

  GroupInfo(String uid) {
    selectedFriends.add(uid);
    print('selectedFriends are $selectedFriends');
  }

  static List<String> presentGroupMembers() {
    return selectedFriends;
  }

  static List<String>selectedFriends = [];
}
