FROM python:3.9.2-slim-buster

WORKDIR /app

COPY requirements.txt .

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    libgl1 \
    libglib2.0-0 \
    libsm6 \
    libxrender1 \
    libxext6 \
    wget \
    xz-utils \
    && rm -rf /var/lib/apt/lists/*

# Download and extract FFmpeg binaries from Heroku buildpack
RUN wget -O ffmpeg.tar.gz https://github.com/jonathanong/heroku-buildpack-ffmpeg-latest/releases/latest/download/ffmpeg.tar.gz \
    && mkdir -p /app/ffmpeg \
    && tar -xzf ffmpeg.tar.gz -C /app/ffmpeg \
    && cp /app/ffmpeg/bin/* /usr/local/bin/ \
    && rm -rf ffmpeg.tar.gz /app/ffmpeg

# Install Python dependencies
RUN pip3 install --no-cache-dir -r requirements.txt

COPY . .

CMD ["bash", "start.sh"]
