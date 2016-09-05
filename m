Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by mail.openembedded.org (Postfix) with ESMTP id 37E6C7741B
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  5 Sep 2016 22:58:06 +0000 (UTC)
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by fmsmga105.fm.intel.com with ESMTP; 05 Sep 2016 15:58:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,288,1470726000"; 
   d="scan'208";a="5310833"
Received: from unknown (HELO peggleto-mobl.ger.corp.intel.com)
	([10.255.181.236])
	by orsmga004.jf.intel.com with ESMTP; 05 Sep 2016 15:58:05 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  6 Sep 2016 10:57:30 +1200
Message-Id: <4db12c5da3d5c0a8d70114eeb4edb884f8768b80.1473116117.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1473116117.git.paul.eggleton@linux.intel.com>
References: <cover.1473116117.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1473116117.git.paul.eggleton@linux.intel.com>
References: <cover.1473116117.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 3/6] fetch2/npm: support subdir= parameter
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
X-List-Received-Date: Mon, 05 Sep 2016 22:58:06 -0000

"npmpkg" can be a default, but it should respect the subdir parameter as
with other FetchMethods. This allows us to have more than one npm://
entry in SRC_URI without nasty hacks.

Fix required in order to support [YOCTO #9537].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/fetch2/npm.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index 9b2d9e1..134bd35 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -138,7 +138,12 @@ class Npm(FetchMethod):
             workobj = json.load(datafile)
         dldir = "%s/%s" % (os.path.dirname(ud.localpath), ud.pkgname)
 
-        self._unpackdep(ud, ud.pkgname, workobj,  "%s/npmpkg" % destdir, dldir, d)
+        if 'subdir' in ud.parm:
+            unpackdir = '%s/%s' % (destdir, ud.parm.get('subdir'))
+        else:
+            unpackdir = '%s/npmpkg' % destdir
+
+        self._unpackdep(ud, ud.pkgname, workobj, unpackdir, dldir, d)
 
     def _parse_view(self, output):
         '''
-- 
2.5.5


