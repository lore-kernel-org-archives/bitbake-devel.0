Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <mark.hatle@windriver.com>) id 1TI75u-0001dR-B3
	for bitbake-devel@lists.openembedded.org;
	Sun, 30 Sep 2012 02:09:14 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q8TNuI1o020365
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 29 Sep 2012 16:56:18 -0700 (PDT)
Received: from localhost.localdomain (172.25.34.61) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server (TLS) id 14.2.309.2;
	Sat, 29 Sep 2012 16:56:17 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sat, 29 Sep 2012 19:01:44 -0500
Message-ID: <1348963305-26122-1-git-send-email-mark.hatle@windriver.com>
X-Mailer: git-send-email 1.7.3.4
MIME-Version: 1.0
X-Originating-IP: [172.25.34.61]
Subject: [PATCH 1/2 v2] utils.py: Check for duplicate dependency entries
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sun, 30 Sep 2012 00:09:14 -0000
Content-Type: text/plain

explode_dep_versions is not able to have duplicate entries.  Previously
duplicate entries ended up with the last item being the one returned to
the caller.

We now detect a collision.  We do allow an empty item to have a comparison
added to it, or a duplicate with the same comparison without error.

When a collision is detected a ValueError exception is thrown.

Allowed:
   foo foo (= 1.12) foo

Invalid:
   foo (= 1.12) foo (= 1.13)

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/bb/utils.py |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 82dab6b..d032ab2 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -157,9 +157,12 @@ def explode_dep_versions(s):
         elif inversion and i.endswith(')'):
             inversion = False
             lastver = lastver + " " + (i[:-1] or "")
+            if lastdep in r and r[lastdep] and r[lastdep] != lastver:
+                raise ValueError("Error, item %s appeared in dependency string '%s' multiple times with different values.  explode_dep_versions cannot cope with this." % (lastdep, s))
             r[lastdep] = lastver
         elif not inversion:
-            r[i] = None
+            if not (i in r and r[i]):
+                r[i] = None
             lastdep = i
             lastver = ""
         elif inversion:
-- 
1.7.3.4



