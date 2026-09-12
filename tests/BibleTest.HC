#include "HolyBible.HC"
#include <stdio.h>
#include <stdlib.h>

U0 Require(Bool condition, const char *message)
{
  if (!condition) {
    fprintf(stderr, "bible test failed: %s\n", message);
    exit(1);
  }
}

U0 Main()
{
  const HBEntity *moses = HBFindEntity("moses");
  const HBEntity *jesus = HBFindEntity("jesus");
  const HBEntity *gabriel = HBFindEntity("gabriel");
  const HBEntity *michael = HBFindEntity("michael");
  const HBVerse *verse = HBFindVerse("JHN", 3, 16);
  I64 first;
  I64 second;

  Require(HBEntityCount() >= 70, "curated entity roster is incomplete");
  Require(HBVerseCount() >= 20, "curated verse set is incomplete");
  Require(moses && moses->testament == HB_OLD_TESTAMENT,
          "Moses lookup failed");
  Require(jesus && jesus->kind == HB_KIND_DIVINE,
          "Jesus lookup failed");
  Require(HBIsAngelic(gabriel), "Gabriel must be classified as angelic");
  Require(HBIsAngelic(michael), "Michael must be classified as angelic");
  Require(!HBFindEntity("raphael"),
          "non-canonical angel must not appear in selected canon");
  Require(verse && strstr(verse->text, "God so loved the world"),
          "John 3:16 lookup failed");
  Require(!HBFindVerse("TOB", 1, 1),
          "deuterocanonical verse must not appear in selected canon");

  for (first = 0; first < HBEntityCount(); first++)
    for (second = first + 1; second < HBEntityCount(); second++)
      Require(strcmp(HBEntityAt(first)->id, HBEntityAt(second)->id) != 0,
              "entity IDs must be unique");

  printf("HolyBible content tests passed: %lld entities, %lld verses\n",
         (long long)HBEntityCount(), (long long)HBVerseCount());
}

Main;
