Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 0E51E65D94
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Apr 2014 17:30:50 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 08 Apr 2014 08:45:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,818,1389772800"; d="scan'208";a="489326613"
Received: from paulonei-mobl.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.120.244])
	by orsmga001.jf.intel.com with ESMTP; 08 Apr 2014 08:50:10 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  8 Apr 2014 16:49:54 +0100
Message-Id: <1e0e4415cf6cfb462a8cfca340646abed39cd077.1396972155.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <cover.1396972155.git.paul.eggleton@linux.intel.com>
References: <cover.1396972155.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1396972155.git.paul.eggleton@linux.intel.com>
References: <cover.1396972155.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/2] bitbake-selftest: fix help message to include command line
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
X-List-Received-Date: Tue, 08 Apr 2014 17:30:50 -0000

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bin/bitbake-selftest | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-selftest b/bin/bitbake-selftest
index 8c55f7b..81e4c3c 100755
--- a/bin/bitbake-selftest
+++ b/bin/bitbake-selftest
@@ -26,7 +26,7 @@ except RuntimeError as exc:
     sys.exit(str(exc))
 
 def usage():
-    print('usage: %s [testname1 [testname2]...]')
+    print('usage: %s [testname1 [testname2]...]' % os.path.basename(sys.argv[0]))
 
 if len(sys.argv) > 1:
     if '--help' in sys.argv[1:]:
-- 
1.9.0


