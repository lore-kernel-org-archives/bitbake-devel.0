Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f170.google.com (mail-we0-f170.google.com
	[74.125.82.170])
	by mail.openembedded.org (Postfix) with ESMTP id 77C4A6FB3C
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Mar 2014 18:37:37 +0000 (UTC)
Received: by mail-we0-f170.google.com with SMTP id w61so3727558wes.29
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Mar 2014 11:37:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=hZtzA7wpTd7z1XMVROPFCc+wpQZqZCIVD/YfKchjusg=;
	b=BnlITopzs19N6HvuxHRdpq91+HqqG6TxY2khiVDQxNgop/qoV9wAa0IYxwwitoVCXY
	IcvNmfbJs2ju+blAN+iRnCJezDqYfYnPcpuV89k4JsspaVwNqgr8xiFfsk1Kwi9R8VZP
	TG6TuDuKjOG4GIQpj5rmKWsRn2+mkNsCW/rjnWxI5UO8K7Mzn2vh94z4xbQuazENIVks
	Xarby5pwSdspcjZMGIMG3NA3OYlLDtRmbmGMv2mjyCjwjmw2SVm3O0jzrDiAb8WI1zUP
	DguVODNNConpJMoZcO8ebrk08dJfXR/8ontIsyWEiWXe49hwq8AMOYzP/ITFCXrmv2Eb
	9cYA==
X-Gm-Message-State: ALoCoQkgLkcvS6koDdv+jX4eNLRp9QxonQd2IB805W9S+NzgwXRRi+jIQFPc0dzes0DxGzbLBBUW
X-Received: by 10.180.20.71 with SMTP id l7mr16330112wie.35.1395686258028;
	Mon, 24 Mar 2014 11:37:38 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id u6sm41446876wif.6.2014.03.24.11.37.34
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Mon, 24 Mar 2014 11:37:35 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id C722B5616BD; Mon, 24 Mar 2014 18:37:29 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 24 Mar 2014 18:37:24 +0000
Message-Id: <77e6cc952e73dec4a6e5149e52f87000709d2152.1395686148.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <7e59b6b1cb44de00c512facece5ede96375a411f.1395686148.git.alexandru.damian@intel.com>
References: <7e59b6b1cb44de00c512facece5ede96375a411f.1395686148.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1395686148.git.alexandru.damian@intel.com>
References: <cover.1395686148.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 14/18] toaster: Remove circular dependecies from packages/recipes
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
X-List-Received-Date: Mon, 24 Mar 2014 18:37:37 -0000

From: Irina Patru <irina.patru@intel.com>

The RelatedManager for Package_Dependency and Recipe_Dependency is changed
so that circular dependacies are hidden in the UI, but will still remain in
the database.

[YOCTO #5655]

Signed-off-by: Irina Patru <irina.patru@intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/orm/models.py | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/lib/toaster/orm/models.py b/lib/toaster/orm/models.py
index bb018a9..3059908 100644
--- a/lib/toaster/orm/models.py
+++ b/lib/toaster/orm/models.py
@@ -20,6 +20,7 @@
 # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 from django.db import models
+from django.db.models import F
 from django.utils.encoding import python_2_unicode_compatible
 
 
@@ -211,6 +212,12 @@ class Package(models.Model):
     section = models.CharField(max_length=80, blank=True)
     license = models.CharField(max_length=80, blank=True)
 
+class Package_DependencyManager(models.Manager):
+    use_for_related_fields = True
+
+    def get_query_set(self):
+        return super(Package_DependencyManager, self).get_query_set().exclude(package_id = F('depends_on__id'))
+
 class Package_Dependency(models.Model):
     TYPE_RDEPENDS = 0
     TYPE_TRDEPENDS = 1
@@ -250,6 +257,7 @@ class Package_Dependency(models.Model):
     depends_on = models.ForeignKey(Package, related_name='package_dependencies_target')   # soft dependency
     dep_type = models.IntegerField(choices=DEPENDS_TYPE)
     target = models.ForeignKey(Target, null=True)
+    objects = Package_DependencyManager()
 
 class Target_Installed_Package(models.Model):
     target = models.ForeignKey(Target)
@@ -273,6 +281,11 @@ class Recipe(models.Model):
     bugtracker = models.URLField(blank=True)
     file_path = models.FilePathField(max_length=255)
 
+class Recipe_DependencyManager(models.Manager):
+    use_for_related_fields = True
+
+    def get_query_set(self):
+        return super(Recipe_DependencyManager, self).get_query_set().exclude(recipe_id = F('depends_on__id'))
 
 class Recipe_Dependency(models.Model):
     TYPE_DEPENDS = 0
@@ -285,6 +298,7 @@ class Recipe_Dependency(models.Model):
     recipe = models.ForeignKey(Recipe, related_name='r_dependencies_recipe')
     depends_on = models.ForeignKey(Recipe, related_name='r_dependencies_depends')
     dep_type = models.IntegerField(choices=DEPENDS_TYPE)
+    objects = Recipe_DependencyManager()
 
 class Layer(models.Model):
     name = models.CharField(max_length=100)
-- 
1.8.3.2


