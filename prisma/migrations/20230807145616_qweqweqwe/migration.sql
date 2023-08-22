/*
  Warnings:

  - The primary key for the `follows` table will be changed. If it partially fails, the table could be left without primary key constraint.

*/
-- AlterTable
ALTER TABLE "follows" DROP CONSTRAINT "follows_pkey",
ADD COLUMN     "id" SERIAL NOT NULL,
ADD CONSTRAINT "follows_pkey" PRIMARY KEY ("id");
