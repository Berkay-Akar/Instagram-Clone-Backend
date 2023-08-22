-- CreateTable
CREATE TABLE "replies_likes" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "reply_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "replies_likes_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "replies_likes" ADD CONSTRAINT "replies_likes_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "replies_likes" ADD CONSTRAINT "replies_likes_reply_id_fkey" FOREIGN KEY ("reply_id") REFERENCES "post_replies"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
