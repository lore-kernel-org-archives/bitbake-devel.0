Return-Path: <david.reyna@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 52B9578273
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Aug 2017 01:10:12 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id v7L1ADls010918
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 20 Aug 2017 18:10:14 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.78) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.361.1; Sun, 20 Aug 2017 18:10:13 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sun, 20 Aug 2017 18:01:49 -0700
Message-ID: <5e2efbd0b97077e55be7029baa717e3bd387572a.1503276918.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1503276918.git.David.Reyna@windriver.com>
References: <cover.1503276918.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.78]
Subject: [PATCH 2/2] Toaster: custom start and stop actions
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 21 Aug 2017 01:10:13 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

Toaster needs the ability to allow custom extensions to execute when
Toaster is started and stopped. Toaster will look for a custom
extension script in the fixtures directory and execute any applicable
hooks.

[YOCTO #11938]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 bin/toaster                                        | 22 +++++++++-
 .../orm/fixtures/custom_toaster_append.sh_sample   | 49 ++++++++++++++++++++++
 2 files changed, 69 insertions(+), 2 deletions(-)
 create mode 100755 bitbake/lib/toaster/orm/fixtures/custom_toaster_append.sh_sample

diff --git a/bin/toaster b/bin/toaster
index c2e33fe..762451d 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -24,6 +24,14 @@ Usage: source toaster start|stop [webport=<address:port>] [noweb]
         [webport] Set the development server (default: localhost:8000)
 "
 
+custom_extention()
+{
+    custom_extension=$BBBASEDIR/lib/toaster/orm/fixtures/custom_toaster_append.sh
+    if [ -f $custom_extension ] ; then
+        $custom_extension $*
+    fi
+}
+
 databaseCheck()
 {
     retval=0
@@ -50,6 +58,11 @@ databaseCheck()
 webserverKillAll()
 {
     local pidfile
+    if [ -f ${BUILDDIR}/.toastermain.pid ] ; then
+        custom_extention web_stop_postpend
+    else
+        custom_extention noweb_stop_postpend
+    fi
     for pidfile in ${BUILDDIR}/.toastermain.pid ${BUILDDIR}/.runbuilds.pid; do
         if [ -f ${pidfile} ]; then
             pid=`cat ${pidfile}`
@@ -89,6 +102,7 @@ webserverStartAll()
     else
         echo "Toaster development webserver started at http://$ADDR_PORT"
         echo -e "\nYou can now run 'bitbake <target>' on the command line and monitor your build in Toaster.\nYou can also use a Toaster project to configure and run a build.\n"
+        custom_extention web_start_postpend $ADDR_PORT
     fi
 
     return $retval
@@ -168,7 +182,6 @@ fi
 unset OE_ROOT
 
 
-
 WEBSERVER=1
 ADDR_PORT="localhost:8000"
 unset CMD
@@ -241,6 +254,7 @@ fi
 echo "The system will $CMD."
 
 # Execute the commands
+custom_extention toaster_prepend $CMD $ADDR_PORT
 
 case $CMD in
     start )
@@ -262,9 +276,10 @@ case $CMD in
             if [ ! -f "$TOASTER_DIR/toaster.sqlite" ] ; then
                 if ! databaseCheck; then
                     echo "Failed ${CMD}."
-                  return 4
+                    return 4
                 fi
             fi
+            custom_extention noweb_start_postpend $ADDR_PORT
         fi
         if [ $WEBSERVER -gt 0 ] && ! webserverStartAll; then
             echo "Failed ${CMD}."
@@ -278,6 +293,7 @@ case $CMD in
         # set fail safe stop system on terminal exit
         trap stop_system SIGHUP
         echo "Successful ${CMD}."
+        custom_extention toaster_postpend $CMD $ADDR_PORT
         return 0
     ;;
     stop )
@@ -285,3 +301,5 @@ case $CMD in
         echo "Successful ${CMD}."
     ;;
 esac
+custom_extention toaster_postpend $CMD $ADDR_PORT
+
diff --git a/lib/toaster/orm/fixtures/custom_toaster_append.sh_sample b/lib/toaster/orm/fixtures/custom_toaster_append.sh_sample
new file mode 100755
index 0000000..8c4e163
--- /dev/null
+++ b/lib/toaster/orm/fixtures/custom_toaster_append.sh_sample
@@ -0,0 +1,49 @@
+#!/bin/bash
+
+# Copyright (C) 2017 Intel Corp.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+# See the GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+
+# This is sample software. Rename it to 'custom_toaster_append.sh' and
+# enable the respective custom sections.
+
+verbose=0
+if [ $verbose -ne 0 ] ; then
+    echo "custom_toaster_append.sh:$*"
+fi
+
+if [ "toaster_prepend" = "$1" ] ; then
+    echo "Add custom actions here when Toaster script is started"
+fi
+
+if [ "web_start_postpend" = "$1" ] ; then
+    echo "Add custom actions here after Toaster web service is started"
+fi
+
+if [ "web_stop_postpend" = "$1" ] ; then
+    echo "Add custom actions here after Toaster web service is stopped"
+fi
+
+if [ "noweb_start_postpend" = "$1" ] ; then
+    echo "Add custom actions here after Toaster (no web) service is started"
+fi
+
+if [ "noweb_stop_postpend" = "$1" ] ; then
+    echo "Add custom actions here after Toaster (no web) service is stopped"
+fi
+
+if [ "toaster_postpend" = "$1" ] ; then
+    echo "Add custom actions here after Toaster script is done"
+fi
+
-- 
1.9.1


