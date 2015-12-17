Return-Path: <elliot.smith@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 37E60731A2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Dec 2015 16:49:10 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga103.fm.intel.com with ESMTP; 17 Dec 2015 08:49:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,441,1444719600"; d="scan'208";a="15002733"
Received: from agusev-mobl2.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.27.121])
	by fmsmga004.fm.intel.com with ESMTP; 17 Dec 2015 08:49:10 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 17 Dec 2015 16:48:53 +0000
Message-Id: <b938708445a789ad6ccfe40bc30558ecb4af8061.1450370782.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <36bd18a963c5ba2849b5420f81b97b8a8ce57481.1450370782.git.elliot.smith@intel.com>
References: <36bd18a963c5ba2849b5420f81b97b8a8ce57481.1450370782.git.elliot.smith@intel.com>
In-Reply-To: <cover.1450370782.git.elliot.smith@intel.com>
References: <cover.1450370782.git.elliot.smith@intel.com>
Subject: [PATCH 08/11] toaster: remove 2 unused functions
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
X-List-Received-Date: Thu, 17 Dec 2015 16:49:11 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Removed check_pidbyfile and notify_chldexit functions from
toaster script as they're not called in the script.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bin/toaster | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index 97ca177..1f4c400 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -131,17 +131,6 @@ stop_bitbake() {
     lsof bitbake.lock | awk '{print $2}' | grep "[0-9]\+" | xargs -n1 -r kill
 }
 
-check_pidbyfile() {
-    [ -e $1 ] && kill -0 `cat $1` 2>/dev/null
-}
-
-notify_chldexit() {
-    if [ $NOTOASTERUI -eq 0 ]; then
-        check_pidbyfile ${BUILDDIR}/.toasterui.pid && return
-        stop_system
-    fi
-}
-
 verify_prereq() {
     # Verify Django version
     reqfile=$(python -c "import os; print os.path.realpath('$BBBASEDIR/toaster-requirements.txt')")
@@ -355,7 +344,6 @@ case $CMD in
         # stop system on terminal exit
         set -o monitor
         trap stop_system SIGHUP
-        #trap notify_chldexit SIGCHLD
     ;;
     stop )
         stop_system
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


