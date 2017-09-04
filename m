Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 43D00781CD
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  4 Sep 2017 09:03:57 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	04 Sep 2017 02:03:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.41,474,1498546800"; d="scan'208";a="1191290690"
Received: from nabmajid-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.129.136])
	by fmsmga001.fm.intel.com with ESMTP; 04 Sep 2017 02:03:55 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  4 Sep 2017 21:03:12 +1200
Message-Id: <32eb175b9b03b51c62a217e18d412b61a4e8c735.1504515728.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1504515728.git.paul.eggleton@linux.intel.com>
References: <cover.1504515728.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/2] siggen: move reset() definition to base SignatureGenerator class
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
X-List-Received-Date: Mon, 04 Sep 2017 09:03:57 -0000

If we're implementing reset() in SignatureGenerator at all (and we need
to for a basic non-OE BitBake setup where that is the default signature
generator), then we need it to be clearing out the internal values
properly.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/siggen.py | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 7521a3a..5ef82d7 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -70,7 +70,8 @@ class SignatureGenerator(object):
         self.runtaskdeps, self.taskhash, self.file_checksum_values, self.taints, self.basehash = data
 
     def reset(self, data):
-        return
+        self.__init__(data)
+
 
 class SignatureGeneratorBasic(SignatureGenerator):
     """
@@ -97,9 +98,6 @@ class SignatureGeneratorBasic(SignatureGenerator):
         else:
             self.checksum_cache = None
 
-    def reset(self, data):
-        self.__init__(data)
-
     def init_rundepcheck(self, data):
         self.taskwhitelist = data.getVar("BB_HASHTASK_WHITELIST") or None
         if self.taskwhitelist:
-- 
2.9.5


