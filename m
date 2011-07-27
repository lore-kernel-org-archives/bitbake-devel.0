Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qlw4o-0004Bm-2S
	for bitbake-devel@lists.openembedded.org;
	Wed, 27 Jul 2011 06:50:34 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 26 Jul 2011 21:46:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,273,1309762800"; d="scan'208";a="30529115"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.163])
	by orsmga002.jf.intel.com with ESMTP; 26 Jul 2011 21:46:18 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 26 Jul 2011 21:46:09 -0700
Message-Id: <bf089d8f95d32ac8c3af5444addd579ee06f5d02.1311741742.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1311741742.git.josh@linux.intel.com>
References: <cover.1311741742.git.josh@linux.intel.com>
In-Reply-To: <cover.1311741742.git.josh@linux.intel.com>
References: <cover.1311741742.git.josh@linux.intel.com>
Subject: [RFC PATCH 1/3] cooker: track conf files parsed outside of the usual bitbake.conf inclusion
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
X-List-Received-Date: Wed, 27 Jul 2011 04:50:34 -0000

Save a list of configuration files loaded pre and post parse of bitbake.conf

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/cooker.py |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 1f305d9..765c58d 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -82,6 +82,7 @@ class BBCooker:
         self.status = None
         self.appendlist = {}
         self.skiplist = {}
+        self.extraconf = []
 
         self.server_registration_cb = server_registration_cb
 
@@ -741,6 +742,7 @@ class BBCooker:
         # Parse files for loading *before* bitbake.conf and any includes
         for f in prefiles:
             data = _parse(f, data)
+            self.extraconf.append(f)
 
         layerconf = self._findLayerConf()
         if layerconf:
@@ -766,6 +768,7 @@ class BBCooker:
         # Parse files for loading *after* bitbake.conf and any includes
         for p in postfiles:
             data = _parse(p, data)
+            self.extraconf.append(p)
 
         # Handle any INHERITs and inherit the base class
         bbclasses  = ["base"] + (data.getVar('INHERIT', True) or "").split()
-- 
1.7.6



