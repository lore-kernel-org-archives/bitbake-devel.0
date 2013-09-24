Return-Path: <ddalex@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id D08076CA17
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Sep 2013 16:53:02 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP; 24 Sep 2013 09:49:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,971,1371106800"; d="scan'208";a="400405644"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by fmsmga001.fm.intel.com with ESMTP; 24 Sep 2013 09:53:01 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 768E2560FA0; Tue, 24 Sep 2013 17:53:04 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Sep 2013 17:51:31 +0100
Message-Id: <eb1d5efcf6bc4b3fe3d9bd4616ba2adb430f1946.1380041477.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
	<22b15f86ec61c7577adab12d7ab4d42373519f5c.1380041477.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1380041477.git.alexandru.damian@intel.com>
References: <cover.1380041477.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 02/94] webhob: add system start/stop script
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
X-List-Received-Date: Tue, 24 Sep 2013 16:53:02 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Adding a script that starts/stops the webhob system.
Sourced, with a parameter, it will start or stop
the bitbake resident, and the webhob server, as well
as point a browser to the webhob home .

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bitbake/bin/webhob | 95 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100755 bitbake/bin/webhob

diff --git a/bitbake/bin/webhob b/bitbake/bin/webhob
new file mode 100755
index 0000000..ccaf91f
--- /dev/null
+++ b/bitbake/bin/webhob
@@ -0,0 +1,95 @@
+#!/bin/bash
+# (c) 2013 Intel Corp.
+
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+
+
+# This script enables webhob event logging and
+# starts bitbake resident server
+# use as:  source webhob [start|stop]
+
+# Helper function to kill a background webhob development server
+        
+function webserverKillAllComponents() 
+{
+	local pidfile
+	for pidfile in ${BUILDDIR}/whbmain.pid; do
+		if [ -f ${pidfile} ]; then
+		while kill -0 $(< ${pidfile}) 2>/dev/null; do
+			kill -SIGTERM -`ps -p $(< ${pidfile}) -o "%r" --no-headers`	
+			sleep 1;
+		done;
+		rm  ${pidfile}
+		fi
+	done
+}
+
+# We make sure we're running in the current shell and in a good environment
+
+if [ -z "$ZSH_NAME" ] && [ `basename "$0"` = `basename $BASH_SOURCE` ]; then
+    echo "Error: This script needs to be sourced. Please run as 'source webhob [start|stop]'" 1>&2;
+    exit 1
+fi
+    
+if [ -z "$BUILDDIR" ] || [ -z `which bitbake` ]; then
+    echo "Error: Build environment is not setup or bitbake is not in path." 1>&2;
+    return 2
+fi
+
+BBBASEDIR=`dirname ${BASH_SOURCE}`/..
+
+# Determine the action. If specified by arguments, fine, if not, toggle it
+if [ "x$1" == "xstart" ] || [ "x$1" == "xstop" ]; then
+    CMD="$1"
+else
+    if [ -z "$BBSERVER" ]; then
+        CMD="start"
+    else
+        CMD="stop"
+    fi;
+fi
+
+# Make sure it's safe to run by checking bitbake lock
+
+lock=1
+(flock -n 200 ) 200<$BUILDDIR/bitbake.lock || lock=0 
+
+if [ ${CMD} == "start" ] && ( [ $lock -eq 0 ] || [ -e $BUILDDIR/whbmain.pid ] ); then
+    echo "Error: bitbake lock state error. System may be already on." 2>&1
+    return 3 
+elif [ ${CMD} == "stop" ] && ( [ $lock -eq 1 ] || ! [ -e $BUILDDIR/whbmain.pid ] ) ; then
+    echo "Error: bitbake lock state error. System may be already off.
+manually stop system with bitbake -m / webserverKillAllComponents" 2>&1
+    return 3 
+fi
+
+
+# Execute the commands
+
+case $CMD in
+    start )
+        unset BBSERVER
+        python $BBBASEDIR/lib/webhob/manage.py syncdb || (echo "Failed db sync, stopping system start" 1>&2 && return 0)
+        bitbake --server-only -t xmlrpc -B localhost:8200 
+        export BBSERVER=localhost:8200
+        python $BBBASEDIR/lib/webhob/manage.py runserver </dev/null >${BUILDDIR}/whbmain.log 2>&1 & echo $! >${BUILDDIR}/whbmain.pid
+    ;;
+    stop )
+        bitbake -m
+        unset BBSERVER
+        webserverKillAllComponents
+esac
+
+    
-- 
1.8.1.2


