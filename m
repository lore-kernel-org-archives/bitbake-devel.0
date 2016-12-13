Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 1471671B57
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Dec 2016 07:09:03 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga103.fm.intel.com with ESMTP; 12 Dec 2016 23:09:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,340,1477983600"; d="scan'208";a="201961530"
Received: from mauric9x-mobl.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.158.7])
	by fmsmga004.fm.intel.com with ESMTP; 12 Dec 2016 23:09:02 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 13 Dec 2016 20:07:13 +1300
Message-Id: <7e8a3ba04c8b7fec49d33f531043386bea4d3d3c.1481611138.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1481611138.git.paul.eggleton@linux.intel.com>
References: <cover.1481611138.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 14/15] siggen: add means of ignoring basehash mismatch
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
X-List-Received-Date: Tue, 13 Dec 2016 07:09:03 -0000

If you run the setVariable command to set variables then you end up
causing the basehash to not match the previously computed values, which
triggers error messages. These mismatches are expected, so add a means
of disabling them.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/siggen.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index fa8a6b1..b20b9cf 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -101,6 +101,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
 
     def _build_data(self, fn, d):
 
+        ignore_mismatch = ((d.getVar("BB_HASH_IGNORE_MISMATCH", True) or '') == '1')
         tasklist, gendeps, lookupcache = bb.data.generate_dependencies(d)
 
         taskdeps = {}
@@ -135,7 +136,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
                     data = data + str(var)
             datahash = hashlib.md5(data.encode("utf-8")).hexdigest()
             k = fn + "." + task
-            if k in self.basehash and self.basehash[k] != datahash:
+            if not ignore_mismatch and k in self.basehash and self.basehash[k] != datahash:
                 bb.error("When reparsing %s, the basehash value changed from %s to %s. The metadata is not deterministic and this needs to be fixed." % (k, self.basehash[k], datahash))
             self.basehash[k] = datahash
             taskdeps[task] = alldeps
-- 
2.5.5


