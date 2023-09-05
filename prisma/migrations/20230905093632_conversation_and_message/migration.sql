/*
  Warnings:

  - You are about to drop the column `chatToId` on the `conversation` table. All the data in the column will be lost.
  - You are about to drop the column `ownerId` on the `conversation` table. All the data in the column will be lost.
  - Added the required column `userAId` to the `conversation` table without a default value. This is not possible if the table is not empty.
  - Added the required column `userBId` to the `conversation` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "conversation" DROP CONSTRAINT "conversation_chatToId_fkey";

-- DropForeignKey
ALTER TABLE "conversation" DROP CONSTRAINT "conversation_ownerId_fkey";

-- AlterTable
ALTER TABLE "conversation" DROP COLUMN "chatToId",
DROP COLUMN "ownerId",
ADD COLUMN     "userAId" INTEGER NOT NULL,
ADD COLUMN     "userBId" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "conversation" ADD CONSTRAINT "conversation_userAId_fkey" FOREIGN KEY ("userAId") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "conversation" ADD CONSTRAINT "conversation_userBId_fkey" FOREIGN KEY ("userBId") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
