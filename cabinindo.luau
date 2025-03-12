--[[
Script Auto Farm Roblox untuk Exploit (Xeno)
Dibuat berdasarkan permintaan. PERHATIAN: Penggunaan exploit dapat melanggar TOS Roblox dan berisiko terkena banned. Gunakan dengan tanggung jawab sendiri.
]]

local gui_nama = "Auto Farm Script"
local tombol_auto_farm_text = "AUTO FARM"
local delay_click = 1.3
local jeda_sebelum_spam = 17
local durasi_spam = 10
local key_spam = "f"
local key_interact = "e"
local auto_farm_aktif = false

-- Fungsi untuk membuat GUI (Tabel)
local function buatGUI()
  local screenGui = Instance.new("ScreenGui")
  screenGui.Name = gui_nama
  screenGui.Parent = game.CoreGui

  local frame = Instance.new("Frame")
  frame.Size = UDim2.new(0, 200, 0, 150)
  frame.Position = UDim2.new(0.05, 0, 0.05, 0) -- Posisi di kiri atas
  frame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
  frame.Parent = screenGui

  local title = Instance.new("TextLabel")
  title.Size = UDim2.new(1, 0, 0.2, 0)
  title.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
  title.TextColor3 = Color3.new(1, 1, 1)
  title.Text = gui_nama
  title.Font = Enum.Font.SourceSansBold
  title.TextScaled = true
  title.Parent = frame

  local autoFarmButton = Instance.new("TextButton")
  autoFarmButton.Size = UDim2.new(0.8, 0, 0.3, 0)
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
      -- Jalankan auto farm di thread terpisah
      task.spawn(function()
        while auto_farm_aktif do
          autoFarm()
          task.wait() -- Hindari infinite loop yang membebani
        end
        autoFarmButton.Text = tombol_auto_farm_text
      end)
    else
      autoFarmButton.Text = tombol_auto_farm_text
    end
  end)

  return screenGui
end

-- Fungsi untuk melakukan klik (simulasi)
local function simulateClick()
  local UserInputService = game:GetService("UserInputService")
  UserInputService:MouseButton1Down(Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2)) -- Klik tengah layar
  task.wait(delay_click)
  UserInputService:MouseButton1Up(Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2))
end

-- Fungsi untuk melakukan spam tombol
local function spamKey(key, duration)
  local UserInputService = game:GetService("UserInputService")
  local endTime = time() + duration
  while time() < endTime do
    UserInputService:SimulateKeyStroke(Enum.KeyCode[key], true)
    task.wait(0.05) -- Sesuaikan delay jika perlu
    UserInputService:SimulateKeyStroke(Enum.KeyCode[key], false)
    task.wait(0.05)
  end
end

-- Fungsi utama auto farm
local function autoFarm()
  simulateClick()
  task.wait(jeda_sebelum_spam)
  spamKey(string.upper(key_spam), durasi_spam) -- Konversi ke uppercase untuk Enum.KeyCode
  local UserInputService = game:GetService("UserInputService")
  UserInputService:SimulateKeyStroke(Enum.KeyCode[string.upper(key_interact)], true)
  task.wait(0.1)
  UserInputService:SimulateKeyStroke(Enum.KeyCode[string.upper(key_interact)], false)
end

-- Inisialisasi GUI
buatGUI()
