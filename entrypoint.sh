#!/bin/bash
sed -i "s|dummyalias|${KEYALIAS}|g" /opt/atlassian/atlassian-jira-software-7.1.7-standalone/conf/server.xml
sed -i "s|dummypath|${KEYSTORE_PATH}|g" /opt/atlassian/atlassian-jira-software-7.1.7-standalone/conf/server.xml
sed -i "s|dummypass|${KEYSTORE_PASS}|g" /opt/atlassian/atlassian-jira-software-7.1.7-standalone/conf/server.xml

/opt/atlassian/atlassian-jira-software-7.1.7-standalone/bin/start-jira.sh -fg
