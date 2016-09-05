Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by mail.openembedded.org (Postfix) with ESMTP id 99F82773B7
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  5 Sep 2016 22:58:01 +0000 (UTC)
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by fmsmga105.fm.intel.com with ESMTP; 05 Sep 2016 15:58:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,288,1470726000"; 
   d="scan'208";a="5310806"
Received: from unknown (HELO peggleto-mobl.ger.corp.intel.com)
	([10.255.181.236])
	by orsmga004.jf.intel.com with ESMTP; 05 Sep 2016 15:58:01 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  6 Sep 2016 10:57:28 +1200
Message-Id: <723d0da75410eb692f123a1b5835e367a408fcb8.1473116117.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1473116117.git.paul.eggleton@linux.intel.com>
References: <cover.1473116117.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1473116117.git.paul.eggleton@linux.intel.com>
References: <cover.1473116117.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/6] fetch2/npm: explicitly specify workdir
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
X-List-Received-Date: Mon, 05 Sep 2016 22:58:04 -0000

We were downloading into the current directory here, which is fine if
that current directory can be expected to be the right place - but
that's not true when called from recipetool within OE. We should
explicitly specify the directory to run the command in and then there
won't be a problem.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/fetch2/npm.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index b26ac22..65ccb0d 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -102,7 +102,8 @@ class Npm(FetchMethod):
     def _runwget(self, ud, d, command, quiet):
         logger.debug(2, "Fetching %s using command '%s'" % (ud.url, command))
         bb.fetch2.check_network_access(d, command)
-        runfetchcmd(command, d, quiet)
+        dldir = d.getVar("DL_DIR", True)
+        runfetchcmd(command, d, quiet, workdir=dldir)
 
     def _unpackdep(self, ud, pkg, data, destdir, dldir, d):
         file = data[pkg]['tgz']
-- 
2.5.5


