Return-Path: <david.reyna@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id BC12071C54
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Sep 2018 05:30:08 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w865U9Zp000081
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 5 Sep 2018 22:30:09 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.217) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Wed, 5 Sep 2018 22:30:09 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 5 Sep 2018 22:26:42 -0700
Message-ID: <118fa6779f1e02d804d0a291b3fdf74ff8ba2bb0.1536210899.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1536210899.git.David.Reyna@windriver.com>
References: <cover.1536210899.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.217]
Subject: [PATCH 3/9] bitbake: toaster: allow TOASTER_DIR to be overridden from cmdline
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
X-List-Received-Date: Thu, 06 Sep 2018 05:30:08 -0000
Content-Type: text/plain

From: Awais Belal <awais_belal@mentor.com>

TOASTER_DIR is used for higher level toaster artifacts
such the SQL DB and creating toaster internal build
directories for projects. Prior to this change it was
evaluated as `dirname $BUILDDIR` and user had no control
over it. This change allows to override this variable
from the command line for more flexibility. The variable
defaults to its original setting if the optional argument
is not passed.

[YOCTO #12891]

(Bitbake rev: e073775d3b6980fc8004ae28a3ccc3c5bbf50fb2)

Signed-off-by: Awais Belal <awais_belal@mentor.com>
Signed-off-by: David Reyna <David.Reyna@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/toaster | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index ed365ee..9fffbc6 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -18,11 +18,12 @@
 # along with this program. If not, see http://www.gnu.org/licenses/.
 
 HELP="
-Usage: source toaster start|stop [webport=<address:port>] [noweb] [nobuild]
+Usage: source toaster start|stop [webport=<address:port>] [noweb] [nobuild] [toasterdir]
     Optional arguments:
         [nobuild] Setup the environment for capturing builds with toaster but disable managed builds
         [noweb] Setup the environment for capturing builds with toaster but don't start the web server
         [webport] Set the development server (default: localhost:8000)
+        [toasterdir] Set absolute path to be used as TOASTER_DIR (default: BUILDDIR/../)
 "
 
 custom_extention()
@@ -186,6 +187,7 @@ unset OE_ROOT
 WEBSERVER=1
 export TOASTER_BUILDSERVER=1
 ADDR_PORT="localhost:8000"
+TOASTERDIR=`dirname $BUILDDIR`
 unset CMD
 for param in $*; do
     case $param in
@@ -211,6 +213,9 @@ for param in $*; do
                 ADDR_PORT="localhost:$PORT"
             fi
     ;;
+    toasterdir=*)
+            TOASTERDIR="${param#*=}"
+    ;;
     --help)
             echo "$HELP"
             return 0
@@ -241,7 +246,7 @@ fi
 # 2) the build dir (in build)
 # 3) the sqlite db if that is being used.
 # 4) pid's we need to clean up on exit/shutdown
-export TOASTER_DIR=`dirname $BUILDDIR`
+export TOASTER_DIR=$TOASTERDIR
 export BB_ENV_EXTRAWHITE="$BB_ENV_EXTRAWHITE TOASTER_DIR"
 
 # Determine the action. If specified by arguments, fine, if not, toggle it
-- 
1.9.1


