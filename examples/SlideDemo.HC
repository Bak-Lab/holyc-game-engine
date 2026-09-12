#include "HolyGame.HC"

U0 Main()
{
  CDC *dc = DCAlias;
  HGWorld world;
  HGActor actor;
  I64 frame;

  HGWorldInit(&world, 0, 0, 640, 480);
  HGWorldAddWall(&world, 300, 80, 24, 320);
  HGActorInit(&actor, 220, 180, 14, 18);

  for (frame = 0; frame < 160; frame++) {
    HGMoveAndSlide(&actor, 2, 1, &world);
    dc->color = BLUE;
    DCFill(dc);
    dc->color = LTGRAY;
    GrRect(dc, 300, 80, 24, 320);
    HGDrawActor(dc, &actor, YELLOW);
    GrText(dc, 16, 16, "MOVE AND SLIDE");
    Sleep(4);
  }

  DCDel(dc);
}

Main;
