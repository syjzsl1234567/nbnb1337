local Players,UserInputService=game:GetService("Players"),game:GetService("UserInputService")
local lp,CoreGui=Players.LocalPlayer,game:GetService("CoreGui")
local function Dec(s)local r=""for i=1,#s do r..=string.char(string.byte(s,i)-2)end return r end
local EncKey="PD3559"
local CorrectKey=Dec(EncKey)
local Unlocked,GuiVis,Minimized=false,true,false
local sg=Instance.new("ScreenGui")
sg.ResetOnSpawn=false
sg.IgnoreGuiInset=true --手机顶部状态栏偏移修复
sg.Parent=CoreGui

local win=Instance.new("Frame")
win.Size=UDim2.new(0,280,0,180)
win.Position=UDim2.new(0.02,0,0.2,0)
win.BackgroundColor3=Color3.new(0.08,0.08,0.11)
win.BackgroundTransparency=0.3
win.BorderSizePixel=0
Instance.new("UICorner",win).CornerRadius=UDim.new(0,18)

local title=Instance.new("Frame")
title.Size=UDim2.new(1,0,0,40)
title.BackgroundColor3=Color3.new(0.4,0.4,0.46)
title.BackgroundTransparency=0.3
title.BorderSizePixel=0
Instance.new("UICorner",title).CornerRadius=UDim.new(0,18)
title.Parent=win

local titleTxt=Instance.new("TextLabel")
titleTxt.Size=UDim2.new(0.7,0,1,0)
titleTxt.Position=UDim2.new(0,10,0,0)
titleTxt.BackgroundTransparency=1
titleTxt.Text="传送工具"
titleTxt.TextColor3=Color3.new(1,1,1)
titleTxt.Font=Enum.Font.SourceSansBold
titleTxt.TextSize=17
titleTxt.Parent=title

local minBtn=Instance.new("TextButton")
minBtn.Size=UDim2.new(0,34,0,34)
minBtn.Position=UDim2.new(1,-42,0,3)
minBtn.BackgroundColor3=Color3.new(0.5,0.5,0.56)
minBtn.BackgroundTransparency=0.3
minBtn.Text="-"
minBtn.TextColor3=Color3.new(1,1,1)
minBtn.Font=Enum.Font.SourceSansBold
minBtn.TextSize=20
minBtn.BorderSizePixel=0
Instance.new("UICorner",minBtn).CornerRadius=UDim.new(0,12)
minBtn.Parent=title

local keyBox=Instance.new("t.me/NB1337JB")
keyBox.Size=UDim2.new(0.86,0,0,36)
keyBox.Position=UDim2.new(0.07,0,0.30,0)
keyBox.BackgroundColor3=Color3.new(0.22,0.22,0.28)
keyBox.BackgroundTransparency=0.3
keyBox.PlaceholderText="输入卡密"
keyBox.TextColor3=Color3.new(1,1,1)
keyBox.BorderSizePixel=0
Instance.new("UICorner",keyBox).CornerRadius=UDim.new(0,12)
keyBox.Parent=win

local verifyBtn=Instance.new("TextButton")
verifyBtn.Size=UDim2.new(0.86,0,0,36)
verifyBtn.Position=UDim2.new(0.07,0,0.56,0)
verifyBtn.BackgroundColor3=Color3.new(0.26,0.4,0.6)
verifyBtn.BackgroundTransparency=0.3
verifyBtn.Text="解锁"
verifyBtn.TextColor3=Color3.new(1,1,1)
verifyBtn.Font=Enum.Font.SourceSansBold
verifyBtn.BorderSizePixel=0
Instance.new("UICorner",verifyBtn).CornerRadius=UDim.new(0,12)
verifyBtn.Parent=win

local tip=Instance.new("TextLabel")
tip.Size=UDim2.new(1,0,0,20)
tip.Position=UDim2.new(0,0,0.84,0)
tip.BackgroundTransparency=1
tip.TextColor3=Color3.new(1,0.45,0.45)
tip.TextSize=12
tip.Parent=win
win.Parent=sg

