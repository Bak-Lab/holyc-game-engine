#ifndef HOLY_BIBLE_HC
#define HOLY_BIBLE_HC

#include <string.h>

#define HB_OLD_TESTAMENT 0
#define HB_NEW_TESTAMENT 1
#define HB_KIND_DIVINE 0
#define HB_KIND_PERSON 1
#define HB_KIND_ANGEL 2
#define HB_KIND_ANGELIC_ORDER 3
#define HB_KIND_SPIRITUAL_ADVERSARY 4

typedef struct {
  const char *id;
  const char *name;
  const char *role;
  const char *first_book;
  I64 first_chapter;
  I64 first_verse;
  I64 testament;
  I64 kind;
} HBEntity;

typedef struct {
  const char *book;
  I64 chapter;
  I64 verse;
  const char *theme;
  const char *text;
} HBVerse;

static const HBEntity hb_entities[] = {
    {"god", "God", "Creator and Lord", "GEN", 1, 1,
     HB_OLD_TESTAMENT, HB_KIND_DIVINE},
    {"jesus", "Jesus Christ", "Messiah and Son of God", "MAT", 1, 1,
     HB_NEW_TESTAMENT, HB_KIND_DIVINE},
    {"holy_spirit", "Holy Spirit", "Spirit of God", "GEN", 1, 2,
     HB_OLD_TESTAMENT, HB_KIND_DIVINE},
    {"adam", "Adam", "First man", "GEN", 2, 7,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"eve", "Eve", "First woman", "GEN", 3, 20,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"cain", "Cain", "Son of Adam and Eve", "GEN", 4, 1,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"abel", "Abel", "Shepherd and son of Adam and Eve", "GEN", 4, 2,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"noah", "Noah", "Builder of the ark", "GEN", 5, 29,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"abraham", "Abraham", "Patriarch of Israel", "GEN", 11, 26,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"sarah", "Sarah", "Matriarch and wife of Abraham", "GEN", 11, 29,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"lot", "Lot", "Nephew of Abraham", "GEN", 11, 27,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"hagar", "Hagar", "Mother of Ishmael", "GEN", 16, 1,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"ishmael", "Ishmael", "Son of Abraham and Hagar", "GEN", 16, 15,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"isaac", "Isaac", "Son of Abraham and Sarah", "GEN", 17, 19,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"rebekah", "Rebekah", "Wife of Isaac", "GEN", 22, 23,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"esau", "Esau", "Son of Isaac and Rebekah", "GEN", 25, 25,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"jacob", "Jacob", "Patriarch also named Israel", "GEN", 25, 26,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"joseph", "Joseph", "Son of Jacob and governor in Egypt", "GEN", 30, 24,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"moses", "Moses", "Prophet and leader of the Exodus", "EXO", 2, 10,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"aaron", "Aaron", "First high priest of Israel", "EXO", 4, 14,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"miriam", "Miriam", "Prophetess and sister of Moses", "EXO", 2, 4,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"joshua", "Joshua", "Successor to Moses", "EXO", 17, 9,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"caleb", "Caleb", "Faithful scout of Canaan", "NUM", 13, 6,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"rahab", "Rahab", "Protector of Israelite spies", "JOS", 2, 1,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"deborah", "Deborah", "Judge and prophetess", "JDG", 4, 4,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"gideon", "Gideon", "Judge who opposed Midian", "JDG", 6, 11,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"samson", "Samson", "Judge known for great strength", "JDG", 13, 24,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"ruth", "Ruth", "Moabite ancestor of David", "RUT", 1, 4,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"naomi", "Naomi", "Mother-in-law of Ruth", "RUT", 1, 2,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"boaz", "Boaz", "Kinsman-redeemer of Ruth", "RUT", 2, 1,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"hannah", "Hannah", "Mother of Samuel", "1SA", 1, 2,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"samuel", "Samuel", "Prophet and judge", "1SA", 1, 20,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"saul", "Saul", "First king of Israel", "1SA", 9, 2,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"david", "David", "King of Israel and psalmist", "1SA", 16, 13,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"jonathan", "Jonathan", "Son of Saul and friend of David", "1SA", 13, 2,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"bathsheba", "Bathsheba", "Mother of Solomon", "2SA", 11, 3,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"solomon", "Solomon", "King known for wisdom", "2SA", 12, 24,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"queen_sheba", "Queen of Sheba", "Royal visitor of Solomon", "1KI", 10, 1,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"elijah", "Elijah", "Prophet who opposed Baal worship", "1KI", 17, 1,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"elisha", "Elisha", "Prophet and successor to Elijah", "1KI", 19, 16,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"isaiah", "Isaiah", "Prophet to Judah", "2KI", 19, 2,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"jeremiah", "Jeremiah", "Prophet before and during exile", "JER", 1, 1,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"ezekiel", "Ezekiel", "Prophet among the exiles", "EZK", 1, 3,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"daniel", "Daniel", "Exile, interpreter, and prophet", "DAN", 1, 6,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"shadrach", "Shadrach", "Faithful exile in Babylon", "DAN", 1, 7,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"meshach", "Meshach", "Faithful exile in Babylon", "DAN", 1, 7,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"abednego", "Abednego", "Faithful exile in Babylon", "DAN", 1, 7,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"esther", "Esther", "Queen who protected her people", "EST", 2, 7,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"mordecai", "Mordecai", "Guardian and adviser of Esther", "EST", 2, 5,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"job", "Job", "Faithful sufferer", "JOB", 1, 1,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"jonah", "Jonah", "Prophet sent to Nineveh", "JON", 1, 1,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"ezra", "Ezra", "Priest and teacher of the law", "EZR", 7, 1,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"nehemiah", "Nehemiah", "Rebuilder of Jerusalem's wall", "NEH", 1, 1,
     HB_OLD_TESTAMENT, HB_KIND_PERSON},
    {"zechariah", "Zechariah", "Priest and father of John", "LUK", 1, 5,
     HB_NEW_TESTAMENT, HB_KIND_PERSON},
    {"elizabeth", "Elizabeth", "Mother of John the Baptist", "LUK", 1, 5,
     HB_NEW_TESTAMENT, HB_KIND_PERSON},
    {"mary", "Mary", "Mother of Jesus", "MAT", 1, 16,
     HB_NEW_TESTAMENT, HB_KIND_PERSON},
    {"joseph_nazareth", "Joseph of Nazareth", "Husband of Mary", "MAT", 1, 16,
     HB_NEW_TESTAMENT, HB_KIND_PERSON},
    {"john_baptist", "John the Baptist", "Prophet who prepared the way", "MAT", 3, 1,
     HB_NEW_TESTAMENT, HB_KIND_PERSON},
    {"peter", "Peter", "Apostle of Jesus", "MAT", 4, 18,
     HB_NEW_TESTAMENT, HB_KIND_PERSON},
    {"andrew", "Andrew", "Apostle and brother of Peter", "MAT", 4, 18,
     HB_NEW_TESTAMENT, HB_KIND_PERSON},
    {"james_zebedee", "James son of Zebedee", "Apostle of Jesus", "MAT", 4, 21,
     HB_NEW_TESTAMENT, HB_KIND_PERSON},
    {"john_zebedee", "John son of Zebedee", "Apostle of Jesus", "MAT", 4, 21,
     HB_NEW_TESTAMENT, HB_KIND_PERSON},
    {"matthew", "Matthew", "Apostle and former tax collector", "MAT", 9, 9,
     HB_NEW_TESTAMENT, HB_KIND_PERSON},
    {"mary_magdalene", "Mary Magdalene", "Disciple and resurrection witness", "MAT", 27, 56,
     HB_NEW_TESTAMENT, HB_KIND_PERSON},
    {"martha", "Martha", "Disciple from Bethany", "LUK", 10, 38,
     HB_NEW_TESTAMENT, HB_KIND_PERSON},
    {"lazarus", "Lazarus", "Brother of Martha and Mary", "JHN", 11, 1,
     HB_NEW_TESTAMENT, HB_KIND_PERSON},
    {"stephen", "Stephen", "Witness and first Christian martyr", "ACT", 6, 5,
     HB_NEW_TESTAMENT, HB_KIND_PERSON},
    {"philip_evangelist", "Philip the Evangelist", "Evangelist and servant", "ACT", 6, 5,
     HB_NEW_TESTAMENT, HB_KIND_PERSON},
    {"paul", "Paul", "Apostle to the Gentiles", "ACT", 7, 58,
     HB_NEW_TESTAMENT, HB_KIND_PERSON},
    {"barnabas", "Barnabas", "Missionary and encourager", "ACT", 4, 36,
     HB_NEW_TESTAMENT, HB_KIND_PERSON},
    {"silas", "Silas", "Missionary companion of Paul", "ACT", 15, 22,
     HB_NEW_TESTAMENT, HB_KIND_PERSON},
    {"timothy", "Timothy", "Coworker and protege of Paul", "ACT", 16, 1,
     HB_NEW_TESTAMENT, HB_KIND_PERSON},
    {"priscilla", "Priscilla", "Teacher and coworker", "ACT", 18, 2,
     HB_NEW_TESTAMENT, HB_KIND_PERSON},
    {"aquila", "Aquila", "Teacher and coworker", "ACT", 18, 2,
     HB_NEW_TESTAMENT, HB_KIND_PERSON},
    {"lydia", "Lydia", "Believer and host in Philippi", "ACT", 16, 14,
     HB_NEW_TESTAMENT, HB_KIND_PERSON},
    {"gabriel", "Gabriel", "Angel and divine messenger", "DAN", 8, 16,
     HB_OLD_TESTAMENT, HB_KIND_ANGEL},
    {"michael", "Michael", "Archangel and heavenly prince", "DAN", 10, 13,
     HB_OLD_TESTAMENT, HB_KIND_ANGEL},
    {"angel_of_yahweh", "Angel of Yahweh", "Scriptural messenger title", "GEN", 16, 7,
     HB_OLD_TESTAMENT, HB_KIND_ANGEL},
    {"cherubim", "Cherubim", "Guardians and throne attendants", "GEN", 3, 24,
     HB_OLD_TESTAMENT, HB_KIND_ANGELIC_ORDER},
    {"seraphim", "Seraphim", "Heavenly beings in Isaiah's vision", "ISA", 6, 2,
     HB_OLD_TESTAMENT, HB_KIND_ANGELIC_ORDER},
    {"heavenly_host", "Heavenly Host", "Company praising God", "LUK", 2, 13,
     HB_NEW_TESTAMENT, HB_KIND_ANGELIC_ORDER},
    {"abaddon", "Abaddon (Apollyon)", "Angel of the abyss", "REV", 9, 11,
     HB_NEW_TESTAMENT, HB_KIND_ANGEL},
    {"satan", "Satan", "Spiritual adversary", "1CH", 21, 1,
     HB_OLD_TESTAMENT, HB_KIND_SPIRITUAL_ADVERSARY},
};

