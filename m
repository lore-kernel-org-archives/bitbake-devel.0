Return-Path: <anibal.limon@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 285A973475
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Feb 2015 21:58:20 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga102.jf.intel.com with ESMTP; 13 Feb 2015 13:54:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.09,573,1418112000"; d="scan'208";a="677724311"
Received: from unknown (HELO alimon-ThinkPad-W540.zpn.intel.com)
	([10.219.4.49])
	by fmsmga002.fm.intel.com with ESMTP; 13 Feb 2015 13:58:18 -0800
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Feb 2015 15:58:14 -0600
Message-Id: <1423864694-24940-8-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1423864694-24940-1-git-send-email-anibal.limon@linux.intel.com>
References: <1423864694-24940-1-git-send-email-anibal.limon@linux.intel.com>
MIME-Version: 1.0
Subject: [PATCH 7/7] tests/fetch.py: latest_versionstring add set of PN
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
X-List-Received-Date: Fri, 13 Feb 2015 21:58:21 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add set of PN in data because now latest_versionstring use it for
validate version directory searching.

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 lib/bb/tests/fetch.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 6eb0f2d..d56ef49 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -629,6 +629,7 @@ class FetchMethodTest(FetcherTest):
     else:
         def test_git_latest_versionstring(self):
             for k, v in self.test_git_uris.items():
+                self.d.setVar("PN", k[0])
                 self.d.setVar("SRCREV", k[2])
                 self.d.setVar("GITTAGREGEX", k[3])
                 ud = bb.fetch2.FetchData(k[1], self.d)
@@ -638,6 +639,7 @@ class FetchMethodTest(FetcherTest):
 
         def test_wget_latest_versionstring(self):
             for k, v in self.test_wget_uris.items():
+                self.d.setVar("PN", k[0])
                 self.d.setVar("REGEX_URI", k[2])
                 self.d.setVar("REGEX", k[3])
                 ud = bb.fetch2.FetchData(k[1], self.d)
-- 
1.9.1


