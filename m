Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
	by mail.openembedded.org (Postfix) with ESMTP id CE917758FD
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jun 2015 14:40:01 +0000 (UTC)
Received: by wgme6 with SMTP id e6so37431049wgm.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jun 2015 07:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=h+cJ75sEmza6sur02HNwP28P46oFLMv0max9PEpuL9A=;
	b=NPiTxsDZwWpkVA3lkWj0SAx/VaObLImZ/vgAJ7XkYT2VpX33ru/qM/rIcjEm9FWS7r
	68Zrsn0rkyJ+Pst7beHrkt2p8FMEU7EKOOUw9HHjFaoku1LvX6Uj8AIcsVWfXoTwHSHP
	2EKs7VbNCQwtjyfgF8n3Uo5iamjHOBegFbpxpfqG+raHXFC3CBz5NPOQDnnH6kiMDdCK
	bL2JkQplhpnRz8xgabq8JutcZMmIgEdmD2zwW9IetqlMk4iMtUgi0swfvcbosSUXVhbX
	PJ3gZ+l/wLxnmMGcy2bXBsYqg7ZrYAw2AdgkhMqooEcwp0gbBT7VWysbthS2tEYzB2yY
	pWRg==
X-Gm-Message-State: ALoCoQluyHCGeimSbNsXMRIV4jR8688yvZRjxRo8u4wicYVeWXHYDuUOVCGONO7fXJi2qCxAbn9z
X-Received: by 10.180.90.73 with SMTP id bu9mr19717313wib.88.1433947202304;
	Wed, 10 Jun 2015 07:40:02 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id u6sm14845547wjy.13.2015.06.10.07.40.01
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 10 Jun 2015 07:40:01 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 2396956124B; Wed, 10 Jun 2015 15:39:09 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 10 Jun 2015 15:39:03 +0100
Message-Id: <febf8bedf8f9d37659831cdde208d14ece2fb322.1433946742.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <15a2274eba13d19b864f337057d61c75ff7849cc.1433946742.git.alexandru.damian@intel.com>
References: <15a2274eba13d19b864f337057d61c75ff7849cc.1433946742.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1433946742.git.alexandru.damian@intel.com>
References: <cover.1433946742.git.alexandru.damian@intel.com>
Subject: [PATCH 15/19] toaster: Make toaster script to work in dash
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
X-List-Received-Date: Wed, 10 Jun 2015 14:40:02 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Made it working in dash. Note, that due to dash limitations
script will not work if sourced.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bin/toaster | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index 0fa8b60..411ce2c 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
 # (c) 2013 Intel Corp.
 
 # This program is free software; you can redistribute it and/or modify
@@ -54,7 +54,7 @@ webserverStartAll()
     fi
 
     retval=0
-    if [ "$TOASTER_MANAGED" '==' '1' ]; then
+    if [ "$TOASTER_MANAGED" '=' '1' ]; then
         python $BBBASEDIR/lib/toaster/manage.py syncdb || retval=1
     else
         python $BBBASEDIR/lib/toaster/manage.py syncdb --noinput || retval=1
@@ -68,7 +68,7 @@ webserverStartAll()
         retval=0
         python $BBBASEDIR/lib/toaster/manage.py migrate orm || retval=1
     fi
-    if [ "$TOASTER_MANAGED" '==' '1' ]; then
+    if [ "$TOASTER_MANAGED" = '1' ]; then
         python $BBBASEDIR/lib/toaster/manage.py migrate bldcontrol || retval=1
         python $BBBASEDIR/lib/toaster/manage.py checksettings  --traceback || retval=1
     fi
@@ -148,7 +148,16 @@ verify_prereq() {
 
 
 # read command line parameters
-BBBASEDIR=`dirname ${BASH_SOURCE:-${(%):-%x}}`/..
+if [ -n "$BASH_SOURCE" ] ; then
+    TOASTER=${BASH_SOURCE}
+elif [ -n "$ZSH_NAME" ] ; then
+    TOASTER=${(%):-%x}
+else
+    TOASTER=$0
+fi
+
+BBBASEDIR=`dirname $TOASTER`/..
+
 RUNNING=0
 
 NOTOASTERUI=0
@@ -176,7 +185,7 @@ for param in $*; do
     esac
 done
 
-[ -z "$ZSH_NAME" ] && SRCFILE=${BASH_SOURCE} || SRCFILE=$_
+[ -n "${BASH_SOURCE}" ] && SRCFILE=${BASH_SOURCE} || SRCFILE=$_
 
 if [ `basename \"$0\"` = `basename \"${SRCFILE}\"` ]; then
     # We are called as standalone. We refuse to run in a build environment - we need the interactive mode for that.
@@ -236,7 +245,7 @@ if [ `basename \"$0\"` = `basename \"${SRCFILE}\"` ]; then
         echo "Starting browser..."
         xdg-open http://127.0.0.1:$WEB_PORT/ >/dev/null 2>&1 &
     fi
-    trap trap_ctrlc SIGINT
+    trap trap_ctrlc 2
     echo "Toaster is now running. You can stop it with Ctrl-C"
     while [ $RUNNING -gt 0 ]; do
         python $BBBASEDIR/lib/toaster/manage.py runbuilds 2>&1 | tee -a "$BUILDDIR/toaster.log"
@@ -262,7 +271,7 @@ fi
 
 
 # Determine the action. If specified by arguments, fine, if not, toggle it
-if [ "$1" '==' 'start' ] || [ "$1" '==' 'stop' ]; then
+if [ "$1" = 'start' ] || [ "$1" = 'stop' ]; then
     CMD="$1"
 else
     if [ -z "$BBSERVER" ]; then
@@ -281,13 +290,13 @@ if [ -e $BUILDDIR/bitbake.lock ]; then
     python -c "import fcntl; fcntl.flock(open(\"$BUILDDIR/bitbake.lock\"), fcntl.LOCK_EX|fcntl.LOCK_NB)" 2>/dev/null || lock=0
 fi
 
-if [ ${CMD} '==' 'start' ] && [ $lock -eq 0 ]; then
+if [ ${CMD} = 'start' ] && [ $lock -eq 0 ]; then
     echo "Error: bitbake lock state error. File locks show that the system is on." 1>&2
     echo "Please wait for the current build to finish, stop and then start the system again." 1>&2
     return 3
 fi
 
-if [ ${CMD} '==' 'start' ] && [ -e $BUILDDIR/.toastermain.pid ] && kill -0 `cat $BUILDDIR/.toastermain.pid`; then
+if [ ${CMD} = 'start' ] && [ -e $BUILDDIR/.toastermain.pid ] && kill -0 `cat $BUILDDIR/.toastermain.pid`; then
     echo "Warning: bitbake appears to be dead, but the Toaster web server is running. Something fishy is going on." 1>&2
     echo "Cleaning up the web server to start from a clean slate."
     webserverKillAll
-- 
1.9.1


