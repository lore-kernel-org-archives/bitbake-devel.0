Return-Path: <alexander.kanavin@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id A46B66072C
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Dec 2015 11:02:54 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga101.fm.intel.com with ESMTP; 04 Dec 2015 03:02:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,380,1444719600"; d="scan'208";a="864581855"
Received: from kanavin-desktop.fi.intel.com ([10.237.68.161])
	by orsmga002.jf.intel.com with ESMTP; 04 Dec 2015 03:02:54 -0800
From: Alexander Kanavin <alexander.kanavin@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  4 Dec 2015 13:00:20 +0200
Message-Id: <1449226820-1435-1-git-send-email-alexander.kanavin@linux.intel.com>
X-Mailer: git-send-email 2.6.2
Subject: [PATCH] wget.py: parse only <a> tags
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
X-List-Received-Date: Fri, 04 Dec 2015 11:02:56 -0000

For two reasons:
1) The important one: we hit the following bug when doing upstream version checks
on some webpages:
https://bugs.launchpad.net/beautifulsoup/+bug/1471755

2) Also, documentation for beautifulsoup states that memory usage and
speed is improved that way.

Signed-off-by: Alexander Kanavin <alexander.kanavin@linux.intel.com>
---
 bitbake/lib/bb/fetch2/wget.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index bd2a897..c185f5b 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -38,6 +38,7 @@ from   bb.fetch2 import FetchError
 from   bb.fetch2 import logger
 from   bb.fetch2 import runfetchcmd
 from   bs4 import BeautifulSoup
+from   bs4 import SoupStrainer
 
 class Wget(FetchMethod):
     """Class to fetch urls via 'wget'"""
@@ -367,7 +368,7 @@ class Wget(FetchMethod):
         version = ['', '', '']
 
         bb.debug(3, "VersionURL: %s" % (url))
-        soup = BeautifulSoup(self._fetch_index(url, ud, d))
+        soup = BeautifulSoup(self._fetch_index(url, ud, d), "html.parser", parse_only=SoupStrainer("a"))
         if not soup:
             bb.debug(3, "*** %s NO SOUP" % (url))
             return ""
@@ -417,7 +418,7 @@ class Wget(FetchMethod):
                 ud.path.split(dirver)[0], ud.user, ud.pswd, {}])
         bb.debug(3, "DirURL: %s, %s" % (dirs_uri, package))
 
-        soup = BeautifulSoup(self._fetch_index(dirs_uri, ud, d))
+        soup = BeautifulSoup(self._fetch_index(dirs_uri, ud, d), "html.parser", parse_only=SoupStrainer("a"))
         if not soup:
             return version[1]
 
-- 
2.6.2


