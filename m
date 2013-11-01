Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 02DA86CE3F
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Nov 2013 15:58:48 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 01 Nov 2013 08:55:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,535,1378882800"; d="scan'208";a="428337471"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.91])
	by orsmga002.jf.intel.com with ESMTP; 01 Nov 2013 08:58:49 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  1 Nov 2013 15:58:34 +0000
Message-Id: <56e90fd051efeaa3317bed9e9c699eb28fe1ea2a.1383321482.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1383321482.git.paul.eggleton@linux.intel.com>
References: <cover.1383321482.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1383321482.git.paul.eggleton@linux.intel.com>
References: <cover.1383321482.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 7/8] toaster: add variable description for prefixed/suffixed variables
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
X-List-Received-Date: Fri, 01 Nov 2013 15:58:48 -0000

From: Cristiana Voicu <cristiana.voicu@intel.com>

In the Configuration table, we need to link prefixed / suffixed
variables to the corresponding variable descriptions in documentation.conf.

[YOCTO #5198]

Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/ui/buildinfohelper.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 4996b42..2ca0bd3 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -226,6 +226,11 @@ class ORMWrapper(object):
                     value = ''
                 desc = vardump[k]['doc'];
                 if desc is None:
+                    var_words = [word for word in k.split('_')]
+                    root_var = "_".join([word for word in var_words if word.isupper()])
+                    if root_var and root_var != k and root_var in vardump:
+                        desc = vardump[root_var]['doc']
+                if desc is None:
                     desc = ''
                 Variable.objects.create( build = build_obj,
                     variable_name = k,
-- 
1.8.1.2


