/* eslint-disable @typescript-eslint/explicit-module-boundary-types */
import prisma from '../client';

interface CreatePlayer {
  name: string
}

interface UpdatePlayer {
  name: string
}

export async function getPlayers() {
  return await prisma.players.findMany({
    include: {
      player_stats: true,
      player_skills: true,
      player_weapons: true,
    },
  })
}

export async function getPlayer(playerId: number) {
  return await prisma.players.findUnique({
    where: {
      player_id: playerId,
    },
    include: {
      player_stats: true,
      player_skills: true,
      player_weapons: true,
    },
  })
}

export async function createPlayer(player: CreatePlayer) {
  return await prisma.players.create({
    data: {
      ...player,
      player_stats: {
        create: {}
      }
    }
  })
}

export async function updatePlayer(playerId: number, player: UpdatePlayer) {
  return await prisma.players.update({
    where: {
      player_id: playerId,
    },
    data: player,
  })
}

export async function deletePlayer(playerId: number) {
  return await prisma.players.delete({
    where: {
      player_id: playerId,
    },
  })
}