Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 by mx.groups.io with SMTP id smtpd.web10.167.1585349539854830910
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 27 Mar 2020 15:52:19 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: windriver.com, ip: 147.11.1.11, mailfrom: david.reyna@windriver.com)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 02RMqJkV013528
	(version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>; Fri, 27 Mar 2020 15:52:19 -0700 (PDT)
Received: from honig-Precision-T5600.corp.ad.wrs.com (147.11.209.184) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
 14.3.487.0; Fri, 27 Mar 2020 15:52:18 -0700
From: "Reyna, David" <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 2/4] toaster: support environment-safe manage commands
Date: Fri, 27 Mar 2020 15:51:00 -0700
Message-ID: <22c6acbe910ad54566088a7eddc70f579709b507.1585348962.git.david.reyna@windriver.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1585348962.git.david.reyna@windriver.com>
References: <cover.1585348962.git.david.reyna@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Directly support the various 'manage' commands from the Toaster
executable, so that users do not have to manually set up the required
environment and paths.

Examples:
  $ . toaster manage createsuperuser
  $ . toaster manage lsupdates

[YOCTO #13170]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 bin/toaster | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index c3472dfee8..6b90ee187e 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -8,12 +8,13 @@
 #
 
 HELP="
-Usage: source toaster start|stop [webport=<address:port>] [noweb] [nobuild] [toasterdir]
+Usage 1: source toaster start|stop [webport=<address:port>] [noweb] [nobuild] [toasterdir]
     Optional arguments:
         [nobuild] Setup the environment for capturing builds with toaster but disable managed builds
         [noweb] Setup the environment for capturing builds with toaster but don't start the web server
         [webport] Set the development server (default: localhost:8000)
         [toasterdir] Set absolute path to be used as TOASTER_DIR (default: BUILDDIR/../)
+Usage 2: source toaster manage [createsuperuser|lsupdates|migrate|makemigrations|checksettings|collectstatic|...]
 "
 
 custom_extention()
@@ -208,13 +209,21 @@ for param in $*; do
     toasterdir=*)
             TOASTERDIR="${param#*=}"
     ;;
+    manage )
+            CMD=$param
+            manage_cmd=""
+    ;;
     --help)
             echo "$HELP"
             return 0
     ;;
     *)
-            echo "$HELP"
-            return 1
+            if [ "manage" == "$CMD" ] ; then
+                manage_cmd="$manage_cmd $param"
+            else
+                echo "$HELP"
+                exit 1
+            fi
     ;;
 
     esac
@@ -306,6 +315,10 @@ case $CMD in
         stop_system
         echo "Successful ${CMD}."
     ;;
+    manage )
+        cd $BBBASEDIR/lib/toaster
+        $MANAGE $manage_cmd
+    ;;
 esac
 custom_extention toaster_postpend $CMD $ADDR_PORT
 
-- 
2.20.1

