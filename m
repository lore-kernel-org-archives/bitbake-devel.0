Return-Path: <alexandru.damian@intel.com>
Received: from mail-pd0-f173.google.com (mail-pd0-f173.google.com
	[209.85.192.173])
	by mail.openembedded.org (Postfix) with ESMTP id 63ADF732AF
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Feb 2015 18:02:05 +0000 (UTC)
Received: by pdbfl12 with SMTP id fl12so8042068pdb.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Feb 2015 10:02:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=QLFGvhinmKus8mdA3F7kxhYfWfm8nnnWnz3NLrhkeQY=;
	b=X09W4NLNUdvg11aKf/bDBLBgv1vxa6eZqTW2ckzzyXWNfSNW79YY7JcgA9vaIMaBou
	dB8wYUD3rSB8OV2cMK7WcUvO+9DUIVfDxeCKLa3uButDNFgawU4mCtxTeanmMrriltr3
	IZt6JG3X7kyCBZ3yB8I8uE8n+ML+VkD067jHzCP93psrASLqrrycZJ+ns16xQyYC3fSp
	IXueWn8GIl/ayvfoWnE8tdEdCvHRuwDGhg0VLxgqMn+ISE1KFN1yJPjOJcB/YSYrVkAM
	Nn1/ogvsJethklXZ5CBSOxJKIMr2VgS2Huy1r1B5ew72WQD9pnQjYLIo5m7VgEx3ci5H
	yP1Q==
X-Gm-Message-State: ALoCoQnOheofdqnhv2jkLRMtQrrtOqnPzjc2fH4fSvof5kz94B6HFzL512hNaOGxPPIXwYc3B3HM
X-Received: by 10.66.141.176 with SMTP id rp16mr31419455pab.11.1423504927159; 
	Mon, 09 Feb 2015 10:02:07 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	os6sm17124572pac.28.2015.02.09.10.02.03
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 09 Feb 2015 10:02:06 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 52E4E5661A1; Mon,  9 Feb 2015 18:01:58 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Feb 2015 18:01:38 +0000
Message-Id: <8a8248f7b7e30469f592e2f8adbf6ce21e8685c5.1423504574.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
References: <b7b1e64f650c9ea676714209b9d6e7efeca992be.1423504574.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1423504574.git.alexandru.damian@intel.com>
References: <cover.1423504574.git.alexandru.damian@intel.com>
Subject: [PATCH 08/27] toaster: improve logging facilities for toaster
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
X-List-Received-Date: Mon, 09 Feb 2015 18:02:07 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch improves the logging facilities for toaster in order
to help diagnose bugs that happen on user machines.

The logs are stored now under "/tmp/toaster_$$" where $$ is a
PID-based unique identifier. On shutdown, toaster will automatically
erase all logs unless errors are listed in the log file.

On error, Toaster provides suggestions on what to do.

This patch includes a minor fix found as a result of logging
improvements.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bin/toaster                                        | 41 +++++++++++++++----
 lib/bb/ui/buildinfohelper.py                       | 47 ++++++++++++++++------
 .../bldcontrol/management/commands/runbuilds.py    |  2 +-
 lib/toaster/toastergui/views.py                    |  2 +-
 lib/toaster/toastermain/settings.py                |  6 +--
 lib/toaster/toastermain/urls.py                    | 18 ++++++++-
 6 files changed, 91 insertions(+), 25 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index c3b8633..04f2e99 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -69,7 +69,7 @@ function webserverStartAll()
 	fi
         if [ $retval -eq 0 ]; then
 	    echo "Starting webserver..."
-            python $BBBASEDIR/lib/toaster/manage.py runserver "0.0.0.0:$WEB_PORT" </dev/null >${BUILDDIR}/toaster_web_$$.log 2>&1 & echo $! >${BUILDDIR}/.toastermain.pid
+            python $BBBASEDIR/lib/toaster/manage.py runserver "0.0.0.0:$WEB_PORT" </dev/null >>${BUILDDIR}/toaster_web.log 2>&1 & echo $! >${BUILDDIR}/.toastermain.pid
             sleep 1
             if ! cat "${BUILDDIR}/.toastermain.pid" | xargs -I{} kill -0 {} ; then
                 retval=1
@@ -189,17 +189,43 @@ if [ -z "$ZSH_NAME" ] && [ `basename \"$0\"` = `basename \"$BASH_SOURCE\"` ]; th
     fi
 
     # Define a fake builddir where only the pid files are actually created. No real builds will take place here.
-    BUILDDIR=/tmp
+    BUILDDIR=/tmp/toaster_$$
+    if [ -d "$BUILDDIR" ]; then
+        echo -e "Previous toaster run directory $BUILDDIR found, cowardly refusing to start. Please remove the directory when that toaster instance is over" 2>&1
+        exit 1;
+    fi
+
+    mkdir -p "$BUILDDIR"
+
     RUNNING=1
     function trap_ctrlc() {
         echo "** Stopping system"
         webserverKillAll
         RUNNING=0
     }
