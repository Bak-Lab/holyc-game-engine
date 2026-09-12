#ifndef HOLY_GAME_HC
#define HOLY_GAME_HC

#define HG_MAX_WALLS 64
#define HG_HIT_NONE 0
#define HG_HIT_X 1
#define HG_HIT_Y 2

typedef struct {
  I64 x;
  I64 y;
} HGVec2;

typedef struct {
  I64 x;
  I64 y;
  I64 width;
  I64 height;
} HGRect;

typedef struct {
  I64 x;
  I64 y;
  I64 width;
  I64 height;
  Bool active;
} HGActor;

typedef struct {
  HGRect walls[HG_MAX_WALLS];
  I64 wall_count;
  HGRect bounds;
} HGWorld;

U0 HGActorInit(HGActor *actor, I64 x, I64 y, I64 width, I64 height)
{
  actor->x = x;
  actor->y = y;
  actor->width = width;
  actor->height = height;
  actor->active = TRUE;
}

HGRect HGActorBounds(HGActor *actor)
{
  HGRect bounds = {actor->x, actor->y, actor->width, actor->height};
  return bounds;
}

Bool HGRectOverlaps(HGRect *first, HGRect *second)
{
  return first->x < second->x + second->width &&
         first->x + first->width > second->x &&
         first->y < second->y + second->height &&
         first->y + first->height > second->y;
}

Bool HGActorsOverlap(HGActor *first, HGActor *second)
{
  HGRect first_bounds;
  HGRect second_bounds;

  if (!first->active || !second->active)
    return FALSE;
  first_bounds = HGActorBounds(first);
  second_bounds = HGActorBounds(second);
  return HGRectOverlaps(&first_bounds, &second_bounds);
}

U0 HGWorldInit(HGWorld *world, I64 x, I64 y, I64 width, I64 height)
{
  world->wall_count = 0;
  world->bounds.x = x;
  world->bounds.y = y;
  world->bounds.width = width;
  world->bounds.height = height;
}

Bool HGWorldAddWall(HGWorld *world, I64 x, I64 y,
                    I64 width, I64 height)
{
  HGRect *wall;

  if (width <= 0 || height <= 0 || world->wall_count >= HG_MAX_WALLS)
    return FALSE;
  wall = &world->walls[world->wall_count++];
  wall->x = x;
  wall->y = y;
  wall->width = width;
  wall->height = height;
  return TRUE;
}

Bool HGWorldCollides(HGWorld *world, HGActor *actor)
{
  HGRect actor_bounds;
  I64 index;

  if (actor->x < world->bounds.x ||
      actor->y < world->bounds.y ||
      actor->x + actor->width > world->bounds.x + world->bounds.width ||
      actor->y + actor->height > world->bounds.y + world->bounds.height)
    return TRUE;

  actor_bounds = HGActorBounds(actor);
  for (index = 0; index < world->wall_count; index++)
    if (HGRectOverlaps(&actor_bounds, &world->walls[index]))
      return TRUE;
  return FALSE;
}

Bool HGMoveAxis(HGActor *actor, I64 amount, Bool horizontal,
                HGWorld *world)
{
  I64 distance = amount < 0 ? -amount : amount;
  I64 step = SignI64(amount);
  I64 moved;

  for (moved = 0; moved < distance; moved++) {
    if (horizontal)
      actor->x += step;
    else
      actor->y += step;

    if (HGWorldCollides(world, actor)) {
      if (horizontal)
        actor->x -= step;
      else
        actor->y -= step;
      return FALSE;
    }
  }
  return TRUE;
}

I64 HGMoveAndSlide(HGActor *actor, I64 delta_x, I64 delta_y,
                   HGWorld *world)
{
  I64 result = HG_HIT_NONE;

  if (!HGMoveAxis(actor, delta_x, TRUE, world))
    result |= HG_HIT_X;
  if (!HGMoveAxis(actor, delta_y, FALSE, world))
    result |= HG_HIT_Y;
  return result;
}

I64 HGMoveToward(HGActor *actor, I64 target_x, I64 target_y,
                 I64 speed, HGWorld *world)
{
  I64 delta_x = ClampI64(target_x - actor->x, -speed, speed);
  I64 delta_y = ClampI64(target_y - actor->y, -speed, speed);
  return HGMoveAndSlide(actor, delta_x, delta_y, world);
}

U0 HGFollow(HGActor *actor, HGActor *target, I64 distance,
            I64 speed, HGWorld *world)
{
  I64 delta_x = target->x - actor->x;
  I64 delta_y = target->y - actor->y;

  if (delta_x * delta_x + delta_y * delta_y <= distance * distance)
    return;
  HGMoveToward(actor, target->x, target->y, speed, world);
}

U0 HGDrawActor(CDC *dc, HGActor *actor, I64 color)
{
  if (!actor->active)
    return;
  dc->color = color;
  GrRect(dc, actor->x, actor->y, actor->width, actor->height);
}

#endif
