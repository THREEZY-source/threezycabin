--[[
Script Auto Farm Roblox untuk Exploit (Xeno)
Dibuat berdasarkan permintaan. PERHATIAN: Penggunaan exploit dapat melanggar TOS Roblox dan berisiko terkena banned. Gunakan dengan tanggung jawab sendiri.
]]

local gui_nama = "Auto Farm Script"
local tombol_auto_farm_text = "AUTO FARM"
local key_spam = "f"
local auto_farm_aktif = false
local show_click_f_event_name = "ShowClickFEvent" -- Ganti dengan nama RemoteEvent yang benar!

-- Fungsi untuk membuat GUI (Tabel)
local function buatGUI()
  local screenGui = Instance.new("ScreenGui")
  screenGui.Name = gui_nama
  screenGui.Parent = game.CoreGui

  local frame = Instance.new("Frame")
  frame.Size = UDim2.new(0, 200, 0, 100)
  frame.Position = UDim2.new(0.05, 0, 0.05, 0) -- Posisi di kiri atas
  frame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
  frame.Parent = screenGui

  local title = Instance.new("TextLabel")
  title.Size = UDim2.new(1, 0, 0.3, 0)
  title.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
  title.TextColor3 = Color3.new(1, 1, 1)
  title.Text = gui_nama
  title.Font = Enum.Font.SourceSansBold
  title.TextScaled = true
  title.Parent = frame

  local autoFarmButton = Instance.new("TextButton")
  autoFarmButton.Size = UDim2.new(0.8, 0, 0.4, 0)
  autoFarmButton.Position = UDim2.new(0.1, 0, 0.3, 0)
  autoFarmButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
  autoFarmButton.TextColor3 = Color3.new(1, 1, 1)
  autoFarmButton.Text = tombol_auto_farm_text
  autoFarmButton.Font = Enum.Font.SourceSansBold
  autoFarmButton.TextScaled = true
  autoFarmButton.Parent = frame

  autoFarmButton.MouseButton1Click:Connect(function()
    auto_farm_aktif = not auto_farm_aktif
    if auto_farm_aktif then
      autoFarmButton.Text = "AUTO FARM (ON)"
    else
      autoFarmButton.Text = tombol_auto_farm_text
    end
  end)

  return screenGui
end

-- Fungsi untuk melakukan spam tombol
local function spamKey(key, duration)
  local UserInputService = game:GetService("UserInputService")
  if not UserInputService then
    warn("AutoFarm: UserInputService tidak tersedia!")
    return
  end

  local endTime = time() + duration
  local keyCode = Enum.KeyCode[string.upper(key)]
  if not keyCode then
    warn("AutoFarm: Keycode invalid: " .. key)
    return
  end

  --print("AutoFarm: Memulai spam tombol " .. key) --Jangan terlalu sering print
  while time() < endTime do
    UserInputService:SimulateKeyStroke(keyCode, true)
    task.wait(0.05)
    UserInputService:SimulateKeyStroke(keyCode, false)
    task.wait(0.05)
  end
  --print("AutoFarm: Selesai spam tombol " .. key) --Jangan terlalu sering print
end

-- Fungsi untuk meng-override RemoteEvent (SANGAT BERISIKO)
local function overrideRemoteEvent()
  local ReplicatedStorage = game:GetService("ReplicatedStorage")
  local ShowClickFEvent = ReplicatedStorage:WaitForChild(show_click_f_event_name)

  if not ShowClickFEvent then
    warn("AutoFarm: RemoteEvent '" .. show_click_f_event_name .. "' tidak ditemukan!")
    return
  end

  local oldFireClient = ShowClickFEvent.FireClient
  ShowClickFEvent.FireClient = function(self, player, ...)
    print("AutoFarm: RemoteEvent '" .. show_click_f_event_name .. "' di-fire ke player!")
    spamKey(string.upper(key_spam), 2) -- Spam selama 2 detik (sesuaikan)

    return oldFireClient(self, player, ...)
  end

  print("AutoFarm: RemoteEvent '" .. show_click_f_event_name .. "' berhasil di-override (BERISIKO!)")
end

-- Inisialisasi GUI
buatGUI()
print("AutoFarm: Script diinisialisasi")

-- Override RemoteEvent saat script dijalankan
overrideRemoteEvent()
