Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id E00C2731E7
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Jan 2016 07:38:52 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id u077cqg9024448
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 6 Jan 2016 23:38:53 -0800
Received: from ala-blade47.wrs.com (147.11.105.67) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.248.2;
	Wed, 6 Jan 2016 23:38:52 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 6 Jan 2016 23:38:51 -0800
Message-ID: <60b4483fa1dfbd45dc1835dca1759ee5f6a27f4f.1452152302.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1452152302.git.liezhi.yang@windriver.com>
References: <cover.1452152302.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] fetch2/git.py:_latest_revision: respect BB_FETCH_PREMIRRORONLY
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
X-List-Received-Date: Thu, 07 Jan 2016 07:38:54 -0000
Content-Type: text/plain

Fixed when use a local BB_FETCH_PREMIRRORONLY for AUTOREV recipes:
SRCREV = "${AUTOREV}"
BB_NO_NETWORK = "1"
For example, the refpolicy-mls from meta-selinux:
$ bitbake refpolicy-mls -ccleanall/fetch

Log data follows:
| DEBUG: Executing python function do_cleanall
| DEBUG: Python function do_cleanall finished
| ERROR: Function failed: Network access disabled through BB_NO_NETWORK (or set indirectly due to use of BB_FETCH_PREMIRRORONLY) but access requested with command git -c core.fsyncobjectfiles=0 ls-remote git://github.com/TresysTechnology/refpolicy.git  (for url None)
ERROR: Task 3 (/path/to/meta-selinux/recipes-security/refpolicy/refpolicy-mls_git.bb, do_cleanall) failed with exit code '1'
NOTE: Tasks Summary: Attempted 4 tasks of which 0 didn't need to be rerun and 1 failed.

Check BB_FETCH_PREMIRRORONLY before ls-remote will fix the problem.

[YOCTO #8893]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/fetch2/git.py |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 5ffab22..7f7296f 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -356,7 +356,10 @@ class Git(FetchMethod):
         """
         Compute the HEAD revision for the url
         """
-        output = self._lsremote(ud, d, "")
+        if d.getVar("BB_FETCH_PREMIRRORONLY", True) and ud.proto != "file":
+            return "HEAD"
+        else:
+            output = self._lsremote(ud, d, "")
         # Tags of the form ^{} may not work, need to fallback to other form
         if ud.unresolvedrev[name][:5] == "refs/":
             head = ud.unresolvedrev[name]
-- 
1.7.9.5


