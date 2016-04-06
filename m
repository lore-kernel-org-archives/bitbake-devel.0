Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com [74.125.82.41])
	by mail.openembedded.org (Postfix) with ESMTP id BDDA07708A
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Apr 2016 16:47:05 +0000 (UTC)
Received: by mail-wm0-f41.google.com with SMTP id n3so71336970wmn.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Apr 2016 09:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=v8NE5/9l2ATrDtBu1fYgtvZbqvBQnsXY482kGtspZRk=;
	b=d+Bxbu15108a2HfSFI8VYxNNURgacwAavVIxtccqsKRLQrSh5DXGkSLNRv4vSca5/U
	9cqaJPMri6tnOZtanBwq43YiW72BRMp14AHFRU+8xILt0KjABld8/jGRVVc17UrDHztS
	/amMTRkIf/4k5/I6Hg8QfNDLGFAOKmUBxnQ925HvYBNRrIEvqeNHEBRYoTyBN4MmV+GN
	a1ey/SZCi9yTbGn6wEoiR8A1fqFl64VjpiwmPiBnQqAzoq4DskfYI/ehcAKNEJQvLGay
	ap+p+YuBMGbQlhEfOdr3q+UvS8lbIt5tTEb6xbMownuGIO6DLbITxc8+Y3eFejiV9o8E
	Uj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=v8NE5/9l2ATrDtBu1fYgtvZbqvBQnsXY482kGtspZRk=;
	b=Tsk7NejEuDaXjthoEcenAJra5+ySFZWBClsgVqE5RtUk7RBeWMX1+LHtMekE9mvV1L
	OF6ODOh5Cb/NWz6yqAg/Qh47MXzxI2fTfi3UCtCr3OOs1v3a2R5cxN1i80hGTKShpTRC
	TlUsfv1MpOC/GpC2REbyDq6k3OncHgqa530j1nu6/zIQhc9sIiRNbH+YvsveeSw7dcPZ
	jaECs6Xv3fTsI4BF4NXlRGUeJkMMUIcwvrdbW2MY1wMfhVIihx0mc3JQYOgZNGgTLpSk
	7ikPI/cs79jq1qSKDV01MDzmzXke0BmbajThdJtMFq25IyhJL4JGHaoeydR2/0eQp4BI
	FKOw==
X-Gm-Message-State: AD7BkJK5DbYTdn6Qecd7drJr74SPsbV5xe17zl8W4JBKg62CO4KRMqOZxGiOE/Ea6IUU7CrH
X-Received: by 10.28.148.19 with SMTP id w19mr25218712wmd.10.1459961225382;
	Wed, 06 Apr 2016 09:47:05 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id gt7sm4145345wjc.1.2016.04.06.09.47.04
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 06 Apr 2016 09:47:04 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Apr 2016 17:46:11 +0100
Message-Id: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1459960764.git.michael.g.wood@intel.com>
References: <cover.1459960764.git.michael.g.wood@intel.com>
Subject: [PATCH 01/38] toaster: don't start bitbake server
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
X-List-Received-Date: Wed, 06 Apr 2016 16:47:08 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

From now on toaster script will not run bitbake server.
It will be started by runbuilds and stopped after the build.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 bin/toaster | 67 ++++++-------------------------------------------------------
 1 file changed, 6 insertions(+), 61 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index d409554..6a85ae2 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -17,7 +17,7 @@
 # You should have received a copy of the GNU General Public License
 # along with this program. If not, see http://www.gnu.org/licenses/.
 
-# Usage: source toaster [start|stop|restart-bitbake]
+# Usage: source toaster [start|stop]
 #                       [webport=<port>] [noui] [noweb]
 
 # Helper function to kill a background toaster development server
@@ -95,7 +95,6 @@ stop_system()
         kill `cat ${BUILDDIR}/.toasterui.pid` 2>/dev/null
         rm ${BUILDDIR}/.toasterui.pid
     fi
