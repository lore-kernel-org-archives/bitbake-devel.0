Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 9CD3278395
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Aug 2017 23:31:37 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	30 Aug 2017 16:31:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.41,450,1498546800"; d="scan'208";a="1189995081"
Received: from ekooi-mobl5.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.141.249])
	by fmsmga001.fm.intel.com with ESMTP; 30 Aug 2017 16:31:36 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 31 Aug 2017 11:30:47 +1200
Message-Id: <f52340ba90b5b001be9b86a0a29a2f230b942cfe.1504135776.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1504135776.git.paul.eggleton@linux.intel.com>
References: <cover.1504135776.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 5/5] fetch2/npm: add noverify parameter to skip lockdown/shrinkwrap
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
X-List-Received-Date: Wed, 30 Aug 2017 23:31:37 -0000

When fetching source for the first time within scripts such as
OpenEmbedded's recipetool, we don't want to be showing warnings about
NPM_SHRINKWRAP or NPM_LOCKDOWN not being set since there's no way we
could have set them in advance. Previously we were using
ud.ignore_checksums to suppress these but since we are now using a more
standard task-based path to fetch the source, we need to disable these
through the metadata. Look for a "noverify" parameter set on the npm URL
and skip the checks if it is set to "1".

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/fetch2/npm.py | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index f2e7983..b5f148c 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -263,26 +263,27 @@ class Npm(FetchMethod):
             runfetchcmd("tar -xJf %s" % (ud.fullmirror), d, workdir=dest)
             return
 
-        shwrf = d.getVar('NPM_SHRINKWRAP')
-        logger.debug(2, "NPM shrinkwrap file is %s" % shwrf)
-        if shwrf:
-            try:
-                with open(shwrf) as datafile:
-                    shrinkobj = json.load(datafile)
-            except Exception as e:
-                raise FetchError('Error loading NPM_SHRINKWRAP file "%s" for %s: %s' % (shwrf, ud.pkgname, str(e)))
-        elif not ud.ignore_checksums:
-            logger.warning('Missing shrinkwrap file in NPM_SHRINKWRAP for %s, this will lead to unreliable builds!' % ud.pkgname)
-        lckdf = d.getVar('NPM_LOCKDOWN')
-        logger.debug(2, "NPM lockdown file is %s" % lckdf)
-        if lckdf:
-            try:
-                with open(lckdf) as datafile:
-                    lockdown = json.load(datafile)
-            except Exception as e:
-                raise FetchError('Error loading NPM_LOCKDOWN file "%s" for %s: %s' % (lckdf, ud.pkgname, str(e)))
-        elif not ud.ignore_checksums:
-            logger.warning('Missing lockdown file in NPM_LOCKDOWN for %s, this will lead to unreproducible builds!' % ud.pkgname)
+        if ud.parm.get("noverify", None) != '1':
+            shwrf = d.getVar('NPM_SHRINKWRAP')
+            logger.debug(2, "NPM shrinkwrap file is %s" % shwrf)
+            if shwrf:
+                try:
+                    with open(shwrf) as datafile:
+                        shrinkobj = json.load(datafile)
+                except Exception as e:
+                    raise FetchError('Error loading NPM_SHRINKWRAP file "%s" for %s: %s' % (shwrf, ud.pkgname, str(e)))
+            elif not ud.ignore_checksums:
+                logger.warning('Missing shrinkwrap file in NPM_SHRINKWRAP for %s, this will lead to unreliable builds!' % ud.pkgname)
+            lckdf = d.getVar('NPM_LOCKDOWN')
+            logger.debug(2, "NPM lockdown file is %s" % lckdf)
+            if lckdf:
+                try:
+                    with open(lckdf) as datafile:
+                        lockdown = json.load(datafile)
+                except Exception as e:
+                    raise FetchError('Error loading NPM_LOCKDOWN file "%s" for %s: %s' % (lckdf, ud.pkgname, str(e)))
+            elif not ud.ignore_checksums:
+                logger.warning('Missing lockdown file in NPM_LOCKDOWN for %s, this will lead to unreproducible builds!' % ud.pkgname)
 
         if ('name' not in shrinkobj):
             self._getdependencies(ud.pkgname, jsondepobj, ud.version, d, ud)
-- 
2.9.5


