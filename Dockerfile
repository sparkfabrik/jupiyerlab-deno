FROM python:3.12-slim

# Install system dependencies.
RUN apt-get update && \
    apt-get install -y build-essential curl unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Deno and Jupyter labs.
ENV DENO_INSTALL="/usr/local/bin"
ENV PATH="$DENO_INSTALL/bin:$PATH"
RUN pip install jupyterlab && \
    curl -fsSL https://deno.land/install.sh | sh

# Set the working directory
WORKDIR /app

# Expose the Jupyter Notebook port
EXPOSE 8888

# Start as a non-root user.
ARG UID=1000

# Create a non-root user.
RUN useradd -m -u ${UID} -s /bin/bash deno

# Set the non-root user as the default user.
USER ${UID}

# Install the Deno Jupyter kernel.
RUN deno jupyter --unstable --install

# Start Jupyter labs.
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--no-browser", "--NotebookApp.token=''"]