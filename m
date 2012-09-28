Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <mark.hatle@windriver.com>) id 1THeTV-0005Vj-7K
	for bitbake-devel@lists.openembedded.org;
	Fri, 28 Sep 2012 19:35:41 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q8SHMYiX002857
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Sep 2012 10:22:34 -0700 (PDT)
Received: from localhost.localdomain (172.25.34.61) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server (TLS) id 14.2.309.2;
	Fri, 28 Sep 2012 10:22:33 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 28 Sep 2012 12:27:49 -0500
Message-ID: <1348853270-29676-1-git-send-email-mark.hatle@windriver.com>
X-Mailer: git-send-email 1.7.3.4
MIME-Version: 1.0
X-Originating-IP: [172.25.34.61]
Subject: [PATCH 1/2] utils.py: Check for duplication dependency entries
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
X-List-Received-Date: Fri, 28 Sep 2012 17:35:41 -0000
Content-Type: text/plain

explode_dep_versions is not able to have duplicate entries.  Previously
duplicate entries ended up with the last item being the one returned to
the caller.

Instead we now throw a ValueType exception.  This will ensure the caller
always gets the full set of declared dependencies.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/bb/utils.py |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 82dab6b..fa5d2ab 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -159,6 +159,8 @@ def explode_dep_versions(s):
             lastver = lastver + " " + (i[:-1] or "")
             r[lastdep] = lastver
         elif not inversion:
+            if i in r:
+                raise ValueError("Error, item %s appeared in dependency string '%s' multiple times.  explode_dep_versions cannot cope with this." % (i, s))
             r[i] = None
             lastdep = i
             lastver = ""
-- 
1.7.3.4



