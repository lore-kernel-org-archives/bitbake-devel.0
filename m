Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f44.google.com (mail-wg0-f44.google.com [74.125.82.44])
	by mail.openembedded.org (Postfix) with ESMTP id 65E62737E1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 May 2015 10:59:46 +0000 (UTC)
Received: by wgin8 with SMTP id n8so124394967wgi.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 May 2015 03:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=y4xDOa828YZBnJ0H/COJN3qzNwdimDL9ImyoOUiOPZc=;
	b=EZ/s1/RtLTaZ9KRELiY75kYldHoQjHMapxAaFEAE0kNeMoYDrEY6c+86vqRNPJ1gMO
	IuA8mdZTiTohiJ1nZ997IoXt9lQAv5Mq/+/pjs4ucG8dFatEtUOFRlicqNhdAFBEwhrs
	Qe6L+DZNipzHcPvPbJwgKSNzx/EkHmzoheGWcpoqNHiBCfn7FPZeFNllWC7RlnWzFVCc
	BZIHIwdwx0jPnlk/qCXJLwYQKd6wMPz6TrusZ6w5BlDuig4UUTwAJvRp4n/MfrSuWJG+
	OpWrm5bLNS0Y9ThgtLY7QCOraZt1G8gC4/MvHR3ZKx5PxOfAAUr9u739/r4aOrmjrNSV
	6xSg==
X-Gm-Message-State: ALoCoQmmC429Gf5z8pn1xigldxMdj+VFrNhEg5TDA7krbfaX7CEXWediZoat2WHmckNGz1DkHreD
X-Received: by 10.180.87.101 with SMTP id w5mr18312268wiz.18.1431341988060;
	Mon, 11 May 2015 03:59:48 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id l6sm22276990wjz.4.2015.05.11.03.59.47
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 11 May 2015 03:59:47 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id EBB79560414; Mon, 11 May 2015 11:58:42 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 11 May 2015 11:58:37 +0100
Message-Id: <db88d114b80e4cfe2ba690c437cf0b71ac1c3867.1431338029.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <7ffd7ba923c85a735e0dad528f1ab9d50073724b.1431338029.git.alexandru.damian@intel.com>
References: <7ffd7ba923c85a735e0dad528f1ab9d50073724b.1431338029.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1431338029.git.alexandru.damian@intel.com>
References: <cover.1431338029.git.alexandru.damian@intel.com>
Cc: Mihail Stanciu <stanciux.mihail@intel.com>
Subject: [PATCH 06/11] toaster: <Add class id to a few columns>
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
X-List-Received-Date: Mon, 11 May 2015 10:59:47 -0000

From: Mihail Stanciu <stanciux.mihail@intel.com>

Added class ids to columns that were missing them in the Packages and Recipes pages. This is required for Toaster UI automation efforts.

[YOCTO #7377]
---
 lib/toaster/toastergui/templates/bpackage.html | 4 ++--
 lib/toaster/toastergui/templates/recipes.html  | 8 ++++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/toastergui/templates/bpackage.html b/lib/toaster/toastergui/templates/bpackage.html
index 80229f9..6fbdc7b 100644
--- a/lib/toaster/toastergui/templates/bpackage.html
+++ b/lib/toaster/toastergui/templates/bpackage.html
@@ -60,9 +60,9 @@
     <tr class="data">
 
         <!-- Package -->
-        <td><a href="{% url "package_built_detail" build.pk package.pk %}">{{package.name}}</a></td>
+        <td class="package_name"><a href="{% url "package_built_detail" build.pk package.pk %}">{{package.name}}</a></td>
         <!-- Package Version -->
-        <td>{%if package.version%}<a href="{% url "package_built_detail" build.pk package.pk %}">{{package.version}}-{{package.revision}}</a>{%endif%}</td>
+        <td class="package_version">{%if package.version%}<a href="{% url "package_built_detail" build.pk package.pk %}">{{package.version}}-{{package.revision}}</a>{%endif%}</td>
         <!-- Package Size -->
         <td class="size sizecol">{{package.size|filtered_filesizeformat}}</td>
         <!-- License -->
diff --git a/lib/toaster/toastergui/templates/recipes.html b/lib/toaster/toastergui/templates/recipes.html
index 458d724..dc2d9e8 100644
--- a/lib/toaster/toastergui/templates/recipes.html
+++ b/lib/toaster/toastergui/templates/recipes.html
@@ -41,8 +41,12 @@
     {% for recipe in objects %}
 
     <tr class="data">
-        <td><a href="{% url "recipe" build.pk recipe.pk %}">{{recipe.name}}</a></td>
-        <td><a href="{% url "recipe" build.pk recipe.pk %}">{{recipe.version}}</a></td>
+        <td class="recipe__name">
+            <a href="{% url "recipe" build.pk recipe.pk %}">{{recipe.name}}</a>
+        </td>
+        <td class="recipe__version">
+            <a href="{% url "recipe" build.pk recipe.pk %}">{{recipe.version}}</a>
+        </td>
         <!-- Depends -->
         <td class="depends_on">
             {% with deps=recipe_deps|get_dict_value:recipe.pk %}
-- 
1.9.1


