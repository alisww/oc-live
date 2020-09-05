local c = require("component")
local tape = c.tape_drive
local net = require("internet")
local event = require("event")
local os = require("os")
local shell = require("shell")

local args, ops = shell.parse(...)

function print_usage()
  print("Usage:")
  print("live <address> <port>")
  print("Other options:")
  print("--bitrate=<bitrate> - sets a custom bitrate (in KB, ex: --bitrate=96)")
  print("Note! higher bitrates may mean more breakups in the audio.")
end

local addr, port, bitrate, per_tick

if #args < 2 then
  print_usage()
  os.exit()
else
  addr = args[1]
  port = tonumber(args[2])
  bitrate = tonumber(ops["bitrate"]) or 48000
  per_tick = bitrate / 20
end

handle = net.open(addr,port)
buf = handle:read(per_tick * 2)
tape.setSpeed(bitrate / 48000)
tape.play()

while true do
  tape.write(buf)
  tape.seek(-#buf)
  start = computer.uptime()
  delay = (#buf / per_tick)
  print("Have: " .. tostring(delay) .. "s")
  buf = ""
  while computer.uptime() - start < delay do
    if event.pull(0.1,"internet_ready") then
      buf = buf .. handle:read(per_tick)
    end
  end
end
