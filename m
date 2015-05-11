Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f47.google.com (mail-wg0-f47.google.com [74.125.82.47])
	by mail.openembedded.org (Postfix) with ESMTP id 7741C73F78
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 May 2015 10:59:24 +0000 (UTC)
Received: by wgin8 with SMTP id n8so124386352wgi.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 May 2015 03:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=Z5C4ngLVQ177mn2jK1oqIwLWH02BCl57lUmTZieG3G4=;
	b=O1IK/Ylwek+mgafeV8EldKrq9Cxybo+SPMZeiH3bQbkRzHAR+JbNGgY8eyIGA5AY7e
	OQg7ViomTQJWiTEsVVT0hZyUwB8rCqPtPeJuDpqI7AH6qMBoaB7WBkTtqEu5iGCzKABE
	ybV4D/ylHQGPveodNWBneNgqoJNcm8NInqqmQOa54q5sO5RWE8BAj13AibDCAvoKccD+
	e0hMALO98ZIn1gV74oi2YKicT0OIhA49tXTjjWifqWWkCovC/9wlG7SKnAQBkAb+sKLi
	Ld1wNErQzYGivSRKYXup/sXSlLNhy26hOGuGleb3m0EfJB/9nULj6S2rud6gvBLm1Vqc
	VF6A==
