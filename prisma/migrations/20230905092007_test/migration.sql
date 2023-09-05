/*
  Warnings:

  - You are about to drop the column `userId` on the `conversation` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `message` table. All the data in the column will be lost.
  - You are about to drop the `_participantConversations` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `chatToId` to the `conversation` table without a default value. This is not possible if the table is not empty.
  - Added the required column `ownerId` to the `conversation` table without a default value. This is not possible if the table is not empty.
  - Added the required column `is_deleted` to the `message` table without a default value. This is not possible if the table is not empty.
  - Added the required column `is_seen` to the `message` table without a default value. This is not possible if the table is not empty.
  - Made the column `conversationId` on table `message` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE "_participantConversations" DROP CONSTRAINT "_participantConversations_A_fkey";

-- DropForeignKey
ALTER TABLE "_participantConversations" DROP CONSTRAINT "_participantConversations_B_fkey";

-- DropForeignKey
ALTER TABLE "conversation" DROP CONSTRAINT "conversation_userId_fkey";

-- DropForeignKey
ALTER TABLE "message" DROP CONSTRAINT "message_conversationId_fkey";

-- DropForeignKey
ALTER TABLE "message" DROP CONSTRAINT "message_userId_fkey";

-- AlterTable
ALTER TABLE "conversation" DROP COLUMN "userId",
ADD COLUMN     "chatToId" INTEGER NOT NULL,
ADD COLUMN     "ownerId" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "message" DROP COLUMN "userId",
ADD COLUMN     "is_deleted" BOOLEAN NOT NULL,
ADD COLUMN     "is_seen" BOOLEAN NOT NULL,
ALTER COLUMN "conversationId" SET NOT NULL;

-- DropTable
DROP TABLE "_participantConversations";

-- AddForeignKey
ALTER TABLE "conversation" ADD CONSTRAINT "conversation_ownerId_fkey" FOREIGN KEY ("ownerId") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "conversation" ADD CONSTRAINT "conversation_chatToId_fkey" FOREIGN KEY ("chatToId") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "message" ADD CONSTRAINT "message_conversationId_fkey" FOREIGN KEY ("conversationId") REFERENCES "conversation"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
