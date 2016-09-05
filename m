Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by mail.openembedded.org (Postfix) with ESMTP id 01276773BD
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  5 Sep 2016 22:58:03 +0000 (UTC)
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by fmsmga105.fm.intel.com with ESMTP; 05 Sep 2016 15:58:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,288,1470726000"; 
   d="scan'208";a="5310823"
Received: from unknown (HELO peggleto-mobl.ger.corp.intel.com)
	([10.255.181.236])
	by orsmga004.jf.intel.com with ESMTP; 05 Sep 2016 15:58:03 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  6 Sep 2016 10:57:29 +1200
Message-Id: <02ea7b4da2df0e30f45b4685ba09ee7da492bbf5.1473116117.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1473116117.git.paul.eggleton@linux.intel.com>
References: <cover.1473116117.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1473116117.git.paul.eggleton@linux.intel.com>
References: <cover.1473116117.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/6] fetch2/npm: fix broken fetches if more than one npm URL fetched
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

You cannot set a URL-specific value in an object-level variable on
the FetchMethod in urldata_init() or the result is the value specific to
the last URL will be the one that gets set. This prevented fetching more
than one npm:// URL correctly - the other tarballs would not download to
the correct location and do_unpack failed to find them as a result.

Fix required in order to support [YOCTO #9537].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/fetch2/npm.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index 65ccb0d..9b2d9e1 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -88,7 +88,7 @@ class Npm(FetchMethod):
         ud.localpath = d.expand("${DL_DIR}/npm/%s" % ud.bbnpmmanifest)
 
         self.basecmd = d.getVar("FETCHCMD_wget", True) or "/usr/bin/env wget -O -t 2 -T 30 -nv --passive-ftp --no-check-certificate "
-        self.basecmd += " --directory-prefix=%s " % prefixdir
+        ud.prefixdir = prefixdir
 
         ud.write_tarballs = ((data.getVar("BB_GENERATE_MIRROR_TARBALLS", d, True) or "0") != "0")
         ud.mirrortarball = 'npm_%s-%s.tar.xz' % (ud.pkgname, ud.version)
@@ -182,7 +182,7 @@ class Npm(FetchMethod):
         outputurl = pdata['dist']['tarball']
         data[pkg] = {}
         data[pkg]['tgz'] = os.path.basename(outputurl)
-        self._runwget(ud, d, "%s %s" % (self.basecmd, outputurl), False)
+        self._runwget(ud, d, "%s --directory-prefix=%s %s" % (self.basecmd, ud.prefixdir, outputurl), False)
 
         dependencies = pdata.get('dependencies', {})
         optionalDependencies = pdata.get('optionalDependencies', {})
@@ -209,7 +209,7 @@ class Npm(FetchMethod):
             outputurl = runfetchcmd(fetchcmd, d, True)
         else:
             outputurl = data['resolved']
-        self._runwget(ud, d, "%s %s" % (self.basecmd, outputurl), False)
+        self._runwget(ud, d, "%s --directory-prefix=%s %s" % (self.basecmd, ud.prefixdir, outputurl), False)
         manifest[pkg] = {}
         manifest[pkg]['tgz'] = os.path.basename(outputurl).rstrip()
         manifest[pkg]['deps'] = {}
-- 
2.5.5


