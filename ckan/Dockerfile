FROM ckan/ckan-base:2.10.1

# Install any extensions needed by your CKAN instance
# See Dockerfile.dev for more details and examples

### Harvester ###
RUN pip3 install -e 'git+https://github.com/ckan/ckanext-harvest.git@v1.5.6#egg=ckanext-harvest' && \
   pip3 install -r ${APP_DIR}/src/ckanext-harvest/pip-requirements.txt
# will also require gather_consumer and fetch_consumer processes running (please see https://github.com/ckan/ckanext-harvest)

### DCAT ###
RUN  pip3 install -e git+https://github.com/ckan/ckanext-dcat.git@v1.5.1#egg=ckanext-dcat && \
    pip3 install -r https://raw.githubusercontent.com/ckan/ckanext-dcat/v1.5.1/requirements.txt

### NDP Keycloak Ext ###
RUN  pip3 install -e git+https://github.com/national-data-platform/ckanext-keycloak.git@v0.3.0#egg=ckanext-keycloak && \
    pip3 install -r https://raw.githubusercontent.com/national-data-platform/ckanext-keycloak/v0.3.0/requirements.txt

## NDP Main Ext ###
RUN  pip3 install -e git+https://github.com/national-data-platform/ckanext-ndp.git@v0.1.0#egg=ckanext-ndp && \
    pip3 install -r https://raw.githubusercontent.com/national-data-platform/ckanext-ndp/v0.1.0/requirements.txt


# Copy custom initialization scripts
COPY docker-entrypoint.d/* /docker-entrypoint.d/

# Apply any patches needed to CKAN core or any of the built extensions (not the
# runtime mounted ones)
COPY patches ${APP_DIR}/patches

RUN for d in $APP_DIR/patches/*; do \
        if [ -d $d ]; then \
            for f in `ls $d/*.patch | sort -g`; do \
                cd $SRC_DIR/`basename "$d"` && echo "$0: Applying patch $f to $SRC_DIR/`basename $d`"; patch -p1 < "$f" ; \
            done ; \
        fi ; \
    done