static const HBVerse hb_verses[] = {
    {"GEN", 1, 1, "creation",
     "In the beginning, God created the heavens and the earth."},
    {"GEN", 12, 2, "calling",
     "I will make of you a great nation. I will bless you and make your name great. You will be a blessing."},
    {"EXO", 3, 14, "name",
     "God said to Moses, “I AM WHO I AM,” and he said, “You shall tell the children of Israel this: ‘I AM has sent me to you.’ ”"},
    {"EXO", 5, 1, "freedom",
     "Afterward Moses and Aaron came, and said to Pharaoh, “This is what the LORD, the God of Israel, says, ‘Let my people go, that they may hold a feast to me in the wilderness.’ ”"},
    {"EXO", 14, 13, "deliverance",
     "Moses said to the people, “Don’t be afraid. Stand still, and see the salvation of the LORD, which he will work for you today; for you will never again see the Egyptians whom you have seen today."},
    {"DEU", 6, 5, "love",
     "You shall love the LORD your God with all your heart, with all your soul, and with all your might."},
    {"JOS", 1, 9, "courage",
     "Haven’t I commanded you? Be strong and courageous. Don’t be afraid. Don’t be dismayed, for the LORD your God is with you wherever you go.”"},
    {"RUT", 1, 16, "loyalty",
     "Ruth said, “Don’t urge me to leave you, and to return from following you, for where you go, I will go; and where you stay, I will stay. Your people will be my people, and your God my God."},
    {"1SA", 16, 7, "character",
     "But the LORD said to Samuel, “Don’t look on his face, or on the height of his stature, because I have rejected him; for I don’t see as man sees. For man looks at the outward appearance, but the LORD looks at the heart.”"},
    {"PSA", 23, 4, "comfort",
     "Even though I walk through the valley of the shadow of death, I will fear no evil, for you are with me. Your rod and your staff, they comfort me."},
    {"PRO", 3, 5, "trust",
     "Trust in the LORD with all your heart, and don’t lean on your own understanding."},
    {"ISA", 40, 31, "strength",
     "but those who wait for the LORD will renew their strength. They will mount up with wings like eagles. They will run, and not be weary. They will walk, and not faint."},
    {"MIC", 6, 8, "justice",
     "He has shown you, O man, what is good. What does the LORD require of you, but to act justly, to love mercy, and to walk humbly with your God?"},
    {"MAT", 5, 9, "peace",
     "Blessed are the peacemakers, for they shall be called children of God."},
    {"MAT", 22, 39, "neighbor",
     "A second likewise is this, ‘You shall love your neighbor as yourself.’"},
    {"LUK", 1, 30, "angel",
     "The angel said to her, “Don’t be afraid, Mary, for you have found favor with God."},
    {"JHN", 3, 16, "salvation",
     "For God so loved the world, that he gave his only born Son, that whoever believes in him should not perish, but have eternal life."},
    {"JHN", 8, 12, "light",
     "Again, therefore, Jesus spoke to them, saying, “I am the light of the world. He who follows me will not walk in the darkness, but will have the light of life.”"},
    {"ROM", 8, 28, "purpose",
     "We know that all things work together for good for those who love God, for those who are called according to his purpose."},
    {"1CO", 13, 13, "love",
     "But now faith, hope, and love remain—these three. The greatest of these is love."},
    {"PHP", 4, 13, "strength",
     "I can do all things through Christ who strengthens me."},
    {"HEB", 11, 1, "faith",
     "Now faith is assurance of things hoped for, proof of things not seen."},
    {"REV", 21, 4, "hope",
     "He will wipe away every tear from their eyes. Death will be no more; neither will there be mourning, nor crying, nor pain any more. The first things have passed away.”"},
};

