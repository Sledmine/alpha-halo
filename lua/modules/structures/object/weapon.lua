return { {
    address = "0x0",
    fields = { {
        address = "0x0",
        fields = { {
            address = "0x0",
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
            offset = 0,
            size = 4,
            type = "TableResourceHandle",
            what = "field"
          }, {
            address = "0x4",
            is = "int",
            name = "networkRole",
            offset = 4,
            size = 4,
            type = "dword",
            unsigned = true,
            what = "field"
          }, {
            address = "0x8",
            is = "int",
            name = "flags0",
            offset = 8,
            size = 4,
            type = "dword",
            unsigned = true,
            what = "field"
          }, {
            address = "0xc",
            is = "int",
            name = "existenceTime",
            offset = 12,
            size = 4,
            type = "dword",
            unsigned = true,
            what = "field"
          }, {
            address = "0x10",
            fields = { {
                address = "0x0",
                is = "int",
                name = "noCollision",
                offset = 0,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "bitfield"
              }, {
                address = "0x0",
                is = "int",
                name = "onGround",
                offset = 1,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "bitfield"
              }, {
                address = "0x0",
                is = "int",
                name = "ignoreGravity",
                offset = 2,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "bitfield"
              }, {
                address = "0x0",
                is = "int",
                name = "inWater",
                offset = 3,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "bitfield"
              }, {
                address = "0x0",
                is = "int",
                name = "pad1",
                offset = 4,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "bitfield"
              }, {
                address = "0x0",
                is = "int",
                name = "stationary",
                offset = 5,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "bitfield"
              }, {
                address = "0x0",
                is = "int",
                name = "pad2",
                offset = 6,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "bitfield"
              }, {
                address = "0x0",
                is = "int",
                name = "noCollision2",
                offset = 7,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "bitfield"
              }, {
                address = "0x1",
                is = "int",
                name = "pad3",
                offset = 8,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "bitfield"
              }, {
                address = "0x1",
                is = "int",
                name = "hasSoundLoopingAttachment",
                offset = 10,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "bitfield"
              }, {
                address = "0x1",
                is = "int",
                name = "connectedToMap",
                offset = 11,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "bitfield"
              }, {
                address = "0x1",
                is = "int",
                name = "notPlacedAutomatically",
                offset = 12,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "bitfield"
              }, {
                address = "0x1",
                is = "int",
                name = "isDeviceMachine",
                offset = 13,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "bitfield"
              }, {
                address = "0x1",
                is = "int",
                name = "isElevator",
                offset = 14,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "bitfield"
              }, {
                address = "0x1",
                is = "int",
                name = "isElevator2",
                offset = 15,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "bitfield"
              }, {
                address = "0x2",
                is = "int",
                name = "isGarbage",
                offset = 16,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "bitfield"
              }, {
                address = "0x2",
                is = "int",
                name = "pad4",
                offset = 17,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "bitfield"
              }, {
                address = "0x2",
                is = "int",
                name = "noShadow",
                offset = 18,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "bitfield"
              }, {
                address = "0x2",
                is = "int",
                name = "deleteAtDeactivation",
                offset = 19,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "bitfield"
              }, {
                address = "0x2",
                is = "int",
                name = "doNotReactivate",
                offset = 20,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "bitfield"
              }, {
                address = "0x2",
                is = "int",
                name = "outsideOfMap",
                offset = 21,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "bitfield"
              }, {
                address = "0x2",
                is = "int",
                name = "pad5",
                offset = 22,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "bitfield"
              }, {
                address = "0x3",
                is = "int",
                name = "collidable",
                offset = 24,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "bitfield"
              }, {
                address = "0x3",
                is = "int",
                name = "hasCollisionModel",
                offset = 25,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "bitfield"
              }, {
                address = "0x3",
                is = "int",
                name = "networkMessageUnknown1",
                offset = 26,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "bitfield"
              }, {
                address = "0x3",
                is = "int",
                name = "networkMessageUnknown2",
                offset = 27,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "bitfield"
              }, {
                address = "0x3",
                is = "int",
                name = "opensauceIsTransformingIn",
                offset = 28,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "bitfield"
              }, {
                address = "0x3",
                is = "int",
                name = "opensauceIsTransformingOut",
                offset = 29,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "bitfield"
              }, {
                address = "0x3",
                is = "int",
                name = "pad6",
                offset = 30,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "bitfield"
              } },
            is = "struct",
            metaName = "BaseDynamicObjectFlags",
            name = "flags1",
            offset = 16,
            size = 4,
            type = "BaseDynamicObjectFlags",
            what = "field"
          }, {
            address = "0x14",
            is = "int",
            name = "objectMarkerId",
            offset = 20,
            size = 4,
            type = "dword",
            unsigned = true,
            what = "field"
          }, {
            address = "0x18",
            fields = { {
                address = "0x0",
                is = "int",
                name = "validPosition",
                offset = 0,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "field"
              }, {
                address = "0x4",
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
                name = "position",
                offset = 4,
                size = 12,
                type = "VectorXYZ",
                what = "field"
              }, {
                address = "0x10",
                is = "int",
                name = "validForwardAndUp",
                offset = 16,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "field"
              }, {
                address = "0x14",
                count = 2,
                elementSize = 12,
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
                is = "array",
                name = "orientation",
                offset = 20,
                size = 24,
                what = "field"
              }, {
                address = "0x2c",
                is = "int",
                name = "validTransitionalVelocity",
                offset = 44,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "field"
              }, {
                address = "0x30",
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
                name = "transitionalVelocity",
                offset = 48,
                size = 12,
                type = "VectorXYZ",
                what = "field"
              }, {
                address = "0x3c",
                is = "int",
                name = "validTimestamp",
                offset = 60,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "field"
              }, {
                address = "0x40",
                is = "int",
                name = "timestamp",
                offset = 64,
                size = 4,
                type = "dword",
                unsigned = true,
                what = "field"
              } },
            is = "struct",
            metaName = "BaseObjectNetwork",
            name = "network",
            offset = 24,
            size = 68,
            type = "BaseObjectNetwork",
            what = "field"
          }, {
            address = "0x5c",
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
            name = "position",
            offset = 92,
            size = 12,
            type = "VectorXYZ",
            what = "field"
          }, {
            address = "0x68",
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
            name = "velocity",
            offset = 104,
            size = 12,
            type = "VectorXYZ",
            what = "field"
          }, {
            address = "0x74",
            count = 2,
            elementSize = 12,
            fields = { {
                address = "0x0",
                is = "float",
                name = "i",
                offset = 0,
                size = 4,
                type = "float",
                what = "field"
              }, {
                address = "0x4",
                is = "float",
                name = "j",
                offset = 4,
                size = 4,
                type = "float",
                what = "field"
              }, {
                address = "0x8",
                is = "float",
                name = "k",
                offset = 8,
                size = 4,
                type = "float",
                what = "field"
              } },
            is = "array",
            name = "rotation",
            offset = 116,
            size = 24,
            what = "field"
          }, {
            address = "0x8c",
            fields = { {
                address = "0x0",
                is = "float",
                name = "pitch",
                offset = 0,
                size = 4,
                type = "float",
                what = "field"
              }, {
                address = "0x4",
                is = "float",
                name = "yaw",
                offset = 4,
                size = 4,
                type = "float",
                what = "field"
              }, {
                address = "0x8",
                is = "float",
                name = "rotation",
                offset = 8,
                size = 4,
                type = "float",
                what = "field"
              } },
            is = "struct",
            metaName = "VectorPYR",
            name = "rotationVelocity",
            offset = 140,
            size = 12,
            type = "VectorPYR",
            what = "field"
          }, {
            address = "0x98",
            fields = { {
                address = "0x0",
                is = "int",
                name = "leafId",
                offset = 0,
                size = 4,
                type = "int",
                what = "field"
              }, {
                address = "0x4",
                is = "int",
                name = "clusterId",
                offset = 4,
                size = 2,
                type = "short",
                what = "field"
              }, {
                address = "0x6",
                count = 2,
                elementSize = 1,
                elementType = "char",
                is = "array",
                name = "pad",
                offset = 6,
                size = 2,
                what = "field"
              } },
            is = "struct",
            metaName = "ScenarioLocation",
            name = "scenarioLocation",
            offset = 152,
            size = 8,
            type = "ScenarioLocation",
            what = "field"
          }, {
            address = "0xa0",
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
            name = "center",
            offset = 160,
            size = 12,
            type = "VectorXYZ",
            what = "field"
          }, {
            address = "0xac",
            is = "float",
            name = "boundingRadius",
            offset = 172,
            size = 4,
            type = "float",
            what = "field"
          }, {
            address = "0xb0",
            is = "float",
            name = "scale",
            offset = 176,
            size = 4,
            type = "float",
            what = "field"
          }, {
            address = "0xb4",
            is = "int",
            name = "objectType",
            offset = 180,
            size = 4,
            type = "dword",
            unsigned = true,
            what = "field"
          }, {
            address = "0xb8",
            is = "int",
            name = "teamOwner",
            offset = 184,
            size = 2,
            type = "word",
            unsigned = true,
            what = "field"
          }, {
            address = "0xba",
            is = "int",
            name = "nameListIndex",
            offset = 186,
            size = 2,
            type = "word",
            unsigned = true,
            what = "field"
          }, {
            address = "0xbc",
            is = "int",
            name = "movingTime",
            offset = 188,
            size = 2,
            type = "word",
            unsigned = true,
            what = "field"
          }, {
            address = "0xbe",
            is = "int",
            name = "variantIndex",
            offset = 190,
            size = 2,
            type = "word",
            unsigned = true,
            what = "field"
          }, {
            address = "0xc0",
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
            name = "player",
            offset = 192,
            size = 4,
            type = "TableResourceHandle",
            what = "field"
          }, {
            address = "0xc4",
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
            name = "ownerObject",
            offset = 196,
            size = 4,
            type = "TableResourceHandle",
            what = "field"
          }, {
            address = "0xc8",
            is = "int",
            name = "pad2",
            offset = 200,
            size = 4,
            type = "dword",
            unsigned = true,
            what = "field"
          }, {
            address = "0xcc",
            fields = { {
                address = "0x0",
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
                name = "animationTagHandle",
                offset = 0,
                size = 4,
                type = "TableResourceHandle",
                what = "field"
              }, {
                address = "0x4",
                fields = { {
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
                    name = "frame",
                    offset = 2,
                    size = 2,
                    type = "word",
                    unsigned = true,
                    what = "field"
                  } },
                is = "struct",
                metaName = "ObjectAnimationState",
                name = "animationState",
                offset = 4,
                size = 4,
                type = "ObjectAnimationState",
                what = "field"
              }, {
                address = "0x8",
                is = "int",
                name = "animationInterpolationFrame",
                offset = 8,
                size = 2,
                type = "word",
                unsigned = true,
                what = "field"
              }, {
                address = "0xa",
                is = "int",
                name = "animationInterpolationFrameCount",
                offset = 10,
                size = 2,
                type = "word",
                unsigned = true,
                what = "field"
              } },
            is = "struct",
            metaName = "ObjectAnimationData",
            name = "animationData",
            offset = 204,
            size = 12,
            type = "ObjectAnimationData",
            what = "field"
          }, {
            address = "0xd8",
            fields = { {
                address = "0x0",
                is = "float",
                name = "baseHealth",
                offset = 0,
                size = 4,
                type = "float",
                what = "field"
              }, {
                address = "0x4",
                is = "float",
                name = "baseShield",
                offset = 4,
                size = 4,
                type = "float",
                what = "field"
              }, {
                address = "0x8",
                is = "float",
                name = "health",
                offset = 8,
                size = 4,
                type = "float",
                what = "field"
              }, {
                address = "0xc",
                is = "float",
                name = "shield",
                offset = 12,
                size = 4,
                type = "float",
                what = "field"
              }, {
                address = "0x10",
                is = "float",
                name = "currentShieldDamage",
                offset = 16,
                size = 4,
                type = "float",
                what = "field"
              }, {
                address = "0x14",
                is = "float",
                name = "currentHealthDamage",
                offset = 20,
                size = 4,
                type = "float",
                what = "field"
              }, {
                address = "0x18",
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
                name = "entangledObjectHandle",
                offset = 24,
                size = 4,
                type = "TableResourceHandle",
                what = "field"
              }, {
                address = "0x1c",
                is = "float",
                name = "recentShieldDamage",
                offset = 28,
                size = 4,
                type = "float",
                what = "field"
              }, {
                address = "0x20",
                is = "float",
                name = "recentHealthDamage",
                offset = 32,
                size = 4,
                type = "float",
                what = "field"
              }, {
                address = "0x24",
                is = "int",
                name = "recentShieldDamageTime",
                offset = 36,
                size = 4,
                type = "dword",
                unsigned = true,
                what = "field"
              }, {
                address = "0x28",
                is = "int",
                name = "recentHealthDamageTime",
                offset = 40,
                size = 4,
                type = "dword",
                unsigned = true,
                what = "field"
              }, {
                address = "0x2c",
                is = "int",
                name = "shieldStunTime",
                offset = 44,
                size = 2,
                type = "word",
                unsigned = true,
                what = "field"
              }, {
                address = "0x2e",
                fields = { {
                    address = "0x0",
                    is = "int",
                    name = "healthDamageEffectApplied",
                    offset = 0,
                    size = 1,
                    type = "byte",
                    unsigned = true,
                    what = "bitfield"
                  }, {
                    address = "0x0",
                    is = "int",
                    name = "shieldDamageEffectApplied",
                    offset = 1,
                    size = 1,
                    type = "byte",
                    unsigned = true,
                    what = "bitfield"
                  }, {
                    address = "0x0",
                    is = "int",
                    name = "healthDepleted",
                    offset = 2,
                    size = 1,
                    type = "byte",
                    unsigned = true,
                    what = "bitfield"
                  }, {
                    address = "0x0",
                    is = "int",
                    name = "shieldDepleted",
                    offset = 3,
                    size = 1,
                    type = "byte",
                    unsigned = true,
                    what = "bitfield"
                  }, {
                    address = "0x0",
                    is = "int",
                    name = "pad1",
                    offset = 4,
                    size = 1,
                    type = "byte",
                    unsigned = true,
                    what = "bitfield"
                  }, {
                    address = "0x0",
                    is = "int",
                    name = "killed",
                    offset = 5,
                    size = 1,
                    type = "byte",
                    unsigned = true,
                    what = "bitfield"
                  }, {
                    address = "0x0",
                    is = "int",
                    name = "killedSilent",
                    offset = 6,
                    size = 1,
                    type = "byte",
                    unsigned = true,
                    what = "bitfield"
                  }, {
                    address = "0x0",
                    is = "int",
                    name = "cannotMeleeAttack",
                    offset = 7,
                    size = 1,
                    type = "byte",
                    unsigned = true,
                    what = "bitfield"
                  }, {
                    address = "0x1",
                    is = "int",
                    name = "pad2",
                    offset = 8,
                    size = 1,
                    type = "byte",
                    unsigned = true,
                    what = "bitfield"
                  }, {
                    address = "0x1",
                    is = "int",
                    name = "invulnerable",
                    offset = 11,
                    size = 1,
                    type = "byte",
                    unsigned = true,
                    what = "bitfield"
                  }, {
                    address = "0x1",
                    is = "int",
                    name = "shieldRecharging",
                    offset = 12,
                    size = 1,
                    type = "byte",
                    unsigned = true,
                    what = "bitfield"
                  }, {
                    address = "0x1",
                    is = "int",
                    name = "killedNoStats",
                    offset = 13,
                    size = 1,
                    type = "byte",
                    unsigned = true,
                    what = "bitfield"
                  }, {
                    address = "0x1",
                    is = "int",
                    name = "pad3",
                    offset = 14,
                    size = 1,
                    type = "byte",
                    unsigned = true,
                    what = "bitfield"
                  } },
                is = "struct",
                metaName = "BaseObjectVitalsFlags",
                name = "flags",
                offset = 46,
                size = 2,
                type = "BaseObjectVitalsFlags",
                what = "field"
              } },
            is = "struct",
            metaName = "BaseObjectVitals",
            name = "vitals",
            offset = 216,
            size = 48,
            type = "BaseObjectVitals",
            what = "field"
          }, {
            address = "0x108",
            is = "int",
            name = "pad3",
            offset = 264,
            size = 4,
            type = "dword",
            unsigned = true,
            what = "field"
          }, {
            address = "0x10c",
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
            name = "clusterPartition",
            offset = 268,
            size = 4,
            type = "TableResourceHandle",
            what = "field"
          }, {
            address = "0x110",
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
            name = "unknownObject",
            offset = 272,
            size = 4,
            type = "TableResourceHandle",
            what = "field"
          }, {
            address = "0x114",
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
            name = "nextObject",
            offset = 276,
            size = 4,
            type = "TableResourceHandle",
            what = "field"
          }, {
            address = "0x118",
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
            name = "firstObject",
            offset = 280,
            size = 4,
            type = "TableResourceHandle",
            what = "field"
          }, {
            address = "0x11c",
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
            name = "parentObject",
            offset = 284,
            size = 4,
            type = "TableResourceHandle",
            what = "field"
          }, {
            address = "0x120",
            is = "int",
            name = "parentAttachmentNode",
            offset = 288,
            size = 1,
            type = "byte",
            unsigned = true,
            what = "field"
          }, {
            address = "0x121",
            is = "int",
            name = "pad4",
            offset = 289,
            size = 1,
            type = "byte",
            unsigned = true,
            what = "field"
          }, {
            address = "0x122",
            is = "int",
            name = "forceShieldUpdate",
            offset = 290,
            size = 1,
            type = "char",
            what = "field"
          }, {
            address = "0x123",
            fields = { {
                address = "0x0",
                is = "int",
                name = "a",
                offset = 0,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "bitfield"
              }, {
                address = "0x0",
                is = "int",
                name = "b",
                offset = 1,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "bitfield"
              }, {
                address = "0x0",
                is = "int",
                name = "c",
                offset = 2,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "bitfield"
              }, {
                address = "0x0",
                is = "int",
                name = "d",
                offset = 3,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "bitfield"
              }, {
                address = "0x0",
                is = "int",
                name = "pad1",
                offset = 4,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "bitfield"
              } },
            is = "struct",
            metaName = "ObjectValidOutGoingFunctions",
            name = "validOutgoingFunctions",
            offset = 291,
            size = 1,
            type = "ObjectValidOutGoingFunctions",
            what = "field"
          }, {
            address = "0x124",
            count = 4,
            elementSize = 4,
            elementType = "float",
            is = "array",
            name = "incomingFunctionValues",
            offset = 292,
            size = 16,
            what = "field"
          }, {
            address = "0x134",
            count = 4,
            elementSize = 4,
            elementType = "float",
            is = "array",
            name = "outgoingFunctionValues",
            offset = 308,
            size = 16,
            what = "field"
          }, {
            address = "0x144",
            fields = { {
                address = "0x0",
                count = 8,
                elementSize = 1,
                elementType = "byte",
                is = "array",
                name = "types",
                offset = 0,
                size = 8,
                what = "field"
              }, {
                address = "0x8",
                count = 8,
                elementSize = 4,
                elementType = "dword",
                is = "array",
                name = "attachments",
                offset = 8,
                size = 32,
                what = "field"
              }, {
                address = "0x28",
                is = "int",
                name = "firstWidget",
                offset = 40,
                size = 4,
                type = "dword",
                unsigned = true,
                what = "field"
              } },
            is = "struct",
            metaName = "BaseObjectAttachmentsData",
            name = "attachmentData",
            offset = 324,
            size = 44,
            type = "BaseObjectAttachmentsData",
            what = "field"
          }, {
            address = "0x170",
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
            name = "cachedRenderState",
            offset = 368,
            size = 4,
            type = "TableResourceHandle",
            what = "field"
          }, {
            address = "0x174",
            fields = { {
                address = "0x0",
                is = "int",
                name = "region0",
                offset = 0,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "bitfield"
              }, {
                address = "0x0",
                is = "int",
                name = "region1",
                offset = 1,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "bitfield"
              }, {
                address = "0x0",
                is = "int",
                name = "region2",
                offset = 2,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "bitfield"
              }, {
                address = "0x0",
                is = "int",
                name = "region3",
                offset = 3,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "bitfield"
              }, {
                address = "0x0",
                is = "int",
                name = "region4",
                offset = 4,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "bitfield"
              }, {
                address = "0x0",
                is = "int",
                name = "region5",
                offset = 5,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "bitfield"
              }, {
                address = "0x0",
                is = "int",
                name = "region6",
                offset = 6,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "bitfield"
              }, {
                address = "0x0",
                is = "int",
                name = "region7",
                offset = 7,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "bitfield"
              }, {
                address = "0x1",
                is = "int",
                name = "pad1",
                offset = 1,
                size = 1,
                type = "byte",
                unsigned = true,
                what = "field"
              } },
            is = "struct",
            metaName = "BaseObjectRegionDestroyeds",
            name = "regionDestroyeds",
            offset = 372,
            size = 2,
            type = "BaseObjectRegionDestroyeds",
            what = "field"
          }, {
            address = "0x176",
            is = "int",
            name = "shaderPermutation",
            offset = 374,
            size = 2,
            type = "short",
            what = "field"
          }, {
            address = "0x178",
            count = 8,
            elementSize = 1,
            elementType = "byte",
            is = "array",
            name = "regionHealths",
            offset = 376,
            size = 8,
            what = "field"
          }, {
            address = "0x180",
            count = 8,
            elementSize = 1,
            elementType = "char",
            is = "array",
            name = "regionPermutationIds",
            offset = 384,
            size = 8,
            what = "field"
          }, {
            address = "0x188",
            count = 4,
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
            name = "colorChange",
            offset = 392,
            size = 48,
            what = "field"
          }, {
            address = "0x1b8",
            count = 4,
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
            name = "colorChange2",
            offset = 440,
            size = 48,
            what = "field"
          }, {
            address = "0x1e8",
            count = 2,
            elementSize = 4,
            fields = { {
                address = "0x0",
                is = "int",
                name = "size",
                offset = 0,
                size = 2,
                type = "word",
                unsigned = true,
                what = "field"
              }, {
                address = "0x2",
                is = "int",
                name = "offset",
                offset = 2,
                size = 2,
                type = "word",
                unsigned = true,
                what = "field"
              } },
            is = "array",
            name = "nodeOrientations",
            offset = 488,
            size = 8,
            what = "field"
          }, {
            address = "0x1f0",
            fields = { {
                address = "0x0",
                is = "int",
                name = "size",
                offset = 0,
                size = 2,
                type = "word",
                unsigned = true,
                what = "field"
              }, {
                address = "0x2",
                is = "int",
                name = "offset",
                offset = 2,
                size = 2,
                type = "word",
                unsigned = true,
                what = "field"
              } },
            is = "struct",
            metaName = "BaseObjectBlockReference",
            name = "nodeMatricesBlock",
            offset = 496,
            size = 4,
            type = "BaseObjectBlockReference",
            what = "field"
          } },
        is = "struct",
        metaName = "DynamicObjectBase",
        name = "base",
        offset = 0,
        size = 500,
        type = "DynamicObjectBase",
        what = "field"
      }, {
        address = "0x1f4",
        is = "int",
        name = "flags",
        offset = 500,
        size = 4,
        type = "dword",
        unsigned = true,
        what = "field"
      }, {
        address = "0x1f8",
        is = "int",
        name = "ticksUntilDetonation",
        offset = 504,
        size = 2,
        type = "short",
        what = "field"
      }, {
        address = "0x1fa",
        is = "int",
        name = "bspCollisionSurfaceId",
        offset = 506,
        size = 2,
        type = "short",
        what = "field"
      }, {
        address = "0x1fc",
        is = "int",
        name = "bspCollisionReferenceId",
        offset = 508,
        size = 2,
        type = "short",
        what = "field"
      }, {
        address = "0x1fe",
        count = 2,
        elementSize = 1,
        elementType = "char",
        is = "array",
        name = "pad1",
        offset = 510,
        size = 2,
        what = "field"
      }, {
        address = "0x200",
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
        name = "droppedByUnit",
        offset = 512,
        size = 4,
        type = "TableResourceHandle",
        what = "field"
      }, {
        address = "0x204",
        is = "int",
        name = "lastUpdateTick",
        offset = 516,
        size = 4,
        type = "int",
        what = "field"
      }, {
        address = "0x208",
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
        name = "collisionObject",
        offset = 520,
        size = 4,
        type = "TableResourceHandle",
        what = "field"
      }, {
        address = "0x20c",
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
        name = "collisionObjectPosition",
        offset = 524,
        size = 12,
        type = "VectorXYZ",
        what = "field"
      }, {
        address = "0x218",
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
        name = "unknownCollisionPosition",
        offset = 536,
        size = 12,
        type = "VectorXYZ",
        what = "field"
      }, {
        address = "0x224",
        fields = { {
            address = "0x0",
            is = "float",
            name = "pitch",
            offset = 0,
            size = 4,
            type = "float",
            what = "field"
          }, {
            address = "0x4",
            is = "float",
            name = "yaw",
            offset = 4,
            size = 4,
            type = "float",
            what = "field"
          } },
        is = "struct",
        metaName = "VectorPY",
        name = "unknownCollisionAngle",
        offset = 548,
        size = 8,
        type = "VectorPY",
        what = "field"
      } },
    is = "struct",
    metaName = "ItemObject",
    name = "base",
    offset = 0,
    size = 556,
    type = "ItemObject",
    what = "field"
  }, {
    address = "0x22c",
    is = "int",
    name = "flags",
    offset = 556,
    size = 4,
    type = "dword",
    unsigned = true,
    what = "field"
  }, {
    address = "0x230",
    is = "int",
    name = "ownerUnitFlags",
    offset = 560,
    size = 2,
    type = "word",
    unsigned = true,
    what = "field"
  }, {
    address = "0x232",
    count = 2,
    elementSize = 1,
    elementType = "char",
    is = "array",
    name = "pad1",
    offset = 562,
    size = 2,
    what = "field"
  }, {
    address = "0x234",
    is = "float",
    name = "primaryTrigger",
    offset = 564,
    size = 4,
    type = "float",
    what = "field"
  }, {
    address = "0x238",
    is = "int",
    name = "weaponState",
    offset = 568,
    size = 1,
    type = "char",
    what = "field"
  }, {
    address = "0x239",
    is = "int",
    name = "pad2",
    offset = 569,
    size = 1,
    type = "char",
    what = "field"
  }, {
    address = "0x23a",
    is = "int",
    name = "readyTicks",
    offset = 570,
    size = 2,
    type = "short",
    what = "field"
  }, {
    address = "0x23c",
    is = "float",
    name = "heat",
    offset = 572,
    size = 4,
    type = "float",
    what = "field"
  }, {
    address = "0x240",
    is = "float",
    name = "age",
    offset = 576,
    size = 4,
    type = "float",
    what = "field"
  }, {
    address = "0x244",
    is = "float",
    name = "illuminationFraction",
    offset = 580,
    size = 4,
    type = "float",
    what = "field"
  }, {
    address = "0x248",
    is = "float",
    name = "integratedLightPower",
    offset = 584,
    size = 4,
    type = "float",
    what = "field"
  }, {
    address = "0x24c",
    count = 4,
    elementSize = 1,
    elementType = "char",
    is = "array",
    name = "pad3",
    offset = 588,
    size = 4,
    what = "field"
  }, {
    address = "0x250",
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
    name = "trackedObject",
    offset = 592,
    size = 4,
    type = "TableResourceHandle",
    what = "field"
  }, {
    address = "0x254",
    count = 8,
    elementSize = 1,
    elementType = "char",
    is = "array",
    name = "pad4",
    offset = 596,
    size = 8,
    what = "field"
  }, {
    address = "0x25c",
    is = "int",
    name = "altShotsLoaded",
    offset = 604,
    size = 2,
    type = "short",
    what = "field"
  }, {
    address = "0x25e",
    count = 2,
    elementSize = 1,
    elementType = "char",
    is = "array",
    name = "pad5",
    offset = 606,
    size = 2,
    what = "field"
  }, {
    address = "0x260",
    count = 2,
    elementSize = 40,
    fields = { {
        address = "0x0",
        is = "int",
        name = "idleTime",
        offset = 0,
        size = 1,
        type = "char",
        what = "field"
      }, {
        address = "0x1",
        is = "int",
        name = "state",
        offset = 1,
        size = 1,
        type = "char",
        what = "field"
      }, {
        address = "0x2",
        is = "int",
        name = "triggerTime",
        offset = 2,
        size = 2,
        type = "word",
        unsigned = true,
        what = "field"
      }, {
        address = "0x4",
        is = "int",
        name = "notFiring",
        offset = 4,
        size = 4,
        type = "dword",
        unsigned = true,
        what = "field"
      }, {
        address = "0x8",
        is = "int",
        name = "autoReload",
        offset = 8,
        size = 4,
        type = "dword",
        unsigned = true,
        what = "field"
      }, {
        address = "0xc",
        count = 2,
        elementSize = 1,
        elementType = "char",
        is = "array",
        name = "pad1",
        offset = 12,
        size = 2,
        what = "field"
      }, {
        address = "0xe",
        is = "int",
        name = "roundsSinceLastTracer",
        offset = 14,
        size = 2,
        type = "word",
        unsigned = true,
        what = "field"
      }, {
        address = "0x10",
        is = "float",
        name = "rateOfFire",
        offset = 16,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x14",
        is = "float",
        name = "ejectionPortRecoveryTime",
        offset = 20,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x18",
        is = "float",
        name = "illuminationRecoveryTime",
        offset = 24,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x1c",
        is = "float",
        name = "projectileErrorRelated",
        offset = 28,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x20",
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
        name = "charingEffect",
        offset = 32,
        size = 4,
        type = "TableResourceHandle",
        what = "field"
      }, {
        address = "0x24",
        is = "int",
        name = "networkDelayTicks",
        offset = 36,
        size = 1,
        type = "char",
        what = "field"
      }, {
        address = "0x25",
        count = 3,
        elementSize = 1,
        elementType = "char",
        is = "array",
        name = "pad2",
        offset = 37,
        size = 3,
        what = "field"
      } },
    is = "array",
    name = "triggers",
    offset = 608,
    size = 80,
    what = "field"
  }, {
    address = "0x2b0",
    count = 2,
    elementSize = 16,
    fields = { {
        address = "0x0",
        is = "int",
        name = "state",
        offset = 0,
        size = 2,
        type = "short",
        what = "field"
      }, {
        address = "0x2",
        is = "int",
        name = "reloadTicksRemaining",
        offset = 2,
        size = 2,
        type = "word",
        unsigned = true,
        what = "field"
      }, {
        address = "0x4",
        is = "int",
        name = "reloadTicks",
        offset = 4,
        size = 2,
        type = "word",
        unsigned = true,
        what = "field"
      }, {
        address = "0x6",
        is = "int",
        name = "roundsUnloaded",
        offset = 6,
        size = 2,
        type = "short",
        what = "field"
      }, {
        address = "0x8",
        is = "int",
        name = "roundsLoaded",
        offset = 8,
        size = 2,
        type = "short",
        what = "field"
      }, {
        address = "0xa",
        is = "int",
        name = "roundsLeftToRecharge",
        offset = 10,
        size = 2,
        type = "short",
        what = "field"
      }, {
        address = "0xc",
        is = "int",
        name = "unknown",
        offset = 12,
        size = 2,
        type = "short",
        what = "field"
      }, {
        address = "0xe",
        is = "int",
        name = "unknown2",
        offset = 14,
        size = 2,
        type = "short",
        what = "field"
      } },
    is = "array",
    name = "magazines",
    offset = 688,
    size = 32,
    what = "field"
  }, {
    address = "0x2d0",
    is = "int",
    name = "lastTriggerFireTick",
    offset = 720,
    size = 4,
    type = "dword",
    unsigned = true,
    what = "field"
  }, {
    address = "0x2d4",
    fields = { {
        address = "0x0",
        count = 2,
        elementSize = 2,
        elementType = "short",
        is = "array",
        name = "totalRounds",
        offset = 0,
        size = 4,
        what = "field"
      }, {
        address = "0x4",
        count = 2,
        elementSize = 2,
        elementType = "short",
        is = "array",
        name = "loadedRounds",
        offset = 4,
        size = 4,
        what = "field"
      } },
    is = "struct",
    metaName = "WeaponReloadStartData",
    name = "reloadStartingPoint",
    offset = 724,
    size = 8,
    type = "WeaponReloadStartData",
    what = "field"
  }, {
    address = "0x2dc",
    count = 4,
    elementSize = 1,
    elementType = "char",
    is = "array",
    name = "pad6",
    offset = 732,
    size = 4,
    what = "field"
  }, {
    address = "0x2e0",
    fields = { {
        address = "0x0",
        is = "int",
        name = "baselineValid",
        offset = 0,
        size = 1,
        type = "byte",
        unsigned = true,
        what = "field"
      }, {
        address = "0x1",
        is = "int",
        name = "baselineIndex",
        offset = 1,
        size = 1,
        type = "char",
        what = "field"
      }, {
        address = "0x2",
        is = "int",
        name = "messageIndex",
        offset = 2,
        size = 1,
        type = "char",
        what = "field"
      }, {
        address = "0x3",
        is = "int",
        name = "pad1",
        offset = 3,
        size = 1,
        type = "char",
        what = "field"
      }, {
        address = "0x4",
        fields = { {
            address = "0x0",
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
            name = "position",
            offset = 0,
            size = 12,
            type = "VectorXYZ",
            what = "field"
          }, {
            address = "0xc",
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
            name = "transitionalVelocity",
            offset = 12,
            size = 12,
            type = "VectorXYZ",
            what = "field"
          }, {
            address = "0x18",
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
            name = "angularVelocity",
            offset = 24,
            size = 12,
            type = "VectorXYZ",
            what = "field"
          }, {
            address = "0x24",
            count = 2,
            elementSize = 2,
            elementType = "short",
            is = "array",
            name = "magazineRoundsTotal",
            offset = 36,
            size = 4,
            what = "field"
          }, {
            address = "0x28",
            is = "float",
            name = "age",
            offset = 40,
            size = 4,
            type = "float",
            what = "field"
          } },
        is = "struct",
        metaName = "WeaponNetworkData",
        name = "updateBaseline",
        offset = 4,
        size = 44,
        type = "WeaponNetworkData",
        what = "field"
      }, {
        address = "0x30",
        is = "int",
        name = "deltaValid",
        offset = 48,
        size = 1,
        type = "byte",
        unsigned = true,
        what = "field"
      }, {
        address = "0x31",
        count = 3,
        elementSize = 1,
        elementType = "char",
        is = "array",
        name = "pad2",
        offset = 49,
        size = 3,
        what = "field"
      }, {
        address = "0x34",
        fields = { {
            address = "0x0",
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
            name = "position",
            offset = 0,
            size = 12,
            type = "VectorXYZ",
            what = "field"
          }, {
            address = "0xc",
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
            name = "transitionalVelocity",
            offset = 12,
            size = 12,
            type = "VectorXYZ",
            what = "field"
          }, {
            address = "0x18",
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
            name = "angularVelocity",
            offset = 24,
            size = 12,
            type = "VectorXYZ",
            what = "field"
          }, {
            address = "0x24",
            count = 2,
            elementSize = 2,
            elementType = "short",
            is = "array",
            name = "magazineRoundsTotal",
            offset = 36,
            size = 4,
            what = "field"
          }, {
            address = "0x28",
            is = "float",
            name = "age",
            offset = 40,
            size = 4,
            type = "float",
            what = "field"
          } },
        is = "struct",
        metaName = "WeaponNetworkData",
        name = "updateDelta",
        offset = 52,
        size = 44,
        type = "WeaponNetworkData",
        what = "field"
      } },
    is = "struct",
    metaName = "WeaponNetwork",
    name = "network",
    offset = 736,
    size = 96,
    type = "WeaponNetwork",
    what = "field"
  } }
