/*
  Warnings:

  - You are about to drop the column `reply` on the `post_replies` table. All the data in the column will be lost.
  - You are about to drop the column `reply_count` on the `post_replies` table. All the data in the column will be lost.
  - Added the required column `content` to the `post_replies` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "post_replies" DROP COLUMN "reply",
DROP COLUMN "reply_count",
ADD COLUMN     "comment_count" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "content" TEXT NOT NULL;
