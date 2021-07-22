-- CreateTable
CREATE TABLE "skills" (
    "skill_id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "damage" DECIMAL(65,30) NOT NULL,
    "cooldown" DECIMAL(65,30) NOT NULL,
    "mana_cost" DECIMAL(65,30) NOT NULL,

    PRIMARY KEY ("skill_id")
);

-- CreateTable
CREATE TABLE "weapons" (
    "weapon_id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "damage" DECIMAL(65,30) NOT NULL,
    "attack_speed" DECIMAL(65,30) NOT NULL,

    PRIMARY KEY ("weapon_id")
);

-- CreateTable
CREATE TABLE "player_skills" (
    "player_id" INTEGER NOT NULL,
    "skill_id" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "player_weapons" (
    "player_id" INTEGER NOT NULL,
    "weapon_id" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "player_stats" (
    "player_stat_id" SERIAL NOT NULL,
    "player_id" INTEGER NOT NULL,
    "strength" INTEGER NOT NULL,
    "magic" INTEGER NOT NULL,
    "dexterity" INTEGER NOT NULL,
    "vitality" INTEGER NOT NULL,
    "life" INTEGER NOT NULL,
    "mana" INTEGER NOT NULL,

    PRIMARY KEY ("player_stat_id")
);

-- CreateTable
CREATE TABLE "players" (
    "player_id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "level" INTEGER NOT NULL,
    "experience" INTEGER NOT NULL,

    PRIMARY KEY ("player_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "player_skill_id" ON "player_skills"("player_id", "skill_id");

-- CreateIndex
CREATE UNIQUE INDEX "player_weapon_id" ON "player_weapons"("player_id", "weapon_id");

-- CreateIndex
CREATE UNIQUE INDEX "player_stats.player_id_unique" ON "player_stats"("player_id");

-- CreateIndex
CREATE UNIQUE INDEX "players.name_unique" ON "players"("name");

-- AddForeignKey
ALTER TABLE "player_skills" ADD FOREIGN KEY ("player_id") REFERENCES "players"("player_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "player_skills" ADD FOREIGN KEY ("skill_id") REFERENCES "skills"("skill_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "player_weapons" ADD FOREIGN KEY ("player_id") REFERENCES "players"("player_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "player_weapons" ADD FOREIGN KEY ("weapon_id") REFERENCES "weapons"("weapon_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "player_stats" ADD FOREIGN KEY ("player_id") REFERENCES "players"("player_id") ON DELETE CASCADE ON UPDATE CASCADE;
