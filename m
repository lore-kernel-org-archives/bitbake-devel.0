Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 75D2D766A3
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Oct 2015 12:21:25 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga101.jf.intel.com with ESMTP; 07 Oct 2015 05:20:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,648,1437462000"; d="scan'208";a="575812726"
Received: from linux.intel.com ([10.23.219.25])
	by FMSMGA003.fm.intel.com with ESMTP; 07 Oct 2015 05:20:46 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id C0C8B6A4083;
	Wed,  7 Oct 2015 05:19:48 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  7 Oct 2015 15:17:36 +0300
Message-Id: <64680eb3a2eef5e6cf46c18f712b319edb1fc78a.1444219934.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <900e642c641bdac7580fc974e58c399069246a04.1444219934.git.ed.bartosh@linux.intel.com>
References: <900e642c641bdac7580fc974e58c399069246a04.1444219934.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1444219934.git.ed.bartosh@linux.intel.com>
References: <cover.1444219934.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 5/5] toaster: remove bashisms so script works in dash as well
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
X-List-Received-Date: Wed, 07 Oct 2015 12:21:26 -0000

From: brian avery <avery.brian@gmail.com>

[YOCTO #8217]

Signed-off-by: brian avery <avery.brian@gmail.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bin/toaster | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index f1aee62..bc439e6 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -162,7 +162,7 @@ RUNNING=0
 NOTOASTERUI=0
 WEBSERVER=1
 TOASTER_BRBE=""
-if [ "$WEB_PORT" == "" ]; then
+if [ "$WEB_PORT" = "" ]; then
     WEB_PORT="8000"
 fi
 # this is the configuraton file we are using for toaster
@@ -172,13 +172,13 @@ fi
 # note: for future there are a number of relative path assumptions
 # in the local layers that currently prevent using an arbitrary
 # toasterconf.json
-if [ "$TOASTER_CONF" == "" ]; then
-    BIN_DIR=$(dirname "${BASH_SOURCE[0]}")
+if [ "$TOASTER_CONF" = "" ]; then
+    BIN_DIR=$(dirname -- "$0")
     export TOASTER_CONF="$BIN_DIR/../../meta-yocto/conf/toasterconf.json"
 fi
 if [ ! -f $TOASTER_CONF ]; then
     echo "$TOASTER_CONF configuration file not found, exiting..."
-    exit -1
+    exit 1;
 fi
 # this defines the dir toaster will use for
 # 1) clones of layers (in _toaster_clones )
@@ -375,4 +375,3 @@ case $CMD in
         echo "Successful ${CMD}."
     ;;
 esac
-
-- 
2.1.4


