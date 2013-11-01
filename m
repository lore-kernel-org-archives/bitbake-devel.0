Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 0BFF96D63D
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Nov 2013 15:58:49 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 01 Nov 2013 08:55:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,535,1378882800"; d="scan'208";a="428337477"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.91])
	by orsmga002.jf.intel.com with ESMTP; 01 Nov 2013 08:58:50 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  1 Nov 2013 15:58:35 +0000
Message-Id: <0e6507dc8b9438d1430bdaa2dbee485425bce6b7.1383321482.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1383321482.git.paul.eggleton@linux.intel.com>
References: <cover.1383321482.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1383321482.git.paul.eggleton@linux.intel.com>
References: <cover.1383321482.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 8/8] toaster: enable required classes in the toaster startup script
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
X-List-Received-Date: Fri, 01 Nov 2013 15:58:49 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

In order to use toaster, now you have to set INHERIT+="toaster buildhistory"
To keep it simple, I've done some changes in order to automate it. When toaster
is started, this line is added to a new file called toaster.conf.

This file is passed to the bitbake server with the --postread parameter.

Based on a patch by Cristiana Voicu <cristiana.voicu@intel.com>

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bin/toaster | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index cc631f6..d4715fa 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -36,7 +36,6 @@ function webserverKillAll()
 	done
 }
 
-
 function webserverStartAll()
 {
         retval=0
@@ -49,6 +48,14 @@ function webserverStartAll()
         return $retval
 }
 
+# Helper functions to add a special configuration file
+
+function addtoConfiguration()
+{
+        echo "#Created by toaster start script" > ${BUILDDIR}/conf/$2
+        echo $1 >> ${BUILDDIR}/conf/$2
+}
+
 # define the stop command
 function stop_system()
 {
@@ -136,9 +143,10 @@ fi
 
 case $CMD in
     start )
+        addtoConfiguration "INHERIT+=\"toaster buildhistory\"" toaster.conf
         webserverStartAll || return 4
         unset BBSERVER
-        bitbake --server-only -t xmlrpc -B localhost:8200
+        bitbake --postread conf/toaster.conf --server-only -t xmlrpc -B localhost:8200
         export BBSERVER=localhost:8200
         if [ $NOTOASTERUI == 0 ]; then        # we start the TOASTERUI only if not inhibited
             bitbake --observe-only -u toasterui >${BUILDDIR}/toaster_ui.log 2>&1 & echo $! >${BUILDDIR}/.toasterui.pid
-- 
1.8.1.2


