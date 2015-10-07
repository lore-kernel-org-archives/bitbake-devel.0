Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id A315260125
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Oct 2015 12:19:15 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga101.fm.intel.com with ESMTP; 07 Oct 2015 05:19:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,648,1437462000"; d="scan'208";a="659549345"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga003.jf.intel.com with ESMTP; 07 Oct 2015 05:19:10 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id 7E76E6A4083;
	Wed,  7 Oct 2015 05:18:12 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  7 Oct 2015 15:17:33 +0300
Message-Id: <b410ebbd121ba277bed91a13fe992eb8c556e64d.1444219934.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <900e642c641bdac7580fc974e58c399069246a04.1444219934.git.ed.bartosh@linux.intel.com>
References: <900e642c641bdac7580fc974e58c399069246a04.1444219934.git.ed.bartosh@linux.intel.com>
In-Reply-To: <cover.1444219934.git.ed.bartosh@linux.intel.com>
References: <cover.1444219934.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 2/5] toaster: remove layer and build dir interactive questions
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
X-List-Received-Date: Wed, 07 Oct 2015 12:19:15 -0000

From: brian avery <avery.brian@gmail.com>

added TOASTER_CONF env var for toaasterconf.json

added TOASTER_DIR env var for working dir

added bugfix so WEB_PORT env variable is honored

Signed-off-by: brian avery <avery.brian@gmail.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bin/toaster | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/bin/toaster b/bin/toaster
index d56d525..ff3123c 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -162,7 +162,30 @@ RUNNING=0
 NOTOASTERUI=0
 WEBSERVER=1
 TOASTER_BRBE=""
-WEB_PORT="8000"
+if [ "$WEB_PORT" == "" ]; then
+    WEB_PORT="8000"
+fi
+# this is the configuraton file we are using for toaster
+# note default is assuming yocto. Override this if you are
+# running in a pure OE environment and use the toasterconf.json
+# in meta/conf/toasterconf.json
+# note: for future there are a number of relative path assumptions
+# in the local layers that currently prevent using an arbitrary
+# toasterconf.json
+if [ "$TOASTER_CONF" == "" ]; then
+    BIN_DIR=$(dirname "${BASH_SOURCE[0]}")
+    export TOASTER_CONF="$BIN_DIR/../../meta-yocto/conf/toasterconf.json"
+fi
+# this defines the dir toaster will use for
+# 1) clones of layers (in _toaster_clones )
+# 2) the build dir (in build)
+# 3) the sqlite db if that is being used.
+# 4) pid's we need to clean up on exit/shutdown
+# note: for future. in order to make this an arbitrary directory, we need to
+# make sure that the toaster.sqlite file doesn't default to `pwd` like it currently does.
+export TOASTER_DIR=`pwd`
+
+
 NOBROWSER=0
 
 for param in $*; do
-- 
2.1.4