X-Gm-Message-State: ALoCoQku5PXvkWCG7jeRWNBB3J7r9RtlwIrAZ1XnC9MzuTLKiby4qb3AU6Exmo/WRfI3AeKF8igm
X-Received: by 10.180.105.227 with SMTP id gp3mr18490394wib.56.1431341964969; 
	Mon, 11 May 2015 03:59:24 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id k9sm12724810wia.6.2015.05.11.03.59.23
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 11 May 2015 03:59:24 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id E7A3B5603BA; Mon, 11 May 2015 11:58:42 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 11 May 2015 11:58:35 +0100
Message-Id: <8de6724d6e1454416288d353fd5da7ae81c8e97b.1431338029.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <7ffd7ba923c85a735e0dad528f1ab9d50073724b.1431338029.git.alexandru.damian@intel.com>
References: <7ffd7ba923c85a735e0dad528f1ab9d50073724b.1431338029.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1431338029.git.alexandru.damian@intel.com>
References: <cover.1431338029.git.alexandru.damian@intel.com>
Subject: [PATCH 04/11] toaster: Code cleanup: indent
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
X-List-Received-Date: Mon, 11 May 2015 10:59:24 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Replaced tabs with 4 spaces.
Removed useless semicolons at the end of lines.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bin/toaster | 125 ++++++++++++++++++++++++++++++------------------------------
 1 file changed, 62 insertions(+), 63 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index 8568c13..f5ee68c 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -30,65 +30,65 @@
 
 function webserverKillAll()
 {
-	local pidfile
-	for pidfile in ${BUILDDIR}/.toastermain.pid; do
-		if [ -f ${pidfile} ]; then
-		while kill -0 $(< ${pidfile}) 2>/dev/null; do
-			kill -SIGTERM -$(< ${pidfile}) 2>/dev/null
-			sleep 1;
-			# Kill processes if they are still running - may happen in interactive shells
-			pkill -U $UID -f "python.*manage.py runserver"
-		done;
-		rm  ${pidfile}
-		fi
-	done
+    local pidfile
+    for pidfile in ${BUILDDIR}/.toastermain.pid; do
+        if [ -f ${pidfile} ]; then
+        while kill -0 $(< ${pidfile}) 2>/dev/null; do
+            kill -SIGTERM -$(< ${pidfile}) 2>/dev/null
+            sleep 1
+            # Kill processes if they are still running - may happen in interactive shells
+            pkill -U $UID -f "python.*manage.py runserver"
+        done;
+        rm  ${pidfile}
+        fi
+    done
 }
 
 function webserverStartAll()
 {
-	# do not start if toastermain points to a valid process
-	if ! cat "${BUILDDIR}/.toastermain.pid" 2>/dev/null | xargs -I{} kill -0 {} ; then
-            retval=1
-            rm "${BUILDDIR}/.toastermain.pid"
-        fi
+    # do not start if toastermain points to a valid process
+    if ! cat "${BUILDDIR}/.toastermain.pid" 2>/dev/null | xargs -I{} kill -0 {} ; then
+        retval=1
+        rm "${BUILDDIR}/.toastermain.pid"
+    fi
 
+    retval=0
+    python $BBBASEDIR/lib/toaster/manage.py syncdb || retval=1
+    python $BBBASEDIR/lib/toaster/manage.py migrate orm || retval=2
+    if [ $retval -eq 1 ]; then
+        echo "Failed db sync, stopping system start" 1>&2
+    elif [ $retval -eq 2 ]; then
+        echo -e "\nError on migration, trying to recover... \n"
+        python $BBBASEDIR/lib/toaster/manage.py migrate orm 0001_initial --fake
         retval=0
-        python $BBBASEDIR/lib/toaster/manage.py syncdb || retval=1
-        python $BBBASEDIR/lib/toaster/manage.py migrate orm || retval=2
-        if [ $retval -eq 1 ]; then
-                echo "Failed db sync, stopping system start" 1>&2
-        elif [ $retval -eq 2 ]; then
-            echo -e "\nError on migration, trying to recover... \n"
-            python $BBBASEDIR/lib/toaster/manage.py migrate orm 0001_initial --fake
-            retval=0
-            python $BBBASEDIR/lib/toaster/manage.py migrate orm || retval=1
-        fi
-	if [ "$TOASTER_MANAGED" '==' '1' ]; then
-	        python $BBBASEDIR/lib/toaster/manage.py migrate bldcontrol || retval=1
-		python $BBBASEDIR/lib/toaster/manage.py checksettings  --traceback || retval=1
-	fi
-        if [ $retval -eq 0 ]; then
-	    echo "Starting webserver..."
-            python $BBBASEDIR/lib/toaster/manage.py runserver "0.0.0.0:$WEB_PORT" </dev/null >>${BUILDDIR}/toaster_web.log 2>&1 & echo $! >${BUILDDIR}/.toastermain.pid
-            sleep 1
-            if ! cat "${BUILDDIR}/.toastermain.pid" | xargs -I{} kill -0 {} ; then
-                retval=1
-                rm "${BUILDDIR}/.toastermain.pid"
-	    else
-		echo "Webserver address:  http://0.0.0.0:$WEB_PORT/"
-            fi
+        python $BBBASEDIR/lib/toaster/manage.py migrate orm || retval=1
+    fi
+    if [ "$TOASTER_MANAGED" '==' '1' ]; then
+        python $BBBASEDIR/lib/toaster/manage.py migrate bldcontrol || retval=1
+        python $BBBASEDIR/lib/toaster/manage.py checksettings  --traceback || retval=1
+    fi
+    if [ $retval -eq 0 ]; then
+        echo "Starting webserver..."
+        python $BBBASEDIR/lib/toaster/manage.py runserver "0.0.0.0:$WEB_PORT" </dev/null >>${BUILDDIR}/toaster_web.log 2>&1 & echo $! >${BUILDDIR}/.toastermain.pid
+        sleep 1
+        if ! cat "${BUILDDIR}/.toastermain.pid" | xargs -I{} kill -0 {} ; then
+            retval=1
+            rm "${BUILDDIR}/.toastermain.pid"
+        else
+            echo "Webserver address:  http://0.0.0.0:$WEB_PORT/"
         fi
-        return $retval
+    fi
+    return $retval
 }
 
 # Helper functions to add a special configuration file
 
 function addtoConfiguration()
 {
-        file=$1
-        shift
-        echo "#Created by toaster start script" > ${BUILDDIR}/conf/$file
-        for var in "$@"; do echo $var >> ${BUILDDIR}/conf/$file; done
+    file=$1
+    shift
+    echo "#Created by toaster start script" > ${BUILDDIR}/conf/$file
+    for var in "$@"; do echo $var >> ${BUILDDIR}/conf/$file; done
 }
 
 INSTOPSYSTEM=0
