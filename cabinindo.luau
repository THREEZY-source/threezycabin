--[[
Script Auto Farm Roblox untuk Exploit (Xeno)
Dibuat berdasarkan permintaan. PERHATIAN: Penggunaan exploit dapat melanggar TOS Roblox dan berisiko terkena banned. Gunakan dengan tanggung jawab sendiri.
]]

local gui_nama = "Auto Farm Script"
local tombol_auto_farm_text = "AUTO FARM"
local key_spam = "f"
local auto_farm_aktif = false

-- Konfigurasi Deteksi Gambar (SANGAT PENTING UNTUK DISESUAIKAN)
local koordinat_piksel = {
  { x = 500, y = 300 },  -- Ganti dengan koordinat piksel di sekitar gambar
  { x = 550, y = 300 },
  { x = 525, y = 325 },
}
local warna_target = {
  Color3.new(1, 1, 1),   -- Ganti dengan warna yang diharapkan pada piksel tersebut
  Color3.new(1, 1, 1),
  Color3.new(1, 1, 1),
}
local toleransi_warna = 0.1      -- Seberapa dekat warna harus cocok (0.0 - 1.0)
local durasi_spam = 5             -- Berapa lama spam tombol "F" (detik)

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
      task.spawn(function()
        while auto_farm_aktif do
          if gambarTerdeteksi() then
            print("AutoFarm: Gambar terdeteksi! Spamming F")
            spamKey(string.upper(key_spam), durasi_spam)
            task.wait(1)  -- Jeda sebentar setelah spam
          else
            --print("AutoFarm: Gambar tidak terdeteksi.")
            task.wait(0.1)
          end
        end
        autoFarmButton.Text = tombol_auto_farm_text
      end)
    else
      autoFarmButton.Text = tombol_auto_farm_text
    end
  end)

  return screenGui
end

-- Fungsi untuk mengambil warna piksel (Mungkin Tidak Berfungsi)
local function ambilWarnaPiksel(x, y)
  -- Exploit-specific code diperlukan di sini untuk mengambil warna piksel
  -- Ini adalah bagian yang PALING SULIT dan mungkin tidak mungkin
  -- Beberapa exploit memiliki fungsi untuk membaca memori game atau menggunakan API Windows
  -- Contoh PALSU:
  -- local warna = exploit.ambilWarna(x, y)
  -- return warna
  -- Jika tidak ada cara untuk mengambil warna piksel, fungsi ini harus selalu mengembalikan warna default
  return Color3.new(0, 0, 0) -- Warna default (hitam)
end

-- Fungsi untuk memeriksa apakah gambar terdeteksi
local function gambarTerdeteksi()
  for i, koordinat in ipairs(koordinat_piksel) do
    local x, y = koordinat.x, koordinat.y
    local warna_layar = ambilWarnaPiksel(x, y)
    local warna_target_saat_ini = warna_target[i]

    -- Hitung selisih antara warna
    local selisih_merah = math.abs(warna_layar.R - warna_target_saat_ini.R)
    local selisih_hijau = math.abs(warna_layar.G - warna_target_saat_ini.G)
    local selisih_biru = math.abs(warna_layar.B - warna_target_saat_ini.B)

    if selisih_merah > toleransi_warna or selisih_hijau > toleransi_warna or selisih_biru > toleransi_warna then
      return false  -- Warna tidak cocok
    end
  end
  return true -- Semua warna cocok
end

-- Fungsi untuk melakukan spam tombol
local function spamKey(key, duration)
  local UserInputService = game:GetService("UserInputService")
  local endTime = time() + duration
  while time() < endTime do
    UserInputService:SimulateKeyStroke(Enum.KeyCode[string.upper(key)], true)
    task.wait(0.05)
    UserInputService:SimulateKeyStroke(Enum.KeyCode[string.upper(key)], false)
    task.wait(0.05)
  end
end

-- Inisialisasi GUI
buatGUI()
print("AutoFarm: Script diinisialisasi")
