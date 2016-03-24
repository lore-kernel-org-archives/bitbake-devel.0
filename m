Return-Path: <anibal.limon@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 5DD026012C
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Mar 2016 18:08:22 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga101.jf.intel.com with ESMTP; 24 Mar 2016 11:07:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,386,1455004800"; d="scan'208";a="72654210"
Received: from jqli-mobl.amr.corp.intel.com (HELO alimonb-mobl1.zpn.intel.com)
	([10.252.192.215])
	by fmsmga004.fm.intel.com with ESMTP; 24 Mar 2016 11:07:50 -0700
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 24 Mar 2016 12:08:18 -0600
Message-Id: <1458842899-12776-1-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Cc: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <limon.anibal@gmail.com>
Subject: [PATCH 1/2] fetch2/wget.py: _check_latest_version_by_dir use group names
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
X-List-Received-Date: Thu, 24 Mar 2016 18:08:24 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Aníbal Limón <limon.anibal@gmail.com>

Little improvement for reference tokens by names instead of index.

Signed-off-by: Aníbal Limón <limon.anibal@gmail.com>
Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 lib/bb/fetch2/wget.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 202ed0b..ffae540 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -420,10 +420,10 @@ class Wget(FetchMethod):
         version_dir = ['', '', '']
         version = ['', '', '']
 
-        dirver_regex = re.compile("(\D*)((\d+[\.\-_])+(\d+))")
+        dirver_regex = re.compile("(?P<pfx>\D*)(?P<ver>(\d+[\.\-_])+(\d+))")
         s = dirver_regex.search(dirver)
         if s:
-            version_dir[1] = s.group(2)
+            version_dir[1] = s.group('ver')
         else:
             version_dir[1] = dirver
 
@@ -438,9 +438,9 @@ class Wget(FetchMethod):
         for line in soup.find_all('a', href=True):
             s = dirver_regex.search(line['href'].strip("/"))
             if s:
-                version_dir_new = ['', s.group(2), '']
+                version_dir_new = ['', s.group('ver'), '']
                 if self._vercmp(version_dir, version_dir_new) <= 0:
-                    dirver_new = s.group(1) + s.group(2)
+                    dirver_new = s.group('pfx') + s.group('ver')
                     path = ud.path.replace(dirver, dirver_new, True) \
                         .split(package)[0]
                     uri = bb.fetch.encodeurl([ud.type, ud.host, path,
-- 
2.1.4


