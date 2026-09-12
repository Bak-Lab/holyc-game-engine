#include "HolyPhysics.HC"
#include <stdio.h>
#include <stdlib.h>

U0 Require(Bool condition, const char *message)
{
  if (!condition) {
    fprintf(stderr, "physics test failed: %s\n", message);
    exit(1);
  }
}

U0 Main()
{
  HGPhysicsWorld world;
  HGPhysicsBody *body;
  HGPhysicsCollider *wall;
  I64 step;

  HGPhysicsWorldInit(&world, 0, 200, 150, 0);
  wall = HGPhysicsAddCollider(
      &world, 80, 20, 8, 100, 1000, HG_MATERIAL_STONE, 1);
  body = HGPhysicsLaunch(&world, 20, 60, 24, 0, 4, 1, 0.5, 0.1, 1);
  for (step = 0; step < 4; step++)
    HGPhysicsStep(&world, 1);
  Require(body->x < 76, "fast body tunneled through wall");
  Require(body->velocity_x < 0, "body did not bounce from wall");
  Require(wall->last_impact > 0, "wall did not record impact");

  HGPhysicsWorldInit(&world, 0, 200, 150, 0);
  wall = HGPhysicsAddCollider(
      &world, 80, 20, 8, 100, 5, HG_MATERIAL_WOOD, 2);
  body = HGPhysicsLaunch(&world, 50, 60, 20, 0, 4, 1, 0.2, 0.1, 2);
  for (step = 0; step < 3; step++)
    HGPhysicsStep(&world, 1);
  Require(!wall->active, "destructible wall survived strong impact");

  HGPhysicsWorldInit(&world, 0, 200, 150, 1);
  body = HGPhysicsLaunch(&world, 50, 100, 2, 0, 4, 1, 0.4, 0.2, 3);
  for (step = 0; step < 40; step++)
    HGPhysicsStep(&world, 0.5);
  Require(body->y <= 146, "body passed through ground");

  printf("HolyPhysics tests passed\n");
}

Main;
