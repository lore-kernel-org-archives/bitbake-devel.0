Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id E583D76486
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 13 Aug 2015 07:08:48 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.1/8.15.1) with ESMTPS id t7D78n04021963
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 13 Aug 2015 00:08:49 -0700 (PDT)
Received: from ala-blade48.wrs.com (147.11.105.68) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.235.1;
	Thu, 13 Aug 2015 00:08:49 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 13 Aug 2015 00:08:48 -0700
Message-ID: <629f01246969a76254c26d5e614ebef5c1ed4270.1439449677.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1439449677.git.liezhi.yang@windriver.com>
References: <cover.1439449677.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] fetch2/git.py: fix _latest_revision for local PREMIRROR
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
X-List-Received-Date: Thu, 13 Aug 2015 07:08:49 -0000
Content-Type: text/plain

- Fixed when SRCREV = "${AUTOREV}", and set BB_NO_NETWORK = "1":
$ bitbake <recipe> -ccleanall
| DEBUG: Executing python function do_cleanall
| DEBUG: Python function do_cleanall finished
| ERROR: Function failed: Network access disabled through BB_NO_NETWORK ...

- Fixed when SRCREV = "${AUTOREV}", set BB_NO_NETWORK = "1"  and use
  local PREMIRROR:
$ bitbake <recipe> -cfetchall
| DEBUG: Python function do_fetch finished
| ERROR: Function failed: Network access disabled through BB_NO_NETWORK ...

Stop running "git ls-remote" when BB_NO_NETWORK would fix the problem.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/fetch2/git.py |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 374d846..67ee107 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -350,7 +350,6 @@ class Git(FetchMethod):
         """
         Compute the HEAD revision for the url
         """
-        output = self._lsremote(ud, d, "")
         # Tags of the form ^{} may not work, need to fallback to other form
         if ud.unresolvedrev[name][:5] == "refs/":
             head = ud.unresolvedrev[name]
@@ -358,6 +357,12 @@ class Git(FetchMethod):
         else:
             head = "refs/heads/%s" % ud.unresolvedrev[name]
             tag = "refs/tags/%s" % ud.unresolvedrev[name]
+        # Only ls-remote when url is "file://" or BB_NO_NETWORK != "1",
+        # this makes local mirror works.
+        if ud.proto.lower() == 'file' or d.getVar("BB_NO_NETWORK", True) != "1":
+            output = self._lsremote(ud, d, "")
+        else:
+            output = "%s %s" % (name, head)
         for s in [head, tag + "^{}", tag]:
             for l in output.split('\n'):
                 if s in l:
-- 
1.7.9.5


