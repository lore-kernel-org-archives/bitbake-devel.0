Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
	[209.85.212.169])
	by mail.openembedded.org (Postfix) with ESMTP id 134FE6B8B0
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  3 Jun 2014 15:26:19 +0000 (UTC)
Received: by mail-wi0-f169.google.com with SMTP id hi2so6249670wib.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 03 Jun 2014 08:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=jUfxvavL24+ATRwIaAu206QFaEV6cfk3rk65vFu7tMc=;
	b=hqT9ijD8NHI468tsEk1tgIFQ2I3hF3+kzX4HHd/1rtDMRbLY1kHdByftwiJt2L2QBP
	KrmC1zBRcDv7yl2Lfx9FyOiq2DN/xwhRFiR634acZrz6ykgG5TlVrQnSSjE2Of6Cbh/T
	CttWjK8YOSAR6QxTUOxW5kiqJE+eHC2X0AVI+LUFIkxQN5MS1W15Jvi0A/OVXKY7FNeW
	oci67yJasUnFBlLBOv8e6ATCraJG5iDjOTITvxgFTJcEhf8L8VYKEhZ8I0jAe4URao8f
	qumk9G+2CrvXcGOTyZ4/UknMDDWfsRPP/epNVZvqEdUAyAyw+/gZeX5JD/i7dSzwLgLq
	PZ+A==
X-Gm-Message-State: ALoCoQlfcNhf04owoGD/a5DvkUQFVcMrNDF5DxAIpabGKo72JiQKKlfwPrablLfAXCBVxRsQyvrC
X-Received: by 10.181.8.67 with SMTP id di3mr33550260wid.8.1401809179316;
	Tue, 03 Jun 2014 08:26:19 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id bn10sm3759713wib.7.2014.06.03.08.26.17
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 03 Jun 2014 08:26:18 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id D1681561BD1; Tue,  3 Jun 2014 16:26:18 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  3 Jun 2014 16:26:15 +0100
Message-Id: <a3f083870759a6c627b4c6374e61df9f5b100c3c.1401808899.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <b6ae17f19c56ec99362290dd701542373720e572.1401808899.git.alexandru.damian@intel.com>
References: <b6ae17f19c56ec99362290dd701542373720e572.1401808899.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1401808899.git.alexandru.damian@intel.com>
References: <cover.1401808899.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 6/9] toaster: startup script standalone mode
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
X-List-Received-Date: Tue, 03 Jun 2014 15:26:23 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

The toaster starter script was designed to be sourced in
a build environment and set up the build recording environment
to be used in an interactive mode.

For the standalone web server mode, we modify the toaster
script to be run directly from the checked-out sources,
without a build environment set up, and run the web server
alone. In the standalone mode, the build environemnts and
all build activities are controled through the web interface.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bin/toaster | 52 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index f81e667..80bda6d 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -16,9 +16,15 @@
 # Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 
 
-# This script enables toaster event logging and
-# starts bitbake resident server
-# use as:  source toaster [start|stop]
+# This script can be run in two modes.
+
+# When used with "source", from a build directory,
+# it enables toaster event logging and starts the bitbake resident server.
+# use as:  source toaster [start|stop] [noweb] [noui]
+
+# When it is called as a stand-alone script, it starts just the
+# web server, and the building shall be done through the web interface.
+# As script, it will not return to the command prompt. Stop with Ctrl-C.
 
 # Helper function to kill a background toaster development server
 
@@ -30,6 +36,8 @@ function webserverKillAll()
 		while kill -0 $(< ${pidfile}) 2>/dev/null; do
 			kill -SIGTERM -$(< ${pidfile}) 2>/dev/null
 			sleep 1;
+			# Kill processes if they are still running - may happen in interactive shells
+			ps fux | grep "python.*manage.py" | awk '{print $2}' | xargs kill
 		done;
 		rm  ${pidfile}
 		fi
@@ -38,6 +46,12 @@ function webserverKillAll()
 
 function webserverStartAll()
 {
+	# do not start if toastermain points to a valid process
+	if ! cat "${BUILDDIR}/.toastermain.pid" 2>/dev/null | xargs -I{} kill -0 {} ; then
+            retval=1
+            rm "${BUILDDIR}/.toastermain.pid"
+        fi
+
         retval=0
         python $BBBASEDIR/lib/toaster/manage.py syncdb || retval=1
         python $BBBASEDIR/lib/toaster/manage.py migrate orm || retval=2
@@ -49,6 +63,8 @@ function webserverStartAll()
             retval=0
             python $BBBASEDIR/lib/toaster/manage.py migrate orm || retval=1
         fi
+        python $BBBASEDIR/lib/toaster/manage.py migrate bldcontrol || retval=1
+
         if [ $retval -eq 0 ]; then
             python $BBBASEDIR/lib/toaster/manage.py runserver 0.0.0.0:8000 </dev/null >${BUILDDIR}/toaster_web.log 2>&1 & echo $! >${BUILDDIR}/.toastermain.pid
             sleep 1
@@ -103,19 +119,43 @@ function notify_chldexit() {
 }
 
 
-# We make sure we're running in the current shell and in a good environment
+BBBASEDIR=`dirname ${BASH_SOURCE}`/..
+RUNNING=0
 
 if [ -z "$ZSH_NAME" ] && [ `basename \"$0\"` = `basename \"$BASH_SOURCE\"` ]; then
-    echo "Error: This script needs to be sourced. Please run as 'source toaster [start|stop]'" 1>&2;
+    # We are called as standalone. We refuse to run in a build environment - we need the interactive mode for that.
+    # Start just the web server, point the web browser to the interface, and start any Django services.
+
+    if [ -n "$BUILDDIR" ]; then
+        echo "Error: build/ directory detected. Standalone Toaster will not start in a build environment." 1>&2;
+        return 1;
+    fi
+
+    # Define a fake builddir where only the pid files are actually created. No real builds will take place here.
+    BUILDDIR=/tmp
+    RUNNING=1
+    function trap_ctrlc() {
+        echo "** Stopping system"
+        webserverKillAll
+        RUNNING=0
+    }
+    webserverStartAll || exit 1
+    xdg-open http://0.0.0.0:8000/ >/dev/null 2>&1 &
+    trap trap_ctrlc SIGINT
+    echo "Running. Stop with Ctrl-C"
+    while [ $RUNNING -gt 0 ]; do
+        wait;
+    done
+    echo "**** Exit"
     exit 1
 fi
 
+# We make sure we're running in the current shell and in a good environment
 if [ -z "$BUILDDIR" ] || [ -z `which bitbake` ]; then
     echo "Error: Build environment is not setup or bitbake is not in path." 1>&2;
     return 2
 fi
 
-BBBASEDIR=`dirname ${BASH_SOURCE}`/..
 
 
 # Verify prerequisites
-- 
1.9.1


