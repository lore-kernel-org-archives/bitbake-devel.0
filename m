Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1S4neG-000371-2t
	for bitbake-devel@lists.openembedded.org;
	Tue, 06 Mar 2012 07:13:24 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q2664l3E004409
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 5 Mar 2012 22:04:47 -0800 (PST)
Received: from build-PowerEdge-T100.corp.ad.wrs.com (128.224.163.66) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.1.255.0; Mon, 5 Mar 2012 22:04:47 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 6 Mar 2012 14:04:36 +0800
Message-ID: <799f88e78f46b5a7eab5932060b4c2bf27ee1a95.1331012089.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1331012089.git.liezhi.yang@windriver.com>
References: <cover.1331012089.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] siggen.py: Use basehash if no taskhash
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
X-List-Received-Date: Tue, 06 Mar 2012 06:13:24 -0000
Content-Type: text/plain

The bitbake-runtask doesn't work since there is no taskhash (it worked
in the past, but seems recent changes made it doesn't work again), use
the basehash when there is no taskhash, just like what dump_sigtask
does.

[YOCTO #1229]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/siggen.py |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 975ae41..39f44a2 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -219,7 +219,11 @@ class SignatureGeneratorBasicHash(SignatureGeneratorBasic):
             k = fn + "." + taskname[:-9]
         else:
             k = fn + "." + taskname
-        h = self.taskhash[k]
+        if k in self.taskhash:
+            h = self.taskhash[k]
+        else:
+            # If k is not in basehash, then error
+            h = self.basehash[k]
         return ("%s.%s.%s.%s" % (stampbase, taskname, h, extrainfo)).rstrip('.')
 
 def dump_this_task(outfile, d):
-- 
1.7.4.1



