Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id AE2A56AB50
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Apr 2014 10:16:46 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 03 Apr 2014 03:16:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,786,1389772800"; d="scan'208";a="513599206"
Received: from pmcgurk-mobl1.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.120.138])
	by fmsmga002.fm.intel.com with ESMTP; 03 Apr 2014 03:16:47 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  3 Apr 2014 11:16:24 +0100
Message-Id: <a351ea3dead262d8e84bba6ab1195f2cb481f1c8.1396520116.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <cover.1396520116.git.paul.eggleton@linux.intel.com>
References: <cover.1396520116.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1396520116.git.paul.eggleton@linux.intel.com>
References: <cover.1396520116.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/2] toaster: fix mis-detection of targets as images
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
X-List-Received-Date: Thu, 03 Apr 2014 10:16:48 -0000

If you are using the testimage class then the old test mistook the
global inheritance of testimage.bbclass with the recipe inheriting
image.bbclass because it was only looking for that at the end of the
string.

Also tidy up the code so you an easily tell what it's doing. (The
original method may have been more "pythonic", but it does nothing for
readability.)

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/ui/buildinfohelper.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 2a9e098..e4d2f1f 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -845,10 +845,12 @@ class BuildInfoHelper(object):
             recipe_info['bugtracker'] = event._depgraph['pn'][pn]['bugtracker']
             recipe_info['file_path'] = file_name
             recipe = self.orm_wrapper.get_update_recipe_object(recipe_info)
+            recipe.is_image = False
             if 'inherits' in event._depgraph['pn'][pn].keys():
-                recipe.is_image = True in map(lambda x: x.endswith('image.bbclass'), event._depgraph['pn'][pn]['inherits'])
-            else:
-                recipe.is_image = False
+                for cls in event._depgraph['pn'][pn]['inherits']:
+                    if cls.endswith('/image.bbclass'):
+                        recipe.is_image = True
+                        break
             if recipe.is_image:
                 for t in self.internal_state['targets']:
                     if pn == t.target:
-- 
1.9.0


