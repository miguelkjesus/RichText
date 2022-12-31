# Rich Text

A module I made since I couldn't be bothered to remember the syntax of Rich Text, so I abstracted it into this.

## How to use:

So, say I wanted to make a pop-up showing how many gems I just collected, like this:

![image](https://user-images.githubusercontent.com/95715385/210150611-972c1928-6b3b-4c3e-a232-67dc11e9bec7.png)

Here's a few ways to do it using this module.


### Method 1: Properties/Attributes

```lua
local GemPopUpLabel = -- Text label here. Make sure it has Rich Text Enabled!
local gems = 25

local gemText = RichText.new(tostring(gems) .. ' gems!')
gemText.Stroke = {
    Thickness = 1,
    Transparency = 0.25,
    Color = Color3.fromRGB(0, 162, 255)
}
gemText.Bold = true

GemPopUpLabel.Text = 'You recieved ' .. tostring(gemText)
```
Breakdown:

1.  First we create our RichText object, with the text we want configured.
    ```lua
    local gemText = RichText.new(tostring(gems) .. ' gems!')
    ```

2.  Next, we configure our object, since without any configuration, it is not much better than a plain string.
    ```lua
    gemText.Stroke = {
        Thickness = 1,
        Transparency = 0.25,
        Color = Color3.fromRGB(0, 162, 255)
    }
    gemText.Bold = true
    ```
3.  Finally, we perform `tostring(...)` on our RichText object. This is very important since this compiles the object into a string that can actually be used in rich text enabled text labels/buttons. (You could also apply the `:ToString()` method to the obejct like I show in the next example.) Then we concatenate this to the rest of the string that we want outputted, and set the pop-up's text to this string.
    ```lua
    GemPopUpLabel.Text = 'You recieved ' .. tostring(gemText)
    ```

### Method 2: Method Chaining

```lua
local GemPopUpLabel = -- Text label here. Make sure it has Rich Text Enabled!
local gems = 25

GemPopUpLabel.Text = 'You recieved '
    .. RichText.new(tostring(gems) .. ' gems!')
        :SetStroke{
            Thickness = 1,
            Transparency = 0.25,
            Color = Color3.fromRGB(0, 162, 255),
            Joins = 'miter'
        }
        :SetBold()
        :ToString() -- This last bit is very important!
```

Breakdown:

1.  First we concatenate (add) our new RichText object to `'You recieved'`.
    ```lua
    GemPopUpLabel.Text = 'You recieved '
        .. RichText.new(tostring(gems) .. ' gems!')
    ```

2.  Next, we actually configure our RichText object. If we just leave it as `RichText.new(...)`, this is not much better than just using a string. Here we set various styles to our object through a method called "method chaining". Unshortened, this is analagous to `RichText.new(...):SetStroke{...}:SetBold()`, however I have put them on seperate lines for clarity.
    ```lua
        .. RichText.new(tostring(gems) .. ' gems!')
            :SetStroke{
                Thickness = 1,
                Transparency = 0.25,
                Color = Color3.fromRGB(0, 162, 255),
                Joins = 'miter'
            }
            :SetBold()
    ```

3.  Finally we put the `:ToString()` at the end. This compiles the actual RichText object into a string that can be fed into a Rich Text enabled text label/button. This also works equally as well like `tostring(RichText.new(...))` like I showed in the first method, however, doing `:ToString()` can look nicer in my opinion.
    ```lua 
            :ToString() -- This last bit is very important!
    ```

## Other info:

For a list of all the chain methods that you can use, just refer to the source code, because I'm frankly not bothered to provide a full API. They're all in a massive block and all begin with `RichTextFuncs:Set` so they're pretty hard to miss. They all have equivalent usage as well apart from a few exceptions that I will show here:

`SetFont{...}` and `SetStroke{...}` set the actual tables of `RichText.Font` and `RichText.Stroke` to the input. Example:
```lua
RichText.new():SetFont{
    Size = 15,
    Transparency = 0.75
}
```

For the rest (`SetBold(...)`, `SetItalic(...)`, etc.), if the arguments are left blank, it will always default to `true`.
