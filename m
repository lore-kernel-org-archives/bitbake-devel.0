Return-Path: <cristiana.voicu@intel.com>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by mail.openembedded.org (Postfix) with ESMTP id C3A7C6D383
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Oct 2013 16:23:22 +0000 (UTC)
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 29 Oct 2013 09:23:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,535,1378882800"; d="scan'208";a="381761091"
Received: from cvoicu-vostro-460.rb.intel.com ([10.237.105.65])
	by azsmga001.ch.intel.com with ESMTP; 29 Oct 2013 09:23:23 -0700
From: Cristiana Voicu <cristiana.voicu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 29 Oct 2013 18:28:21 +0200
Message-Id: <1383064101-15309-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] toaster: add variable description for prefixed/suffixed variables
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
X-List-Received-Date: Tue, 29 Oct 2013 16:23:24 -0000

In the Configuration table, we need to link prefixed / suffixed
variables to the corresponding variable descriptions in documentation.conf.

[YOCTO #5198]
Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
---
 bitbake/lib/bb/ui/buildinfohelper.py |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/bitbake/lib/bb/ui/buildinfohelper.py b/bitbake/lib/bb/ui/buildinfohelper.py
index 9541d10..303766a 100644
--- a/bitbake/lib/bb/ui/buildinfohelper.py
+++ b/bitbake/lib/bb/ui/buildinfohelper.py
@@ -230,6 +230,11 @@ class ORMWrapper(object):
                     value = ''
                 desc = vardump[k]['doc'];
                 if desc is None:
+                    var_words = [word for word in k.split('_')]
+                    root_var = "_".join([word for word in var_words if word.isupper()])
+                    if root_var and root_var != k and root_var in vardump:
+                        desc = vardump[root_var]['doc']
+                if desc is None:
                     desc = ''
                 variable_obj = Variable.objects.create( build = build_obj,
                     variable_name = k,
-- 
1.7.9.5


