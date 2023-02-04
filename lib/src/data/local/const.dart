const createUser = """
CREATE TABLE IF NOT EXISTS "User" (
    "id" INTEGER PRIMARY KEY,
    "name" TEXT NOT NULL,
    "imageUri" TEXT
);
""";

const createMessage = """
CREATE TABLE IF NOT EXISTS "Message" (
    "localId" INTEGER PRIMARY KEY AUTOINCREMENT,
    "id" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "content" TEXT NOT NULL,
    "createdById" INTEGER NOT NULL,
    "roomId" INTEGER NOT NULL
);
""";

const createRoom = """
CREATE TABLE IF NOT EXISTS "RoomChat" (
    "id" INTEGER PRIMARY KEY,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "name" TEXT NOT NULL,
    "avatarUri" TEXT
);
""";

const createAccount = """
CREATE TABLE IF NOT EXISTS "MyAccount" (
    "id" INTEGER PRIMARY KEY,
    "name" TEXT NOT NULL,
    "imageUri" TEXT,
    "token" TEXT NOT NULL,
    "userName" TEXT NOT NULL,
    "password" TEXT NOT NULL
);
""";