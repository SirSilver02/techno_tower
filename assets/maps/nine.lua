return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "1.1.4",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 32,
  height = 24,
  tilewidth = 32,
  tileheight = 32,
  nextobjectid = 103,
  properties = {
    ["on_enter"] = "local state=  states.get_state(\"game\")\nlocal label = state.message_label\nlocal message=  \"Yes. Yes it does.\"\n\nlabel:set_text(message)\n\nstate.timer:after(5, function()\n        label:set_text(\"\")\nend)"
  },
  tilesets = {
    {
      name = "blue",
      firstgid = 1,
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      image = "assets/graphics/blue.png",
      imagewidth = 32,
      imageheight = 32,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 32,
        height = 32
      },
      properties = {},
      terrains = {},
      tilecount = 1,
      tiles = {}
    },
    {
      name = "white",
      firstgid = 2,
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      image = "assets/graphics/white.png",
      imagewidth = 32,
      imageheight = 32,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 32,
        height = 32
      },
      properties = {},
      terrains = {},
      tilecount = 1,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "floor",
      x = 0,
      y = 0,
      width = 32,
      height = 24,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 2, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 2, 1, 2, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
      }
    },
    {
      type = "objectgroup",
      name = "entities",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 1,
          name = "",
          type = "spawn",
          shape = "rectangle",
          x = 288,
          y = 384,
          width = 32,
          height = 96,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "",
          type = "kill_ball",
          shape = "rectangle",
          x = 352,
          y = 448,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["path"] = "50",
            ["speed"] = 12
          }
        },
        {
          id = 13,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 256,
          y = 352,
          width = 128,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 15,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 480,
          y = 352,
          width = 32,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 18,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 256,
          y = 384,
          width = 32,
          height = 96,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 19,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 352,
          y = 256,
          width = 32,
          height = 96,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 21,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 352,
          y = 224,
          width = 288,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 22,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 608,
          y = 256,
          width = 32,
          height = 96,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 25,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 256,
          y = 480,
          width = 480,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 27,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 608,
          y = 352,
          width = 128,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 44,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 704,
          y = 384,
          width = 32,
          height = 96,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 47,
          name = "",
          type = "exit",
          shape = "rectangle",
          x = 672,
          y = 384,
          width = 32,
          height = 96,
          rotation = 0,
          visible = true,
          properties = {
            ["map_name"] = "ten"
          }
        },
        {
          id = 50,
          name = "",
          type = "kill_ball_node",
          shape = "rectangle",
          x = 352,
          y = 384,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 68,
          name = "",
          type = "kill_ball",
          shape = "rectangle",
          x = 384,
          y = 384,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["path"] = "75",
            ["speed"] = 12
          }
        },
        {
          id = 69,
          name = "",
          type = "kill_ball",
          shape = "rectangle",
          x = 416,
          y = 448,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["path"] = "76",
            ["speed"] = 12
          }
        },
        {
          id = 70,
          name = "",
          type = "kill_ball",
          shape = "rectangle",
          x = 448,
          y = 384,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["path"] = "77",
            ["speed"] = 12
          }
        },
        {
          id = 71,
          name = "",
          type = "kill_ball",
          shape = "rectangle",
          x = 384,
          y = 352,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["path"] = "78",
            ["speed"] = 12
          }
        },
        {
          id = 72,
          name = "",
          type = "kill_ball",
          shape = "rectangle",
          x = 448,
          y = 320,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["path"] = "80",
            ["speed"] = 12
          }
        },
        {
          id = 75,
          name = "",
          type = "kill_ball_node",
          shape = "rectangle",
          x = 384,
          y = 448,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 76,
          name = "",
          type = "kill_ball_node",
          shape = "rectangle",
          x = 416,
          y = 384,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 77,
          name = "",
          type = "kill_ball_node",
          shape = "rectangle",
          x = 448,
          y = 448,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 78,
          name = "",
          type = "kill_ball_node",
          shape = "rectangle",
          x = 448,
          y = 352,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 80,
          name = "",
          type = "kill_ball_node",
          shape = "rectangle",
          x = 448,
          y = 256,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 83,
          name = "",
          type = "kill_ball",
          shape = "rectangle",
          x = 480,
          y = 256,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["path"] = "85",
            ["speed"] = 12
          }
        },
        {
          id = 84,
          name = "",
          type = "kill_ball",
          shape = "rectangle",
          x = 512,
          y = 320,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["path"] = "86",
            ["speed"] = 12
          }
        },
        {
          id = 85,
          name = "",
          type = "kill_ball_node",
          shape = "rectangle",
          x = 480,
          y = 320,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 86,
          name = "",
          type = "kill_ball_node",
          shape = "rectangle",
          x = 512,
          y = 256,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 87,
          name = "",
          type = "kill_ball",
          shape = "rectangle",
          x = 576,
          y = 352,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["path"] = "88",
            ["speed"] = 12
          }
        },
        {
          id = 88,
          name = "",
          type = "kill_ball_node",
          shape = "rectangle",
          x = 512,
          y = 352,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 89,
          name = "",
          type = "kill_ball",
          shape = "rectangle",
          x = 512,
          y = 384,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["path"] = "93",
            ["speed"] = 12
          }
        },
        {
          id = 90,
          name = "",
          type = "kill_ball",
          shape = "rectangle",
          x = 544,
          y = 448,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["path"] = "94",
            ["speed"] = 12
          }
        },
        {
          id = 91,
          name = "",
          type = "kill_ball",
          shape = "rectangle",
          x = 576,
          y = 384,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["path"] = "95",
            ["speed"] = 12
          }
        },
        {
          id = 92,
          name = "",
          type = "kill_ball",
          shape = "rectangle",
          x = 608,
          y = 448,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["path"] = "96",
            ["speed"] = 12
          }
        },
        {
          id = 93,
          name = "",
          type = "kill_ball_node",
          shape = "rectangle",
          x = 512,
          y = 448,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 94,
          name = "",
          type = "kill_ball_node",
          shape = "rectangle",
          x = 544,
          y = 384,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 95,
          name = "",
          type = "kill_ball_node",
          shape = "rectangle",
          x = 576,
          y = 448,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 96,
          name = "",
          type = "kill_ball_node",
          shape = "rectangle",
          x = 608,
          y = 384,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 98,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 384,
          y = 256,
          width = 64,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 99,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 544,
          y = 256,
          width = 64,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 100,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 384,
          y = 288,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 101,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 576,
          y = 288,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
