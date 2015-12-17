Return-Path: <elliot.smith@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 7719A73191
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Dec 2015 16:49:14 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga103.fm.intel.com with ESMTP; 17 Dec 2015 08:49:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,441,1444719600"; d="scan'208";a="15002760"
Received: from agusev-mobl2.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.27.121])
	by fmsmga004.fm.intel.com with ESMTP; 17 Dec 2015 08:49:14 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 17 Dec 2015 16:48:56 +0000
Message-Id: <3fd968aa576abf4e6ddc12b7b14c6afe206393ec.1450370782.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <36bd18a963c5ba2849b5420f81b97b8a8ce57481.1450370782.git.elliot.smith@intel.com>
References: <36bd18a963c5ba2849b5420f81b97b8a8ce57481.1450370782.git.elliot.smith@intel.com>
In-Reply-To: <cover.1450370782.git.elliot.smith@intel.com>
References: <cover.1450370782.git.elliot.smith@intel.com>
Subject: [PATCH 11/11] toaster: remove 2 confusing parameters
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
X-List-Received-Date: Thu, 17 Dec 2015 16:49:14 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Removed nobrowser and brbe script parameters as both
are confusing and nobrowser is not used anywhere.

brbe parameter usage can only be justified if toaster
doesn't work properly and user has to manually connect
toaster to running bitbake server. Even in this scenario
it's very unlikely to achieve as toaster script is not
designed for this kind of usage.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bin/toaster | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index 7cecc7b..1f98490 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -17,8 +17,8 @@
 # You should have received a copy of the GNU General Public License
 # along with this program. If not, see http://www.gnu.org/licenses/.
 
-# Usage: source toaster [start|stop|restart-bitbake] [webport=<port>]
-#                       [noui] [noweb] [nobrowser] [brbe=<BRBE>]
+# Usage: source toaster [start|stop|restart-bitbake]
+#                       [webport=<port>] [noui] [noweb]
 
 # Helper function to kill a background toaster development server
 
@@ -203,8 +203,6 @@ export TOASTER_DIR=`pwd`
 
 NOTOASTERUI=0
 WEBSERVER=1
-NOBROWSER=0
-TOASTER_BRBE=""
 WEB_PORT="8000"
 
 for param in $*; do
@@ -215,12 +213,6 @@ for param in $*; do
     noweb )
             WEBSERVER=0
     ;;
-    nobrowser )
-            NOBROWSER=1
-    ;;
-    brbe=* )
-            TOASTER_BRBE=$'\n'"TOASTER_BRBE=\""${param#*=}"\""
-    ;;
     webport=*)
             WEB_PORT="${param#*=}"
     esac
@@ -318,7 +310,6 @@ case $CMD in
         conf=${BUILDDIR}/conf/toaster.conf
         echo "# Created by toaster start script" > $conf
         echo "INHERIT+=\"toaster buildhistory\"" >> $conf
-        [ -n "$TOASTER_BRBE" ] && echo $TOASTER_BRBE >> $conf
 
         if [ $WEBSERVER -gt 0 ] && ! webserverStartAll; then
             echo "Failed ${CMD}."
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


