const sampleUsers = """
INSERT INTO "User"("id", "name", "imageUri") VALUES
(1,'admin',null),
(2,'Thuỷ Tiên',null),
(3,'Minh Nhực', null);
""";

const sampleRooms = """
INSERT INTO "RoomChat"("id", "name", "avatarUri") VALUES
(1,'Phòng chat số 1', null),
(2,'Phòng chat số 2', null);
""";

const sampleMessages = """
INSERT INTO "Message"("id", "localId", "content", "createdById", "roomId") VALUES
(1, 1, 'Chat 1', 2, 1),
(2, 2, 'Chat 2', 3, 1),
(3, 3, 'Chat 3', 2, 1);
""";
