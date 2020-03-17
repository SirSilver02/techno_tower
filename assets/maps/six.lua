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
  nextobjectid = 53,
  properties = {
    ["on_enter"] = "local state=  states.get_state(\"game\")\nlocal label = state.message_label\nlocal message=  \"Be the circle\"\n\nlabel:set_text(message)\n\nstate.timer:after(5, function()\n        label:set_text(\"\")\nend)"
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
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
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
          x = 256,
          y = 320,
          width = 32,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "",
          type = "kill_ball",
          shape = "rectangle",
          x = 352,
          y = 320,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["path"] = "42",
            ["speed"] = 24
          }
        },
        {
          id = 9,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 224,
          y = 448,
          width = 576,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 13,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 224,
          y = 288,
          width = 576,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 14,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 224,
          y = 320,
          width = 32,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 27,
          name = "",
          type = "wall",
          shape = "rectangle",
          x = 768,
          y = 320,
          width = 32,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 28,
          name = "",
          type = "exit",
          shape = "rectangle",
          x = 736,
          y = 320,
          width = 32,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {
            ["map_name"] = "seven"
          }
        },
        {
          id = 33,
          name = "",
          type = "kill_ball",
          shape = "rectangle",
          x = 384,
          y = 416,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["path"] = "44",
            ["speed"] = 24
          }
        },
        {
          id = 34,
          name = "",
          type = "kill_ball",
          shape = "rectangle",
          x = 416,
          y = 320,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["path"] = "45",
            ["speed"] = 24
          }
        },
        {
          id = 35,
          name = "",
          type = "kill_ball",
          shape = "rectangle",
          x = 448,
          y = 416,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["path"] = "46",
            ["speed"] = 24
          }
        },
        {
          id = 36,
          name = "",
          type = "kill_ball",
          shape = "rectangle",
          x = 480,
          y = 320,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["path"] = "47",
            ["speed"] = 24
          }
        },
        {
          id = 37,
          name = "",
          type = "kill_ball",
          shape = "rectangle",
          x = 512,
          y = 416,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["path"] = "48",
            ["speed"] = 24
          }
        },
        {
          id = 38,
          name = "",
          type = "kill_ball",
          shape = "rectangle",
          x = 544,
          y = 320,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["path"] = "49",
            ["speed"] = 24
          }
        },
        {
          id = 39,
          name = "",
          type = "kill_ball",
          shape = "rectangle",
          x = 576,
          y = 416,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["path"] = "50",
            ["speed"] = 24
          }
        },
        {
          id = 40,
          name = "",
          type = "kill_ball",
          shape = "rectangle",
          x = 608,
          y = 320,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["path"] = "51",
            ["speed"] = 24
          }
        },
        {
          id = 41,
          name = "",
          type = "kill_ball",
          shape = "rectangle",
          x = 640,
          y = 416,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["path"] = "52",
            ["speed"] = 24
          }
        },
        {
          id = 42,
          name = "",
          type = "kill_ball_node",
          shape = "rectangle",
          x = 352,
          y = 416,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 44,
          name = "",
          type = "kill_ball_node",
          shape = "rectangle",
          x = 384,
          y = 320,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 45,
          name = "",
          type = "kill_ball_node",
          shape = "rectangle",
          x = 416,
          y = 416,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 46,
          name = "",
          type = "kill_ball_node",
          shape = "rectangle",
          x = 448,
          y = 320,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 47,
          name = "",
          type = "kill_ball_node",
          shape = "rectangle",
          x = 480,
          y = 416,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 48,
          name = "",
          type = "kill_ball_node",
          shape = "rectangle",
          x = 512,
          y = 320,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 49,
          name = "",
          type = "kill_ball_node",
          shape = "rectangle",
          x = 544,
          y = 416,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 50,
          name = "",
          type = "kill_ball_node",
          shape = "rectangle",
          x = 576,
          y = 320,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 51,
          name = "",
          type = "kill_ball_node",
          shape = "rectangle",
          x = 608,
          y = 416,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 52,
          name = "",
          type = "kill_ball_node",
          shape = "rectangle",
          x = 640,
          y = 320,
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
