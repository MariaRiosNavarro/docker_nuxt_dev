# Nuxt-DEV in docker

TODO: All created images here are really big, so in another version I will create the images with node18 in alpine, to see if it shrinks like that.

### HOW i did the NUXT_IMAGE & create the CONTAINER

### Step 1

1. Create a development Docker container with the minimum Node.js version required for Nuxt, which is version 18.

![DockerNuxt](/readme_assets/step1/one1.png)

2. Wait for it to finish when you see this message.

![DockerNuxt](/readme_assets/step1/one2.png)

3. Install Nuxt in the environment (select nuxi@3.11.1, yes).

![DockerNuxt](/readme_assets/step1/one3.png)

4. Choose your package manager (I use npm).

![DockerNuxt](/readme_assets/step1/one4.png)

5. We do not need a repository since we will only copy the files in another folder, and we will not need this development Docker container later.

![DockerNuxt](/readme_assets/step1/one5.png)

6. The project is installed.

![DockerNuxt](/readme_assets/step1/one6.png)

7. Enter the folder

![DockerNuxt](/readme_assets/step1/one7.png)

8. MOST IMPORTANTLY, run `npm i` in this environment, and do not close the terminal, or you will lose everything (development environment only).

![DockerNuxt](/readme_assets/step1/one8.png)

### Step 2

1. Open another terminal without closing the previous one, navigate to the location where you want to develop your project. Find the ID of the container created in the first terminal using `docker ps`

2. Copy the contents of the image to the desired location using `docker cp saved_id:your_folder_name .` **DO NOT FORGET THE TRAILING PERIOD AT THE END**

![DockerNuxt](/readme_assets/step2/two1.png)

3. Check that it has been created using `ls` and navigate to the folder using `cd your_folder_name` and open your IDE, I use vsc for this, so I use `. code`

![DockerNuxt](/readme_assets/step2/two2.png)

### Step 3

NOTE: In the examples, from this step onwards, my shell path in my IDE will change since I removed an intermediate folder called docker-vite-nuxt.

1. In the IDE (I use vsc), create `.dockerignore` and `Dockerfile`.

`.dockerignore`

```
# Node dependencies
node_modules

# Local env files
.env
.env.*
!.env.example

```

`Dockerfile`

```
FROM node:18
WORKDIR /nuxt
COPY . .
EXPOSE 3000
CMD ["npm","run", "dev", "--", "--host"]

```

2. Create the Nuxt_DEV image using `docker build -t name_of_the_image_you_want .` This will read the Dockerfile and create an image based on it. If you are using Docker Desktop, you will see the image and its ID (the number below). You can also use`docker ps`and see it in the terminal. Copy and save the ID.

![DockerNuxt](/readme_assets/step3/three2.png)

3. Now you can create a container from this image with the volume direction in your project

3.1. You can do:

```
docker run -d -p new_port_you_want:port_in_dockerfile -v ${pwd}:PATH_OF_YOUR_IMAGE --name NAME_TO_YOUR_CONTAINER_you_WANT name_or_ID_of_the_image
```

3.2. Another way (I had problems with the relative address with `${pwd}`) is:

```
docker run -d -p new_port_you_want:port_in_dockerfile -v ABSOLUTE_PATH_YOUR_WORK_APP:PATH_OF_YOUR_IMAGE  --name NAME_TO_YOUR_CONTAINER_you_WANT name_or_ID_of_the_image

```

![DockerNuxt](/readme_assets/step3/three3.png)

4. NOW you can open your port and see this (mine was 3030)

![DockerNuxt](/readme_assets/step3/three4.png)

Change something in the `app.vue` to test

![DockerNuxt](/readme_assets/step3/three5.png)

And you should see it immediately.

![DockerNuxt](/readme_assets/step3/three6.png)



WORKS!!