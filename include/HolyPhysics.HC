#ifndef HOLY_PHYSICS_HC
#define HOLY_PHYSICS_HC

#include <math.h>

#define HG_PHYSICS_MAX_BODIES 16
#define HG_PHYSICS_MAX_COLLIDERS 64

#define HG_MATERIAL_WOOD 1
#define HG_MATERIAL_STONE 2
#define HG_MATERIAL_METAL 3
#define HG_MATERIAL_TARGET 4

typedef struct {
  F64 x;
  F64 y;
  F64 velocity_x;
  F64 velocity_y;
  F64 radius;
  F64 mass;
  F64 restitution;
  F64 friction;
  F64 last_impact;
  I64 tag;
  Bool active;
} HGPhysicsBody;

typedef struct {
  F64 x;
  F64 y;
  F64 width;
  F64 height;
  F64 durability;
  F64 last_impact;
  I64 material;
  I64 tag;
  Bool active;
} HGPhysicsCollider;

typedef struct {
  HGPhysicsBody bodies[HG_PHYSICS_MAX_BODIES];
  HGPhysicsCollider colliders[HG_PHYSICS_MAX_COLLIDERS];
  I64 body_count;
  I64 collider_count;
  F64 gravity;
  F64 left;
  F64 right;
  F64 ground;
} HGPhysicsWorld;

F64 HGClampF64(F64 value, F64 minimum, F64 maximum)
{
  if (value < minimum)
    return minimum;
  if (value > maximum)
    return maximum;
  return value;
}

U0 HGPhysicsWorldInit(HGPhysicsWorld *world, F64 left,
                      F64 right, F64 ground, F64 gravity)
{
  world->body_count = 0;
  world->collider_count = 0;
  world->gravity = gravity;
  world->left = left;
  world->right = right;
  world->ground = ground;
}

HGPhysicsCollider *HGPhysicsAddCollider(
    HGPhysicsWorld *world, F64 x, F64 y, F64 width, F64 height,
    F64 durability, I64 material, I64 tag)
{
  HGPhysicsCollider *collider;

  if (width <= 0 || height <= 0 ||
      world->collider_count >= HG_PHYSICS_MAX_COLLIDERS)
    return NULL;
  collider = &world->colliders[world->collider_count++];
  collider->x = x;
  collider->y = y;
  collider->width = width;
  collider->height = height;
  collider->durability = durability;
  collider->last_impact = 0;
  collider->material = material;
  collider->tag = tag;
  collider->active = TRUE;
  return collider;
}

HGPhysicsBody *HGPhysicsLaunch(
    HGPhysicsWorld *world, F64 x, F64 y, F64 velocity_x, F64 velocity_y,
    F64 radius, F64 mass, F64 restitution, F64 friction, I64 tag)
{
  HGPhysicsBody *body;

  if (radius <= 0 || mass <= 0 ||
      world->body_count >= HG_PHYSICS_MAX_BODIES)
    return NULL;
  body = &world->bodies[world->body_count++];
  body->x = x;
  body->y = y;
  body->velocity_x = velocity_x;
  body->velocity_y = velocity_y;
  body->radius = radius;
  body->mass = mass;
  body->restitution = HGClampF64(restitution, 0, 1);
  body->friction = HGClampF64(friction, 0, 1);
  body->last_impact = 0;
  body->tag = tag;
  body->active = TRUE;
  return body;
}

