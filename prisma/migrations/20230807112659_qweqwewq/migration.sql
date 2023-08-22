/*
  Warnings:

  - You are about to drop the `replies_likes` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "replies_likes" DROP CONSTRAINT "replies_likes_reply_id_fkey";

-- DropForeignKey
ALTER TABLE "replies_likes" DROP CONSTRAINT "replies_likes_user_id_fkey";

-- DropTable
DROP TABLE "replies_likes";

-- CreateTable
CREATE TABLE "reply_likes" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "reply_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "reply_likes_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "reply_likes" ADD CONSTRAINT "reply_likes_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "reply_likes" ADD CONSTRAINT "reply_likes_reply_id_fkey" FOREIGN KEY ("reply_id") REFERENCES "post_replies"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
