Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
	[209.85.220.52])
	by mail.openembedded.org (Postfix) with ESMTP id A593E60667
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Dec 2015 17:59:43 +0000 (UTC)
Received: by pacdm15 with SMTP id dm15so47007094pac.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Dec 2015 09:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=LDV4bz91/YhIbW0YQTYEUgtio5TcW+RIuB353N8ScyU=;
	b=cY7FXdcevZgxr/2Kc5Z+p30kYZkA215qoyAhY0dqOEYMWEWaEn3H+h+WYR5r8Jn5I9
	vDk8kGOU4hxYNl2tpcc+M+YDP/0qE737FvOwpUPr4ojM2SwZLTnXN4rjFMJ0yVbqPdN7
	t1ix5SRTLLUE3rzYCbQPWUlfsU+AWfvEc7pQSnXITJ09d7WlxEpB/2vd1Pa4xUoCw/2L
	bOLuTRROdKp87tTJ85n7fczrF7hJq7dJsNFYpa/wRmNw4VviOP1g5h6rBKUm2E0uiQUM
	vLJIzwJDxqXRs7vpMQLCO31rtJA8JPKXK+mbDL0ul4DXMlSvK5h+Zz9UQkrkpgMgLdqK
	eYMg==
X-Received: by 10.66.219.163 with SMTP id pp3mr6343022pac.55.1449079184377;
	Wed, 02 Dec 2015 09:59:44 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	e25sm5657267pfb.64.2015.12.02.09.59.43
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Dec 2015 09:59:43 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Dec 2015 10:02:44 -0800
Message-Id: <1c6a8574417eb51b89bfc8c93f267f661b9b6ed5.1449078919.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
References: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
In-Reply-To: <cover.1449078919.git.avery.brian@gmail.com>
References: <cover.1449078919.git.avery.brian@gmail.com>
Subject: [PATCH 12/30] toaster: implement start_bitbake function
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
X-List-Received-Date: Wed, 02 Dec 2015 17:59:43 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Separated functionality of starting bitbake server and observer
processes.

This functionality will be used by build controllers to restart
bitbake processes.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 bin/toaster | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index e82df9b..34a4e8f 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -133,6 +133,22 @@ stop_system()
     INSTOPSYSTEM=0
 }
 
+start_bitbake() {
+    unset BBSERVER
+    bitbake --read conf/toaster-pre.conf --postread conf/toaster.conf --server-only -t xmlrpc -B 0.0.0.0:0
+    if [ $? -ne 0 ]; then
+        echo "Bitbake server start failed"
+        return 1
+    fi
+    export BBSERVER=0.0.0.0:-1
+    export DATABASE_URL=`$BBBASEDIR/lib/toaster/manage.py get-dburl`
+    if [ $NOTOASTERUI -eq 0 ]; then        # we start the TOASTERUI only if not inhibited
+        bitbake --observe-only -u toasterui --remote-server=$BBSERVER -t xmlrpc >>${BUILDDIR}/toaster_ui.log 2>&1 \
+            & echo $! >${BUILDDIR}/.toasterui.pid
+    fi
+    return 0
+}
+
 stop_bitbake() {
     BBSERVER=0.0.0.0:-1 bitbake -m
     unset BBSERVER
@@ -324,28 +340,15 @@ fi
 
 case $CMD in
     start )
-        start_success=1
         addtoConfiguration toaster.conf "INHERIT+=\"toaster buildhistory\"" $TOASTER_BRBE
         echo > ${BUILDDIR}/conf/toaster-pre.conf
         if [ $WEBSERVER -gt 0 ] && ! webserverStartAll; then
             echo "Failed ${CMD}."
             return 4
         fi
-        unset BBSERVER
-        bitbake --read conf/toaster-pre.conf --postread conf/toaster.conf --server-only -t xmlrpc -B 0.0.0.0:0
-        if [ $? -ne 0 ]; then
-            start_success=0
-            echo "Bitbake server start failed"
-        else
-            export BBSERVER=0.0.0.0:-1
-            export DATABASE_URL=`$BBBASEDIR/lib/toaster/manage.py get-dburl`
-            if [ $NOTOASTERUI -eq 0 ]; then        # we start the TOASTERUI only if not inhibited
-                bitbake --observe-only -u toasterui --remote-server=$BBSERVER -t xmlrpc >>${BUILDDIR}/toaster_ui.log 2>&1 \
-                    & echo $! >${BUILDDIR}/.toasterui.pid
-            fi
+        start_bitbake
+        if [ $? -eq 0 ]; then
             python $BBBASEDIR/lib/toaster/manage.py runbuilds & echo $! >${BUILDDIR}/.runbuilds.pid
-        fi
-        if [ $start_success -eq 1 ]; then
             # set fail safe stop system on terminal exit
             trap stop_system SIGHUP
             echo "Successful ${CMD}."
-- 
1.9.1


