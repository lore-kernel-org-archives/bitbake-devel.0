Return-Path: <elliot.smith@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 14B6173191
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Dec 2015 16:49:13 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga103.fm.intel.com with ESMTP; 17 Dec 2015 08:49:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,441,1444719600"; d="scan'208";a="15002750"
Received: from agusev-mobl2.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.27.121])
	by fmsmga004.fm.intel.com with ESMTP; 17 Dec 2015 08:49:12 -0800
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 17 Dec 2015 16:48:55 +0000
Message-Id: <6f22d375119f90d6a1fd53c135c00138fb75e0d6.1450370782.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <36bd18a963c5ba2849b5420f81b97b8a8ce57481.1450370782.git.elliot.smith@intel.com>
References: <36bd18a963c5ba2849b5420f81b97b8a8ce57481.1450370782.git.elliot.smith@intel.com>
In-Reply-To: <cover.1450370782.git.elliot.smith@intel.com>
References: <cover.1450370782.git.elliot.smith@intel.com>
Subject: [PATCH 10/11] toaster: move setting of default values
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
X-List-Received-Date: Thu, 17 Dec 2015 16:49:13 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Set default values of script parameters just before
they are parsed to increase readability.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bin/toaster | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index 6dd20c1..7cecc7b 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -159,12 +159,7 @@ fi
 BBBASEDIR=`dirname $TOASTER`/..
 MANAGE=$BBBASEDIR/lib/toaster/manage.py
 OEROOT=`dirname $TOASTER`/../..
-NOTOASTERUI=0
-WEBSERVER=1
-TOASTER_BRBE=""
-if [ "$WEB_PORT" = "" ]; then
-    WEB_PORT="8000"
-fi
+
 # this is the configuraton file we are using for toaster
 # we are using the same logic that oe-setup-builddir uses
 # (based on TEMPLATECONF and .templateconf) to determine
@@ -206,7 +201,11 @@ fi
 # make sure that the toaster.sqlite file doesn't default to `pwd` like it currently does.
 export TOASTER_DIR=`pwd`
 
+NOTOASTERUI=0
+WEBSERVER=1
 NOBROWSER=0
+TOASTER_BRBE=""
+WEB_PORT="8000"
 
 for param in $*; do
     case $param in
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


