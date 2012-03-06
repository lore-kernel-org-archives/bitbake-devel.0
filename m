Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1S545I-0003YO-Vy
	for bitbake-devel@lists.openembedded.org;
	Wed, 07 Mar 2012 00:46:25 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 06 Mar 2012 15:37:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="118399675"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.123.109])
	by orsmga002.jf.intel.com with ESMTP; 06 Mar 2012 15:37:47 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  6 Mar 2012 23:37:35 +0000
Message-Id: <789e78d1de4f36657addeb3a7264a6fabfa697e2.1331076902.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1331076902.git.paul.eggleton@linux.intel.com>
References: <cover.1331076902.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1331076902.git.paul.eggleton@linux.intel.com>
References: <cover.1331076902.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/1] bitbake/siggen: output filename on error in finalise
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
X-List-Received-Date: Tue, 06 Mar 2012 23:46:25 -0000

If an error occurs during finalise() (when for example we might get an
expansion error in SRCPV), log a note which mentions which recipe was
being finalised.

Fixes [YOCTO #1782]

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/siggen.py |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 975ae41..eaef4a8 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -126,7 +126,11 @@ class SignatureGeneratorBasic(SignatureGenerator):
         if variant:
             fn = "virtual:" + variant + ":" + fn
 
-        taskdeps = self._build_data(fn, d)
+        try:
+            taskdeps = self._build_data(fn, d)
+        except:
+            bb.note("Error during finalise of %s" % fn)
+            raise
 
         #Slow but can be useful for debugging mismatched basehashes
         #for task in self.taskdeps[fn]:
-- 
1.7.5.4



