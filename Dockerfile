FROM python:3.9.2-slim-buster

WORKDIR /app

COPY requirements.txt .

RUN apt-get update && apt-get install -y \
    libgl1 \
    libglib2.0-0 \
    libsm6 \
    libxrender1 \
    libxext6 \
    wget \
    xz-utils \
 && wget https://github.com/BtbN/FFmpeg-Builds/releases/latest/download/ffmpeg-n6.1-latest-linux64-gpl.tar.xz \
 && tar -xf ffmpeg-n6.1-latest-linux64-gpl.tar.xz \
 && cp -r ffmpeg-n6.1*/bin/* /usr/bin/ \
 && rm -rf ffmpeg-n6.1* *.tar.xz \
 && pip3 install --no-cache-dir -r requirements.txt

COPY . .

CMD ["bash", "start.sh"]
