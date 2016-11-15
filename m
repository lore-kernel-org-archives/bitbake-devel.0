Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by mail.openembedded.org (Postfix) with ESMTP id 9266C60234
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 Nov 2016 20:11:13 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga105.jf.intel.com with ESMTP; 15 Nov 2016 12:11:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,496,1473145200"; d="scan'208";a="786809709"
Received: from nnasirin-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.185.211])
	by FMSMGA003.fm.intel.com with ESMTP; 15 Nov 2016 12:11:11 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 16 Nov 2016 09:11:03 +1300
Message-Id: <beb349785eb0a0494f760db369c75a0d11117fb6.1479240639.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1479240639.git.paul.eggleton@linux.intel.com>
References: <cover.1479240639.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1479240639.git.paul.eggleton@linux.intel.com>
References: <cover.1479240639.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/1] fetch2: npm: conditionally hide NPM_LOCKDOWN / NPM_SHRINKWRAP warnings
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
X-List-Received-Date: Tue, 15 Nov 2016 20:11:13 -0000

If ud.ignore_checksums is set (which we currently use to suppress the
warnings for missing SRC_URI checksums when fetching files from
scripts), then if we're fetching an npm package we should similarly
suppress the warnings when NPM_LOCKDOWN and NPM_SHRINKWRAP aren't set.

At the same time, make any errors reading either of these files actual
errors since if the file is specified and could not be found, that
should be an error - not the exact same warning.

Fixes [YOCTO #10464].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/fetch2/npm.py | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index 699ae72..c3e02e4 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -258,17 +258,23 @@ class Npm(FetchMethod):
 
         shwrf = d.getVar('NPM_SHRINKWRAP', True)
         logger.debug(2, "NPM shrinkwrap file is %s" % shwrf)
-        try:
-            with open(shwrf) as datafile:
-                shrinkobj = json.load(datafile)
-        except:
+        if shwrf:
+            try:
+                with open(shwrf) as datafile:
+                    shrinkobj = json.load(datafile)
+            except Exception as e:
+                raise FetchError('Error loading NPM_SHRINKWRAP file "%s" for %s: %s' % (shwrf, ud.pkgname, str(e)))
+        elif not ud.ignore_checksums:
             logger.warning('Missing shrinkwrap file in NPM_SHRINKWRAP for %s, this will lead to unreliable builds!' % ud.pkgname)
         lckdf = d.getVar('NPM_LOCKDOWN', True)
         logger.debug(2, "NPM lockdown file is %s" % lckdf)
-        try:
-            with open(lckdf) as datafile:
-                lockdown = json.load(datafile)
-        except:
+        if lckdf:
+            try:
+                with open(lckdf) as datafile:
+                    lockdown = json.load(datafile)
+            except Exception as e:
+                raise FetchError('Error loading NPM_LOCKDOWN file "%s" for %s: %s' % (lckdf, ud.pkgname, str(e)))
+        elif not ud.ignore_checksums:
             logger.warning('Missing lockdown file in NPM_LOCKDOWN for %s, this will lead to unreproducible builds!' % ud.pkgname)
 
         if ('name' not in shrinkobj):
-- 
2.5.5


