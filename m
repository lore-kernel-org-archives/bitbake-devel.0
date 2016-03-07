Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 60DC472DC4
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Mar 2016 04:28:16 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP; 06 Mar 2016 20:28:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,549,1449561600"; d="scan'208";a="918275406"
Received: from kgoh8-mobl1.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.138.205])
	by fmsmga001.fm.intel.com with ESMTP; 06 Mar 2016 20:28:15 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  7 Mar 2016 17:27:37 +1300
Message-Id: <e51116e8cc3531464394c387efc8985fd036ea85.1457324829.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <cover.1457324829.git.paul.eggleton@linux.intel.com>
References: <cover.1457324829.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1457324829.git.paul.eggleton@linux.intel.com>
References: <cover.1457324829.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 3/3] fetch2/npm: ignore unknown headers in tarballs
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
X-List-Received-Date: Mon, 07 Mar 2016 04:28:16 -0000

Tarballs that are fetched down via npm repositories seem to often have
unknown headers. This doesn't affect our ability to extract the contents
though so we don't really care to see those warnings.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/fetch2/npm.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index 761c2e0..457043f 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -108,7 +108,7 @@ class Npm(FetchMethod):
         file = data[pkg]['tgz']
         logger.debug(2, "file to extract is %s" % file)
         if file.endswith('.tgz') or file.endswith('.tar.gz') or file.endswith('.tar.Z'):
-            cmd = 'tar xz --strip 1 --no-same-owner -f %s/%s' % (dldir, file)
+            cmd = 'tar xz --strip 1 --no-same-owner --warning=no-unknown-keyword -f %s/%s' % (dldir, file)
         else:
             bb.fatal("NPM package %s downloaded not a tarball!" % file)
 
-- 
2.5.0


