FROM node:18.12.1-slim as node

FROM debian:bullseye-slim AS texlive-minimal
ARG VERSION=local
WORKDIR /tmp/texlive
ARG SCHEME=scheme-basic
ARG DOCFILES=0
ARG SRCFILES=0
ARG TEXLIVE_VERSION=2022
ARG TEXLIVE_MIRROR=http://ctan.math.utah.edu/ctan/tex-archive/systems/texlive/tlnet
RUN apt update -y && \
    apt install -y --no-install-recommends wget gnupg cpanminus && \
    wget -qO- ${TEXLIVE_MIRROR}/install-tl-unx.tar.gz | \
    tar -xz --strip-components=1 && \
    export TEXLIVE_INSTALL_NO_CONTEXT_CACHE=1 && \
    export TEXLIVE_INSTALL_NO_WELCOME=1 && \
    printf "selected_scheme ${SCHEME}\ninstopt_letter 0\ntlpdbopt_autobackup 0\ntlpdbopt_desktop_integration 0\ntlpdbopt_file_assocs 0\ntlpdbopt_install_docfiles ${DOCFILES}\ntlpdbopt_install_srcfiles ${SRCFILES}" > profile.txt && \
    perl install-tl -profile profile.txt --location ${TEXLIVE_MIRROR} && \
    # Cleanup
    cd && \
    apt clean autoclean && \
    apt autoremove -y && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/ /tmp/texlive /usr/local/texlive/${TEXLIVE_VERSION}/*.log
ENV PATH ${PATH}:\
/usr/local/texlive/${TEXLIVE_VERSION}/bin/x86_64-linux:\
/usr/local/texlive/${TEXLIVE_VERSION}/bin/aarch64-linux
WORKDIR /workspace

RUN mkdir -p /usr/local/lib/node_modules/npm/bin
COPY --from=node /usr/local/lib/node_modules/ /usr/local/lib/node_modules/
COPY --from=node /usr/local/bin/node /usr/local/bin/node
RUN ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm \
    && npm -v

RUN npm install -g prettier@2.8.1 prettier-plugin-latex@1.2.4 \
    && prettier -v

RUN tlmgr install \
          latexmk \
    && \
    texhash && \
    rm -rf /usr/local/texlive/${TEXLIVE_VERSION}/texmf-var/web2c/*.log && \
    rm -rf /usr/local/texlive/${TEXLIVE_VERSION}/tlpkg/texlive.tlpdb.main.*

# Verify binaries work and have the right permissions
RUN tlmgr version && \
    latexmk -version && \
    texhash --version

FROM texlive-minimal AS cheat-sheet

# cache big packages
RUN tlmgr install \
          libertine \
    && \
    texhash && \
    rm -rf /usr/local/texlive/${TEXLIVE_VERSION}/texmf-var/web2c/*.log && \
    rm -rf /usr/local/texlive/${TEXLIVE_VERSION}/tlpkg/texlive.tlpdb.main.*

RUN tlmgr install \
          bigfoot \
          cheatsheet \
          csquotes \
          ifmtarg \
          listings \
          mathtools \
          mdframed \
          needspace \
          xcolor \
          xifthen \
          zref \
    && \
    texhash && \
    rm -rf /usr/local/texlive/${TEXLIVE_VERSION}/texmf-var/web2c/*.log && \
    rm -rf /usr/local/texlive/${TEXLIVE_VERSION}/tlpkg/texlive.tlpdb.main.*

RUN mkdir -p /out

ARG USERNAME=tex
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt update \
    && apt install -y sudo \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/ \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME

ENV LATEX_MAIN_FILE="main.tex"

COPY entrypoint.sh /usr/local/bin/entrypoint
RUN sudo chmod +x /usr/local/bin/entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint"]

CMD ["default"]