+
+    function do_cleanup() {
+        find "$BUILDDIR" -type f | xargs rm
+        rmdir "$BUILDDIR"
+    }
+    function cleanup() {
+        if grep -ir error "$BUILDDIR" >/dev/null; then
+            if grep -irn "That port is already in use" "$BUILDDIR"; then
+                echo "You can use the \"webport=PORTNUMBER\" parameter to start Toaster on a different port (port $WEB_PORT is already in use)"
+                do_cleanup
+            else
+                echo -e "\nErrors found in the Toaster log files present in '$BUILDDIR'. Directory will not be cleaned.\n Please review the errors and notify toaster@yoctoproject.org or submit a bug https://bugzilla.yoctoproject.org/enter_bug.cgi?product=Toaster"
+            fi
+        else
+            echo "No errors found, removing the run directory '$BUILDDIR'"
+            do_cleanup
+        fi;
+    }
     TOASTER_MANAGED=1
     export TOASTER_MANAGED=1
     if [ $WEBSERVER -gt 0 ] && ! webserverStartAll; then
         echo "Failed to start the web server, stopping" 1>&2;
+        cleanup
         exit 1;
     fi
     if [ $WEBSERVER -gt 0 ]; then
@@ -209,9 +235,10 @@ if [ -z "$ZSH_NAME" ] && [ `basename \"$0\"` = `basename \"$BASH_SOURCE\"` ]; th
     trap trap_ctrlc SIGINT
     echo "Toaster is now running. You can stop it with Ctrl-C"
     while [ $RUNNING -gt 0 ]; do
-	python $BBBASEDIR/lib/toaster/manage.py runbuilds
-	sleep 1
+        python $BBBASEDIR/lib/toaster/manage.py runbuilds 2>&1 | tee -a "$BUILDDIR/toaster.log"
+        sleep 1
     done
+    cleanup
     echo "**** Exit"
     exit 0
 fi
@@ -275,8 +302,8 @@ case $CMD in
         fi
         unset BBSERVER
         PREREAD=""
-        if [ -e conf/toaster-pre.conf ]; then
-                PREREAD="--read conf/toaster-pre.conf"
+        if [ -e ${BUILDDIR}/conf/toaster-pre.conf ]; then
+		rm ${BUILDDIR}/conf/toaster-pre.conf
         fi
         bitbake $PREREAD --postread conf/toaster.conf --server-only -t xmlrpc -B 0.0.0.0:0
         if [ $? -ne 0 ]; then
@@ -285,7 +312,7 @@ case $CMD in
         else
             export BBSERVER=0.0.0.0:-1
             if [ $NOTOASTERUI == 0 ]; then        # we start the TOASTERUI only if not inhibited
-                bitbake --observe-only -u toasterui >${BUILDDIR}/toaster_ui.log 2>&1 & echo $! >${BUILDDIR}/.toasterui.pid
+                bitbake --observe-only -u toasterui >>${BUILDDIR}/toaster_ui.log 2>&1 & echo $! >${BUILDDIR}/.toasterui.pid
             fi
         fi
         if [ $start_success -eq 1 ]; then
diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 4e2d4a7..491fd15 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -656,18 +656,41 @@ class BuildInfoHelper(object):
         assert path.startswith("/")
         assert 'build' in self.internal_state
 
-        def _slkey(layer_version):
-            assert isinstance(layer_version, Layer_Version)
-            return len(layer_version.layer.local_path)
-
-        # Heuristics: we always match recipe to the deepest layer path that
-        # we can match to the recipe file path
-        for bl in sorted(self.orm_wrapper.layer_version_objects, reverse=True, key=_slkey):
-            if (path.startswith(bl.layer.local_path)):
-                return bl
-
-        #if we get here, we didn't read layers correctly; mockup the new layer
-        unknown_layer, created = Layer.objects.get_or_create(name="unknown", local_path="/", layer_index_url="")
+        if self.brbe is None:
+            def _slkey_interactive(layer_version):
+                assert isinstance(layer_version, Layer_Version)
+                return len(layer_version.layer.local_path)
+
+            # Heuristics: we always match recipe to the deepest layer path in the discovered layers
+            for lvo in sorted(self.orm_wrapper.layer_version_objects, reverse=True, key=_slkey_interactive):
+                # we can match to the recipe file path
+                if path.startswith(lvo.layer.local_path):
+                    return lvo
+
+        else:
+            br_id, be_id = self.brbe.split(":")
+            from bldcontrol.bbcontroller import getBuildEnvironmentController
+            from bldcontrol.models import BuildRequest
+            bc = getBuildEnvironmentController(pk = be_id)
+
+            def _slkey_managed(layer_version):
+                return len(bc.getGitCloneDirectory(layer_version.giturl, layer_version.commit) + layer_version.dirpath)
+
+            # Heuristics: we match the path to where the layers have been checked out
+            for brl in sorted(BuildRequest.objects.get(pk = br_id).brlayer_set.all(), reverse = True, key = _slkey_managed):
+                localdirname = os.path.join(os.path.join(bc.be.sourcedir, bc.getGitCloneDirectory(brl.giturl, brl.commit)), brl.dirpath)
+                if path.startswith(localdirname):
+                    #logger.warn("-- managed: matched path %s with layer %s " % (path, localdirname))
+                    # we matched the BRLayer, but we need the layer_version that generated this br
+                    for lvo in self.orm_wrapper.layer_version_objects:
+                        if brl.name == lvo.layer.name:
+                            return lvo
+
+        #if we get here, we didn't read layers correctly; dump whatever information we have on the error log
+        logger.error("Could not match layer version for recipe path %s : %s" % (path, self.orm_wrapper.layer_version_objects))
+
+        #mockup the new layer
+        unknown_layer, created = Layer.objects.get_or_create(name="__FIXME__unidentified_layer", local_path="/", layer_index_url="")
         unknown_layer_version_obj, created = Layer_Version.objects.get_or_create(layer = unknown_layer, build = self.internal_state['build'])
 
         return unknown_layer_version_obj
