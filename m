Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by mail.openembedded.org (Postfix) with ESMTP id 39F13719BD
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 30 Mar 2017 02:24:07 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga105.fm.intel.com with ESMTP; 29 Mar 2017 19:24:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.36,244,1486454400"; d="scan'208";a="1128726364"
Received: from driley-mobl5.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.172.155])
	by fmsmga001.fm.intel.com with ESMTP; 29 Mar 2017 19:24:07 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 30 Mar 2017 15:24:00 +1300
Message-Id: <478d4c6b740a26b8af498db5624440de00b691dd.1490840595.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1490840595.git.paul.eggleton@linux.intel.com>
References: <cover.1490840595.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/2] tinfoil: improve get_recipe_file() exception text
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
X-List-Received-Date: Thu, 30 Mar 2017 02:24:07 -0000

* Turn reasons from a list into a string (usually there will be only one
  reason, but the interface provides for more than one) and state up
  front that the recipe is unavailable for clarity
* Use quotes around invalid recipe name

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/tinfoil.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 14a2271..928333a 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -368,9 +368,9 @@ class Tinfoil:
             taskdata = bb.taskdata.TaskData(None, skiplist=skiplist)
             skipreasons = taskdata.get_reasons(pn)
             if skipreasons:
-                raise bb.providers.NoProvider(skipreasons)
+                raise bb.providers.NoProvider('%s is unavailable:\n  %s' % (pn, '  \n'.join(skipreasons)))
             else:
-                raise bb.providers.NoProvider('Unable to find any recipe file matching %s' % pn)
+                raise bb.providers.NoProvider('Unable to find any recipe file matching "%s"' % pn)
         return best[3]
 
     def get_file_appends(self, fn):
-- 
2.9.3


