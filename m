Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 28AFE719B0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Apr 2017 02:20:34 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	19 Apr 2017 19:20:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.37,223,1488873600"; d="scan'208";a="958979177"
Received: from sitinura-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.137.15])
	by orsmga003.jf.intel.com with ESMTP; 19 Apr 2017 19:20:34 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 20 Apr 2017 14:20:29 +1200
Message-Id: <3653b7e0f718b37496d75f950d13ceead2ae6675.1492654797.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1492654797.git.paul.eggleton@linux.intel.com>
References: <cover.1492654797.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/1] lib/bb/command: fix overrides in remote datastores where there is no default
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
X-List-Received-Date: Thu, 20 Apr 2017 02:20:34 -0000

If you have, for example, no value set for a variable VARIABLE and a
then VARIABLE_pn-something = "value" and then you parse something.bb,
you expect getVar('VARIABLE') on the resulting datastore to return
"value", but the code here assumed that if the variable wasn't set
without overrides then we didn't need to return the overridedata and
thus we didn't get the overridden value.

In OE this affected the ability to get RECIPE_MAINTAINER for a recipe
in a script using tinfoil (since this is only set from an inc file with
_pn- overrides for each recipe, and no default is set).

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/command.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 390d4f1..ab51d8e 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -479,6 +479,9 @@ class CommandsSync:
                         '_connector_overrides': overridedata}
             else:
                 value['_connector_overrides'] = overridedata
+        else:
+            value = {}
+            value['_connector_overrides'] = overridedata
         return value
     dataStoreConnectorFindVar.readonly = True
 
-- 
2.9.3


