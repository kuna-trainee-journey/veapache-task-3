/*
  Warnings:

  - You are about to drop the `player_skills` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `player_stats` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `player_weapons` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `players` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `skills` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `weapons` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "player_skills" DROP CONSTRAINT "player_skills_player_id_fkey";

-- DropForeignKey
ALTER TABLE "player_skills" DROP CONSTRAINT "player_skills_skill_id_fkey";

-- DropForeignKey
ALTER TABLE "player_stats" DROP CONSTRAINT "player_stats_player_id_fkey";

-- DropForeignKey
ALTER TABLE "player_weapons" DROP CONSTRAINT "player_weapons_player_id_fkey";

-- DropForeignKey
ALTER TABLE "player_weapons" DROP CONSTRAINT "player_weapons_weapon_id_fkey";

-- DropTable
DROP TABLE "player_skills";

-- DropTable
DROP TABLE "player_stats";

-- DropTable
DROP TABLE "player_weapons";

-- DropTable
DROP TABLE "players";

-- DropTable
DROP TABLE "skills";

-- DropTable
DROP TABLE "weapons";

-- CreateTable
CREATE TABLE "Skill" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "damage" DECIMAL(65,30) NOT NULL,
    "cooldown" DECIMAL(65,30) NOT NULL,
    "manaCost" DECIMAL(65,30) NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Weapon" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "damage" DECIMAL(65,30) NOT NULL,
    "attackSpeed" DECIMAL(65,30) NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PlayerSkill" (
    "playerId" INTEGER NOT NULL,
    "skillId" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "PlayerWeapon" (
    "playerId" INTEGER NOT NULL,
    "weaponId" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "PlayerStat" (
    "id" SERIAL NOT NULL,
    "playerId" INTEGER NOT NULL,
    "strength" INTEGER NOT NULL DEFAULT 1,
    "magic" INTEGER NOT NULL DEFAULT 1,
    "dexterity" INTEGER NOT NULL DEFAULT 1,
    "vitality" INTEGER NOT NULL DEFAULT 1,
    "life" INTEGER NOT NULL DEFAULT 1,
    "mana" INTEGER NOT NULL DEFAULT 1,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Player" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "level" INTEGER NOT NULL DEFAULT 0,
    "experience" INTEGER NOT NULL DEFAULT 0,

    PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Skill.name_unique" ON "Skill"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Weapon.name_unique" ON "Weapon"("name");

-- CreateIndex
CREATE UNIQUE INDEX "player_skill_id" ON "PlayerSkill"("playerId", "skillId");

-- CreateIndex
CREATE UNIQUE INDEX "player_weapon_id" ON "PlayerWeapon"("playerId", "weaponId");

-- CreateIndex
CREATE UNIQUE INDEX "PlayerStat.playerId_unique" ON "PlayerStat"("playerId");

-- CreateIndex
CREATE UNIQUE INDEX "Player.name_unique" ON "Player"("name");

-- AddForeignKey
ALTER TABLE "PlayerSkill" ADD FOREIGN KEY ("playerId") REFERENCES "Player"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PlayerSkill" ADD FOREIGN KEY ("skillId") REFERENCES "Skill"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PlayerWeapon" ADD FOREIGN KEY ("playerId") REFERENCES "Player"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PlayerWeapon" ADD FOREIGN KEY ("weaponId") REFERENCES "Weapon"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PlayerStat" ADD FOREIGN KEY ("playerId") REFERENCES "Player"("id") ON DELETE CASCADE ON UPDATE CASCADE;
