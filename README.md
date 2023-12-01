# Add Jupyter to an Existing Container
This tool will create a new Dockerfile that will add 
Jupyter to an existing Docker image, and expose it on 
port 4200. This is useful when testing images and you
would like to get shell access, as well as an editor
inside the container.

This tool uses an existing Docker image that has been
already built. It will use that image as the base and
add to it.

The ENTRYPOINT for the new image will be to run the 
embedded `jupyter_and.sh` script, which will launch 
Jupyter and then execute a bash script passing
along any command-line parameters to that bash script.
The design is that the ENTRYPOINT of the base image
uses a bash script (such as `entrypoint.sh`). The 
new ENTRYPOINT will then have the same ENTRYPOINT with
`jupyter_and.sh` prepended.

## How to Use
Run the following command:
```
bash jupyter_and.sh
```

You will be prompted for an existing image name/tag,
and a new image name/tag. The tool will create a new 
Dockerfile with Jupyter added and exposed on port 4200.
All other services will be started and ports exposed per
the base Dockerfile.

To build, run
```
docker build -t new_image_name .
```

To run the image, run
```
docker run -p 4200:4200 new_image_name
```

Of course, if your base image exposed some ports, you would
want to modify the `docker run` command to expose those
additional ports. Similarly, if your base image takes 
command-line arguments, then you would want to add those
to the `docker run` command.

For simplicity, the `jupyter_and.sh` will also create
a Makefile with 3 targets:
* `help` - which displays some help
* `build_local` - which will build the new image for the local architecture
* `run` - which will run the `docker run` command on the new image and expose port 4200

