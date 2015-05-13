Return-Path: <mariano.lopez@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 67C9D6013D
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 May 2015 19:30:18 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga101.jf.intel.com with ESMTP; 13 May 2015 12:30:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.13,422,1427785200"; d="scan'208";a="709772485"
Received: from yctb01.ostc.intel.com (HELO yctb01.otcr.intel.com)
	([10.23.219.46])
	by fmsmga001.fm.intel.com with ESMTP; 13 May 2015 12:30:17 -0700
From: mariano.lopez@linux.intel.com
To: bitbake-devel@lists.openembedded.org
Date: Wed, 13 May 2015 11:24:57 +0000
Message-Id: <1431516297-42766-1-git-send-email-mariano.lopez@linux.intel.com>
X-Mailer: git-send-email 1.8.4.5
Subject: [PATCH] bitbake: fetch2/git: Add URL when latest_revision generates an exception.
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
X-List-Received-Date: Wed, 13 May 2015 19:30:18 -0000

From: Mariano Lopez <mariano.lopez@linux.intel.com>

The URL is not sent when _latest_revision generates and exception.
When performing the sanity checks it is not possible to know the URI that failed.

This add the URL when latest_revision generates an exception.

[YOCTO: #7592]

Signed-off-by: Mariano Lopez <mariano.lopez@linux.intel.com>
---
 bitbake/lib/bb/fetch2/git.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 0fd9bee..a67033f 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -352,7 +352,8 @@ class Git(FetchMethod):
             for l in output.split('\n'):
                 if s in l:
                     return l.split()[0]
-        raise bb.fetch2.FetchError("Unable to resolve '%s' in upstream git repository in git ls-remote output" % ud.unresolvedrev[name])
+        raise bb.fetch2.FetchError("Unable to resolve '%s' in upstream git repository in git ls-remote output for %s" % \
+            (ud.unresolvedrev[name], ud.host+ud.path))
 
     def latest_versionstring(self, ud, d):
         """
-- 
1.8.4.5


