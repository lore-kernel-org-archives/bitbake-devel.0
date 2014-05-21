Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f180.google.com (unknown [209.85.212.180])
	by mail.openembedded.org (Postfix) with ESMTP id 1174A6AD11
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 May 2014 14:15:10 +0000 (UTC)
Received: by mail-wi0-f180.google.com with SMTP id hi2so2842103wib.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 May 2014 07:15:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=MoEA50anwsN3fXfTMVISIq8J4/b5g17QbaOBiA16Cgw=;
	b=nBb/swcI2l1WgoARtBMKIeuIkPhcjyd6JviKzon4yTUVk6y/7V3I7mFvfXJ+WCdbCm
	S7YgLWRqfk7/Utq6koV8Ow7fL6OHe9+Ax59SLoTSfP27BSzZSJ9mG4tGfo4GdzCc/cEu
	xMXf/Yf1q92YcfdTD/3sYvQXAOEHgH6reJAKUh4SyxJfBm0ssf7FN3q7uP+R4bq5XcnD
	U451i57aRrDDPWyU3Efe3lm6NlGO6nkGNywOArd12qx0OnU3z2IxKg3CP+DryGpsndhM
	i5oxT/A8wXn8FYf4WaqM26ve7Af8X+gPhWNF6nWEfhZXSgeu0EXS0wnPGobpFpVbjpQc
	EaiA==
X-Gm-Message-State: ALoCoQl5AVe25BS4BW7vSIrajBPdmXl9R+c4n4H9kfM9T7oNBTwJ7/cOLW93qTF9tmiNtLw1o/BF
X-Received: by 10.180.86.74 with SMTP id n10mr10557811wiz.55.1400681711545;
	Wed, 21 May 2014 07:15:11 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id c7sm22744119wjf.19.2014.05.21.07.15.09
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 21 May 2014 07:15:10 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 4EC825603E9; Wed, 21 May 2014 15:15:10 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 May 2014 15:15:09 +0100
Message-Id: <8aa469853e706a00d2dd629d48fea07645947233.1400681628.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <bee80157c3652f498ae1b98a90fb022356c6ff53.1400681628.git.alexandru.damian@intel.com>
References: <bee80157c3652f498ae1b98a90fb022356c6ff53.1400681628.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1400681628.git.alexandru.damian@intel.com>
References: <cover.1400681628.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>,
	David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 3/3] toaster: reduce redundant foreign key lookups
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
X-List-Received-Date: Wed, 21 May 2014 14:15:15 -0000

From: David Reyna <david.reyna@windriver.com>

Replace redundant foreign key lookups with "with" to improve all
recipes page load time. Do depends pre-lookup in the view class,
and use python itertation instead of filter() all to achieve x16
processing speedup.

[YOCTO #6137]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>

Conflicts:
	bitbake/lib/toaster/toastergui/views.py
---
 lib/toaster/toastergui/templates/recipes.html | 20 ++++++++++++++------
 lib/toaster/toastergui/views.py               | 15 +++++++++++++++
 2 files changed, 29 insertions(+), 6 deletions(-)
 mode change 100644 => 100755 lib/toaster/toastergui/views.py

diff --git a/lib/toaster/toastergui/templates/recipes.html b/lib/toaster/toastergui/templates/recipes.html
index 907b83d..791a487 100755
--- a/lib/toaster/toastergui/templates/recipes.html
+++ b/lib/toaster/toastergui/templates/recipes.html
@@ -45,31 +45,39 @@
         <td><a href="{% url "recipe" build.pk recipe.pk %}">{{recipe.version}}</a></td>
         <!-- Depends -->
         <td class="depends_on">
-            {% if recipe.r_dependencies_recipe.all.count %}
+            {% with deps=recipe_deps|get_dict_value:recipe.pk %}
+            {% with count=deps|length %}
+            {% if count %}
             <a class="btn"
                 title="<a href='{% url "recipe" build.pk recipe.pk %}#dependencies'>{{recipe.name}}</a> dependencies"
                 data-content="<ul class='unstyled'>
-                  {% for i in recipe.r_dependencies_recipe.all|dictsort:"depends_on.name"%}
+                  {% for i in deps|dictsort:"depends_on.name"%}
                     <li><a href='{% url "recipe" build.pk i.depends_on.pk %}'>{{i.depends_on.name}}</a></li>
                   {% endfor %}
                 </ul>">
-                {{recipe.r_dependencies_recipe.all.count}}
+                {{count}}
             </a>
             {% endif %}
+            {% endwith %}
+            {% endwith %}
         </td>
         <!--  Brought in by -->
         <td class="depends_by">
-            {% if recipe.r_dependencies_depends.all.count %}
+            {% with revs=recipe_revs|get_dict_value:recipe.pk %}
+            {% with count=revs|length %}
+            {% if count %}
             <a class="btn"
                 title="<a href='{% url "recipe" build.pk recipe.pk %}#brought-in-by'>{{recipe.name}}</a> reverse dependencies"
                 data-content="<ul class='unstyled'>
-                  {% for i in recipe.r_dependencies_depends.all|dictsort:"recipe.name"%}
+                  {% for i in revs|dictsort:"recipe.name" %}
                     <li><a href='{% url "recipe" build.pk i.recipe.pk %}'>{{i.recipe.name}}</a></li>
                   {% endfor %}
                 </ul>">
-                {{recipe.r_dependencies_depends.all.count}}
+                {{count}}
             </a>
             {% endif %}
+            {% endwith %}
+            {% endwith %}
         </td>
         <!-- Recipe file -->
         <td class="recipe_file">{{recipe.file_path}}</td>
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
old mode 100644
new mode 100755
index 4622810..686cd5c
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1074,11 +1074,26 @@ def recipes(request, build_id):
 
     recipes = _build_page_range(Paginator(queryset, request.GET.get('count', 100)),request.GET.get('page', 1))
 
+    # prefetch the forward and reverse recipe dependencies
+    deps = { }; revs = { }
+    queryset_dependency=Recipe_Dependency.objects.filter(recipe__layer_version__build_id = build_id)
+    for recipe in recipes:
+        deplist = [ ]
+        for recipe_dep in [x for x in queryset_dependency if x.recipe_id == recipe.id]:
+            deplist.append(recipe_dep)
+        deps[recipe.id] = deplist
+        revlist = [ ]
+        for recipe_dep in [x for x in queryset_dependency if x.depends_on_id == recipe.id]:
+            revlist.append(recipe_dep)
+        revs[recipe.id] = revlist
+
     context = {
         'objectname': 'recipes',
         'build': Build.objects.filter(pk=build_id)[0],
         'objects': recipes,
         'default_orderby' : 'name:+',
+        'recipe_deps' : deps,
+        'recipe_revs' : revs,
         'tablecols':[
             {
                 'name':'Recipe',
-- 
1.9.1


