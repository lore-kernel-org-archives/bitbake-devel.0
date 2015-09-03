Return-Path: <alexander.kanavin@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 3750C77009
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Sep 2015 15:35:39 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga102.jf.intel.com with ESMTP; 03 Sep 2015 08:35:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,462,1437462000"; d="scan'208";a="797541481"
Received: from kanavin-desktop.fi.intel.com ([10.237.68.161])
	by fmsmga002.fm.intel.com with ESMTP; 03 Sep 2015 08:35:34 -0700
From: Alexander Kanavin <alexander.kanavin@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  3 Sep 2015 18:37:07 +0300
Message-Id: <6cc60f518992d5c20164cde35a3862edebdab385.1441294533.git.alexander.kanavin@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1441294533.git.alexander.kanavin@linux.intel.com>
References: <cover.1441294533.git.alexander.kanavin@linux.intel.com>
Subject: [PATCH 1/1] wget.py: use BPN when parsing upstream directory paths
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
X-List-Received-Date: Thu, 03 Sep 2015 15:35:40 -0000

PN in this context may contain bogus suffixes like -native etc.

Signed-off-by: Alexander Kanavin <alexander.kanavin@linux.intel.com>
---
 bitbake/lib/bb/fetch2/wget.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index bd2a897..d32f5d0 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -521,11 +521,11 @@ class Wget(FetchMethod):
             path = ud.path.split(package)[0]
 
             # search for version matches on folders inside the path, like:
-            # "5.7" in http://download.gnome.org/sources/${PN}/5.7/${PN}-${PV}.tar.gz
+            # "5.7" in http://download.gnome.org/sources/${BPN}/5.7/${BPN}-${PV}.tar.gz
             dirver_regex = re.compile("(?P<dirver>[^/]*(\d+\.)*\d+([-_]r\d+)*)/")
             m = dirver_regex.search(path)
             if m:
-                pn = d.getVar('PN', True)
+                pn = d.getVar('BPN', True)
                 dirver = m.group('dirver')
 
                 dirver_pn_regex = re.compile("%s\d?" % (re.escape(pn)))
-- 
2.1.4


