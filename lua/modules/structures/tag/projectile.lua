return { {
    address = "0x0",
    fields = { {
        address = "0x0",
        is = "int",
        metaName = "ObjectType",
        name = "type",
        offset = 0,
        size = 2,
        type = "short",
        what = "field"
      }, {
        address = "0x2",
        fields = { {
            address = "0x0",
            is = "int",
            name = "doesNotCastShadow",
            offset = 0,
            size = 2,
            type = "word",
            unsigned = true,
            what = "bitfield"
          }, {
            address = "0x0",
            is = "int",
            name = "transparentSelfOcclusion",
            offset = 1,
            size = 2,
            type = "word",
            unsigned = true,
            what = "bitfield"
          }, {
            address = "0x0",
            is = "int",
            name = "brighterThanItShouldBe",
            offset = 2,
            size = 2,
            type = "word",
            unsigned = true,
            what = "bitfield"
          }, {
            address = "0x0",
            is = "int",
            name = "notAPathfindingObstacle",
            offset = 3,
            size = 2,
            type = "word",
            unsigned = true,
            what = "bitfield"
          }, {
            address = "0x0",
            is = "int",
            name = "extensionOfParent",
            offset = 4,
            size = 2,
            type = "word",
            unsigned = true,
            what = "bitfield"
          }, {
            address = "0x0",
            is = "int",
            name = "castShadowByDefault",
            offset = 5,
            size = 2,
            type = "word",
            unsigned = true,
            what = "bitfield"
          }, {
            address = "0x0",
            is = "int",
            name = "doesNotHaveAnniversaryGeometry",
            offset = 6,
            size = 2,
            type = "word",
            unsigned = true,
            what = "bitfield"
          } },
        is = "struct",
        metaName = "ObjectFlags",
        name = "flags",
        offset = 2,
        size = 2,
        type = "ObjectFlags",
        what = "field"
      }, {
        address = "0x4",
        is = "float",
        name = "boundingRadius",
        offset = 4,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x8",
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
        name = "boundingOffset",
        offset = 8,
        size = 12,
        type = "VectorXYZ",
        what = "field"
      }, {
        address = "0x14",
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
        name = "originOffset",
        offset = 20,
        size = 12,
        type = "VectorXYZ",
        what = "field"
      }, {
        address = "0x20",
        is = "float",
        name = "accelerationScale",
        offset = 32,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x24",
        fields = { {
            address = "0x0",
            is = "int",
            name = "functionsControlColorScale",
            offset = 0,
            size = 4,
            type = "dword",
            unsigned = true,
            what = "bitfield"
          } },
        is = "struct",
        metaName = "ObjectRuntimeFlags",
        name = "runtimeFlags",
        offset = 36,
        size = 4,
        type = "ObjectRuntimeFlags",
        what = "field"
      }, {
        address = "0x28",
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
        name = "model",
        offset = 40,
        size = 16,
        type = "TagReference",
        what = "field"
      }, {
        address = "0x38",
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
        name = "animationGraph",
        offset = 56,
        size = 16,
        type = "TagReference",
        what = "field"
      }, {
        address = "0x48",
        count = 40,
        elementSize = 1,
        elementType = "char",
        is = "array",
        name = "pad5279",
        offset = 72,
        size = 40,
        what = "field"
      }, {
        address = "0x70",
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
        name = "collisionModel",
        offset = 112,
        size = 16,
        type = "TagReference",
        what = "field"
      }, {
        address = "0x80",
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
        name = "physics",
        offset = 128,
        size = 16,
        type = "TagReference",
        what = "field"
      }, {
        address = "0x90",
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
        name = "modifierShader",
        offset = 144,
        size = 16,
        type = "TagReference",
        what = "field"
      }, {
        address = "0xa0",
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
        name = "creationEffect",
        offset = 160,
        size = 16,
        type = "TagReference",
        what = "field"
      }, {
        address = "0xb0",
        count = 84,
        elementSize = 1,
        elementType = "char",
        is = "array",
        name = "pad5430",
        offset = 176,
        size = 84,
        what = "field"
      }, {
        address = "0x104",
        is = "float",
        name = "renderBoundingRadius",
        offset = 260,
        size = 4,
        type = "float",
        what = "field"
      }, {
        address = "0x108",
        is = "int",
        metaName = "ObjectFunctionIn",
        name = "aIn",
        offset = 264,
        size = 2,
        type = "short",
        what = "field"
      }, {
        address = "0x10a",
        is = "int",
        metaName = "ObjectFunctionIn",
        name = "bIn",
        offset = 266,
        size = 2,
        type = "short",
        what = "field"
      }, {
        address = "0x10c",
        is = "int",
        metaName = "ObjectFunctionIn",
        name = "cIn",
        offset = 268,
        size = 2,
        type = "short",
        what = "field"
      }, {
        address = "0x10e",
        is = "int",
        metaName = "ObjectFunctionIn",
        name = "dIn",
        offset = 270,
        size = 2,
        type = "short",
        what = "field"
      }, {
        address = "0x110",
        count = 44,
        elementSize = 1,
        elementType = "char",
        is = "array",
        name = "pad5595",
        offset = 272,
        size = 44,
        what = "field"
      }, {
        address = "0x13c",
        is = "int",
        name = "hudTextMessageIndex",
        offset = 316,
        size = 2,
        type = "word",
        unsigned = true,
        what = "field"
      }, {
        address = "0x13e",
        is = "int",
        name = "forcedShaderPermutationIndex",
        offset = 318,
        size = 2,
        type = "word",
        unsigned = true,
        what = "field"
      }, {
        address = "0x140",
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
            elementSize = 72,
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
                name = "type",
                offset = 0,
                size = 16,
                type = "TagReference",
                what = "field"
              }, {
                address = "0x10",
                fields = { {
                    address = "0x0",
                    count = 32,
                    elementSize = 1,
                    elementType = "char",
                    is = "array",
                    name = "string",
                    offset = 0,
                    size = 32,
                    what = "field"
                  } },
                is = "struct",
                metaName = "String32",
                name = "marker",
                offset = 16,
                size = 32,
                type = "String32",
                what = "field"
              }, {
                address = "0x30",
                is = "int",
                metaName = "FunctionOut",
                name = "primaryScale",
                offset = 48,
                size = 2,
                type = "short",
                what = "field"
              }, {
                address = "0x32",
                is = "int",
                metaName = "FunctionOut",
                name = "secondaryScale",
                offset = 50,
                size = 2,
                type = "short",
                what = "field"
              }, {
                address = "0x34",
                is = "int",
                metaName = "FunctionNameNullable",
                name = "changeColor",
                offset = 52,
                size = 2,
                type = "short",
                what = "field"
              }, {
                address = "0x36",
                count = 2,
                elementSize = 1,
                elementType = "char",
                is = "array",
                name = "pad3396",
                offset = 54,
                size = 2,
                what = "field"
              }, {
                address = "0x38",
                count = 16,
                elementSize = 1,
                elementType = "char",
                is = "array",
                name = "pad3418",
                offset = 56,
                size = 16,
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
        name = "attachments",
        offset = 320,
        size = 12,
        what = "field"
      }, {
        address = "0x14c",
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
                name = "reference",
                offset = 0,
                size = 16,
                type = "TagReference",
                what = "field"
              }, {
                address = "0x10",
                count = 16,
                elementSize = 1,
                elementType = "char",
                is = "array",
                name = "pad3569",
                offset = 16,
                size = 16,
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
        name = "widgets",
        offset = 332,
        size = 12,
        what = "field"
      }, {
        address = "0x158",
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
            elementSize = 360,
            fields = { {
                address = "0x0",
                fields = { {
                    address = "0x0",
                    is = "int",
                    name = "invert",
                    offset = 0,
                    size = 4,
                    type = "dword",
                    unsigned = true,
                    what = "bitfield"
                  }, {
                    address = "0x0",
                    is = "int",
                    name = "additive",
                    offset = 1,
                    size = 4,
                    type = "dword",
                    unsigned = true,
                    what = "bitfield"
                  }, {
                    address = "0x0",
                    is = "int",
                    name = "alwaysActive",
                    offset = 2,
                    size = 4,
                    type = "dword",
                    unsigned = true,
                    what = "bitfield"
                  } },
                is = "struct",
                metaName = "ObjectFunctionFlags",
                name = "flags",
                offset = 0,
                size = 4,
                type = "ObjectFunctionFlags",
                what = "field"
              }, {
                address = "0x4",
                is = "float",
                name = "period",
                offset = 4,
                size = 4,
                type = "float",
                what = "field"
              }, {
                address = "0x8",
                is = "int",
                metaName = "FunctionScaleBy",
                name = "scalePeriodBy",
                offset = 8,
                size = 2,
                type = "short",
                what = "field"
              }, {
                address = "0xa",
                is = "int",
                metaName = "WaveFunction",
                name = "function",
                offset = 10,
                size = 2,
                type = "short",
                what = "field"
              }, {
                address = "0xc",
                is = "int",
                metaName = "FunctionScaleBy",
                name = "scaleFunctionBy",
                offset = 12,
                size = 2,
                type = "short",
                what = "field"
              }, {
                address = "0xe",
                is = "int",
                metaName = "WaveFunction",
                name = "wobbleFunction",
                offset = 14,
                size = 2,
                type = "short",
                what = "field"
              }, {
                address = "0x10",
                is = "float",
                name = "wobblePeriod",
                offset = 16,
                size = 4,
                type = "float",
                what = "field"
              }, {
                address = "0x14",
                is = "float",
                name = "wobbleMagnitude",
                offset = 20,
                size = 4,
                type = "float",
                what = "field"
              }, {
                address = "0x18",
                is = "float",
                name = "squareWaveThreshold",
                offset = 24,
                size = 4,
                type = "float",
                what = "field"
              }, {
                address = "0x1c",
                is = "int",
                name = "stepCount",
                offset = 28,
                size = 2,
                type = "short",
                what = "field"
              }, {
                address = "0x1e",
                is = "int",
                metaName = "FunctionType",
                name = "mapTo",
                offset = 30,
                size = 2,
                type = "short",
                what = "field"
              }, {
                address = "0x20",
                is = "int",
                name = "sawtoothCount",
                offset = 32,
                size = 2,
                type = "short",
                what = "field"
              }, {
                address = "0x22",
                is = "int",
                metaName = "FunctionScaleBy",
                name = "add",
                offset = 34,
                size = 2,
                type = "short",
                what = "field"
              }, {
                address = "0x24",
                is = "int",
                metaName = "FunctionScaleBy",
                name = "scaleResultBy",
                offset = 36,
                size = 2,
                type = "short",
                what = "field"
              }, {
                address = "0x26",
                is = "int",
                metaName = "FunctionBoundsMode",
                name = "boundsMode",
                offset = 38,
                size = 2,
                type = "short",
                what = "field"
              }, {
                address = "0x28",
                count = 2,
                elementSize = 4,
                elementType = "float",
                is = "array",
                name = "bounds",
                offset = 40,
                size = 8,
                what = "field"
              }, {
                address = "0x30",
                count = 4,
                elementSize = 1,
                elementType = "char",
                is = "array",
                name = "pad4154",
                offset = 48,
                size = 4,
                what = "field"
              }, {
                address = "0x34",
                count = 2,
                elementSize = 1,
                elementType = "char",
                is = "array",
                name = "pad4176",
                offset = 52,
                size = 2,
                what = "field"
              }, {
                address = "0x36",
                is = "int",
                name = "turnOffWith",
                offset = 54,
                size = 2,
                type = "short",
                what = "field"
              }, {
                address = "0x38",
                is = "float",
                name = "scaleBy",
                offset = 56,
                size = 4,
                type = "float",
                what = "field"
              }, {
                address = "0x3c",
                count = 252,
                elementSize = 1,
                elementType = "char",
                is = "array",
                name = "pad4245",
                offset = 60,
                size = 252,
                what = "field"
              }, {
                address = "0x138",
                is = "float",
                name = "inverseBounds",
                offset = 312,
                size = 4,
                type = "float",
                what = "field"
              }, {
                address = "0x13c",
                is = "float",
                name = "inverseSawtooth",
                offset = 316,
                size = 4,
                type = "float",
                what = "field"
              }, {
                address = "0x140",
                is = "float",
                name = "inverseStep",
                offset = 320,
                size = 4,
                type = "float",
                what = "field"
              }, {
                address = "0x144",
                is = "float",
                name = "inversePeriod",
                offset = 324,
                size = 4,
                type = "float",
                what = "field"
              }, {
                address = "0x148",
                fields = { {
                    address = "0x0",
                    count = 32,
                    elementSize = 1,
                    elementType = "char",
                    is = "array",
                    name = "string",
                    offset = 0,
                    size = 32,
                    what = "field"
                  } },
                is = "struct",
                metaName = "String32",
                name = "usage",
                offset = 328,
                size = 32,
                type = "String32",
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
        name = "functions",
        offset = 344,
        size = 12,
        what = "field"
      }, {
        address = "0x164",
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
            elementSize = 44,
            fields = { {
                address = "0x0",
                is = "int",
                metaName = "FunctionScaleBy",
                name = "darkenBy",
                offset = 0,
                size = 2,
                type = "short",
                what = "field"
              }, {
                address = "0x2",
                is = "int",
                metaName = "FunctionScaleBy",
                name = "scaleBy",
                offset = 2,
                size = 2,
                type = "short",
                what = "field"
              }, {
                address = "0x4",
                fields = { {
                    address = "0x0",
                    is = "int",
                    name = "blendInHsv",
                    offset = 0,
                    size = 4,
                    type = "dword",
                    unsigned = true,
                    what = "bitfield"
                  }, {
                    address = "0x0",
                    is = "int",
                    name = "moreColors",
                    offset = 1,
                    size = 4,
                    type = "dword",
                    unsigned = true,
                    what = "bitfield"
                  } },
                is = "struct",
                metaName = "ColorInterpolationFlags",
                name = "flags",
                offset = 4,
                size = 4,
                type = "ColorInterpolationFlags",
                what = "field"
              }, {
                address = "0x8",
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
                offset = 8,
                size = 24,
                what = "field"
              }, {
                address = "0x20",
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
                    elementSize = 28,
                    fields = { {
                        address = "0x0",
                        is = "float",
                        name = "weight",
                        offset = 0,
                        size = 4,
                        type = "float",
                        what = "field"
                      }, {
                        address = "0x4",
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
                        offset = 4,
                        size = 24,
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
                name = "permutations",
                offset = 32,
                size = 12,
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
        offset = 356,
        size = 12,
        what = "field"
      }, {
        address = "0x170",
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
            elementSize = 8,
            fields = { {
                address = "0x0",
                is = "int",
                metaName = "PredictedResourceType",
                name = "type",
                offset = 0,
                size = 2,
                type = "short",
                what = "field"
              }, {
                address = "0x2",
                is = "int",
                name = "resourceIndex",
                offset = 2,
                size = 2,
                type = "word",
                unsigned = true,
                what = "field"
              }, {
                address = "0x4",
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
                name = "tag",
                offset = 4,
                size = 4,
                type = "TableResourceHandle",
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
        name = "predictedResources",
        offset = 368,
        size = 12,
        what = "field"
      } },
    is = "struct",
    metaName = "Object",
    name = "base",
    offset = 0,
    size = 380,
    type = "Object",
    what = "field"
  }, {
    address = "0x17c",
    fields = { {
        address = "0x0",
        is = "int",
        name = "orientedAlongVelocity",
        offset = 0,
        size = 4,
        type = "dword",
        unsigned = true,
        what = "bitfield"
      }, {
        address = "0x0",
        is = "int",
        name = "aiMustUseBallisticAiming",
        offset = 1,
        size = 4,
        type = "dword",
        unsigned = true,
        what = "bitfield"
      }, {
        address = "0x0",
        is = "int",
        name = "detonationMaxTimeIfAttached",
        offset = 2,
        size = 4,
        type = "dword",
        unsigned = true,
        what = "bitfield"
      }, {
        address = "0x0",
        is = "int",
        name = "hasSuperCombiningExplosion",
        offset = 3,
        size = 4,
        type = "dword",
        unsigned = true,
        what = "bitfield"
      }, {
        address = "0x0",
        is = "int",
        name = "combineInitialVelocityWithParentVelocity",
        offset = 4,
        size = 4,
        type = "dword",
        unsigned = true,
        what = "bitfield"
      }, {
        address = "0x0",
        is = "int",
        name = "randomAttachedDetonationTime",
        offset = 5,
        size = 4,
        type = "dword",
        unsigned = true,
        what = "bitfield"
      }, {
        address = "0x0",
        is = "int",
        name = "minimumUnattachedDetonationTime",
        offset = 6,
        size = 4,
        type = "dword",
        unsigned = true,
        what = "bitfield"
      } },
    is = "struct",
    metaName = "ProjectileFlags",
    name = "flags",
    offset = 380,
    size = 4,
    type = "ProjectileFlags",
    what = "field"
  }, {
    address = "0x180",
    is = "int",
    metaName = "ProjectileDetonationTimerStarts",
    name = "detonationTimerStarts",
    offset = 384,
    size = 2,
    type = "short",
    what = "field"
  }, {
    address = "0x182",
    is = "int",
    metaName = "ObjectNoise",
    name = "impactNoise",
    offset = 386,
    size = 2,
    type = "short",
    what = "field"
  }, {
    address = "0x184",
    is = "int",
    metaName = "ProjectileFunctionIn",
    name = "aIn",
    offset = 388,
    size = 2,
    type = "short",
    what = "field"
  }, {
    address = "0x186",
    is = "int",
    metaName = "ProjectileFunctionIn",
    name = "bIn",
    offset = 390,
    size = 2,
    type = "short",
    what = "field"
  }, {
    address = "0x188",
    is = "int",
    metaName = "ProjectileFunctionIn",
    name = "cIn",
    offset = 392,
    size = 2,
    type = "short",
    what = "field"
  }, {
    address = "0x18a",
    is = "int",
    metaName = "ProjectileFunctionIn",
    name = "dIn",
    offset = 394,
    size = 2,
    type = "short",
    what = "field"
  }, {
    address = "0x18c",
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
    name = "superDetonation",
    offset = 396,
    size = 16,
    type = "TagReference",
    what = "field"
  }, {
    address = "0x19c",
    is = "float",
    name = "aiPerceptionRadius",
    offset = 412,
    size = 4,
    type = "float",
    what = "field"
  }, {
    address = "0x1a0",
    is = "float",
    name = "collisionRadius",
    offset = 416,
    size = 4,
    type = "float",
    what = "field"
  }, {
    address = "0x1a4",
    is = "float",
    name = "armingTime",
    offset = 420,
    size = 4,
    type = "float",
    what = "field"
  }, {
    address = "0x1a8",
    is = "float",
    name = "dangerRadius",
    offset = 424,
    size = 4,
    type = "float",
    what = "field"
  }, {
    address = "0x1ac",
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
    name = "effect",
    offset = 428,
    size = 16,
    type = "TagReference",
    what = "field"
  }, {
    address = "0x1bc",
    count = 2,
    elementSize = 4,
    elementType = "float",
    is = "array",
    name = "timer",
    offset = 444,
    size = 8,
    what = "field"
  }, {
    address = "0x1c4",
    is = "float",
    name = "minimumVelocity",
    offset = 452,
    size = 4,
    type = "float",
    what = "field"
  }, {
    address = "0x1c8",
    is = "float",
    name = "maximumRange",
    offset = 456,
    size = 4,
    type = "float",
    what = "field"
  }, {
    address = "0x1cc",
    is = "float",
    name = "airGravityScale",
    offset = 460,
    size = 4,
    type = "float",
    what = "field"
  }, {
    address = "0x1d0",
    count = 2,
    elementSize = 4,
    elementType = "float",
    is = "array",
    name = "airDamageRange",
    offset = 464,
    size = 8,
    what = "field"
  }, {
    address = "0x1d8",
    is = "float",
    name = "waterGravityScale",
    offset = 472,
    size = 4,
    type = "float",
    what = "field"
  }, {
    address = "0x1dc",
    count = 2,
    elementSize = 4,
    elementType = "float",
    is = "array",
    name = "waterDamageRange",
    offset = 476,
    size = 8,
    what = "field"
  }, {
    address = "0x1e4",
    is = "float",
    name = "initialVelocity",
    offset = 484,
    size = 4,
    type = "float",
    what = "field"
  }, {
    address = "0x1e8",
    is = "float",
    name = "finalVelocity",
    offset = 488,
    size = 4,
    type = "float",
    what = "field"
  }, {
    address = "0x1ec",
    is = "float",
    name = "guidedAngularVelocity",
    offset = 492,
    size = 4,
    type = "float",
    what = "field"
  }, {
    address = "0x1f0",
    is = "int",
    metaName = "ObjectNoise",
    name = "detonationNoise",
    offset = 496,
    size = 2,
    type = "short",
    what = "field"
  }, {
    address = "0x1f2",
    count = 2,
    elementSize = 1,
    elementType = "char",
    is = "array",
    name = "pad4106",
    offset = 498,
    size = 2,
    what = "field"
  }, {
    address = "0x1f4",
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
    name = "detonationStarted",
    offset = 500,
    size = 16,
    type = "TagReference",
    what = "field"
  }, {
    address = "0x204",
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
    name = "flybySound",
    offset = 516,
    size = 16,
    type = "TagReference",
    what = "field"
  }, {
    address = "0x214",
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
    name = "attachedDetonationDamage",
    offset = 532,
    size = 16,
    type = "TagReference",
    what = "field"
  }, {
    address = "0x224",
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
    name = "impactDamage",
    offset = 548,
    size = 16,
    type = "TagReference",
    what = "field"
  }, {
    address = "0x234",
    count = 12,
    elementSize = 1,
    elementType = "char",
    is = "array",
    name = "pad4272",
    offset = 564,
    size = 12,
    what = "field"
  }, {
    address = "0x240",
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
        elementSize = 160,
        fields = { {
            address = "0x0",
            fields = { {
                address = "0x0",
                is = "int",
                name = "cannotBeOverpenetrated",
                offset = 0,
                size = 2,
                type = "word",
                unsigned = true,
                what = "bitfield"
              } },
            is = "struct",
            metaName = "ProjectileMaterialResponseFlags",
            name = "flags",
            offset = 0,
            size = 2,
            type = "ProjectileMaterialResponseFlags",
            what = "field"
          }, {
            address = "0x2",
            is = "int",
            metaName = "ProjectileResponse",
            name = "defaultResponse",
            offset = 2,
            size = 2,
            type = "short",
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
            name = "defaultEffect",
            offset = 4,
            size = 16,
            type = "TagReference",
            what = "field"
          }, {
            address = "0x14",
            count = 16,
            elementSize = 1,
            elementType = "char",
            is = "array",
            name = "pad2660",
            offset = 20,
            size = 16,
            what = "field"
          }, {
            address = "0x24",
            is = "int",
            metaName = "ProjectileResponse",
            name = "potentialResponse",
            offset = 36,
            size = 2,
            type = "short",
            what = "field"
          }, {
            address = "0x26",
            fields = { {
                address = "0x0",
                is = "int",
                name = "onlyAgainstUnits",
                offset = 0,
                size = 2,
                type = "word",
                unsigned = true,
                what = "bitfield"
              }, {
                address = "0x0",
                is = "int",
                name = "neverAgainstUnits",
                offset = 1,
                size = 2,
                type = "word",
                unsigned = true,
                what = "bitfield"
              } },
            is = "struct",
            metaName = "ProjectileMaterialResponsePotentialFlags",
            name = "potentialFlags",
            offset = 38,
            size = 2,
            type = "ProjectileMaterialResponsePotentialFlags",
            what = "field"
          }, {
            address = "0x28",
            is = "float",
            name = "potentialSkipFraction",
            offset = 40,
            size = 4,
            type = "float",
            what = "field"
          }, {
            address = "0x2c",
            count = 2,
            elementSize = 4,
            elementType = "float",
            is = "array",
            name = "potentialBetween",
            offset = 44,
            size = 8,
            what = "field"
          }, {
            address = "0x34",
            count = 2,
            elementSize = 4,
            elementType = "float",
            is = "array",
            name = "potentialAnd",
            offset = 52,
            size = 8,
            what = "field"
          }, {
            address = "0x3c",
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
            name = "potentialEffect",
            offset = 60,
            size = 16,
            type = "TagReference",
            what = "field"
          }, {
            address = "0x4c",
            count = 16,
            elementSize = 1,
            elementType = "char",
            is = "array",
            name = "pad2918",
            offset = 76,
            size = 16,
            what = "field"
          }, {
            address = "0x5c",
            is = "int",
            metaName = "ProjectileScaleEffectsBy",
            name = "scaleEffectsBy",
            offset = 92,
            size = 2,
            type = "short",
            what = "field"
          }, {
            address = "0x5e",
            count = 2,
            elementSize = 1,
            elementType = "char",
            is = "array",
            name = "pad2988",
            offset = 94,
            size = 2,
            what = "field"
          }, {
            address = "0x60",
            is = "float",
            name = "angularNoise",
            offset = 96,
            size = 4,
            type = "float",
            what = "field"
          }, {
            address = "0x64",
            is = "float",
            name = "velocityNoise",
            offset = 100,
            size = 4,
            type = "float",
            what = "field"
          }, {
            address = "0x68",
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
            name = "detonationEffect",
            offset = 104,
            size = 16,
            type = "TagReference",
            what = "field"
          }, {
            address = "0x78",
            count = 24,
            elementSize = 1,
            elementType = "char",
            is = "array",
            name = "pad3097",
            offset = 120,
            size = 24,
            what = "field"
          }, {
            address = "0x90",
            is = "float",
            name = "initialFriction",
            offset = 144,
            size = 4,
            type = "float",
            what = "field"
          }, {
            address = "0x94",
            is = "float",
            name = "maximumDistance",
            offset = 148,
            size = 4,
            type = "float",
            what = "field"
          }, {
            address = "0x98",
            is = "float",
            name = "parallelFriction",
            offset = 152,
            size = 4,
            type = "float",
            what = "field"
          }, {
            address = "0x9c",
            is = "float",
            name = "perpendicularFriction",
            offset = 156,
            size = 4,
            type = "float",
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
    name = "materialResponse",
    offset = 576,
    size = 12,
    what = "field"
  } }
