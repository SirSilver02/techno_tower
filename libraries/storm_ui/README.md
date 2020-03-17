# Storm_UI
### A UI system for Love2D, inspired by Garry's Mod's Derma.
![Image](https://media.giphy.com/media/3o6nUKWBZhIfHKXcXu/giphy.gif)


## Beginner's Guide
* [Getting Started](#getting-started)
    * [License](#license)
    * [Installation](#installation)
* [The Elements](#the-elements)
    * [Panel](#panel)
    * [Label](#label)
    
# Getting Started

## License
Storm_UI uses the [MIT license](https://github.com/Warlik50/Storm_UI/blob/master/LICENSE).
## Installation
How to download, and require the library.
# The Elements

## Panel
Panels are the building blocks of ui elements. To create a panel, we can use the following code:
```lua
function state:on_first_enter()
    local button = self.ui_manager:add("button")
end
```
## Label
Labels are panels that display text. To create a label that says "hello world", we can use the following code:
```lua
function state:on_first_enter()
    local label = self.ui_manager:add("label")
    label:set_text("hello world")
end
```
