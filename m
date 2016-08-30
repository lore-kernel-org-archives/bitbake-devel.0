Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 1E8CD70031
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Aug 2016 20:48:49 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga104.fm.intel.com with ESMTP; 30 Aug 2016 13:48:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,258,1470726000"; d="scan'208";a="162622916"
Received: from ashuvini-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.145.135])
	by fmsmga004.fm.intel.com with ESMTP; 30 Aug 2016 13:48:48 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 31 Aug 2016 08:48:06 +1200
Message-Id: <16567ebbd1d9f86b9c799a209a6ec1d313f69fe3.1472589757.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <cover.1472589757.git.paul.eggleton@linux.intel.com>
References: <cover.1472589757.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1472589757.git.paul.eggleton@linux.intel.com>
References: <cover.1472589757.git.paul.eggleton@linux.intel.com>
Subject: [PATCH v2 1/4] tinfoil: add context manager functions
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
X-List-Received-Date: Tue, 30 Aug 2016 20:48:49 -0000

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


