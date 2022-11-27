import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String createSQL = '''-- CreateTable
CREATE TABLE "User" (
    "id" INTEGER PRIMARY KEY,
    "name" TEXT NOT NULL,
    "imageUri" TEXT,
);

-- CreateTable
CREATE TABLE "Message" (
    "localId" INTEGER PRIMARY KEY AUTOINCREMENT,
    "id" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "content" TEXT NOT NULL,
    "createdById" INTEGER NOT NULL,
    "roomId" INTEGER NOT NULL,
);

-- CreateTable
CREATE TABLE "RoomChat" (
    "id" INTEGER PRIMARY KEY,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "name" TEXT NOT NULL,
    "avatarUri" TEXT,
);
''';

class LocalDBController {
  static openDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'doggie_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
        );
      },
      version: 1,
    );
  }
}
