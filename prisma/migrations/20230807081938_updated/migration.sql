/*
  Warnings:

  - Added the required column `reply` to the `post_replies` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "post_replies" ADD COLUMN     "reply" TEXT NOT NULL;
