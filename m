Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by mail.openembedded.org (Postfix) with ESMTP id 8D05E6B72B
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Apr 2014 14:10:57 +0000 (UTC)
Received: by mail-wi0-f179.google.com with SMTP id z2so1338935wiv.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 04 Apr 2014 07:10:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=LRqaA7glBrn0xr8h1eX3on16FzbJeB2TUfnS+LbjhEE=;
	b=KLdGfhZ36e0Z6HXUzqQd1KTdS9v/WPp/NVYFxDPlzYN61sEYJilQEF9oFtFKnSKzcq
	OdxXGp4ovNaF2L761YF9ZXBfKc7bqGBoZhkU0PloTg5G4U8JduFgZ6olZsJt0NEQS7UD
	l95cYmh/C/+eYLRQ2yd6aGYePVXpyWU7TJTi/5zbRsObEGNPbd/xcXBKrdxq1AErk9Nj
	G1q5cm16FFdi15qRQgpCJRvAwu2XJ6FyEvN3Kvd8R2yB1fGAvebf4EbY2e+0/P1ciCnT
	dmK63mwfWFQo7dtPZA+1ULhpsfmqNMCk1ur4vyIOLacAac0E77jZfcv5e5nsPIPgjisj
	RMGg==
X-Gm-Message-State: ALoCoQmVHrnm0Hp6RoGtDjd4VY/F8uMSBvlgEQvwWZJc1XcspQfqRaetMYhAQBtZZbwls5WBtldV
X-Received: by 10.180.101.166 with SMTP id fh6mr5005454wib.2.1396620658762;
	Fri, 04 Apr 2014 07:10:58 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id w10sm4911108wiy.9.2014.04.04.07.10.54
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 04 Apr 2014 07:10:57 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 8228956032B; Fri,  4 Apr 2014 15:10:54 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  4 Apr 2014 15:10:41 +0100
Message-Id: <29ff11635f0ed27dcd7ea33521825e80a2e1ff67.1396620556.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <c0b41b6763e049cd67b1b8038d85c49482557773.1396620556.git.alexandru.damian@intel.com>
References: <c0b41b6763e049cd67b1b8038d85c49482557773.1396620556.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1396620556.git.alexandru.damian@intel.com>
References: <cover.1396620556.git.alexandru.damian@intel.com>
Subject: [PATCH 02/14] toaster: Update API
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
X-List-Received-Date: Fri, 04 Apr 2014 14:10:58 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

Make sure the REST API includes the latest changes
to the database schema.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/bldviewer/api.py   | 3 ++-
 lib/toaster/bldviewer/views.py | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/bldviewer/api.py b/lib/toaster/bldviewer/api.py
index 76d45c7..c4c6135 100644
--- a/lib/toaster/bldviewer/api.py
+++ b/lib/toaster/bldviewer/api.py
@@ -25,12 +25,13 @@ from django.conf.urls import patterns, include, url
 urlpatterns = patterns('bldviewer.views',
         url(r'^builds$', 'model_explorer',  {'model_name':'build'}, name='builds'),
         url(r'^targets$', 'model_explorer',  {'model_name':'target'}, name='targets'),
+        url(r'^target_files$', 'model_explorer',  {'model_name':'target_file'}, name='target_file'),
         url(r'^target_image_file$', 'model_explorer',  {'model_name':'target_image_file'}, name='target_image_file'),
         url(r'^tasks$', 'model_explorer', {'model_name':'task'}, name='task'),
         url(r'^task_dependencies$', 'model_explorer',  {'model_name':'task_dependency'}, name='task_dependencies'),
         url(r'^packages$', 'model_explorer',  {'model_name':'package'}, name='package'),
         url(r'^package_dependencies$', 'model_explorer',  {'model_name':'package_dependency'}, name='package_dependency'),
-        url(r'^target_packages$', 'model_explorer',  {'model_name':'target_package'}, name='target_packages'),
+        url(r'^target_packages$', 'model_explorer',  {'model_name':'target_installed_package'}, name='target_packages'),
         url(r'^target_installed_packages$', 'model_explorer',  {'model_name':'target_installed_package'}, name='target_installed_package'),
         url(r'^package_files$', 'model_explorer',  {'model_name':'build_file'}, name='build_file'),
         url(r'^layers$', 'model_explorer', {'model_name':'layer'}, name='layer'),
diff --git a/lib/toaster/bldviewer/views.py b/lib/toaster/bldviewer/views.py
index 6f86379..c2e0c0c 100644
--- a/lib/toaster/bldviewer/views.py
+++ b/lib/toaster/bldviewer/views.py
@@ -25,7 +25,7 @@ from django.db.models import Q
 from django.shortcuts import render
 from orm.models import Build, Target, Task, Layer, Layer_Version, Recipe, LogMessage, Variable, Target_Installed_Package
 from orm.models import Task_Dependency, Recipe_Dependency, Package, Package_File, Package_Dependency
-from orm.models import Target_Installed_Package, VariableHistory, Target_Image_File
+from orm.models import Target_Installed_Package, VariableHistory, Target_Image_File, Target_File
 from django.views.decorators.cache import cache_control
 from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
 
@@ -159,6 +159,7 @@ def model_explorer(request, model_name):
     model_mapping = {
         'build': Build,
         'target': Target,
+        'target_file': Target_File,
         'target_image_file': Target_Image_File,
         'task': Task,
         'task_dependency': Task_Dependency,
-- 
1.9.1