I64 HBEntityCount()
{
  return sizeof(hb_entities) / sizeof(hb_entities[0]);
}

I64 HBVerseCount()
{
  return sizeof(hb_verses) / sizeof(hb_verses[0]);
}

const HBEntity *HBEntityAt(I64 index)
{
  if (index < 0 || index >= HBEntityCount())
    return NULL;
  return &hb_entities[index];
}

const HBVerse *HBVerseAt(I64 index)
{
  if (index < 0 || index >= HBVerseCount())
    return NULL;
  return &hb_verses[index];
}

const HBEntity *HBFindEntity(const char *id)
{
  I64 index;

  if (!id)
    return NULL;
  for (index = 0; index < HBEntityCount(); index++)
    if (strcmp(hb_entities[index].id, id) == 0)
      return &hb_entities[index];
  return NULL;
}

const HBVerse *HBFindVerse(const char *book, I64 chapter, I64 verse)
{
  I64 index;

  if (!book)
    return NULL;
  for (index = 0; index < HBVerseCount(); index++)
    if (hb_verses[index].chapter == chapter &&
        hb_verses[index].verse == verse &&
        strcmp(hb_verses[index].book, book) == 0)
      return &hb_verses[index];
  return NULL;
}

Bool HBIsAngelic(const HBEntity *entity)
{
  return entity &&
         (entity->kind == HB_KIND_ANGEL ||
          entity->kind == HB_KIND_ANGELIC_ORDER);
}

const char *HBVerseSource()
{
  return "World English Bible, 2020 stable text edition";
}

#endif
