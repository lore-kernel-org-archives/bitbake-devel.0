Return-Path: <caio.oliveira@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id B6CF378273
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Aug 2017 22:35:51 +0000 (UTC)
Received: from orsmga005.jf.intel.com ([10.7.209.41])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	30 Aug 2017 15:35:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.41,450,1498546800"; d="scan'208";a="143871098"
Received: from cmdeoliv-mobl2.jf.intel.com (HELO
	cmdeoliv-mobl2.amr.corp.intel.com) ([10.24.8.241])
	by orsmga005.jf.intel.com with ESMTP; 30 Aug 2017 15:35:52 -0700
Date: Wed, 30 Aug 2017 15:35:52 -0700
From: Caio Marcelo de Oliveira Filho <caio.oliveira@intel.com>
To: bitbake-devel@lists.openembedded.org
Message-ID: <20170830223552.GA14312@cmdeoliv-mobl2.amr.corp.intel.com>
MIME-Version: 1.0
User-Agent: Mutt/1.8.3 (2017-05-23)
Subject: [PATCH] siggen: Add reset to SignatureGenerator
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
X-List-Received-Date: Wed, 30 Aug 2017 22:35:51 -0000
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fix failure after commit "cooker/siggen: Reset siggen when reparsing"
(e4c6ca9440f63761560b49bbe12654441f54687e) when executing without
specifying a BB_SIGNATURE_HANDLER.

Signed-off-by: Caio Marcelo de Oliveira Filho <caio.oliveira@intel.com>
---
 lib/bb/siggen.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 4380760..7521a3a 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -69,6 +69,9 @@ class SignatureGenerator(object):
     def set_taskdata(self, data):
         self.runtaskdeps, self.taskhash, self.file_checksum_values, self.taints, self.basehash = data
 
+    def reset(self, data):
+        return
+
 class SignatureGeneratorBasic(SignatureGenerator):
     """
     """
-- 
2.9.4