-    stop_bitbake
     webserverKillAll
     # unset exported variables
     unset DATABASE_URL
@@ -106,31 +105,6 @@ stop_system()
     INSTOPSYSTEM=0
 }
 
-start_bitbake() {
-    unset BBSERVER
-    bitbake --read conf/toaster.conf --server-only -t xmlrpc -B 0.0.0.0:0
-    if [ $? -ne 0 ]; then
-        echo "Bitbake server start failed"
-        return 1
-    fi
-    export BBSERVER=0.0.0.0:-1
-    export DATABASE_URL=`$MANAGE get-dburl`
-    # we start the TOASTERUI only if not inhibited
-    if [ $NOTOASTERUI -eq 0 ]; then
-        bitbake --observe-only -u toasterui --remote-server=$BBSERVER -t xmlrpc \
-            >>${BUILDDIR}/toaster_ui.log 2>&1 \
-            & echo $! >${BUILDDIR}/.toasterui.pid
-    fi
-    return 0
-}
-
-stop_bitbake() {
-    BBSERVER=0.0.0.0:-1 bitbake -m
-    unset BBSERVER
-    # force stop any misbehaving bitbake server
-    lsof -t bitbake.lock | awk '{print $2}' | grep "[0-9]\+" | xargs -n1 -r kill
-}
-
 verify_prereq() {
     # Verify Django version
     reqfile=$(python -c "import os; print os.path.realpath('$BBBASEDIR/toaster-requirements.txt')")
@@ -229,15 +203,6 @@ if [ `basename \"$0\"` = `basename \"${TOASTER}\"` ]; then
     return 1
 fi
 
-if [ "$1" = 'restart-bitbake' ] ; then
-    stop_bitbake
-    sleep 1
-    start_bitbake
-    rc=$?
-    sleep 3
-    return $rc
-fi
-
 verify_prereq || return 1
 
 # We make sure we're running in the current shell and in a good environment
@@ -281,16 +246,6 @@ case $CMD in
              $MANAGE checksocket "0.0.0.0:$WEB_PORT" || return 1
         fi
 
-        # Make sure it's safe to start by checking bitbake lock
-        if [ -e $BUILDDIR/bitbake.lock ]; then
-            python -c "import fcntl; fcntl.flock(open(\"$BUILDDIR/bitbake.lock\"), fcntl.LOCK_EX|fcntl.LOCK_NB)" 2>/dev/null
-            if [ $? -ne 0 ] ; then
-                echo "Error: bitbake lock state error. File locks show that the system is on." 1>&2
-                echo "Please wait for the current build to finish, stop and then start the system again." 1>&2
-                return 3
-            fi
-        fi
-
         # kill Toaster web server if it's alive
         if [ -e $BUILDDIR/.toastermain.pid ] && kill -0 `cat $BUILDDIR/.toastermain.pid`; then
             echo "Warning: bitbake appears to be dead, but the Toaster web server is running." 1>&2
@@ -308,22 +263,12 @@ case $CMD in
             echo "Failed ${CMD}."
             return 4
         fi
-        start_bitbake
-        if [ $? -eq 0 ]; then
-            $MANAGE runbuilds & echo $! >${BUILDDIR}/.runbuilds.pid
-            # set fail safe stop system on terminal exit
-            trap stop_system SIGHUP
-            echo "Successful ${CMD}."
-            return 0
-        else
-            # failed start, do stop
-            stop_system
-            echo "Failed ${CMD}."
-            return 1
-        fi
-        # stop system on terminal exit
-        set -o monitor
+        export DATABASE_URL=`$MANAGE get-dburl`
+        $MANAGE runbuilds & echo $! >${BUILDDIR}/.runbuilds.pid
+        # set fail safe stop system on terminal exit
         trap stop_system SIGHUP
+        echo "Successful ${CMD}."
+        return 0
     ;;
     stop )
         stop_system
-- 
2.1.4


