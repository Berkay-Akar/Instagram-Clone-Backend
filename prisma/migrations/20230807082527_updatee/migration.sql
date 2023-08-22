-- AlterTable
ALTER TABLE "post_replies" ADD COLUMN     "like_count" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "reply_count" INTEGER NOT NULL DEFAULT 0;
