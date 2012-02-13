Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1RwuQn-0003dN-BV
	for bitbake-devel@lists.openembedded.org;
	Mon, 13 Feb 2012 12:50:53 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 13 Feb 2012 03:41:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="116995922"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.241])
	by fmsmga001.fm.intel.com with ESMTP; 13 Feb 2012 03:41:38 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 13 Feb 2012 11:41:32 +0000
Message-Id: <b0e42ae76c528cf90d3a78acfe8b4cd6b8552d42.1329133148.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1329133148.git.paul.eggleton@linux.intel.com>
References: <cover.1329133148.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1329133148.git.paul.eggleton@linux.intel.com>
References: <cover.1329133148.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/3] bitbake/knotty: ensure we return non-zero exit code on Ctrl+C
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
X-List-Received-Date: Mon, 13 Feb 2012 11:50:53 -0000

If the user uses Ctrl+C to exit out of the build, then ensure we return
a non-zero exit code since the entire build was not completed
successfully.

If nothing else, this is useful to avoid continuing in the bitbake
wrapper script in OE-Core if the initial pseudo build is interrupted.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/ui/knotty.py |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
index e1d42f7..2693a78 100644
--- a/bitbake/lib/bb/ui/knotty.py
+++ b/bitbake/lib/bb/ui/knotty.py
@@ -296,4 +296,9 @@ def main(server, eventHandler):
     if summary:
         print(summary)
 
+    if shutdown:
+        print("Execution was interrupted, returning a non-zero exit code.")
+        if return_value == 0:
+            return_value = 1
+
     return return_value
-- 
1.7.5.4



