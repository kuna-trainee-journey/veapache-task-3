import prisma from "../client";
import { createPlayer, getPlayer, getPlayers, updatePlayer, deletePlayer } from "../functions/players";


beforeAll(async () => {
  const playerData = {
    name: 'Voland',
  }

  await createPlayer(playerData);
})

test('should find player with id', async () => {
  const playerId = 666;
  
  const playerData = {
    player_id: playerId,
    name: 'Punk',
  }

  await createPlayer(playerData);

  const player = await getPlayer(playerId);

  expect(player?.player_id).toEqual(playerId);
})

test('should find all players', async () => {
  const initialPlayers = await getPlayers();

  const playerData = {
    player_id: 667,
    name: 'Bob'
  }

  await createPlayer(playerData);

  const newPlayers = await getPlayers();

  expect(initialPlayers.length + 1).toEqual(newPlayers.length);
})

test('should create new player ', async () => {
  const playerData = {
    name: 'Demortovich',
  }

  const newPlayer = await createPlayer(playerData);

  expect(newPlayer.name).toEqual(playerData.name);
})

test('should update player ', async () => {
  const playerData = {
    name: 'Great player',
  }

  const newPlayer = await createPlayer(playerData);

  const updatePlayerData = {
    name: 'Ugly player'
  }

  const updatedPlayer = await updatePlayer(newPlayer.player_id, updatePlayerData);

  expect(updatedPlayer.name).toEqual(updatePlayerData.name);
})

test('should delete player with id', async () => {
  const playerId = 777;

  const playerData = {
    player_id: playerId,
    name: 'Lucky Lucy',
  }

  await createPlayer(playerData);

  await deletePlayer(playerId);

  const player = await getPlayer(playerId);

  expect(player).toEqual(null);
})


afterAll(async () => {
  const deletePlayerStas = prisma.player_stats.deleteMany();
  const deletePlayers = prisma.players.deleteMany();

  await prisma.$transaction([
    deletePlayerStas,
    deletePlayers
  ])

  await prisma.$disconnect();
});
