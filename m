Return-Path: <elliot.smith@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 127F2731A5
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Dec 2015 16:49:06 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga103.fm.intel.com with ESMTP; 17 Dec 2015 08:49:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,441,1444719600"; d="scan'208";a="15002700"
Received: from agusev-mobl2.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.27.121])
	by fmsmga004.fm.intel.com with ESMTP; 17 Dec 2015 08:49:05 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 17 Dec 2015 16:48:50 +0000
Message-Id: <9806bb71225d50d52b9b369a9cc3445d47610d2a.1450370782.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <36bd18a963c5ba2849b5420f81b97b8a8ce57481.1450370782.git.elliot.smith@intel.com>
References: <36bd18a963c5ba2849b5420f81b97b8a8ce57481.1450370782.git.elliot.smith@intel.com>
In-Reply-To: <cover.1450370782.git.elliot.smith@intel.com>
References: <cover.1450370782.git.elliot.smith@intel.com>
Subject: [PATCH 05/11] toaster: add MANAGE variable
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
X-List-Received-Date: Thu, 17 Dec 2015 16:49:06 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Used MANAGE variable to avoid repeating path to
manage.py in many places in toaster script.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bin/toaster | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index ccbfdb3..087e3f9 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -57,14 +57,14 @@ webserverStartAll()
     retval=0
     # you can always add a superuser later via
     # ../bitbake/lib/toaster/manage.py createsuperuser --username=<ME>
-    python $BBBASEDIR/lib/toaster/manage.py migrate --noinput || retval=1
+    $MANAGE migrate --noinput || retval=1
 
     if [ $retval -eq 1 ]; then
         echo "Failed migrations, aborting system start" 1>&2
         return $retval
     fi
 
-    python $BBBASEDIR/lib/toaster/manage.py checksettings --traceback || retval=1
+    $MANAGE checksettings --traceback || retval=1
 
     if [ $retval -eq 1 ]; then
         printf "\nError while checking settings; aborting\n"
@@ -73,7 +73,7 @@ webserverStartAll()
 
     echo "Starting webserver..."
 
-    python $BBBASEDIR/lib/toaster/manage.py runserver "0.0.0.0:$WEB_PORT" \
+    $MANAGE runserver "0.0.0.0:$WEB_PORT" \
            </dev/null >>${BUILDDIR}/toaster_web.log 2>&1 \
            & echo $! >${BUILDDIR}/.toastermain.pid
 
@@ -130,7 +130,7 @@ start_bitbake() {
         return 1
     fi
     export BBSERVER=0.0.0.0:-1
-    export DATABASE_URL=`$BBBASEDIR/lib/toaster/manage.py get-dburl`
+    export DATABASE_URL=`$MANAGE get-dburl`
     # we start the TOASTERUI only if not inhibited
     if [ $NOTOASTERUI -eq 0 ]; then
         bitbake --observe-only -u toasterui --remote-server=$BBSERVER -t xmlrpc \
@@ -184,6 +184,7 @@ else
 fi
 
 BBBASEDIR=`dirname $TOASTER`/..
+MANAGE=$BBBASEDIR/lib/toaster/manage.py
 OEROOT=`dirname $TOASTER`/../..
 NOTOASTERUI=0
 WEBSERVER=1
@@ -316,7 +317,7 @@ echo "The system will $CMD."
 
 # check if addr:port is not in use
 if [ "$CMD" == 'start' ]; then
-    python $BBBASEDIR/lib/toaster/manage.py checksocket "0.0.0.0:$WEB_PORT" || return 1
+    $MANAGE checksocket "0.0.0.0:$WEB_PORT" || return 1
 fi
 
 # Make sure it's safe to run by checking bitbake lock
@@ -351,7 +352,7 @@ case $CMD in
         fi
         start_bitbake
         if [ $? -eq 0 ]; then
-            python $BBBASEDIR/lib/toaster/manage.py runbuilds & echo $! >${BUILDDIR}/.runbuilds.pid
+            $MANAGE runbuilds & echo $! >${BUILDDIR}/.runbuilds.pid
             # set fail safe stop system on terminal exit
             trap stop_system SIGHUP
             echo "Successful ${CMD}."
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


