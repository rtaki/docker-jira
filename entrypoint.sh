#!/bin/bash
isMod=$(grep "SSLCONNECTOR_INSERT" -c /opt/atlassian/atlassian-jira-software-7.1.7-standalone/conf/server.xml)

if [ "${SSL}" = "TRUE" ]; then
 if [ "${KEYSTORE_PATH}" = "" ]; then
  echo "UNDEFINED KEYSTORE_PATH"
 elif [ "${KEYSTORE_PASS}" = "" ]; then
  echo "UNDEFINED KEYSTORE_PASS"
 elif [ "${KEYALIAS}" = "" ]; then
  echo "UNDEFINED KEYALIAS"
 elif [ ${isMod} -ne 0 ]; then
  echo "Already SSL connector is registered"
 else
  sed -i "s|</Service>|<Connector port=\"8443\" protocol=\"org.apache.coyote.http11.Http11Protocol\" maxHttpHeaderSize=\"8192\" \
  SSLEnabled=\"true\" maxThreads=\"150\" minSpareThreads=\"25\" enableLookups=\"false\" disableUploadTimeout=\"true\" acceptCount=\"100\" \
  scheme=\"https\" secure=\"true\" clientAuth=\"false\" sslProtocol=\"TLS\" useBodyEncodingForURI=\"true\" keyAlias=\"${KEYALIAS}\" \
  keystoreFile=\"${KEYSTORE_PATH}\" keystorePass=\"${KEYSTORE_PASS}\" keystoreType=\"JKS\"/>\n<!--SSLCONNECTOR_INSERT-->\n </Service>|g" \
  /opt/atlassian/atlassian-jira-software-7.1.7-standalone/conf/server.xml
  echo "SSL connector is registered"
 fi
else
 echo "SSL=FALSE"
fi

/opt/atlassian/atlassian-jira-software-7.1.7-standalone/bin/start-jira.sh -fg
