Return-Path: <ddalex@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id 96D0C60DCA
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Dec 2013 19:26:55 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by azsmga102.ch.intel.com with ESMTP; 18 Dec 2013 11:26:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.95,508,1384329600"; d="scan'208";a="446512352"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by fmsmga001.fm.intel.com with ESMTP; 18 Dec 2013 11:26:54 -0800
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 5925C560594; Wed, 18 Dec 2013 19:26:56 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 18 Dec 2013 19:26:51 +0000
Message-Id: <1387394811-24196-1-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 1/1] toaster: add buildstats to toaster config file
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
X-List-Received-Date: Wed, 18 Dec 2013 19:26:55 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Toaster needs buildstats to be enabled in order to
be able to collect task running stats. This patch
adds buildstats to the running configuration in toaster mode.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 bin/toaster | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/bin/toaster b/bin/toaster
index 38e71ac..d6c3175 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -61,10 +61,13 @@ function webserverStartAll()
 }
 
 # Helper functions to add a special configuration file
+function initConfiguration()
+{
+        echo "#Created by toaster start script" > ${BUILDDIR}/conf/$1
+}
 
 function addtoConfiguration()
 {
-        echo "#Created by toaster start script" > ${BUILDDIR}/conf/$2
         echo $1 >> ${BUILDDIR}/conf/$2
 }
 
@@ -167,7 +170,9 @@ fi
 case $CMD in
     start )
         start_success=1
+        initConfiguration toaster.conf
         addtoConfiguration "INHERIT+=\"toaster buildhistory\"" toaster.conf
+        addtoConfiguration "USER_CLASSES+=\"buildstats\"" toaster.conf
         if ! webserverStartAll; then
             echo "Failed ${CMD}."
             return 4
-- 
1.8.3.2


