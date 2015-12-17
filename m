Return-Path: <elliot.smith@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id CA1AC731B6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Dec 2015 16:49:08 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga103.fm.intel.com with ESMTP; 17 Dec 2015 08:49:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,441,1444719600"; d="scan'208";a="15002724"
Received: from agusev-mobl2.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.27.121])
	by fmsmga004.fm.intel.com with ESMTP; 17 Dec 2015 08:49:08 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 17 Dec 2015 16:48:52 +0000
Message-Id: <f3a0207e9a68e8200ff00ec51b7a9ac12e6887c5.1450370782.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <36bd18a963c5ba2849b5420f81b97b8a8ce57481.1450370782.git.elliot.smith@intel.com>
References: <36bd18a963c5ba2849b5420f81b97b8a8ce57481.1450370782.git.elliot.smith@intel.com>
In-Reply-To: <cover.1450370782.git.elliot.smith@intel.com>
References: <cover.1450370782.git.elliot.smith@intel.com>
Subject: [PATCH 07/11] toaster: remove addtoConfiguration function
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
X-List-Received-Date: Thu, 17 Dec 2015 16:49:09 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

This function is useless as it's called just once
and makes code less readable.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bin/toaster | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index 40c3c35..97ca177 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -83,16 +83,6 @@ webserverStartAll()
     return $retval
 }
 
-# Helper functions to add a special configuration file
-
-addtoConfiguration()
-{
-    file=$1
-    shift
-    echo "#Created by toaster start script" > ${BUILDDIR}/conf/$file
-    for var in "$@"; do echo $var >> ${BUILDDIR}/conf/$file; done
-}
-
 INSTOPSYSTEM=0
 
 # define the stop command
@@ -339,7 +329,12 @@ fi
 
 case $CMD in
     start )
-        addtoConfiguration toaster.conf "INHERIT+=\"toaster buildhistory\"" $TOASTER_BRBE
+        # Create configuration file
+        conf=${BUILDDIR}/conf/toaster.conf
+        echo "# Created by toaster start script" > $conf
+        echo "INHERIT+=\"toaster buildhistory\"" >> $conf
+        [ -n "$TOASTER_BRBE" ] && echo $TOASTER_BRBE >> $conf
+
         if [ $WEBSERVER -gt 0 ] && ! webserverStartAll; then
             echo "Failed ${CMD}."
             return 4
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