Bool HGPhysicsResolveCollider(HGPhysicsBody *body,
                              HGPhysicsCollider *collider)
{
  F64 nearest_x;
  F64 nearest_y;
  F64 difference_x;
  F64 difference_y;
  F64 distance_squared;
  F64 distance;
  F64 normal_x;
  F64 normal_y;
  F64 penetration;
  F64 velocity_normal;
  F64 edge;
  F64 candidate;

  if (!body->active || !collider->active)
    return FALSE;

  nearest_x = HGClampF64(body->x, collider->x,
                         collider->x + collider->width);
  nearest_y = HGClampF64(body->y, collider->y,
                         collider->y + collider->height);
  difference_x = body->x - nearest_x;
  difference_y = body->y - nearest_y;
  distance_squared =
      difference_x * difference_x + difference_y * difference_y;
  if (distance_squared >= body->radius * body->radius)
    return FALSE;

  if (distance_squared > 0.0001) {
    distance = sqrt(distance_squared);
    normal_x = difference_x / distance;
    normal_y = difference_y / distance;
    penetration = body->radius - distance;
  } else {
    normal_x = -1;
    normal_y = 0;
    edge = body->x - collider->x;
    candidate = collider->x + collider->width - body->x;
    if (candidate < edge) {
      edge = candidate;
      normal_x = 1;
    }
    candidate = body->y - collider->y;
    if (candidate < edge) {
      edge = candidate;
      normal_x = 0;
      normal_y = -1;
    }
    candidate = collider->y + collider->height - body->y;
    if (candidate < edge) {
      edge = candidate;
      normal_x = 0;
      normal_y = 1;
    }
    penetration = body->radius + edge;
  }

  body->x += normal_x * penetration;
  body->y += normal_y * penetration;
  velocity_normal =
      body->velocity_x * normal_x + body->velocity_y * normal_y;
  body->last_impact = 0;
  if (velocity_normal < 0) {
    body->last_impact = -velocity_normal * body->mass;
    body->velocity_x -=
        (1 + body->restitution) * velocity_normal * normal_x;
    body->velocity_y -=
        (1 + body->restitution) * velocity_normal * normal_y;
    collider->last_impact = body->last_impact;
    collider->durability -= body->last_impact;
    if (collider->durability <= 0)
      collider->active = FALSE;
  }
  return TRUE;
}

U0 HGPhysicsSubstep(HGPhysicsWorld *world, HGPhysicsBody *body,
                    F64 delta)
{
  I64 index;

  body->velocity_y += world->gravity * delta;
  body->x += body->velocity_x * delta;
  body->y += body->velocity_y * delta;
  body->last_impact = 0;

  if (body->x - body->radius < world->left) {
    body->x = world->left + body->radius;
    body->velocity_x = fabs(body->velocity_x) * body->restitution;
  } else if (body->x + body->radius > world->right) {
    body->x = world->right - body->radius;
    body->velocity_x = -fabs(body->velocity_x) * body->restitution;
  }

  if (body->y + body->radius > world->ground) {
    body->y = world->ground - body->radius;
    body->last_impact = fabs(body->velocity_y) * body->mass;
    body->velocity_y = -fabs(body->velocity_y) * body->restitution;
    body->velocity_x *= 1 - body->friction;
    if (fabs(body->velocity_y) < 0.35)
      body->velocity_y = 0;
    if (fabs(body->velocity_x) < 0.05)
      body->velocity_x = 0;
  }

  for (index = 0; index < world->collider_count; index++)
    HGPhysicsResolveCollider(body, &world->colliders[index]);
}

U0 HGPhysicsStep(HGPhysicsWorld *world, F64 delta)
{
  I64 body_index;
  I64 step;
  I64 steps;
  F64 speed;
  F64 step_delta;
  HGPhysicsBody *body;

  for (body_index = 0; body_index < world->body_count; body_index++) {
    body = &world->bodies[body_index];
    if (!body->active)
      continue;
    speed = fabs(body->velocity_x);
    if (fabs(body->velocity_y) > speed)
      speed = fabs(body->velocity_y);
    steps = (I64)(speed * delta / HGClampF64(body->radius, 1, 100)) + 1;
    steps = ClampI64(steps, 1, 24);
    step_delta = delta / steps;
    for (step = 0; step < steps; step++)
      HGPhysicsSubstep(world, body, step_delta);
  }
}

Bool HGPhysicsBodyMoving(HGPhysicsBody *body)
{
  return body && body->active &&
         (fabs(body->velocity_x) > 0.08 ||
          fabs(body->velocity_y) > 0.08);
}

#endif
