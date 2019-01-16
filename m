Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 3E77D7C1B5
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 16 Jan 2019 06:12:46 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x0G6Cld3013687
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 Jan 2019 22:12:47 -0800 (PST)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.408.0; Tue, 15 Jan 2019 22:12:46 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 16 Jan 2019 14:30:42 +0800
Message-ID: <f556525b04a48e761636dac6f53f4d62ab93fb47.1547620210.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1547620210.git.liezhi.yang@windriver.com>
References: <cover.1547620210.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 2/2] bb: siggen: Print more info when basehash are mis-matched
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
X-List-Received-Date: Wed, 16 Jan 2019 06:12:46 -0000
Content-Type: text/plain

This is useful for debugging.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/siggen.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index a0ca7e1..2d3e4e6 100644
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


