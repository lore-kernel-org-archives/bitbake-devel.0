Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1R4YRS-0001fs-FG
	for bitbake-devel@lists.openembedded.org;
	Fri, 16 Sep 2011 15:26:54 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 16 Sep 2011 06:21:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="49107870"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.120.40])
	by orsmga001.jf.intel.com with ESMTP; 16 Sep 2011 06:21:40 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Sep 2011 14:21:37 +0100
Message-Id: <d77660aa9085af99cdb0aa4d38736b8485434697.1316178644.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1316178644.git.paul.eggleton@linux.intel.com>
References: <cover.1316178644.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1316178644.git.paul.eggleton@linux.intel.com>
References: <cover.1316178644.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/1] fetch2/git: fix subpath destination directory
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
X-List-Received-Date: Fri, 16 Sep 2011 13:26:54 -0000

Make the git fetcher's subpath (path within the git repo to fetch)
option set the destsuffix (destination directory) option by default.
This reverts the behaviour of subpath to the same as when it was
introduced.

Based on a patch by Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/fetch2/git.py |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 9a578ae..5e9e817 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -210,10 +210,12 @@ class Git(FetchMethod):
         subdir = ud.parm.get("subpath", "")
         if subdir != "":
             readpathspec = ":%s" % (subdir)
+            def_destsuffix = "%s/" % subdir
         else:
             readpathspec = ""
+            def_destsuffix = "git/"
 
-        destsuffix = ud.parm.get("destsuffix", "git/")
+        destsuffix = ud.parm.get("destsuffix", def_destsuffix)
         destdir = os.path.join(destdir, destsuffix)
         if os.path.exists(destdir):
             bb.utils.prunedir(destdir)
-- 
1.7.4.1



