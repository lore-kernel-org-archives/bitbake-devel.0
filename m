Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1Qe5gV-0005Yl-1H
	for bitbake-devel@lists.openembedded.org;
	Tue, 05 Jul 2011 15:29:03 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 05 Jul 2011 06:25:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,479,1304319600"; d="scan'208";a="22815075"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.255.17.114])
	by azsmga001.ch.intel.com with ESMTP; 05 Jul 2011 06:25:10 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  5 Jul 2011 14:25:06 +0100
Message-Id: <15f6829a3ca8e8c067adedbeea11fc250ee0eb19.1309872199.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1309872199.git.paul.eggleton@linux.intel.com>
References: <cover.1309872199.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1309872199.git.paul.eggleton@linux.intel.com>
References: <cover.1309872199.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/2] bitbake-layers: fix error on startup caused by recent cooker change
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
X-List-Received-Date: Tue, 05 Jul 2011 13:29:03 -0000

Fix bitbake-layers "TypeError: 'NoneType' object is not iterable" error on
startup. Commit f3be8e9a7df13cc11ffc8fc667efaf2db96a7c38 changed to expect
prefile and postfile to be populated and no longer expects file.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/bin/bitbake-layers |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/bitbake/bin/bitbake-layers b/bitbake/bin/bitbake-layers
index bdfa4b6..1c48c8c 100755
--- a/bitbake/bin/bitbake-layers
+++ b/bitbake/bin/bitbake-layers
@@ -211,7 +211,8 @@ class Config(object):
         self.pkgs_to_build = []
         self.debug_domains = []
         self.extra_assume_provided = []
-        self.file = []
+        self.prefile = []
+        self.postfile = []
         self.debug = 0
         self.__dict__.update(options)
 
-- 
1.7.4.1



