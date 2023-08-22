/*
  Warnings:

  - You are about to drop the column `comment_count` on the `post_replies` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "post_replies" DROP COLUMN "comment_count",
ADD COLUMN     "comments_count" INTEGER NOT NULL DEFAULT 0;
