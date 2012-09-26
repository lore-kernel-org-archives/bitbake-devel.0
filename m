Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <cristiana.voicu@intel.com>) id 1TGnMT-0008Sz-QX
	for bitbake-devel@lists.openembedded.org;
	Wed, 26 Sep 2012 10:52:54 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 26 Sep 2012 01:39:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,489,1344236400"; d="scan'208";a="213384428"
Received: from cvoicu-vostro-460 (HELO localhost.localdomain)
	([10.237.105.151])
	by orsmga002.jf.intel.com with ESMTP; 26 Sep 2012 01:40:01 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 26 Sep 2012 11:40:54 +0300
Message-Id: <1348648854-4588-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob/builddetailspage: change branch field
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
X-List-Received-Date: Wed, 26 Sep 2012 08:52:54 -0000

When a user makes a build from a tarball, it shows fatal error in branch field.
Now it not complains as a fatal error. It is a normal message.

[YOCTO #3114]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builddetailspage.py |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/bitbake/lib/bb/ui/crumbs/builddetailspage.py b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
index a927c21..816ffde 100755
--- a/bitbake/lib/bb/ui/crumbs/builddetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
@@ -99,6 +99,8 @@ class BuildConfigurationTreeView(gtk.TreeView):
             import os, os.path
             if os.path.exists(path):
                 branch = bb.process.run('cd %s; git branch | grep "^* " | tr -d "* "' % path)[0]
+                if branch.startswith("fatal: Not a git repository"):
+                    branch = branch[7:]
                 if branch:
                     branch = branch.strip('\n')
                     vars.append(self.set_vars("Branch:", branch))
-- 
1.7.9.5



