Return-Path: <david.reyna@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 7C30271C54
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  6 Sep 2018 05:30:10 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w865UBOc015922
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 5 Sep 2018 22:30:11 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.217) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Wed, 5 Sep 2018 22:30:11 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 5 Sep 2018 22:26:46 -0700
Message-ID: <c8be3cac8fd74c32adc60d63002af556e87556c9.1536210899.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1536210899.git.David.Reyna@windriver.com>
References: <cover.1536210899.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.157.217]
Subject: [PATCH 7/9] toaster/models.py: allow local paths for custom recipe's base
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
X-List-Received-Date: Thu, 06 Sep 2018 05:30:10 -0000
Content-Type: text/plain

From: Awais Belal <awais_belal@mentor.com>

In a case where the layer source is local only and the recipe
is not yet built, we can search for the path with layer's
local_source_dir, and if available that should be used rather
than just skipping the scenario.

[YOCTO #12891]

Signed-off-by: Awais Belal <awais_belal@mentor.com>
Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/orm/models.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 3a7dff8..4b77e8f 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -1663,6 +1663,9 @@ class CustomImageRecipe(Recipe):
 
         path_schema_two = self.base_recipe.file_path
 
+        path_schema_three = "%s/%s" % (self.base_recipe.layer_version.layer.local_source_dir,
+                                     self.base_recipe.file_path)
+
         if os.path.exists(path_schema_one):
             return path_schema_one
 
@@ -1670,6 +1673,10 @@ class CustomImageRecipe(Recipe):
         if os.path.exists(path_schema_two):
             return path_schema_two
 
+        # Or a local path if all layers are local
+        if os.path.exists(path_schema_three):
+            return path_schema_three
+
         return None
 
     def generate_recipe_file_contents(self):
-- 
1.9.1


