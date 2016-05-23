Return-Path: <peter.kjellerstedt@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id 2B48D60745
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 May 2016 11:35:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id 7579D2E1E4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 May 2016 13:35:51 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id q5hIFY5huwvM for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 May 2016 13:35:50 +0200 (CEST)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id 8F1B82E302
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 May 2016 13:35:50 +0200 (CEST)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 766101A8B
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 May 2016 13:35:50 +0200 (CEST)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id 6BD171A89
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 May 2016 13:35:50 +0200 (CEST)
Received: from saur-2.se.axis.com (saur-2.se.axis.com [10.92.3.2])
	by seth.se.axis.com (Postfix) with ESMTP id 6A956FB1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 May 2016 13:35:50 +0200 (CEST)
Received: from saur-2.se.axis.com (localhost [127.0.0.1])
	by saur-2.se.axis.com (8.14.5/8.14.5) with ESMTP id u4NBZoqb027514
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 May 2016 13:35:50 +0200
Received: (from pkj@localhost)
	by saur-2.se.axis.com (8.14.5/8.14.5/Submit) id u4NBZoiN027513
	for bitbake-devel@lists.openembedded.org;
	Mon, 23 May 2016 13:35:50 +0200
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 23 May 2016 13:35:49 +0200
Message-Id: <1b54aaed6dd402ea25e51902438640edabf32727.1464003299.git.pkj@axis.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <cover.1464003299.git.pkj@axis.com>
References: <cover.1464003299.git.pkj@axis.com>
In-Reply-To: <cover.1464003299.git.pkj@axis.com>
References: <cover.1464003299.git.pkj@axis.com>
Subject: [PATCH 1/1] fetch2/git.py: References must match exactly
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
X-List-Received-Date: Mon, 23 May 2016 11:35:54 -0000

Previously the code used to match a reference to its SHA-1 in
_latest_revision() used the Python "in" operator, which made it match
if the reference matched the beginning of an existing tag or
branch. This test, however, must be exact. I.e., either the reference
matches a tag or branch exactly, or it does not match at all.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/fetch2/git.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 526668b..59827e3 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -350,9 +350,10 @@ class Git(FetchMethod):
             head = "refs/heads/%s" % ud.unresolvedrev[name]
             tag = "refs/tags/%s" % ud.unresolvedrev[name]
         for s in [head, tag + "^{}", tag]:
-            for l in output.split('\n'):
-                if s in l:
-                    return l.split()[0]
+            for l in output.strip().split('\n'):
+                sha1, ref = l.split()
+                if s == ref:
+                    return sha1
         raise bb.fetch2.FetchError("Unable to resolve '%s' in upstream git repository in git ls-remote output for %s" % \
             (ud.unresolvedrev[name], ud.host+ud.path))
 
-- 
2.1.0


