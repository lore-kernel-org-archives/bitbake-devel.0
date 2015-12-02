Return-Path: <avery.brian@gmail.com>
Received: from mail-pf0-f179.google.com (mail-pf0-f179.google.com
	[209.85.192.179])
	by mail.openembedded.org (Postfix) with ESMTP id 82DB460616
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Dec 2015 17:59:31 +0000 (UTC)
Received: by pfu207 with SMTP id 207so1134363pfu.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Dec 2015 09:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=/4NeLSXd/rxZItUqn1slCUbVJ4lCllXrSgfsQ71Od/o=;
	b=w3hWBYNEOE8MaPwioTlURoXmPePN78jLm96HJBzZcPaZfMjYQMK5kkHRAshtcG9ENC
	bfWPJ8Cetij7P66svRK1B89AnN8XE5IIdaKZLpz3W7ODnmuyb2B5WbJKReUmMvLzN/Vy
	HSexzwjGkUMgiO5HrE2mMWJdtLA10y7ILmCRLOKYL9AStP/ZgNO34MtLoH+pSpfngjHj
	1Yn3TmqzRDAE9ShWMkzLas9eTJdJfh9fU7ztjBq4ToZl2EIAJhGUsHHfZ0Z4bi+6OL9T
	4DVd8RRGjYZna8f3O5T47E1n96Hm114irSH27nvXqXx/lYOAj5PqSmIvMSneB5eQdv+v
	y0wg==
X-Received: by 10.98.72.18 with SMTP id v18mr6539323pfa.68.1449079171833;
	Wed, 02 Dec 2015 09:59:31 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	e25sm5657267pfb.64.2015.12.02.09.59.30
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Dec 2015 09:59:30 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Dec 2015 10:02:33 -0800
Message-Id: <757ad75509219d7ce5afe9db3bb7524fde4a3809.1449078919.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1449078919.git.avery.brian@gmail.com>
References: <cover.1449078919.git.avery.brian@gmail.com>
Subject: [PATCH 01/30] toaster: don't allow to run toaster as a script
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
X-List-Received-Date: Wed, 02 Dec 2015 17:59:31 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Removed support of starting toaster as a script.

Sourcing a toaster script becomes the only way to start it.
It's consistent with the way oe build system is started by sourcing
oe-init-build-env. It also returns user back to shell, so user can
continue running builds without having to open new terminal window.

[YOCTO #8279]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 bin/toaster | 80 ++++---------------------------------------------------------
 1 file changed, 5 insertions(+), 75 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index 432756c..7b510fc 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/echo ERROR: This script needs to be sourced. Please run as .
 # (c) 2013 Intel Corp.
 
 # This program is free software; you can redistribute it and/or modify
@@ -81,9 +81,7 @@ webserverStartAll()
         return $retval
     fi
 
-    if [ "$TOASTER_MANAGED" = '1' ]; then
-        python $BBBASEDIR/lib/toaster/manage.py checksettings --traceback || retval=1
-    fi
+    python $BBBASEDIR/lib/toaster/manage.py checksettings --traceback || retval=1
 
     if [ $retval -eq 1 ]; then
         printf "\nError while checking settings; aborting\n"
@@ -176,8 +174,6 @@ else
     TOASTER=$0
 fi
 
-[ `basename \"$0\"` = `basename \"${TOASTER}\"` ] && TOASTER_MANAGED=1
-
 BBBASEDIR=`dirname $TOASTER`/..
 OEROOT=`dirname $TOASTER`/../..
 
@@ -250,88 +246,22 @@ for param in $*; do
     esac
 done
 
-if [ "$TOASTER_MANAGED" = '1' ]; then
-    # We are called as standalone. We refuse to run in a build environment - we need the interactive mode for that.
-    # Start just the web server, point the web browser to the interface, and start any Django services.
-
-    if ! verify_prereq; then
-        echo "Error: Could not verify that the needed dependencies are installed. Please use virtualenv and pip to install dependencies listed in toaster-requirements.txt" 1>&2
-        exit 1
-    fi
-
-    if [ -n "$BUILDDIR" ]; then
-        printf "Error: It looks like you sourced oe-init-build-env. Toaster cannot start in build mode from an oe-core build environment.\n You should be starting Toaster from a new terminal window.\n" 1>&2
-        exit 1
-    fi
-
-    # Define a fake builddir where only the pid files are actually created. No real builds will take place here.
-    BUILDDIR=/tmp/toaster_$$
-    if [ -d "$BUILDDIR" ]; then
-        echo "Previous toaster run directory $BUILDDIR found, cowardly refusing to start. Please remove the directory when that toaster instance is over" 2>&1
-        exit 1
-    fi
-
-    mkdir -p "$BUILDDIR"
-
-    RUNNING=1
-    trap_ctrlc() {
-        echo "** Stopping system"
-        webserverKillAll
-        RUNNING=0
-    }
-
-    do_cleanup() {
-        find "$BUILDDIR" -type f | xargs rm
-        rmdir "$BUILDDIR"
-    }
-    cleanup() {
-        if grep -ir error "$BUILDDIR" >/dev/null; then
-            if grep -irn "That port is already in use" "$BUILDDIR"; then
-                echo "You can use the \"webport=PORTNUMBER\" parameter to start Toaster on a different port (port $WEB_PORT is already in use)"
-                do_cleanup
-            else
-                printf "\nErrors found in the Toaster log files present in '$BUILDDIR'. Directory will not be cleaned.\n Please review the errors and notify toaster@yoctoproject.org or submit a bug https://bugzilla.yoctoproject.org/enter_bug.cgi?product=Toaster"
-            fi
-        else
-            echo "No errors found, removing the run directory '$BUILDDIR'"
-            do_cleanup
-        fi
-    }
-    export TOASTER_MANAGED=1
-    if [ $WEBSERVER -gt 0 ] && ! webserverStartAll; then
-        echo "Failed to start the web server, stopping" 1>&2
-        cleanup
-        exit 1
-    fi
-    if [ $WEBSERVER -gt 0 ] && [ $NOBROWSER -eq 0 ]  ; then
-        echo "Starting browser..."
-        xdg-open http://127.0.0.1:$WEB_PORT/ >/dev/null 2>&1 &
-    fi
-    trap trap_ctrlc 2
-    echo "Toaster is now running. You can stop it with Ctrl-C"
-    while [ $RUNNING -gt 0 ]; do
-        python $BBBASEDIR/lib/toaster/manage.py runbuilds 2>&1 | tee -a "$BUILDDIR/toaster.log"
-        sleep 1
-    done
-    cleanup
-    echo "**** Exit"
-    exit 0
+if [ `basename \"$0\"` = `basename \"${TOASTER}\"` ]; then
+    echo "Error: This script needs to be sourced. Please run as . $TOASTER"
+    exit 1
 fi
 
-
 if ! verify_prereq; then
     echo "Error: Could not verify that the needed dependencies are installed. Please use virtualenv and pip to install dependencies listed in toaster-requirements.txt" 1>&2
     return 1
 fi
 
-
 # We make sure we're running in the current shell and in a good environment
 if [ -z "$BUILDDIR" ] ||  ! which bitbake >/dev/null 2>&1 ; then
     echo "Error: Build environment is not setup or bitbake is not in path." 1>&2
     return 2
 fi
 
-
 # Determine the action. If specified by arguments, fine, if not, toggle it
 if [ "$1" = 'start' ] || [ "$1" = 'stop' ]; then
     CMD="$1"
-- 
1.9.1


