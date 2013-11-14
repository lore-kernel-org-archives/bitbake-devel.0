Return-Path: <ddalex@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 062F66D684
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Nov 2013 10:53:40 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 14 Nov 2013 02:53:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,699,1378882800"; d="scan'208";a="433318189"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by fmsmga002.fm.intel.com with ESMTP; 14 Nov 2013 02:53:03 -0800
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 1D8CA5604D4; Thu, 14 Nov 2013 10:53:03 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 14 Nov 2013 10:52:59 +0000
Message-Id: <1384426381-7869-4-git-send-email-alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1384426381-7869-1-git-send-email-alexandru.damian@intel.com>
References: <1384426381-7869-1-git-send-email-alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 3/5] toaster: remove author field
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
X-List-Received-Date: Thu, 14 Nov 2013 10:53:41 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

The AUTHOR field in most recipes is not defined,
or it's not really consistently set in the metadata,
Also does it seem particularly useful.

This patch removes the AUTHOR variable from the
toaster system

    [YOCTO #5449]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/buildinfohelper.py                | 1 -
 lib/toaster/bldviewer/templates/recipe.html | 1 -
 lib/toaster/orm/models.py                   | 1 -
 3 files changed, 3 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 863a20e..c1ffa26 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -624,7 +624,6 @@ class BuildInfoHelper(object):
             recipe_info['licensing_info'] = 'Not Available'
             recipe_info['homepage'] = event._depgraph['pn'][pn]['homepage']
             recipe_info['bugtracker'] = event._depgraph['pn'][pn]['bugtracker']
-            recipe_info['author'] = 'Not Available'
             recipe_info['file_path'] = file_name
             recipe = self.orm_wrapper.get_update_recipe_object(recipe_info)
             if 'inherits' in event._depgraph['pn'][pn].keys():
diff --git a/lib/toaster/bldviewer/templates/recipe.html b/lib/toaster/bldviewer/templates/recipe.html
index a624370..e9a1c10 100644
--- a/lib/toaster/bldviewer/templates/recipe.html
+++ b/lib/toaster/bldviewer/templates/recipe.html
@@ -38,7 +38,6 @@
             <td>{{recipe.licensing_info}}</td>
             <td>{{recipe.homepage}}</td>
             <td>{{recipe.bugtracker}}</td>
-            <td>{{recipe.author}}</td>
             <td>{{recipe.file_path}}</td>
             <td>
         <div style="height: 5em; overflow:auto">
diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index a3df990..cac8367 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -207,7 +207,6 @@ class Recipe(models.Model):
     licensing_info = models.TextField(blank=True)
     homepage = models.URLField(blank=True)
     bugtracker = models.URLField(blank=True)
-    author = models.CharField(max_length=100, blank=True)
     file_path = models.FilePathField(max_length=255)
 
 
-- 
1.8.3.2


