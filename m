Return-Path: <anibal.limon@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 6FA647317C
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Mar 2016 18:08:24 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga101.jf.intel.com with ESMTP; 24 Mar 2016 11:07:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,386,1455004800"; d="scan'208";a="72654235"
Received: from jqli-mobl.amr.corp.intel.com (HELO alimonb-mobl1.zpn.intel.com)
	([10.252.192.215])
	by fmsmga004.fm.intel.com with ESMTP; 24 Mar 2016 11:07:52 -0700
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 24 Mar 2016 12:08:19 -0600
Message-Id: <1458842899-12776-2-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1458842899-12776-1-git-send-email-anibal.limon@linux.intel.com>
References: <1458842899-12776-1-git-send-email-anibal.limon@linux.intel.com>
MIME-Version: 1.0
Cc: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <limon.anibal@gmail.com>
Subject: [PATCH 2/2] fetch2/wget.py: _check_latest_version_by_dir fix prefix detection
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

When prefix is part of the version directory it need to ensure that
only version directory is used so remove previous directories if exists.

Example: pfx = '/dir1/dir2/v' and version = '2.5' the expected result
is 'v2.5' instead of '/dir1/dir2/v2.5'.

[YOCTO #8778]

Signed-off-by: Aníbal Limón <limon.anibal@gmail.com>
Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 lib/bb/fetch2/wget.py | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index ffae540..8bc9e93 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -438,9 +438,19 @@ class Wget(FetchMethod):
         for line in soup.find_all('a', href=True):
             s = dirver_regex.search(line['href'].strip("/"))
             if s:
-                version_dir_new = ['', s.group('ver'), '']
+                sver = s.group('ver')
+
+                # When prefix is part of the version directory it need to
+                # ensure that only version directory is used so remove previous
+                # directories if exists.
+                #
+                # Example: pfx = '/dir1/dir2/v' and version = '2.5' the expected
+                # result is v2.5.
+                spfx = s.group('pfx').split('/')[-1]
+
+                version_dir_new = ['', sver, '']
                 if self._vercmp(version_dir, version_dir_new) <= 0:
-                    dirver_new = s.group('pfx') + s.group('ver')
+                    dirver_new = spfx + sver
                     path = ud.path.replace(dirver, dirver_new, True) \
                         .split(package)[0]
                     uri = bb.fetch.encodeurl([ud.type, ud.host, path,
-- 
2.1.4


