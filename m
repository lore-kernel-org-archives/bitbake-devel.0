Return-Path: <anibal.limon@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 14B7C7162E
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Jan 2015 00:35:20 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga103.fm.intel.com with ESMTP; 12 Jan 2015 16:30:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,862,1389772800"; d="scan'208";a="439690527"
Received: from alimon-thinkpad-w540.zpn.intel.com ([10.219.4.151])
	by FMSMGA003.fm.intel.com with ESMTP; 12 Jan 2015 16:22:27 -0800
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 12 Jan 2015 18:36:13 -0600
Message-Id: <1421109373-25292-1-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Subject: [PATCH] bb/fetch2/ssh.py: Fix urldata.localpath use os.path.normpath
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
X-List-Received-Date: Tue, 13 Jan 2015 00:35:23 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When urls ends with trailing slash os.path.basename return "" [1]
and built urldata.localpath only with DL_DIR, it causes that
donestamp is built as DL_DIR + '.done' and seems that ssh resource
was already download.

[YOCTO #6448]

[1] https://docs.python.org/2/library/os.path.html#os.path.basename

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 lib/bb/fetch2/ssh.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/ssh.py b/lib/bb/fetch2/ssh.py
index 4ae9794..635578a 100644
--- a/lib/bb/fetch2/ssh.py
+++ b/lib/bb/fetch2/ssh.py
@@ -87,7 +87,8 @@ class SSH(FetchMethod):
         m = __pattern__.match(urldata.url)
         path = m.group('path')
         host = m.group('host')
-        urldata.localpath = os.path.join(d.getVar('DL_DIR', True), os.path.basename(path))
+        urldata.localpath = os.path.join(d.getVar('DL_DIR', True),
+                os.path.basename(os.path.normpath(path)))
 
     def download(self, urldata, d):
         dldir = d.getVar('DL_DIR', True)
-- 
1.9.1


