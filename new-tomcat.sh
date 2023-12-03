#!/bin/bash

# Source the configuration file
source config.sh

# Check if the specified version of Tomcat already exists
if [ -d "$TOMCAT_DIR" ]; then
    echo "Tomcat directory $TOMCAT_DIR already exists. Removing it..."
    rm -rf "$TOMCAT_DIR"
fi

# Check if unzip is installed
if ! command -v unzip &> /dev/null; then
    echo "unzip not found, installing..."
    sudo apt-get install unzip -y
fi

echo "Downloading Tomcat from $TOMCAT_URL..."
wget $TOMCAT_URL -O tomcat.zip

echo "Extracting Tomcat..."
unzip tomcat.zip -d $(dirname $TOMCAT_DIR)
rm tomcat.zip  # Remove the zip file after extraction

# Create setenv.sh in Tomcat bin directory
echo "Creating setenv.sh..."
cat << EOF > $TOMCAT_DIR/bin/setenv.sh
#!/bin/bash
export JAVA_OPTS="-server -Xmx4g -XX:MaxMetaspaceSize=1g -Djava.awt.headless=true -XX:+UseCompressedOops -XX:+UseConcMarkSweepGC -XX:+DisableExplicitGC -Djava.util.Arrays.useLegacyMergeSort=true"
JAVA_OPTS="\$JAVA_OPTS -Dhttp.agent=Sakai"
JAVA_OPTS="\$JAVA_OPTS -Dorg.apache.jasper.compiler.Parser.STRICT_QUOTE_ESCAPING=false"
JAVA_OPTS="\$JAVA_OPTS -Dsakai.security=$SAKAI_HOME"
JAVA_OPTS="\$JAVA_OPTS -Dsakai.home=$SAKAI_HOME"
JAVA_OPTS="\$JAVA_OPTS -Dsakai.cookieName=SAKAI2SESSIONID"
JAVA_OPTS="\$JAVA_OPTS -Dsakai.demo=true"
JAVA_OPTS="\$JAVA_OPTS -Duser.timezone=US/Eastern"
JAVA_OPTS="\$JAVA_OPTS -Duser.language=en -Duser.region=ES"
EOF

# Make setenv.sh executable
chmod +x $TOMCAT_DIR/bin/setenv.sh

# Clearing the webapps directory
echo "Clearing webapps directory..."
rm -rf $TOMCAT_DIR/webapps/*

# Adding JarScanFilter to context.xml using awk
echo "Modifying context.xml with JarScanner block..."

awk '/<\/Context>/ { 
    print "    <JarScanner>"
    print "        <!-- This is to speed up startup so that Tomcat doesn'\''t scan as much -->"
    print "        <JarScanFilter defaultPluggabilityScan=\"false\" />"
    print "    </JarScanner>"
} 
{ 
    print 
}' $TOMCAT_DIR/conf/context.xml > temp_file && mv temp_file $TOMCAT_DIR/conf/context.xml 


# Make tomcat/bin/*.sh executable
chmod +x $TOMCAT_DIR/bin/*.sh

echo "Tomcat setup for Sakai complete."
