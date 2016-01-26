Return-Path: <markus.lehtonen@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 13EF876803
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Jan 2016 13:34:36 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga101.fm.intel.com with ESMTP; 26 Jan 2016 05:34:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,350,1449561600"; d="scan'208";a="641616591"
Received: from marquiz.fi.intel.com ([10.237.72.155])
	by FMSMGA003.fm.intel.com with ESMTP; 26 Jan 2016 05:34:35 -0800
From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 26 Jan 2016 15:34:28 +0200
Message-Id: <1453815272-8303-3-git-send-email-markus.lehtonen@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1453815272-8303-1-git-send-email-markus.lehtonen@linux.intel.com>
References: <1453815272-8303-1-git-send-email-markus.lehtonen@linux.intel.com>
Subject: [PATCH 2/6] SignatureGenerator: add method for saving the file checksum cache
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
X-List-Received-Date: Tue, 26 Jan 2016 13:34:37 -0000

Extend the API in order to be able to write out the file checksum cache
onto disk. SignatureGeneratorBasic class now implements a method that
update the fetcher local files checksum cache with the task file
dependency checksums.

Signed-off-by: Markus Lehtonen <markus.lehtonen@linux.intel.com>
---
 lib/bb/siggen.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index c104c19..a7916b2 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -44,6 +44,10 @@ class SignatureGenerator(object):
     def get_taskhash(self, fn, task, deps, dataCache):
         return "0"
 
+    def writeout_file_checksum_cache(self):
+        """Write/update the file checksum cache onto disk"""
+        return
+
     def set_taskdata(self, hashes, deps, checksum):
         return
 
@@ -215,6 +219,11 @@ class SignatureGeneratorBasic(SignatureGenerator):
         #d.setVar("BB_TASKHASH_task-%s" % task, taskhash[task])
         return h
 
+    def writeout_file_checksum_cache(self):
+        """Write/update the file checksum cache onto disk"""
+        bb.fetch2.fetcher_parse_save()
+        bb.fetch2.fetcher_parse_done()
+
     def dump_sigtask(self, fn, task, stampbase, runtime):
         k = fn + "." + task
         if runtime == "customfile":
-- 
2.1.4


