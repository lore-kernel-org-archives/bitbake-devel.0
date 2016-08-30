Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 671226FF84
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Aug 2016 04:37:08 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga102.fm.intel.com with ESMTP; 29 Aug 2016 21:37:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,254,1470726000"; d="scan'208";a="872441196"
Received: from unknown (HELO peggleto-mobl.ger.corp.intel.com)
	([10.255.182.37])
	by orsmga003.jf.intel.com with ESMTP; 29 Aug 2016 21:37:08 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 30 Aug 2016 16:36:36 +1200
Message-Id: <16567ebbd1d9f86b9c799a209a6ec1d313f69fe3.1472531645.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1472531645.git.paul.eggleton@linux.intel.com>
References: <cover.1472531645.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1472531645.git.paul.eggleton@linux.intel.com>
References: <cover.1472531645.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/3] tinfoil: add context manager functions
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
X-List-Received-Date: Tue, 30 Aug 2016 04:37:08 -0000

Since calling the shutdown() function is highly recommended, make
tinfoil objects a little easier to deal with by adding context manager
support - so you can do the following:

    with bb.tinfoil.Tinfoil() as tinfoil:
        tinfoil.prepare(True)
        ...

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/tinfoil.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 95608ae..441be2c 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -59,6 +59,12 @@ class Tinfoil:
     def register_idle_function(self, function, data):
         pass
 
+    def __enter__(self):
+        return self
+
+    def __exit__(self, type, value, traceback):
+        self.shutdown()
+
     def parseRecipes(self):
         sys.stderr.write("Parsing recipes..")
         self.logger.setLevel(logging.WARNING)
-- 
2.5.5


