Return-Path: <marius.avram@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 5DB006FB21
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Mar 2014 13:03:45 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 25 Mar 2014 05:59:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,728,1389772800"; d="scan'208";a="507080170"
Received: from mavram-vostro.rb.intel.com ([10.237.105.158])
	by orsmga002.jf.intel.com with ESMTP; 25 Mar 2014 06:02:09 -0700
From: Marius Avram <marius.avram@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 25 Mar 2014 15:02:10 +0200
Message-Id: <1395752530-24031-1-git-send-email-marius.avram@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH 1/2] cooker: delVar in removeConfigurationVar
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
X-List-Received-Date: Tue, 25 Mar 2014 13:03:49 -0000

When a variable was removed from a configuration file it was not
removed from memory. This also had the effect of not allowing
to set a new value for the same variable with saveConfigurationVar.

Signed-off-by: Marius Avram <marius.avram@intel.com>
---
 bitbake/lib/bb/cooker.py |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 07202e3..e4cff3a 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -334,6 +334,8 @@ class BBCooker:
                         contents[begin_line] = "\n"
                     #remove var from history
                     self.data.varhistory.del_var_history(var, conf_file, line)
+                    #remove variable
+                    self.data.delVar(var)
 
                 with open(conf_file, 'w') as f:
                     f.writelines(contents)
-- 
1.7.9.5


