#include "HolyGame.HC"
#include <stdio.h>
#include <stdlib.h>

U0 Require(Bool condition, const char *message)
{
  if (!condition) {
    fprintf(stderr, "engine test failed: %s\n", message);
    exit(1);
  }
}

U0 Main()
{
  HGWorld world;
  HGActor actor;
  HGActor other;
  I64 collision;

  HGWorldInit(&world, 0, 0, 200, 160);
  Require(HGWorldAddWall(&world, 50, 0, 10, 80),
          "wall should be added");

  HGActorInit(&actor, 40, 30, 8, 8);
  collision = HGMoveAndSlide(&actor, 20, 15, &world);
  Require(actor.x == 42, "actor must stop at wall");
  Require(actor.y == 45, "actor must slide along wall");
  Require(collision == HG_HIT_X, "horizontal collision must be reported");

  HGMoveAndSlide(&actor, 0, 50, &world);
  collision = HGMoveAndSlide(&actor, 20, 0, &world);
  Require(actor.x == 62, "actor must move after clearing wall");
  Require(collision == HG_HIT_NONE, "cleared wall must not collide");

  HGActorInit(&other, 65, 96, 8, 8);
  Require(HGActorsOverlap(&actor, &other), "actors must overlap");

  HGActorInit(&actor, 190, 150, 8, 8);
  collision = HGMoveAndSlide(&actor, 20, 20, &world);
  Require(actor.x == 192 && actor.y == 152,
          "world bounds must contain actor");
  Require(collision == (HG_HIT_X | HG_HIT_Y),
          "world-bound collisions must be reported");

  printf("HolyGame engine tests passed\n");
}

Main;
