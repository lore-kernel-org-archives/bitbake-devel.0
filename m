Return-Path: <elliot.smith@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id AB3246E6B1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Apr 2016 13:22:21 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP; 21 Apr 2016 06:22:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,512,1455004800"; d="scan'208";a="949956252"
Received: from santhige-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.8.209])
	by fmsmga001.fm.intel.com with ESMTP; 21 Apr 2016 06:22:21 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 21 Apr 2016 14:22:05 +0100
Message-Id: <1461244926-20236-2-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <1461244926-20236-1-git-send-email-elliot.smith@intel.com>
References: <1461244926-20236-1-git-send-email-elliot.smith@intel.com>
Subject: [PATCH 2/3] toaster: bin/toaster Add ability to specify port and address to bind to
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
X-List-Received-Date: Thu, 21 Apr 2016 13:22:23 -0000

From: Michael Wood <michael.g.wood@intel.com>

Allow binding to a specified address and port to start the django
development server on.
Remove the assumption that you want to bind to 0.0.0.0 and set the
default to localhost.
Add some additional help text after Toaster webserver has started

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/bin/toaster | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/bitbake/bin/toaster b/bitbake/bin/toaster
index 2d07255..9540fc9 100755
--- a/bitbake/bin/toaster
+++ b/bitbake/bin/toaster
@@ -69,7 +69,7 @@ webserverStartAll()
 
     echo "Starting webserver..."
 
-    $MANAGE runserver "0.0.0.0:$WEB_PORT" \
+    $MANAGE runserver "$ADDR_PORT" \
            </dev/null >>${BUILDDIR}/toaster_web.log 2>&1 \
            & echo $! >${BUILDDIR}/.toastermain.pid
 
@@ -79,7 +79,8 @@ webserverStartAll()
         retval=1
         rm "${BUILDDIR}/.toastermain.pid"
     else
-        echo "Webserver address:  http://0.0.0.0:$WEB_PORT/"
+        echo "Toaster development webserver started at http://$ADDR_PORT"
+        echo -e "\nYou can now run 'bitbake <target>' on the command line and monitor your build in Toaster.\nYou can also use a Toaster project to configure and run a build.\n"
     fi
 
     return $retval
@@ -180,7 +181,7 @@ fi
 export TOASTER_DIR=`pwd`
 
 WEBSERVER=1
-WEB_PORT="8000"
+ADDR_PORT="localhost:8000"
 unset CMD
 for param in $*; do
     case $param in
@@ -194,7 +195,14 @@ for param in $*; do
             CMD=$param
     ;;
     webport=*)
-            WEB_PORT="${param#*=}"
+            ADDR_PORT="${param#*=}"
+            # Split the addr:port string
+            ADDR=`echo $ADDR_PORT | cut -f 1 -d ':'`
+            PORT=`echo $ADDR_PORT | cut -f 2 -d ':'`
+            # If only a port has been speified then set address to localhost.
+            if [ $ADDR = $PORT ] ; then
+                ADDR_PORT="localhost:$PORT"
+            fi
     ;;
     *)
             echo "$HELP"
@@ -247,7 +255,7 @@ case $CMD in
     start )
         # check if addr:port is not in use
         if [ "$CMD" == 'start' ]; then
-             $MANAGE checksocket "0.0.0.0:$WEB_PORT" || return 1
+             $MANAGE checksocket "$ADDR_PORT" || return 1
         fi
 
         # kill Toaster web server if it's alive
-- 
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


