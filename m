Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f53.google.com (mail-wg0-f53.google.com [74.125.82.53])
	by mail.openembedded.org (Postfix) with ESMTP id D717C73D40
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Apr 2015 14:47:44 +0000 (UTC)
Received: by wgso17 with SMTP id o17so83645732wgs.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Apr 2015 07:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=l1rivzECrEYEgJyIUwf1K39k/HFuhlS7E6m6JiTMC+w=;
	b=QPrUu5Yr4yFot/H1+DEB0oYCLTDAnWqfo85Bl3F5yn/HomlDlHc9gl0fd9MKToteDJ
	ga72+QjPdNc9r7CskLD8Flw0KCl/aJzgavZJqNpn4m+hG9F6IvrwTeoRNZ7sKd4lHdWh
	IlB6Y9rbroSfLFopcINu4yfzwMDcWa3lp9ZwWQpB3zYsEgUz9e6QTisZse9ELYtzPv57
	CfTrzaPqZGJnT2CUfT2ehHYQy3MRBwi3UWNOgfOKgvbgvy/K5OZvJSUCoy0ahC0QAIqn
	sSz3CbLEn5l4c41HqYBoVw03WukUgxvRl7fzvCsyy/+pR68M8y94T066V9ICexDddMCp
	bJdg==
X-Gm-Message-State: ALoCoQnROs2NiX+JSstDQWfFy5JU9UjOcMRFgIOBKKTkQ0WDa1OkqLXdIuJMm/LLp3C59qDKxQi2
X-Received: by 10.180.73.230 with SMTP id o6mr5942920wiv.30.1429195665699;
	Thu, 16 Apr 2015 07:47:45 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id l3sm26355361wiv.18.2015.04.16.07.47.43
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 Apr 2015 07:47:44 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id CA5EF560E6E; Thu, 16 Apr 2015 15:47:41 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 16 Apr 2015 15:47:40 +0100
Message-Id: <3da9f033ba3cb7313761ed1aff44617754e3dd9c.1429195580.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <e4e9f956e8370ba543578054ea7e889a9f689632.1429195580.git.alexandru.damian@intel.com>
References: <e4e9f956e8370ba543578054ea7e889a9f689632.1429195580.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1429195580.git.alexandru.damian@intel.com>
References: <cover.1429195580.git.alexandru.damian@intel.com>
Cc: David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 7/8] toaster: recipe path broken in recipe detail page
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
X-List-Received-Date: Thu, 16 Apr 2015 14:47:46 -0000

From: David Reyna <David.Reyna@windriver.com>

The recipe paths in managed mode are not processed correctly. They need
any prefix tags removed, and then any build path prefix removed only if
present.

[YOCTO #7523]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/orm/models.py                     | 8 +++++++-
 lib/toaster/toastergui/templates/recipes.html | 2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index 4a6ca8f..b9bb896 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -557,7 +557,13 @@ class Recipe(models.Model):
 
     def get_local_path(self):
         if settings.MANAGED and self.layer_version.build.project is not None:
-            return self.file_path[len(self.layer_version.layer.local_path)+1:]
+            # strip any tag prefixes ('virtual:native:')
+            layer_path=self.layer_version.layer.local_path.split(":")[-1]
+            recipe_path=self.file_path.split(":")[-1]
+            if 0 == recipe_path.find(layer_path):
+                return recipe_path[len(layer_path)+1:]
+            else:
+                return recipe_path
 
         return self.file_path
 
diff --git a/lib/toaster/toastergui/templates/recipes.html b/lib/toaster/toastergui/templates/recipes.html
index 889e676..458d724 100644
--- a/lib/toaster/toastergui/templates/recipes.html
+++ b/lib/toaster/toastergui/templates/recipes.html
@@ -80,7 +80,7 @@
             {% endwith %}
         </td>
         <!-- Recipe file -->
-        <td class="recipe_file">{{recipe.file_path}}</td>
+        <td class="recipe_file">{{recipe.get_local_path}}</td>
         <!-- Section -->
         <td class="recipe_section">{{recipe.section}}</td>
         <!-- License -->
-- 
1.9.1


