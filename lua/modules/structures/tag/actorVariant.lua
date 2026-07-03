return { {
    address = "0x0",
    fields = { {
        address = "0x0",
        is = "int",
        name = "canShootWhileFlying",
        offset = 0,
        size = 4,
        type = "dword",
        unsigned = true,
        what = "bitfield"
      }, {
        address = "0x0",
        is = "int",
        name = "interpolateColorInHsv",
        offset = 1,
        size = 4,
        type = "dword",
        unsigned = true,
        what = "bitfield"
      }, {
        address = "0x0",
        is = "int",
        name = "hasUnlimitedGrenades",
        offset = 2,
        size = 4,
        type = "dword",
        unsigned = true,
        what = "bitfield"
      }, {
        address = "0x0",
        is = "int",
        name = "movementSwitchingTryToStayWithFriends",
        offset = 3,
        size = 4,
        type = "dword",
        unsigned = true,
        what = "bitfield"
      }, {
        address = "0x0",
        is = "int",
        name = "activeCamouflage",
        offset = 4,
        size = 4,
        type = "dword",
        unsigned = true,
        what = "bitfield"
      }, {
        address = "0x0",
        is = "int",
        name = "superActiveCamouflage",
        offset = 5,
        size = 4,
        type = "dword",
        unsigned = true,
        what = "bitfield"
      }, {
        address = "0x0",
        is = "int",
        name = "cannotUseRangedWeapons",
        offset = 6,
        size = 4,
        type = "dword",
        unsigned = true,
        what = "bitfield"
      }, {
        address = "0x0",
        is = "int",
        name = "preferPassengerSeat",
        offset = 7,
        size = 4,
        type = "dword",
        unsigned = true,
        what = "bitfield"
      } },
    is = "struct",
    metaName = "ActorVariantFlags",
    name = "flags",
    offset = 0,
    size = 4,
    type = "ActorVariantFlags",
    what = "field"
  }, {
    address = "0x4",
    fields = { {
        address = "0x0",
        is = "int",
        metaName = "TagGroup",
        name = "tagGroup",
        offset = 0,
        size = 4,
        type = "int",
        what = "field"
      }, {
        address = "0x4",
        count = 4,
        elementSize = 1,
        elementType = "char",
        is = "ptr",
        name = "path",
        offset = 4,
        size = 4,
        what = "field"
      }, {
        address = "0x8",
        is = "int",
        name = "pathSize",
        offset = 8,
        size = 4,
        type = "dword",
        unsigned = true,
        what = "field"
      }, {
        address = "0xc",
        fields = { {
            address = "0x0",
            is = "int",
            name = "value",
            offset = 0,
            size = 4,
            type = "dword",
            unsigned = true,
            what = "field"
          }, {
            address = "0x0",
            is = "int",
            name = "index",
            offset = 0,
            size = 2,
            type = "word",
            unsigned = true,
            what = "field"
          }, {
            address = "0x2",
            is = "int",
            name = "id",
            offset = 2,
            size = 2,
            type = "word",
            unsigned = true,
            what = "field"
          } },
        is = "union",
        metaName = "TableResourceHandle",
        name = "tagHandle",
        offset = 12,
        size = 4,
        type = "TableResourceHandle",
        what = "field"
      } },
    is = "struct",
    metaName = "TagReference",
    name = "actorDefinition",
    offset = 4,
    size = 16,
    type = "TagReference",
    what = "field"
  }, {
    address = "0x14",
    fields = { {
        address = "0x0",
        is = "int",
        metaName = "TagGroup",
        name = "tagGroup",
        offset = 0,
        size = 4,
        type = "int",
        what = "field"
      }, {
        address = "0x4",
        count = 4,
        elementSize = 1,
        elementType = "char",
        is = "ptr",
        name = "path",
        offset = 4,
        size = 4,
        what = "field"
      }, {
        address = "0x8",
        is = "int",
        name = "pathSize",
        offset = 8,
        size = 4,
        type = "dword",
        unsigned = true,
        what = "field"
      }, {
        address = "0xc",
        fields = { {
            address = "0x0",
            is = "int",
            name = "value",
            offset = 0,
            size = 4,
            type = "dword",
            unsigned = true,
            what = "field"
          }, {
            address = "0x0",
            is = "int",
            name = "index",
            offset = 0,
            size = 2,
            type = "word",
            unsigned = true,
            what = "field"
          }, {
            address = "0x2",
            is = "int",
            name = "id",
            offset = 2,
            size = 2,
            type = "word",
            unsigned = true,
            what = "field"
          } },
        is = "union",
        metaName = "TableResourceHandle",
        name = "tagHandle",
        offset = 12,
        size = 4,
        type = "TableResourceHandle",
        what = "field"
      } },
    is = "struct",
    metaName = "TagReference",
    name = "unit",
    offset = 20,
    size = 16,
    type = "TagReference",
    what = "field"
  }, {
    address = "0x24",
    fields = { {
        address = "0x0",
        is = "int",
        metaName = "TagGroup",
        name = "tagGroup",
        offset = 0,
        size = 4,
        type = "int",
        what = "field"
      }, {
        address = "0x4",
        count = 4,
        elementSize = 1,
        elementType = "char",
        is = "ptr",
        name = "path",
        offset = 4,
        size = 4,
        what = "field"
      }, {
        address = "0x8",
        is = "int",
        name = "pathSize",
        offset = 8,
        size = 4,
        type = "dword",
        unsigned = true,
        what = "field"
      }, {
        address = "0xc",
        fields = { {
            address = "0x0",
            is = "int",
            name = "value",
            offset = 0,
            size = 4,
            type = "dword",
            unsigned = true,
            what = "field"
          }, {
            address = "0x0",
            is = "int",
            name = "index",
            offset = 0,
            size = 2,
            type = "word",
            unsigned = true,
            what = "field"
          }, {
            address = "0x2",
            is = "int",
            name = "id",
            offset = 2,
            size = 2,
            type = "word",
            unsigned = true,
            what = "field"
          } },
        is = "union",
        metaName = "TableResourceHandle",
        name = "tagHandle",
        offset = 12,
        size = 4,
        type = "TableResourceHandle",
        what = "field"
      } },
    is = "struct",
    metaName = "TagReference",
    name = "majorVariant",
    offset = 36,
    size = 16,
    type = "TagReference",
    what = "field"
  }, {
    address = "0x34",
    fields = { {
        address = "0x0",
        is = "int",
        metaName = "MetagameType",
        name = "metagameType",
        offset = 0,
        size = 2,
        type = "short",
        what = "field"
      }, {
        address = "0x2",
        is = "int",
        metaName = "MetagameClass",
        name = "metagameClass",
        offset = 2,
        size = 2,
        type = "short",
        what = "field"
      } },
    is = "struct",
    metaName = "MetagameProperties",
    name = "metagameProperties",
    offset = 52,
    size = 4,
    type = "MetagameProperties",
    what = "field"
  }, {
    address = "0x38",
    count = 20,
    elementSize = 1,
    elementType = "char",
    is = "array",
    name = "pad6948",
    offset = 56,
    size = 20,
    what = "field"
  }, {
    address = "0x4c",
    fields = { {
        address = "0x0",
        is = "int",
        metaName = "ActorVariantMovementType",
        name = "movementType",
        offset = 0,
        size = 2,
        type = "short",
        what = "field"
      }, {
        address = "0x2",
        count = 2,
        elementSize = 1,
        elementType = "char",
        is = "array",
        name = "pad2743",
        offset = 2,
        size = 2,
        what = "field"
      }, {
        address = "0x4",
        is = "float",
        name = "initialCrouchChance",
        offset = 4,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x8",
        count = 2,
        elementSize = 4,
        elementType = "float",
        is = "array",
        name = "crouchTime",
        offset = 8,
        size = 8,
        what = "field"
      }, {
        address = "0x10",
        count = 2,
        elementSize = 4,
        elementType = "float",
        is = "array",
        name = "runTime",
        offset = 16,
        size = 8,
        what = "field"
      } },
    is = "struct",
    metaName = "ActorVariantMovementSwitching",
    name = "movementSwitching",
    offset = 76,
    size = 24,
    type = "ActorVariantMovementSwitching",
    what = "field"
  }, {
    address = "0x64",
    fields = { {
        address = "0x0",
        fields = { {
            address = "0x0",
            is = "int",
            metaName = "TagGroup",
            name = "tagGroup",
            offset = 0,
            size = 4,
            type = "int",
            what = "field"
          }, {
            address = "0x4",
            count = 4,
            elementSize = 1,
            elementType = "char",
            is = "ptr",
            name = "path",
            offset = 4,
            size = 4,
            what = "field"
          }, {
            address = "0x8",
            is = "int",
            name = "pathSize",
            offset = 8,
            size = 4,
            type = "dword",
            unsigned = true,
            what = "field"
          }, {
            address = "0xc",
            fields = { {
                address = "0x0",
                is = "int",
                name = "value",
                offset = 0,
                size = 4,
                type = "dword",
                unsigned = true,
                what = "field"
              }, {
                address = "0x0",
                is = "int",
                name = "index",
                offset = 0,
                size = 2,
                type = "word",
                unsigned = true,
                what = "field"
              }, {
                address = "0x2",
                is = "int",
                name = "id",
                offset = 2,
                size = 2,
                type = "word",
                unsigned = true,
                what = "field"
              } },
            is = "union",
            metaName = "TableResourceHandle",
            name = "tagHandle",
            offset = 12,
            size = 4,
            type = "TableResourceHandle",
            what = "field"
          } },
        is = "struct",
        metaName = "TagReference",
        name = "weapon",
        offset = 0,
        size = 16,
        type = "TagReference",
        what = "field"
      }, {
        address = "0x10",
        is = "float",
        name = "maximumFiringDistance",
        offset = 16,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x14",
        is = "float",
        name = "rateOfFire",
        offset = 20,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x18",
        is = "float",
        name = "projectileError",
        offset = 24,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x1c",
        count = 2,
        elementSize = 4,
        elementType = "float",
        is = "array",
        name = "firstBurstDelayTime",
        offset = 28,
        size = 8,
        what = "field"
      }, {
        address = "0x24",
        is = "float",
        name = "newTargetFiringPatternTime",
        offset = 36,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x28",
        is = "float",
        name = "surpriseDelayTime",
        offset = 40,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x2c",
        is = "float",
        name = "surpriseFireWildlyTime",
        offset = 44,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x30",
        is = "float",
        name = "deathFireWildlyChance",
        offset = 48,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x34",
        is = "float",
        name = "deathFireWildlyTime",
        offset = 52,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x38",
        count = 2,
        elementSize = 4,
        elementType = "float",
        is = "array",
        name = "desiredCombatRange",
        offset = 56,
        size = 8,
        what = "field"
      }, {
        address = "0x40",
        fields = { {
            address = "0x0",
            is = "float",
            name = "x",
            offset = 0,
            size = 4,
            type = "float",
            what = "field"
          }, {
            address = "0x4",
            is = "float",
            name = "y",
            offset = 4,
            size = 4,
            type = "float",
            what = "field"
          }, {
            address = "0x8",
            is = "float",
            name = "z",
            offset = 8,
            size = 4,
            type = "float",
            what = "field"
          } },
        is = "struct",
        metaName = "VectorXYZ",
        name = "customStandGunOffset",
        offset = 64,
        size = 12,
        type = "VectorXYZ",
        what = "field"
      }, {
        address = "0x4c",
        fields = { {
            address = "0x0",
            is = "float",
            name = "x",
            offset = 0,
            size = 4,
            type = "float",
            what = "field"
          }, {
            address = "0x4",
            is = "float",
            name = "y",
            offset = 4,
            size = 4,
            type = "float",
            what = "field"
          }, {
            address = "0x8",
            is = "float",
            name = "z",
            offset = 8,
            size = 4,
            type = "float",
            what = "field"
          } },
        is = "struct",
        metaName = "VectorXYZ",
        name = "customCrouchGunOffset",
        offset = 76,
        size = 12,
        type = "VectorXYZ",
        what = "field"
      }, {
        address = "0x58",
        is = "float",
        name = "targetTracking",
        offset = 88,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x5c",
        is = "float",
        name = "targetLeading",
        offset = 92,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x60",
        is = "float",
        name = "weaponDamageModifier",
        offset = 96,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x64",
        is = "float",
        name = "damagePerSecond",
        offset = 100,
        size = 4,
        type = "float",
        what = "field"
      } },
    is = "struct",
    metaName = "ActorVariantRangedCombat",
    name = "rangedCombat",
    offset = 100,
    size = 104,
    type = "ActorVariantRangedCombat",
    what = "field"
  }, {
    address = "0xcc",
    fields = { {
        address = "0x0",
        is = "float",
        name = "burstOriginRadius",
        offset = 0,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x4",
        is = "float",
        name = "burstOriginAngle",
        offset = 4,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x8",
        count = 2,
        elementSize = 4,
        elementType = "float",
        is = "array",
        name = "burstReturnLength",
        offset = 8,
        size = 8,
        what = "field"
      }, {
        address = "0x10",
        is = "float",
        name = "burstReturnAngle",
        offset = 16,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x14",
        count = 2,
        elementSize = 4,
        elementType = "float",
        is = "array",
        name = "burstDuration",
        offset = 20,
        size = 8,
        what = "field"
      }, {
        address = "0x1c",
        count = 2,
        elementSize = 4,
        elementType = "float",
        is = "array",
        name = "burstSeparation",
        offset = 28,
        size = 8,
        what = "field"
      }, {
        address = "0x24",
        is = "float",
        name = "burstAngularVelocity",
        offset = 36,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x28",
        count = 4,
        elementSize = 1,
        elementType = "char",
        is = "array",
        name = "pad3893",
        offset = 40,
        size = 4,
        what = "field"
      }, {
        address = "0x2c",
        is = "float",
        name = "specialDamageModifier",
        offset = 44,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x30",
        is = "float",
        name = "specialProjectileError",
        offset = 48,
        size = 4,
        type = "float",
        what = "field"
      } },
    is = "struct",
    metaName = "ActorVariantBurstGeometry",
    name = "burstGeometry",
    offset = 204,
    size = 52,
    type = "ActorVariantBurstGeometry",
    what = "field"
  }, {
    address = "0x100",
    fields = { {
        address = "0x0",
        is = "float",
        name = "newTargetBurstDuration",
        offset = 0,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x4",
        is = "float",
        name = "newTargetBurstSeparation",
        offset = 4,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x8",
        is = "float",
        name = "newTargetRateOfFire",
        offset = 8,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0xc",
        is = "float",
        name = "newTargetProjectileError",
        offset = 12,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x10",
        count = 8,
        elementSize = 1,
        elementType = "char",
        is = "array",
        name = "pad4268",
        offset = 16,
        size = 8,
        what = "field"
      }, {
        address = "0x18",
        is = "float",
        name = "movingBurstDuration",
        offset = 24,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x1c",
        is = "float",
        name = "movingBurstSeparation",
        offset = 28,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x20",
        is = "float",
        name = "movingRateOfFire",
        offset = 32,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x24",
        is = "float",
        name = "movingProjectileError",
        offset = 36,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x28",
        count = 8,
        elementSize = 1,
        elementType = "char",
        is = "array",
        name = "pad4424",
        offset = 40,
        size = 8,
        what = "field"
      }, {
        address = "0x30",
        is = "float",
        name = "berserkBurstDuration",
        offset = 48,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x34",
        is = "float",
        name = "berserkBurstSeparation",
        offset = 52,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x38",
        is = "float",
        name = "berserkRateOfFire",
        offset = 56,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x3c",
        is = "float",
        name = "berserkProjectileError",
        offset = 60,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x40",
        count = 8,
        elementSize = 1,
        elementType = "char",
        is = "array",
        name = "pad4584",
        offset = 64,
        size = 8,
        what = "field"
      } },
    is = "struct",
    metaName = "ActorVariantFiringPatterns",
    name = "firingPatterns",
    offset = 256,
    size = 72,
    type = "ActorVariantFiringPatterns",
    what = "field"
  }, {
    address = "0x148",
    fields = { {
        address = "0x0",
        is = "float",
        name = "superBallisticRange",
        offset = 0,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x4",
        is = "float",
        name = "bombardmentRange",
        offset = 4,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x8",
        is = "float",
        name = "modifiedVisionRange",
        offset = 8,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0xc",
        is = "int",
        metaName = "ActorVariantSpecialFireMode",
        name = "specialFireMode",
        offset = 12,
        size = 2,
        type = "short",
        what = "field"
      }, {
        address = "0xe",
        is = "int",
        metaName = "ActorVariantSpecialFireSituation",
        name = "specialFireSituation",
        offset = 14,
        size = 2,
        type = "short",
        what = "field"
      }, {
        address = "0x10",
        is = "float",
        name = "specialFireChance",
        offset = 16,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x14",
        is = "float",
        name = "specialFireDelay",
        offset = 20,
        size = 4,
        type = "float",
        what = "field"
      } },
    is = "struct",
    metaName = "ActorVariantSpecialCaseFiringProperties",
    name = "specialCaseFiringProperties",
    offset = 328,
    size = 24,
    type = "ActorVariantSpecialCaseFiringProperties",
    what = "field"
  }, {
    address = "0x160",
    fields = { {
        address = "0x0",
        is = "float",
        name = "meleeRange",
        offset = 0,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x4",
        is = "float",
        name = "meleeAbortRange",
        offset = 4,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x8",
        count = 2,
        elementSize = 4,
        elementType = "float",
        is = "array",
        name = "berserkFiringRanges",
        offset = 8,
        size = 8,
        what = "field"
      }, {
        address = "0x10",
        is = "float",
        name = "berserkMeleeRange",
        offset = 16,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x14",
        is = "float",
        name = "berserkMeleeAbortRange",
        offset = 20,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x18",
        count = 8,
        elementSize = 1,
        elementType = "char",
        is = "array",
        name = "pad5341",
        offset = 24,
        size = 8,
        what = "field"
      } },
    is = "struct",
    metaName = "ActorVariantBerserkingAndMelee",
    name = "berserkingAndMelee",
    offset = 352,
    size = 32,
    type = "ActorVariantBerserkingAndMelee",
    what = "field"
  }, {
    address = "0x180",
    fields = { {
        address = "0x0",
        is = "int",
        metaName = "GrenadeType",
        name = "grenadeType",
        offset = 0,
        size = 2,
        type = "short",
        what = "field"
      }, {
        address = "0x2",
        is = "int",
        metaName = "ActorVariantTrajectoryType",
        name = "trajectoryType",
        offset = 2,
        size = 2,
        type = "short",
        what = "field"
      }, {
        address = "0x4",
        is = "int",
        metaName = "ActorVariantGrenadeStimulus",
        name = "grenadeStimulus",
        offset = 4,
        size = 2,
        type = "short",
        what = "field"
      }, {
        address = "0x6",
        is = "int",
        name = "minimumEnemyCount",
        offset = 6,
        size = 2,
        type = "short",
        what = "field"
      }, {
        address = "0x8",
        is = "float",
        name = "enemyRadius",
        offset = 8,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0xc",
        count = 4,
        elementSize = 1,
        elementType = "char",
        is = "array",
        name = "pad5684",
        offset = 12,
        size = 4,
        what = "field"
      }, {
        address = "0x10",
        is = "float",
        name = "grenadeVelocity",
        offset = 16,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x14",
        count = 2,
        elementSize = 4,
        elementType = "float",
        is = "array",
        name = "grenadeRanges",
        offset = 20,
        size = 8,
        what = "field"
      }, {
        address = "0x1c",
        is = "float",
        name = "collateralDamageRadius",
        offset = 28,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x20",
        is = "float",
        name = "grenadeChance",
        offset = 32,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x24",
        is = "float",
        name = "grenadeCheckTime",
        offset = 36,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x28",
        is = "float",
        name = "encounterGrenadeTimeout",
        offset = 40,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x2c",
        count = 20,
        elementSize = 1,
        elementType = "char",
        is = "array",
        name = "pad5892",
        offset = 44,
        size = 20,
        what = "field"
      } },
    is = "struct",
    metaName = "ActorVariantGrenades",
    name = "grenades",
    offset = 384,
    size = 64,
    type = "ActorVariantGrenades",
    what = "field"
  }, {
    address = "0x1c0",
    fields = { {
        address = "0x0",
        fields = { {
            address = "0x0",
            is = "int",
            metaName = "TagGroup",
            name = "tagGroup",
            offset = 0,
            size = 4,
            type = "int",
            what = "field"
          }, {
            address = "0x4",
            count = 4,
            elementSize = 1,
            elementType = "char",
            is = "ptr",
            name = "path",
            offset = 4,
            size = 4,
            what = "field"
          }, {
            address = "0x8",
            is = "int",
            name = "pathSize",
            offset = 8,
            size = 4,
            type = "dword",
            unsigned = true,
            what = "field"
          }, {
            address = "0xc",
            fields = { {
                address = "0x0",
                is = "int",
                name = "value",
                offset = 0,
                size = 4,
                type = "dword",
                unsigned = true,
                what = "field"
              }, {
                address = "0x0",
                is = "int",
                name = "index",
                offset = 0,
                size = 2,
                type = "word",
                unsigned = true,
                what = "field"
              }, {
                address = "0x2",
                is = "int",
                name = "id",
                offset = 2,
                size = 2,
                type = "word",
                unsigned = true,
                what = "field"
              } },
            is = "union",
            metaName = "TableResourceHandle",
            name = "tagHandle",
            offset = 12,
            size = 4,
            type = "TableResourceHandle",
            what = "field"
          } },
        is = "struct",
        metaName = "TagReference",
        name = "equipment",
        offset = 0,
        size = 16,
        type = "TagReference",
        what = "field"
      }, {
        address = "0x10",
        count = 2,
        elementSize = 2,
        elementType = "short",
        is = "array",
        name = "grenadeCount",
        offset = 16,
        size = 4,
        what = "field"
      }, {
        address = "0x14",
        is = "float",
        name = "dontDropGrenadesChance",
        offset = 20,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x18",
        count = 2,
        elementSize = 4,
        elementType = "float",
        is = "array",
        name = "dropWeaponLoaded",
        offset = 24,
        size = 8,
        what = "field"
      }, {
        address = "0x20",
        count = 2,
        elementSize = 2,
        elementType = "short",
        is = "array",
        name = "dropWeaponAmmo",
        offset = 32,
        size = 4,
        what = "field"
      }, {
        address = "0x24",
        count = 12,
        elementSize = 1,
        elementType = "char",
        is = "array",
        name = "pad6189",
        offset = 36,
        size = 12,
        what = "field"
      }, {
        address = "0x30",
        count = 16,
        elementSize = 1,
        elementType = "char",
        is = "array",
        name = "pad6212",
        offset = 48,
        size = 16,
        what = "field"
      } },
    is = "struct",
    metaName = "ActorVariantItems",
    name = "items",
    offset = 448,
    size = 64,
    type = "ActorVariantItems",
    what = "field"
  }, {
    address = "0x200",
    fields = { {
        address = "0x0",
        is = "float",
        name = "bodyVitality",
        offset = 0,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x4",
        is = "float",
        name = "shieldVitality",
        offset = 4,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x8",
        is = "float",
        name = "shieldSappingRadius",
        offset = 8,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0xc",
        is = "int",
        name = "forcedShaderPermutation",
        offset = 12,
        size = 2,
        type = "word",
        unsigned = true,
        what = "field"
      }, {
        address = "0xe",
        count = 2,
        elementSize = 1,
        elementType = "char",
        is = "array",
        name = "pad6476",
        offset = 14,
        size = 2,
        what = "field"
      }, {
        address = "0x10",
        count = 16,
        elementSize = 1,
        elementType = "char",
        is = "array",
        name = "pad6498",
        offset = 16,
        size = 16,
        what = "field"
      }, {
        address = "0x20",
        count = 12,
        elementSize = 1,
        elementType = "char",
        is = "array",
        name = "pad6521",
        offset = 32,
        size = 12,
        what = "field"
      }, {
        address = "0x2c",
        fields = { {
            address = "0x0",
            is = "int",
            name = "count",
            offset = 0,
            size = 4,
            type = "dword",
            unsigned = true,
            what = "field"
          }, {
            address = "0x4",
            count = 0,
            elementSize = 32,
            fields = { {
                address = "0x0",
                count = 2,
                elementSize = 12,
                fields = { {
                    address = "0x0",
                    is = "float",
                    name = "r",
                    offset = 0,
                    size = 4,
                    type = "float",
                    what = "field"
                  }, {
                    address = "0x4",
                    is = "float",
                    name = "g",
                    offset = 4,
                    size = 4,
                    type = "float",
                    what = "field"
                  }, {
                    address = "0x8",
                    is = "float",
                    name = "b",
                    offset = 8,
                    size = 4,
                    type = "float",
                    what = "field"
                  } },
                is = "array",
                name = "color",
                offset = 0,
                size = 24,
                what = "field"
              }, {
                address = "0x18",
                count = 8,
                elementSize = 1,
                elementType = "char",
                is = "array",
                name = "pad2544",
                offset = 24,
                size = 8,
                what = "field"
              } },
            is = "ptr",
            name = "elements",
            offset = 4,
            size = 4,
            what = "field"
          }, {
            address = "0x8",
            count = 0,
            elementSize = 20,
            fields = { {
                address = "0x0",
                count = 4,
                elementSize = 1,
                elementType = "char",
                is = "ptr",
                name = "name",
                offset = 0,
                size = 4,
                what = "field"
              }, {
                address = "0x4",
                is = "int",
                name = "maximum",
                offset = 4,
                size = 4,
                type = "int",
                what = "field"
              }, {
                address = "0x8",
                count = 4,
                elementSize = 1,
                elementType = "char",
                is = "array",
                name = "padding",
                offset = 8,
                size = 4,
                what = "field"
              }, {
                address = "0xc",
                is = "int",
                name = "elementsSize",
                offset = 12,
                size = 4,
                type = "int",
                what = "field"
              }, {
                address = "0x10",
                count = 0,
                elementSize = "none",
                elementType = "void",
                is = "ptr",
                name = "fields",
                offset = 16,
                size = 4,
                what = "field"
              } },
            is = "ptr",
            name = "definition",
            offset = 8,
            size = 4,
            what = "field"
          } },
        is = "struct",
        name = "changeColors",
        offset = 44,
        size = 12,
        what = "field"
      } },
    is = "struct",
    metaName = "ActorVariantUnitProperties",
    name = "unitProperties",
    offset = 512,
    size = 56,
    type = "ActorVariantUnitProperties",
    what = "field"
  } }
