local RichTextFuncs = {}

local ELEMENT_TAGS = {
    ['Font'] = 'font',
    Stroke = 'stroke',
    Bold = 'b',
    Italic = 'i',
    Underline = 'u',
    Strikethrough = 's',
    Uppercase = 'uc',
    SmallCaps = 'sc'
}

local ATTRIBUTE_TAGS = {
    Color = 'color',
    Size = 'size',
    Face = 'face',
    Family = 'family',
    Weight = 'weight',
    Transparency = 'transparency',
    Joins = 'joins',
    Thickness = 'thickness'
}



function RichTextFuncs:Compile()
    local text = self.BaseText
    
    for el_name, val in self do
        local tag = ELEMENT_TAGS[el_name]
        if tag == nil then continue end
        
        local opening_tag = tag
        if type(val) == 'table' then
            if next(val) == nil then continue end
            
            for attr_name, attr_val in val do
                local attr_tag = ATTRIBUTE_TAGS[attr_name]
                if attr_tag == nil then continue end
                
                local attr_val_str = ''
                if typeof(attr_val) == 'Color3' then
                    attr_val_str = 'rgb('..tostring(math.round(attr_val.R * 255))..','..tostring(math.round(attr_val.G * 255))..','..tostring(math.round(attr_val.B * 255))..')'
                else
                    attr_val_str = tostring(attr_val)
                end
                
                opening_tag ..= ' '..attr_tag..'="'..attr_val_str..'"'
            end
            
        elseif val == false then
            continue 
        end
        
        text = '<'..opening_tag..'>' .. text .. '</'..tag..'>'
    end
    
    return text
end


function RichTextFuncs:SetFontColor(color: Color3?)
    self.Font.Color = color
    return self
end

function RichTextFuncs:SetFontSize(size: number?)
    self.Font.Size = size
    return self
end

function RichTextFuncs:SetFontFace(face: string?)
    self.Font.Face = face
    return self
end

function RichTextFuncs:SetFontFamily(family: string?)
    self.Font.Family = family
    return self
end

function RichTextFuncs:SetFontWeight(weight: string? | number?)
    self.Font.Weight = weight
    return self
end

function RichTextFuncs:SetFontTransparency(transparency: number?)
    self.Font.Transparency = transparency
    return self
end

function RichTextFuncs:SetStrokeColor(color: Color3?)
    self.Stroke.Color = color
    return self
end

function RichTextFuncs:SetStrokeJoins(joins: string?)
    self.Stroke.Joins = joins
    return self
end

function RichTextFuncs:SetStrokeThickness(thickness: number?)
    self.Stroke.Thickness = thickness
    return self
end

function RichTextFuncs:SetStrokeTransparency(transparency: number?)
    self.Stroke.Transparency = transparency
    return self
end

function RichTextFuncs:SetBold(val: boolean?)
    self.Bold = val or true
    return self
end

function RichTextFuncs:SetItalic(val: boolean?)
    self.Italic = val or true
    return self
end

function RichTextFuncs:SetUnderline(val: boolean?)
    self.Underline = val or true
    return self
end

function RichTextFuncs:SetStrikethrough(val: boolean?)
    self.Strikethrough = val or true
    return self
end

function RichTextFuncs:SetUppercase(val: boolean?)
    self.Uppercase = val or true
    return self
end

function RichTextFuncs:SetSmallCaps(val: boolean?)
    self.SmallCaps = val or true
    return self
end


local RichText = {}

RichText.LineBreak = '<br />'
RichText.LessThan = '&lt;'
RichText.GreaterThan = '&gt;'
RichText.Quote = '&quot;'
RichText.Apostrophe = '&apos;'
RichText.Ampersand = '&amp;'


function RichText.new(text: string?)
    local this = {}
    
    this.BaseText = text or ''
    
    this.Font = {
        Color = nil :: Color3?,
        Size = nil :: number?,
        Face = nil :: string?,
        Family = nil :: string?,
        Weight = nil :: string? | number?,
        Transparency = nil :: number?
    }
    
    this.Stroke = {
        Color = nil :: Color3?,
        Joins = nil :: string?,
        Thickness = nil :: number?,
        Transparency = nil :: number?
    }
    
    this.Bold = false
    this.Italic = false
    this.Underline = false
    this.Strikethrough = false
    this.Uppercase = false
    this.SmallCaps = false
    
    
    return setmetatable(this, {
        __index = RichTextFuncs,
        __tostring = RichTextFuncs.Compile
    })
end

return RichText
