Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 692947D2F2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 17 Apr 2019 11:03:11 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x3HB3Co5002920
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 17 Apr 2019 04:03:12 -0700 (PDT)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.439.0; Wed, 17 Apr 2019 04:03:12 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 17 Apr 2019 19:01:51 +0800
Message-ID: <1a10a265b66dda0223a7a4064c99bf632df29f5a.1555498609.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1555498609.git.liezhi.yang@windriver.com>
References: <cover.1555498609.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 3/3 V2] bb: siggen: Print more info when basehash are mis-matched
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
X-List-Received-Date: Wed, 17 Apr 2019 11:03:12 -0000
Content-Type: text/plain

This is useful for debugging.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/siggen.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 89bf533..7b9f3de 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -119,6 +119,12 @@ class SignatureGeneratorBasic(SignatureGenerator):
             k = fn + "." + task
             if not ignore_mismatch and k in self.basehash and self.basehash[k] != basehash[k]:
                 bb.error("When reparsing %s, the basehash value changed from %s to %s. The metadata is not deterministic and this needs to be fixed." % (k, self.basehash[k], basehash[k]))
+                bb.error("The following commands may help:")
+                cmd = "$ bitbake %s -c%s" % (d.getVar('PN'), task)
+                # Make sure sigdata is dumped before run printdiff
+                bb.error("%s -Snone" % cmd)
+                bb.error("Then:")
+                bb.error("%s -Sprintdiff\n" % cmd)
             self.basehash[k] = basehash[k]
 
         self.taskdeps[fn] = taskdeps
-- 
2.7.4


