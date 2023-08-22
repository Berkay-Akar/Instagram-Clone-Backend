/*
  Warnings:

  - You are about to drop the column `postId` on the `post_replies` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "post_replies" DROP CONSTRAINT "post_replies_postId_fkey";

-- AlterTable
ALTER TABLE "post_replies" DROP COLUMN "postId",
ADD COLUMN     "post_id" INTEGER;

-- AddForeignKey
ALTER TABLE "post_replies" ADD CONSTRAINT "post_replies_post_id_fkey" FOREIGN KEY ("post_id") REFERENCES "post"("id") ON DELETE SET NULL ON UPDATE CASCADE;
