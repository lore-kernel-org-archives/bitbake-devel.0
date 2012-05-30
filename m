Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1SZlkM-00054z-4z
	for bitbake-devel@lists.openembedded.org;
	Wed, 30 May 2012 18:27:42 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 30 May 2012 09:17:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="105914732"
Received: from unknown (HELO helios.amr.corp.intel.com) ([10.255.12.128])
	by AZSMGA002.ch.intel.com with ESMTP; 30 May 2012 09:17:21 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 30 May 2012 17:17:14 +0100
Message-Id: <b32bd1c30888569f45c7682b66c75e0504433e14.1338394341.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1338394341.git.paul.eggleton@linux.intel.com>
References: <cover.1338394341.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1338394341.git.paul.eggleton@linux.intel.com>
References: <cover.1338394341.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/5] lib/bb/data_smart.py: don't report variable in ExpansionError if not set
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
X-List-Received-Date: Wed, 30 May 2012 16:27:42 -0000

If the variable name is not specified then don't confuse the error message
by starting off with "Failure expanding variable None...".

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/data_smart.py |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index 27fb7d9..2c02cde 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -102,7 +102,10 @@ class ExpansionError(Exception):
         self.expression = expression
         self.variablename = varname
         self.exception = exception
-        self.msg = "Failure expanding variable %s, expression was %s which triggered exception %s: %s" % (varname, expression, type(exception).__name__, exception)
+        if varname:
+            self.msg = "Failure expanding variable %s, expression was %s which triggered exception %s: %s" % (varname, expression, type(exception).__name__, exception)
+        else:
+            self.msg = "Failure expanding expression %s which triggered exception %s: %s" % (expression, type(exception).__name__, exception)
         Exception.__init__(self, self.msg)
         self.args = (varname, expression, exception)
     def __str__(self):
-- 
1.7.9.5



