/*
  Warnings:

  - A unique constraint covering the columns `[name]` on the table `skills` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[name]` on the table `weapons` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "skills.name_unique" ON "skills"("name");

-- CreateIndex
CREATE UNIQUE INDEX "weapons.name_unique" ON "weapons"("name");
