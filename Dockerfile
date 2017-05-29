FROM centos/s2i-base-centos7

MAINTAINER Hossam Hammady <github@hammady.net>

EXPOSE 8080

LABEL summary="Platform for building and running Java 8 Ant based applications" \
      io.k8s.description="Platform for building and running Java 8 Ant based applications" \
      io.k8s.display-name="Java 8 Ant" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,java,ant"

RUN yum install -y centos-release-scl && \
    INSTALL_PKGS="java-1.8.0-openjdk java-1.8.0-openjdk-devel ant" && \
    yum install -y --setopt=tsflags=nodocs $INSTALL_PKGS && rpm -V $INSTALL_PKGS && \
    yum clean all -y

# Copy the S2I scripts from the specific language image to $STI_SCRIPTS_PATH
COPY ./s2i/bin/ $STI_SCRIPTS_PATH

RUN chown -R 1001:0 /opt/app-root && chmod -R ug+rwx /opt/app-root

USER 1001

# Set the default CMD to print the usage of the language image
CMD $STI_SCRIPTS_PATH/usage
