import prisma from "../client";
import { createPlayer, getPlayer, getPlayers, updatePlayer, deletePlayer } from "../functions/players";

const deletePlayerRecords = async () => {
  await prisma.$transaction([
    prisma.playerStat.deleteMany(),
    prisma.player.deleteMany()
  ]);
}

beforeEach(async () => {
  await deletePlayerRecords();
})

afterAll(async () => {
  await deletePlayerRecords();
  await prisma.$disconnect();
})

test('should find player with id', async () => {
  const playerId = 666;
  
  const playerData = {
    id: playerId,
    name: 'Punk',
  }

  await createPlayer(playerData);

  const player = await getPlayer(playerId);

  expect(player?.id).toEqual(playerId);
})

test('should find all players', async () => {
  const initialPlayers = await getPlayers();

  const playerData = {
    id: 667,
    name: 'Bob'
  }

  await createPlayer(playerData);

  const newPlayers = await getPlayers();

  expect(initialPlayers.length + 1).toEqual(newPlayers.length);
})

test('should create new player ', async () => {
  const playerId = 322;

  const playerData = {
    id: playerId,
    name: 'Demortovich',
  }

  const newPlayer = await createPlayer(playerData);

  const player = await getPlayer(newPlayer.id);

  expect(player?.id).toEqual(playerId);
})

test('should create default player stats on player create', async () => {
  const playerId = 2021;

  const playerData = {
    id: playerId,
    name: 'KunaCoder',
  }

  const basePlayerStats = {
    strength: 1,
    magic: 1,
    dexterity: 1,
    vitality: 1,
    life: 1,
    mana: 1,
  }

  await createPlayer(playerData);

  const player = await getPlayer(playerId);

  expect(player?.playerStats).toMatchObject(basePlayerStats);
})

test('should update player ', async () => {
  const playerId = 228;

  const playerData = {
    id: playerId,
    name: 'Great player',
  }

  const newPlayer = await createPlayer(playerData);

  const updatePlayerData = {
    name: 'Ugly player'
  }

  const updatedPlayer = await updatePlayer(newPlayer.id, updatePlayerData);

  const player = await getPlayer(updatedPlayer.id);

  expect(player?.id).toEqual(playerId);
})

test('should delete player with id', async () => {
  const playerId = 777;

  const playerData = {
    id: playerId,
    name: 'Lucky Lucy',
  }

  await createPlayer(playerData);

  await deletePlayer(playerId);

  const player = await getPlayer(playerId);

  expect(player).toEqual(null);
})
