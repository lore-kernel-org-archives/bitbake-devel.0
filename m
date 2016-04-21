Return-Path: <elliot.smith@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id AA53865CC3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 21 Apr 2016 13:22:20 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP; 21 Apr 2016 06:22:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,512,1455004800"; d="scan'208";a="949956227"
Received: from santhige-mobl.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.8.209])
	by fmsmga001.fm.intel.com with ESMTP; 21 Apr 2016 06:22:18 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 21 Apr 2016 14:22:04 +0100
Message-Id: <1461244926-20236-1-git-send-email-elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH 1/3] toaster: bin/toaster Add help text for unrecognised command
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
X-List-Received-Date: Thu, 21 Apr 2016 13:22:23 -0000

From: Michael Wood <michael.g.wood@intel.com>

Add help text for unrecognised or missing command for toaster script
Remove assumption that no command is 'start' as the default.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bitbake/bin/toaster | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/bitbake/bin/toaster b/bitbake/bin/toaster
index 70c66d2..2d07255 100755
--- a/bitbake/bin/toaster
+++ b/bitbake/bin/toaster
@@ -17,10 +17,12 @@
 # You should have received a copy of the GNU General Public License
 # along with this program. If not, see http://www.gnu.org/licenses/.
 
-# Usage: source toaster [start|stop]
-#                       [webport=<port>] [noui] [noweb]
-
-# Helper function to kill a background toaster development server
+HELP="
+Usage: source toaster start|stop [webport=<address:port>] [noweb]
+    Optional arguments:
+        [noweb] Setup the environment for building with toaster but don't start the development server
+        [webport] Set the development server (default: localhost:8000)
+"
 
 webserverKillAll()
 {
@@ -193,6 +195,12 @@ for param in $*; do
     ;;
     webport=*)
             WEB_PORT="${param#*=}"
+    ;;
+    *)
+            echo "$HELP"
+            return 1
+    ;;
+
     esac
 done
 
@@ -226,11 +234,9 @@ if [ "$CMD" = "start" ] ; then
 	return 1
 fi
 elif [ "$CMD" = "" ]; then
-    if [ -z "$BBSERVER" ]; then
-        CMD="start"
-    else
-        CMD="stop"
-    fi
+    echo "No command specified"
+    echo "$HELP"
+    return 1
 fi
 
 echo "The system will $CMD."
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


