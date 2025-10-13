#!/usr/bin/python3

###########################################################################
##Can't remember official author of the non-modified form of this script.##
#############The base python script is also provided by cava.##############
###########################################################################

import os
import struct
import subprocess
import tempfile
import json
import time

BARS_NUMBER = 20
# OUTPUT_BIT_FORMAT = "8bit"
OUTPUT_BIT_FORMAT = "16bit"
# RAW_TARGET = "/tmp/cava.fifo"
RAW_TARGET = "/dev/stdout"
SENSITIVITY = 274
FRAMERATE = 120
TOOLTIP_UPDATE_INTERVAL = 2  # seconds

conpat = """
[general]
bars = %d
sensitivity = %d
framerate = %d
[output]
method = raw
raw_target = %s
bit_format = %s
"""

config = conpat % (BARS_NUMBER, SENSITIVITY, FRAMERATE, RAW_TARGET, OUTPUT_BIT_FORMAT)
bytetype, bytesize, bytenorm = ("H", 2, 65535) if OUTPUT_BIT_FORMAT == "16bit" else ("B", 1, 255)

bar_map = {
        0: "⠀",
        1: "⠁",
        2: "⠃",
        3: "⠇",
        4: "⡇"
        }

def fetch_now_playing():
    try:
        output = subprocess.check_output(
            ["playerctl", "metadata", "--format", "{{title}} - {{artist}}"],
            stderr=subprocess.DEVNULL
        )
        return output.decode().strip()
    except subprocess.CalledProcessError:
        return "Nothing Playing"

def run():
    last_tooltip_update = 0
    cached_tooltip = "Fetching..."

    with tempfile.NamedTemporaryFile() as config_file:
        config_file.write(config.encode())
        config_file.flush()

        process = subprocess.Popen(["cava", "-p", config_file.name], stdout=subprocess.PIPE)
        chunk = bytesize * BARS_NUMBER
        fmt = bytetype * BARS_NUMBER

        if RAW_TARGET != "/dev/stdout":
            if not os.path.exists(RAW_TARGET):
                os.mkfifo(RAW_TARGET)
            source = open(RAW_TARGET, "rb")
        else:
            source = process.stdout

        while True:
            data = source.read(chunk)
            if len(data) < chunk:
                break
            # sample = [i for i in struct.unpack(fmt, data)]  # raw values without norming
            # sample = "".join([bar_map[int((i / bytenorm) * 4)] for i in struct.unpack(fmt, data)])

            # Only update tooltip every TOOLTIP_UPDATE_INTERVAL seconds
            now = time.time()
            if now - last_tooltip_update > TOOLTIP_UPDATE_INTERVAL:
                cached_tooltip = fetch_now_playing()
                last_tooltip_update = now

            # display something when nothing is playing
            if cached_tooltip == "Nothing Playing":
                output = {
                    "text": "⠁⠃⠇⠃⠁⠃⠇⠇⡇⠇⡇⠁⠇⡇⠃⠇⠇⡇⠃⠁",           # text for when nothing is playing
                    # "text": "⡇⠇⠃⡇⠇⠃⠁⠁⠇⠃⠁⡇⠇⠃⠇⠃⠁⠃⠇⡇",
                    "tooltip": cached_tooltip
                }
            else:
                sample = "".join([
                    bar_map[int((i / bytenorm) * 4)]
                    for i in struct.unpack(fmt, data)
                ])

                output = {
                    "text": sample,
                    "tooltip": cached_tooltip
                }

            print(json.dumps(output), flush=True)

if __name__ == "__main__":
    run()
