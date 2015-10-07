Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 8CED460125
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Oct 2015 12:18:57 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga103.fm.intel.com with ESMTP; 07 Oct 2015 05:18:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,648,1437462000"; d="scan'208";a="805535100"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga001.fm.intel.com with ESMTP; 07 Oct 2015 05:18:26 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.51])
	by linux.intel.com (Postfix) with ESMTP id CA5F56A4083;
	Wed,  7 Oct 2015 05:17:28 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  7 Oct 2015 15:17:32 +0300
Message-Id: <900e642c641bdac7580fc974e58c399069246a04.1444219934.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1444219934.git.ed.bartosh@linux.intel.com>
References: <cover.1444219934.git.ed.bartosh@linux.intel.com>
Subject: [PATCH 1/5] toaster: removed superuser question from startup
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
X-List-Received-Date: Wed, 07 Oct 2015 12:18:59 -0000

From: brian avery <avery.brian@gmail.com>

added comment explaining how to create one later

Signed-off-by: brian avery <avery.brian@gmail.com>
Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bin/toaster | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/bin/toaster b/bin/toaster
index ac27826..d56d525 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -54,11 +54,10 @@ webserverStartAll()
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
+
     python $BBBASEDIR/lib/toaster/manage.py migrate orm || retval=2
     if [ $retval -eq 1 ]; then
         echo "Failed db sync, stopping system start" 1>&2
-- 
2.1.4


