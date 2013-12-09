Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 8341E6E26D
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Dec 2013 19:07:26 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 09 Dec 2013 11:07:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,859,1378882800"; d="scan'208";a="449359885"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.25])
	by orsmga002.jf.intel.com with ESMTP; 09 Dec 2013 11:07:24 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Dec 2013 19:07:07 +0000
Message-Id: <f304332da3a51b15e864a853989fe5fbaf5f6079.1386615747.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1386615747.git.paul.eggleton@linux.intel.com>
References: <cover.1386615747.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1386615747.git.paul.eggleton@linux.intel.com>
References: <cover.1386615747.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 01/11] toaster: Analysis API variablehistory update
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
X-List-Received-Date: Mon, 09 Dec 2013 19:07:26 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patch updates the Analysis REST API to expose
the variablehistory information. A UI tool can query
this API to get a picture on how a variable value got
to its final form.

The documentation for VariableHistory is updated on
Wiki https://wiki.yoctoproject.org/wiki/Analysis_REST_API_Contracts

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/bldviewer/api.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/toaster/bldviewer/api.py b/lib/toaster/bldviewer/api.py
index f761ba6..a586734 100644
--- a/lib/toaster/bldviewer/api.py
+++ b/lib/toaster/bldviewer/api.py
@@ -33,5 +33,6 @@ urlpatterns = patterns('bldviewer.views',
         url(r'^recipes$', 'model_explorer', {'model_name':'recipe'}, name='recipe'),
         url(r'^recipe_dependencies$', 'model_explorer',  {'model_name':'recipe_dependency'}, name='recipe_dependencies'),
         url(r'^variables$', 'model_explorer',  {'model_name':'variable'}, name='variables'),
+        url(r'^variableshistory$', 'model_explorer',  {'model_name':'variablehistory'}, name='variablehistory'),
         url(r'^logmessages$', 'model_explorer',  {'model_name':'logmessage'}, name='logmessages'),
 )
-- 
1.8.1.2