--手机触屏拖动核心代码
local drag,startTouch,startWinPos=false
title.InputBegan:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.Touch and input.Position then
        drag=true
        startTouch=input.Position
        startWinPos=win.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if drag and input.UserInputType==Enum.UserInputType.Touch then
        local delta=input.Position-startTouch
        win.Position=UDim2.new(startWinPos.X.Scale,startWinPos.X.Offset+delta.X,startWinPos.Y.Scale,startWinPos.Y.Offset+delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.Touch then drag=false end
end)

local fullSize,miniSize=UDim2.new(0,280,0,340),UDim2.new(0,280,0,40)
minBtn.MouseButton1Click:Connect(function()
    Minimized=not Minimized
    if Minimized then
        win.Size=miniSize
        keyBox.Visible=false verifyBtn.Visible=false tip.Visible=false minBtn.Text="+"
    else
        win.Size=Unlocked and fullSize or UDim2.new(0,280,0,180)
        keyBox.Visible=not Unlocked verifyBtn.Visible=not Unlocked tip.Visible=true minBtn.Text="-"
    end
end)

UserInputService.InputBegan:Connect(function(i,gpe)
    if gpe then return end
    if i.KeyCode==Enum.KeyCode.Insert then GuiVis=not GuiVis win.Visible=GuiVis end
end)

local function Tele(plr)
    local c=lp.Character local tc=plr.Character
    if not c or not tc then tip.Text="模型未加载" task.wait(1.2) tip.Text="" return end
    local r=c:FindFirstChild("HumanoidRootPart") local tr=tc:FindFirstChild("HumanoidRootPart")
    if not r or not tr then return end
    c:PivotTo(tr.CFrame+Vector3.new(0,3,0))
    tip.Text="传送成功" task.wait(1.2) tip.Text=""
end

local function Refresh(list,layout)
    for _,v in pairs(list:GetChildren())do if v:IsA("TextButton")then v:Destroy()end end
    for _,p in ipairs(Players:GetPlayers())do
        if p~=lp then
            local btn=Instance.new("TextButton")
            btn.Size=UDim2.new(1,0,0,34) --手机加高按钮，手指好点
            btn.BackgroundColor3=Color3.new(0.21,0.21,0.27)
            btn.BackgroundTransparency=0.3
            btn.BorderSizePixel=0
            btn.Text=p.Name btn.TextColor3=Color3.new(1,1,1)
            btn.TextSize=14
            Instance.new("UICorner",btn).CornerRadius=UDim.new(0,10)
            btn.MouseButton1Click:Connect(function()Tele(p)end)
            btn.Parent=list
        end
    end
    list.CanvasSize=UDim2.new(0,0,0,layout.AbsoluteContentSize.Y)
end

verifyBtn.MouseButton1Click:Connect(function()
    if Unlocked then return end
    if keyBox.Text==CorrectKey then
        Unlocked=true tip.Text="解锁成功"
        titleTxt.Text="玩家传送TG@NB1337JB"
        win.Size=fullSize
        keyBox:Destroy() verifyBtn:Destroy()
        local scroll=Instance.new("ScrollingFrame")
        scroll.Size=UDim2.new(1,-12,1,-48)
        scroll.Position=UDim2.new(0,6,0,44)
        scroll.BackgroundTransparency=1 scroll.BorderSizePixel=0 scroll.ScrollBarThickness=4
        local layout=Instance.new("UIListLayout") layout.Padding=UDim.new(0,5) layout.Parent=scroll
        scroll.Parent=win
        Players.PlayerAdded:Connect(function()Refresh(scroll,layout)end)
        Players.PlayerRemoving:Connect(function()Refresh(scroll,layout)end)
        task.wait(0.4) Refresh(scroll,layout)
    else
        tip.Text="卡密错误" task.wait(1.2) tip.Text=""
    end
end)