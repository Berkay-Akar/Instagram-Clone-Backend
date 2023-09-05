/*
  Warnings:

  - A unique constraint covering the columns `[senderId,receiverId]` on the table `message` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "message_senderId_receiverId_key" ON "message"("senderId", "receiverId");
