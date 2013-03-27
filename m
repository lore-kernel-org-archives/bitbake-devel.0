Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei.adrianx.dinu@intel.com>) id 1UKnqN-0005Ib-P8
	for bitbake-devel@lists.openembedded.org;
	Wed, 27 Mar 2013 11:44:37 +0100
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 27 Mar 2013 03:27:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.84,917,1355126400"; d="scan'208";a="219373027"
Received: from adinu-vostro-460.rb.intel.com ([10.237.105.146])
	by AZSMGA002.ch.intel.com with ESMTP; 27 Mar 2013 03:27:06 -0700
From: Andrei Dinu <andrei.adrianx.dinu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 27 Mar 2013 12:27:50 +0200
Message-Id: <1364380074-16382-3-git-send-email-andrei.adrianx.dinu@intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1364380074-16382-1-git-send-email-andrei.adrianx.dinu@intel.com>
References: <1364380074-16382-1-git-send-email-andrei.adrianx.dinu@intel.com>
Subject: [PATCH 2/6] cooker.py : added variables related to cache_extra
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
X-List-Received-Date: Wed, 27 Mar 2013 10:44:50 -0000

So that the information added to cache_extra could
be accesed by hob, new variables were added in
the cooker.py.

Signed-off-by: Andrei Dinu <andrei.adrianx.dinu@intel.com>
---
 bitbake/lib/bb/cooker.py |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 4650d7c..c7c2ca6 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -576,6 +576,7 @@ class BBCooker:
             description = self.status.description[fn]
             homepage = self.status.homepage[fn]
             bugtracker = self.status.bugtracker[fn]
+            files_info = self.status.files_info[fn]
             rdepends = self.status.rundeps[fn]
             rrecs = self.status.runrecs[fn]
             prevision = self.status.prevision[fn]
@@ -591,6 +592,7 @@ class BBCooker:
                 depend_tree["pn"][pn]["inherits"] = inherits
                 depend_tree["pn"][pn]["homepage"] = homepage
                 depend_tree["pn"][pn]["bugtracker"] = bugtracker
+                depend_tree["pn"][pn]["files_info"] = files_info
                 depend_tree["pn"][pn]["revision"] = prevision
 
             if fnid not in seen_fnids:
-- 
1.7.9.5



