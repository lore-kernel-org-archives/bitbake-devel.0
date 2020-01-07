Return-Path: <peter.kjellerstedt@axis.com>
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
	by mail.openembedded.org (Postfix) with ESMTP id 41DF77F939
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 Jan 2020 19:33:54 +0000 (UTC)
IronPort-SDR: B5yh1NsE3EUI3QOTznBkWaaUteIKnYi2RKOqCLp782wYP/enUtZmP6C3lrkJpNt5su+1CMC2nX
	7sXSIpmGF9BPINkGxy9r7GbultodrFvkE9ARzsv8P+K5eR49PMCB5tEga2N2b+bcOIKmWrx/Cn
	VlcvMXqrRqrLToto6gBBBMcVa62R9sDLbBhlQ0xKhOhK0werFEQobi6W0Gk7ZjEtY/JYZB+GfN
	9pxz98NQuwgBSSmVEHF1NO2YxscmcU4+Nfs4eTr7+SOvdbimYNHAPnZW6Db5MlARIoODkZ8C36
	WPo=
X-IronPort-AV: E=Sophos;i="5.69,407,1571695200"; 
   d="scan'208";a="4031733"
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  7 Jan 2020 20:33:52 +0100
Message-Id: <20200107193352.4458-2-pkj@axis.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200107193352.4458-1-pkj@axis.com>
References: <20200107193352.4458-1-pkj@axis.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
Subject: [master][zeus][warrior][PATCH 2/2] cooker: Ignore notifications about changes to the sanity_info file
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
X-List-Received-Date: Tue, 07 Jan 2020 19:33:56 -0000
Content-Transfer-Encoding: 8bit

Since this file is written during recipe parsing, having a watch on it
(or actually the directory that contains it) will trigger a re-parse
the next time bitbake is run and the resident bitbake server is
enabled. This causes the sanity_info file to be updated again, which
triggers a new re-parse the next time bitbake is run ad infinitum.

Also generalize the ignoring of bitbake-cookerdaemon.log and
bitbake.lock to all log files and lock files.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/cooker.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index b74affa7ec..74c9fbc4c0 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -267,8 +267,9 @@ class BBCooker:
             self.parsecache_valid = False
             bb.parse.clear_cache()
             return
-        if event.pathname.endswith("bitbake-cookerdaemon.log") \
-                or event.pathname.endswith("bitbake.lock"):
+        if event.pathname.endswith(".log") \
+                or event.pathname.endswith(".lock") \
+                or event.pathname.endswith("sanity_info"):
             return
         if not event.pathname in self.inotify_modified_files:
             self.inotify_modified_files.append(event.pathname)
-- 
2.21.1


