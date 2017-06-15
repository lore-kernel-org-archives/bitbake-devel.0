Return-Path: <david.reyna@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 988B478340
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Jun 2017 05:06:13 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id v5F56ECt004854
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Jun 2017 22:06:14 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.200.76) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.294.0; Wed, 14 Jun 2017 22:06:14 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 14 Jun 2017 21:57:29 -0700
Message-ID: <36e42522bc15d4c9c88248a5f881724cefb6affe.1497502547.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1497502547.git.David.Reyna@windriver.com>
References: <cover.1497502547.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.200.76]
Subject: [PATCH 1/1] toaster: noweb should init database
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
X-List-Received-Date: Thu, 15 Jun 2017 05:06:15 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

When the 'noweb' option for Toaster is used, perform the database
check/create if the Toaster database does not yet exist.

This will allow Toaster to not fail if the first use is with 'noweb'.
This avoids potentially clashing database updates if there are
multiple overlaping 'noweb' sessions (for example with a CI system).

If the user wished to update the database, they can either use the
explicit "lsupdate" command or (re)start a web hosted Toaster session
(which is gated by the webserver's PID).

[YOCTO #11378]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 bin/toaster | 50 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index fd6cabf..61a4a0f 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -24,6 +24,29 @@ Usage: source toaster start|stop [webport=<address:port>] [noweb]
         [webport] Set the development server (default: localhost:8000)
 "
 
+databaseCheck()
+{
+    retval=0
+    # you can always add a superuser later via
+    # ../bitbake/lib/toaster/manage.py createsuperuser --username=<ME>
+    $MANAGE migrate --noinput || retval=1
+
+    if [ $retval -eq 1 ]; then
+        echo "Failed migrations, aborting system start" 1>&2
+        return $retval
+    fi
+    # Make sure that checksettings can pick up any value for TEMPLATECONF
+    export TEMPLATECONF
+    $MANAGE checksettings --traceback || retval=1
+
+    if [ $retval -eq 1 ]; then
+        printf "\nError while checking settings; aborting\n"
+        return $retval
+    fi
+
+    return $retval
+}
+
 webserverKillAll()
 {
     local pidfile
@@ -48,22 +71,9 @@ webserverStartAll()
     fi
 
     retval=0
-    # you can always add a superuser later via
-    # ../bitbake/lib/toaster/manage.py createsuperuser --username=<ME>
-    $MANAGE migrate --noinput || retval=1
 
-    if [ $retval -eq 1 ]; then
-        echo "Failed migrations, aborting system start" 1>&2
-        return $retval
-    fi
-    # Make sure that checksettings can pick up any value for TEMPLATECONF
-    export TEMPLATECONF
-    $MANAGE checksettings --traceback || retval=1
-
-    if [ $retval -eq 1 ]; then
-        printf "\nError while checking settings; aborting\n"
-        return $retval
-    fi
+    # check the database
+    databaseCheck || return 1
 
     echo "Starting webserver..."
 
@@ -240,6 +250,16 @@ case $CMD in
         line='INHERIT+="toaster buildhistory"'
         grep -q "$line" $conf || echo $line >> $conf
 
+        if [ $WEBSERVER -eq 0 ] ; then
+            # Do not update the database for "noweb" unless
+            # it does not yet exist
+            if [ ! -f "$TOASTER_DIR/toaster.sqlite" ] ; then
+                if ! databaseCheck; then
+                    echo "Failed ${CMD}."
+                  return 4
+                fi
+            fi
+        fi
         if [ $WEBSERVER -gt 0 ] && ! webserverStartAll; then
             echo "Failed ${CMD}."
             return 4
-- 
1.9.1


