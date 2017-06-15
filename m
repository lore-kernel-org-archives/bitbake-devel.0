Return-Path: <david.reyna@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id B537578372
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Jun 2017 04:53:59 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id v5F4s0BC004164
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Jun 2017 21:54:00 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.200.76) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.294.0; Wed, 14 Jun 2017 21:54:00 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 14 Jun 2017 21:45:15 -0700
Message-ID: <3971df4e49c2e900a1a875823fcf9fb1cf5e1b7e.1497501754.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1497501754.git.David.Reyna@windriver.com>
References: <cover.1497501754.git.David.Reyna@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [147.11.200.76]
Subject: [PATCH 1/1] toaster: add ID's to build menu links
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
X-List-Received-Date: Thu, 15 Jun 2017 04:53:59 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

Add IDs to the build page menu lines, for example "Tasks", "Recipes",
"Time", "CPU Time", "Disk I/O", and so forth. This will support test
automation.

[YOCTO #11337]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/toastergui/templates/basebuildpage.html | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/lib/toaster/toastergui/templates/basebuildpage.html b/lib/toaster/toastergui/templates/basebuildpage.html
index f5eee96..a41911f 100644
--- a/lib/toaster/toastergui/templates/basebuildpage.html
+++ b/lib/toaster/toastergui/templates/basebuildpage.html
@@ -132,16 +132,16 @@
           {% endif %}
           <li class="nav-header">Build</li>
             <li id="menu-configuration"><a href="{% url 'configuration' build.pk %}">Configuration</a></li>
-            <li><a href="{% url 'tasks' build.pk %}">Tasks</a></li>
-            <li><a href="{% url 'recipes' build.pk %}">Recipes</a></li>
-            <li><a href="{% url 'packages' build.pk %}">Packages</a></li>
+            <li id="menu-tasks"><a href="{% url 'tasks' build.pk %}">Tasks</a></li>
+            <li id="menu-recipes"><a href="{% url 'recipes' build.pk %}">Recipes</a></li>
+            <li id="menu-packages"><a href="{% url 'packages' build.pk %}">Packages</a></li>
             <li class="nav-header">Performance</li>
-            <li><a href="{% url 'buildtime' build.pk %}">Time</a></li>
-            <li><a href="{% url 'cputime' build.pk %}">CPU usage</a></li>
-            <li><a href="{% url 'diskio' build.pk %}">Disk I/O</a></li>
+            <li id="menu-time"><a href="{% url 'buildtime' build.pk %}">Time</a></li>
+            <li id="menu-cpu-time"><a href="{% url 'cputime' build.pk %}">CPU usage</a></li>
+            <li id="menu-disk-io"><a href="{% url 'diskio' build.pk %}">Disk I/O</a></li>
 
           <li class="nav-header">Actions</li>
-          <li>
+          <li id="menu-download-build-log">
             <a href="{% url 'build_artifact' build.id 'cookerlog' build.id %}">
               <span class="glyphicon glyphicon-download-alt"></span>
             Download build log
@@ -151,7 +151,7 @@
           {% with build.get_custom_image_recipes as custom_image_recipes %}
             {% if custom_image_recipes.count > 0 %}
               <!-- edit custom image built during this build -->
-              <li>
+              <li id="menu-edit-custom-image">
                 <a href="#" data-role="edit-custom-image-trigger">
                   <span class="glyphicon glyphicon-edit"></span>
                   Edit custom image
@@ -186,7 +186,7 @@
 
             <!-- new custom image from image recipe in this build -->
             {% if build.has_image_recipes %}
-            <li>
+            <li id="menu-new-custom-image">
               <a href="#"  data-role="new-custom-image-trigger">
                 <span class="glyphicon glyphicon-plus"></span>
                 New custom image
@@ -216,7 +216,7 @@
               </script>
             {% endif %}
 
-            <li>
+            <li  id="menu-delete-build">
             <a href="#delete-build-modal" id="delete-build" data-toggle="modal" data-target="#delete-build-modal" class="text-danger">
               <span class="glyphicon glyphicon-trash"></span>
               Delete build
-- 
1.9.1


