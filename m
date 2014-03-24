Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f175.google.com (mail-we0-f175.google.com
	[74.125.82.175])
	by mail.openembedded.org (Postfix) with ESMTP id C7DDE6FB3C
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Mar 2014 18:37:38 +0000 (UTC)
Received: by mail-we0-f175.google.com with SMTP id q58so3712773wes.34
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Mar 2014 11:37:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=nF0FW362sLBDUE08Cnkp+no+f0VzFwJQUBfVi3PpI38=;
	b=jtrlVxGyOT8AwcqwDzRCtL2tvYn/o7xpIpsJMI459n4LGh3DOGiJZnkdNOxmVsilLW
	oVDHni9ukx+wEYq5hm75Rj0rBBuMcghaDnJjXrkH2GOpd0Sa2TZlhEpArxgUdS0gSwXe
	/UbIR8WJ+9z1YaNSp75s2xGMssMStchTvWTaad/K9gnncpF3m5bO30Tsi80uwhv/zyba
	tfO6GbzWcydQ98I/QF7Y15VvAT1WCYbJCo0vmBm9ntoj33fcwz5/MrmtLFdX+BaJi2z7
	roZKdsLcJHN+DDCEcNGqRtIcumx1eJcZXC+seJE0pqtv01aDThWyn2/OeMNkTHGx6QBF
	3FQg==
X-Gm-Message-State: ALoCoQmZPpQXiMVptZmFNL0NSUgrnzAPgPnjjfvGH0LrZLz6ycS7pBFoN5G+qcdCSJxZk91e6YFW
X-Received: by 10.180.76.137 with SMTP id k9mr781161wiw.21.1395686259379;
	Mon, 24 Mar 2014 11:37:39 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id lz3sm41541980wic.1.2014.03.24.11.37.35
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Mon, 24 Mar 2014 11:37:38 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id CC46A56239D; Mon, 24 Mar 2014 18:37:29 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 24 Mar 2014 18:37:27 +0000
Message-Id: <a9cfa3eacfc99550e1ad3f8bb61b2a0bc9b44332.1395686148.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <7e59b6b1cb44de00c512facece5ede96375a411f.1395686148.git.alexandru.damian@intel.com>
References: <7e59b6b1cb44de00c512facece5ede96375a411f.1395686148.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1395686148.git.alexandru.damian@intel.com>
References: <cover.1395686148.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 17/18] toaster: clean exit on bb server shutdown
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
X-List-Received-Date: Mon, 24 Mar 2014 18:37:39 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch adds the capability to have the Toaster UI
detect when the Bitbake server exited and cleanly
trigger a clean shutdown of the system through the toaster
starting script.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bin/toaster            | 28 ++++++++++++++++++++++++++--
 lib/bb/ui/toasterui.py |  7 +++++--
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index 9c0a15f..b27f7c2 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -68,11 +68,16 @@ function addtoConfiguration()
         echo $1 >> ${BUILDDIR}/conf/$2
 }
 
+INSTOPSYSTEM=0
+
 # define the stop command
 function stop_system()
 {
+    # prevent reentry
+    if [ $INSTOPSYSTEM == 1 ]; then return; fi
+    INSTOPSYSTEM=1
     if [ -f ${BUILDDIR}/.toasterui.pid ]; then
-        kill $(< ${BUILDDIR}/.toasterui.pid )
+        kill $(< ${BUILDDIR}/.toasterui.pid ) 2>/dev/null
         rm ${BUILDDIR}/.toasterui.pid
     fi
     BBSERVER=localhost:8200 bitbake -m
@@ -80,8 +85,24 @@ function stop_system()
     webserverKillAll
     # force stop any misbehaving bitbake server
     lsof bitbake.lock | awk '{print $2}' | grep "[0-9]\+" | xargs -n1 -r kill
+    trap - SIGHUP
+    trap - SIGCHLD
+    INSTOPSYSTEM=0
+}
+
+function check_pidbyfile() {
+    [ -e $1 ] && kill -0 $(< $1) 2>/dev/null
 }
 
+
+function notify_chldexit() {
+    if [ $NOTOASTERUI == 0 ]; then
+        check_pidbyfile ${BUILDDIR}/.toasterui.pid && return
+        stop_system
+    fi
+}
+
+
 # We make sure we're running in the current shell and in a good environment
 
 if [ -z "$ZSH_NAME" ] && [ `basename \"$0\"` = `basename \"$BASH_SOURCE\"` ]; then
@@ -179,10 +200,13 @@ case $CMD in
             stop_system
             echo "Failed ${CMD}."
         fi
+        # stop system on terminal exit
+        set -o monitor
+        trap stop_system SIGHUP
+        trap notify_chldexit SIGCHLD
     ;;
     stop )
         stop_system
-        trap '' SIGHUP
         echo "Successful ${CMD}."
     ;;
 esac
diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index 453eaf9..37d6b1a 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -249,6 +249,10 @@ def main(server, eventHandler, params ):
                     buildinfohelper.store_license_manifest_path(event)
                 continue
 
+            if isinstance(event, bb.cooker.CookerExit):
+                # exit when the server exits
+                break
+
             # ignore
             if isinstance(event, (bb.event.BuildBase,
                                   bb.event.StampUpdate,
@@ -258,8 +262,7 @@ def main(server, eventHandler, params ):
                                   bb.event.OperationProgress,
                                   bb.command.CommandFailed,
                                   bb.command.CommandExit,
-                                  bb.command.CommandCompleted,
-                                  bb.cooker.CookerExit)):
+                                  bb.command.CommandCompleted)):
                 continue
 
             if isinstance(event, bb.event.DepTreeGenerated):
-- 
1.8.3.2


