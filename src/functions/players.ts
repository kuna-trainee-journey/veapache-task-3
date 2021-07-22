/* eslint-disable @typescript-eslint/explicit-module-boundary-types */
import prisma from '../client';

type CreatePlayer = {
  name: string
}

type UpdatePlayer = {
  name: string
}

export async function getPlayers() {
  return prisma.player.findMany({
    include: {
      PlayerStats: true,
      PlayerSkills: true,
      PlayerWeapons: true,
    },
  })
}

export async function getPlayer(playerId: number) {
  return prisma.player.findUnique({
    where: {
      id: playerId,
    },
  })
}

export async function getPlayerDetails(playerId: number) {
  return prisma.player.findUnique({
    where: {
      id: playerId,
    },
    include: {
      PlayerStats: true,
      PlayerSkills: true,
      PlayerWeapons: true,
    },
  })
}

export async function createPlayer(player: CreatePlayer) {
  return prisma.player.create({
    data: {
      ...player,
      PlayerStats: {
        create: {}
      }
    }
  })
}

export async function updatePlayer(playerId: number, player: UpdatePlayer) {
  return prisma.player.update({
    where: {
      id: playerId,
    },
    data: player,
  })
}

export async function deletePlayer(playerId: number) {
  return prisma.player.delete({
    where: {
      id: playerId,
    },
  })
}