Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1R3yDu-00054t-Ih
	for bitbake-devel@lists.openembedded.org;
	Thu, 15 Sep 2011 00:46:30 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 14 Sep 2011 15:41:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,383,1312182000"; d="scan'208";a="48915613"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.158])
	by azsmga001.ch.intel.com with ESMTP; 14 Sep 2011 15:41:04 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Sep 2011 15:40:58 -0700
Message-Id: <98fa70c07936c71785162f74971b8a868b17ec31.1316039862.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1316039862.git.josh@linux.intel.com>
References: <cover.1316039862.git.josh@linux.intel.com>
In-Reply-To: <cover.1316039862.git.josh@linux.intel.com>
References: <cover.1316039862.git.josh@linux.intel.com>
Subject: [PATCH 1/1] fetch2/wget: make checkstatus() quieter
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 14 Sep 2011 22:46:30 -0000

Change the wget fetcher to not emit the commands output when calling checkstatus, this
matches the behaviour of the git fetchers checkstatus() method.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/fetch2/wget.py |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 7bd027a..d3be069 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -69,10 +69,11 @@ class Wget(FetchMethod):
 
             fetchcmd = fetchcmd.replace("${URI}", uri.split(";")[0])
             fetchcmd = fetchcmd.replace("${FILE}", ud.basename)
-            logger.info("fetch " + uri)
-            logger.debug(2, "executing " + fetchcmd)
+            if not checkonly:
+                logger.info("fetch " + uri)
+                logger.debug(2, "executing " + fetchcmd)
             bb.fetch2.check_network_access(d, fetchcmd)
-            runfetchcmd(fetchcmd, d)
+            runfetchcmd(fetchcmd, d, quiet=checkonly)
 
             # Sanity check since wget can pretend it succeed when it didn't
             # Also, this used to happen if sourceforge sent us to the mirror page
-- 
1.7.6



