Return-Path: <anibal.limon@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 23D2475979
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Jul 2015 00:31:01 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga103.jf.intel.com with ESMTP; 14 Jul 2015 17:31:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,476,1432623600"; d="scan'208";a="729009043"
Received: from alimon-thinkpad-w540.zpn.intel.com ([10.219.5.54])
	by orsmga001.jf.intel.com with ESMTP; 14 Jul 2015 17:31:01 -0700
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 14 Jul 2015 19:30:56 -0500
Message-Id: <1436920259-31969-2-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1436920259-31969-1-git-send-email-anibal.limon@linux.intel.com>
References: <1436920259-31969-1-git-send-email-anibal.limon@linux.intel.com>
MIME-Version: 1.0
Cc: alexander.kanavin@linux.intel.com
Subject: [PATCH 1/4] fetch2/git.py: latest_versionstring search in all tags
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
X-List-Received-Date: Wed, 15 Jul 2015 00:31:01 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Don't limit the tag search for only tags end with ^{}.

Signed-off-by: Aníbal Limón <anibal.limon@linux.intel.com>
---
 lib/bb/fetch2/git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 31fd8a7..706fff5 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -374,7 +374,7 @@ class Git(FetchMethod):
         verstring = ""
         tagregex = re.compile(d.getVar('GITTAGREGEX', True) or "(?P<pver>([0-9][\.|_]?)+)")
         try:
-            output = self._lsremote(ud, d, "refs/tags/*^{}")
+            output = self._lsremote(ud, d, "refs/tags/*")
         except bb.fetch2.FetchError or bb.fetch2.NetworkAccess:
             return ""
 
-- 
1.9.1


