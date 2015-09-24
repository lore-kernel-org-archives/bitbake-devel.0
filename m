Return-Path: <elliot.smith@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 6A70173BB8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Sep 2015 10:31:38 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga102.jf.intel.com with ESMTP; 24 Sep 2015 03:31:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,580,1437462000"; d="scan'208";a="811939719"
Received: from rdouetx-mobl2.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.2.3])
	by fmsmga002.fm.intel.com with ESMTP; 24 Sep 2015 03:31:37 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 24 Sep 2015 11:31:30 +0100
Message-Id: <92bef2c338fd79ad607f25b8062e8c71eef2a31e.1443090607.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1443090607.git.elliot.smith@intel.com>
References: <cover.1443090607.git.elliot.smith@intel.com>
Subject: [PATCH 1/2] toaster: small improvements to the startup script
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
X-List-Received-Date: Thu, 24 Sep 2015 10:31:39 -0000

From: brian avery <avery.brian@gmail.com>

Do not ask the user to create a superuser on running in managed mode

Correctly inherit the env variable WEB_PORT if set in analysis mode

Signed-off-by: brian avery <avery.brian@gmail.com>
Signed-off-by: Elliot Smith <elliot.smith@intel.com>
---
 bin/toaster | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index ac27826..2153282 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -54,11 +54,9 @@ webserverStartAll()
     fi
 
     retval=0
-    if [ "$TOASTER_MANAGED" '=' '1' ]; then
-        python $BBBASEDIR/lib/toaster/manage.py syncdb || retval=1
-    else
-        python $BBBASEDIR/lib/toaster/manage.py syncdb --noinput || retval=1
-    fi
+    # you can always add a superuser later via
+    # python bitbake/lib/toaster/manage.py python manage.py createsuperuser --username=<ME>
+    python $BBBASEDIR/lib/toaster/manage.py syncdb --noinput || retval=1
     python $BBBASEDIR/lib/toaster/manage.py migrate orm || retval=2
     if [ $retval -eq 1 ]; then
         echo "Failed db sync, stopping system start" 1>&2
@@ -163,7 +161,9 @@ RUNNING=0
 NOTOASTERUI=0
 WEBSERVER=1
 TOASTER_BRBE=""
-WEB_PORT="8000"
+if [ "WEB_PORT" == "" ]; then
+    WEB_PORT="8000"
+fi
 NOBROWSER=0
 
 for param in $*; do
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