@@ -127,7 +127,7 @@ function notify_chldexit() {
 
 
 function verify_prereq() {
-	# Verify prerequisites
+    # Verify prerequisites
 
     if ! echo "import django; print (1,) == django.VERSION[0:1] and django.VERSION[1:2][0] in (6,)" | python 2>/dev/null | grep True >/dev/null; then
         echo -e "This program needs Django 1.6. Please install with\n\npip install django==1.6\n"
@@ -174,25 +174,25 @@ if [ `basename \"$0\"` = `basename \"${SRCFILE}\"` ]; then
     # Start just the web server, point the web browser to the interface, and start any Django services.
 
     if ! verify_prereq; then
-        echo -e "Error: Could not verify that the needed dependencies are installed. Please use virtualenv and pip to install dependencies listed in toaster-requirements.txt" 1>&2;
-        exit 1;
+        echo -e "Error: Could not verify that the needed dependencies are installed. Please use virtualenv and pip to install dependencies listed in toaster-requirements.txt" 1>&2
+        exit 1
     fi
 
     if [ -n "$BUILDDIR" ]; then
-	echo -e "Error: It looks like you sourced oe-init-build-env. Toaster cannot start in build mode from an oe-core build environment.\n You should be starting Toaster from a new terminal window." 1>&2;
-        exit 1;
+        echo -e "Error: It looks like you sourced oe-init-build-env. Toaster cannot start in build mode from an oe-core build environment.\n You should be starting Toaster from a new terminal window." 1>&2
+        exit 1
     fi
 
     if ! which daemon >/dev/null 2>&1; then
-        echo -e "Failed dependency; toaster needs the 'daemon' program in order to be able to start builds'. Please install the 'daemon' program from your distribution repositories or http://www.libslack.org/daemon/" 1>&2;
-	exit 1;
+        echo -e "Failed dependency; toaster needs the 'daemon' program in order to be able to start builds'. Please install the 'daemon' program from your distribution repositories or http://www.libslack.org/daemon/" 1>&2
+        exit 1
     fi
 
     # Define a fake builddir where only the pid files are actually created. No real builds will take place here.
     BUILDDIR=/tmp/toaster_$$
     if [ -d "$BUILDDIR" ]; then
         echo -e "Previous toaster run directory $BUILDDIR found, cowardly refusing to start. Please remove the directory when that toaster instance is over" 2>&1
-        exit 1;
+        exit 1
     fi
 
     mkdir -p "$BUILDDIR"
@@ -219,14 +219,14 @@ if [ `basename \"$0\"` = `basename \"${SRCFILE}\"` ]; then
         else
             echo "No errors found, removing the run directory '$BUILDDIR'"
             do_cleanup
-        fi;
+        fi
     }
     TOASTER_MANAGED=1
     export TOASTER_MANAGED=1
     if [ $WEBSERVER -gt 0 ] && ! webserverStartAll; then
-        echo "Failed to start the web server, stopping" 1>&2;
+        echo "Failed to start the web server, stopping" 1>&2
         cleanup
-        exit 1;
+        exit 1
     fi
     if [ $WEBSERVER -gt 0 ]; then
         echo "Starting browser..."
@@ -245,14 +245,14 @@ fi
 
 
 if ! verify_prereq; then
-	echo -e "Error: Could not verify that the needed dependencies are installed. Please use virtualenv and pip to install dependencies listed in toaster-requirements.txt" 1>&2;
-	return 1;
+    echo -e "Error: Could not verify that the needed dependencies are installed. Please use virtualenv and pip to install dependencies listed in toaster-requirements.txt" 1>&2
+    return 1
 fi
 
 
 # We make sure we're running in the current shell and in a good environment
 if [ -z "$BUILDDIR" ] ||  ! which bitbake >/dev/null 2>&1 ; then
-    echo "Error: Build environment is not setup or bitbake is not in path." 1>&2;
+    echo "Error: Build environment is not setup or bitbake is not in path." 1>&2
     return 2
 fi
 
@@ -265,7 +265,7 @@ else
         CMD="start"
     else
         CMD="stop"
-    fi;
+    fi
 fi
 
 echo "The system will $CMD."
@@ -303,7 +303,7 @@ case $CMD in
         unset BBSERVER
         PREREAD=""
         if [ -e ${BUILDDIR}/conf/toaster-pre.conf ]; then
-		rm ${BUILDDIR}/conf/toaster-pre.conf
+            rm ${BUILDDIR}/conf/toaster-pre.conf
         fi
         bitbake $PREREAD --postread conf/toaster.conf --server-only -t xmlrpc -B 0.0.0.0:0
         if [ $? -ne 0 ]; then
@@ -337,4 +337,3 @@ case $CMD in
     ;;
 esac
 
-
-- 
1.9.1


