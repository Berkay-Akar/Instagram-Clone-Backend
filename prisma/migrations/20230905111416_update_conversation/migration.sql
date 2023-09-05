/*
  Warnings:

  - A unique constraint covering the columns `[userAId,userBId]` on the table `conversation` will be added. If there are existing duplicate values, this will fail.

*/
-- DropIndex
DROP INDEX "message_senderId_receiverId_key";

-- CreateIndex
CREATE UNIQUE INDEX "conversation_userAId_userBId_key" ON "conversation"("userAId", "userBId");