diff --git a/lib/toaster/bldcontrol/management/commands/runbuilds.py b/lib/toaster/bldcontrol/management/commands/runbuilds.py
index 3b539b5..c4ab87b 100644
--- a/lib/toaster/bldcontrol/management/commands/runbuilds.py
+++ b/lib/toaster/bldcontrol/management/commands/runbuilds.py
@@ -68,7 +68,7 @@ class Command(NoArgsCommand):
                 task = None
             bbctrl.build(list(map(lambda x:x.target, br.brtarget_set.all())), task)
 
-            logger.debug("runbuilds: Build launched, exiting")
+            logger.debug("runbuilds: Build launched, exiting. Follow build logs at %s/toaster_ui.log" % bec.be.builddir)
             # disconnect from the server
             bbctrl.disconnect()
 
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 7353844..b67a676 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -3248,7 +3248,7 @@ else:
     def xhr_build(request, pid):
         raise Exception("page not available in interactive mode")
 
-    def xhr_projectinfo(request, pid):
+    def xhr_projectinfo(request):
         raise Exception("page not available in interactive mode")
 
     def xhr_projectedit(request, pid):
diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
index 7cf9052..ea7c353 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -344,7 +344,7 @@ LOGGING = {
     },
     'formatters': {
         'datetime': {
-            'format': '%(levelname)s %(asctime)s %(message)s'
+            'format': '%(asctime)s %(levelname)s %(message)s'
         }
     },
     'handlers': {
@@ -365,8 +365,8 @@ LOGGING = {
             'level': 'DEBUG',
         },
         'django.request': {
-            'handlers': ['mail_admins'],
-            'level': 'ERROR',
+            'handlers': ['console'],
+            'level': 'WARN',
             'propagate': True,
         },
     }
diff --git a/lib/toaster/toastermain/urls.py b/lib/toaster/toastermain/urls.py
index 6112067..f66f11d 100644
--- a/lib/toaster/toastermain/urls.py
+++ b/lib/toaster/toastermain/urls.py
@@ -23,6 +23,9 @@ from django.conf.urls import patterns, include, url
 from django.views.generic import RedirectView
 from django.views.decorators.cache import never_cache
 
+import logging
+
+logger = logging.getLogger("toaster")
 
 # Uncomment the next two lines to enable the admin:
 from django.contrib import admin
@@ -47,10 +50,12 @@ import toastermain.settings
 
 if toastermain.settings.FRESH_ENABLED:
     urlpatterns.insert(1, url(r'', include('fresh.urls')))
+    logger.info("Enabled django-fresh extension")
 
 if toastermain.settings.DEBUG_PANEL_ENABLED:
     import debug_toolbar
     urlpatterns.insert(1, url(r'', include(debug_toolbar.urls)))
+    logger.info("Enabled django_toolbar extension")
 
 
 if toastermain.settings.MANAGED:
@@ -70,4 +75,15 @@ for t in os.walk(os.path.dirname(currentdir)):
 
     if "urls.py" in t[2] and t[0] != currentdir:
         modulename = os.path.basename(t[0])
-        urlpatterns.insert(0, url(r'^' + modulename + '/', include ( modulename + '.urls')))
+        # make sure we don't have this module name in
+        conflict = False
+        for p in urlpatterns:
+            if p.regex.pattern == '^' + modulename + '/':
+                conflict = True
+        if not conflict:
+            urlpatterns.insert(0, url(r'^' + modulename + '/', include ( modulename + '.urls')))
+        else:
+            logger.warn("Module \'%s\' has a regexp conflict, was not added to the urlpatterns" % modulename)
+
+from pprint import pformat
+logger.debug("urlpatterns list %s", pformat(urlpatterns))
-- 
1.9.1


