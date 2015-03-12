Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com
	[209.85.212.177])
	by mail.openembedded.org (Postfix) with ESMTP id B468C73B41
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2015 10:46:48 +0000 (UTC)
Received: by wivr20 with SMTP id r20so19145378wiv.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2015 03:46:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=k1rfdfwBOe/hscz9JMajyWP+m4rgFXIwxW2FMm27UTw=;
	b=FF9WrhSKEB7Gu6AT3/xxlmr+FuZhS3D4hg+fI3sWQklu2nKg7OAveA0AQQ+5Yc0lcx
	sr5fd6ApofBx91zeIXXLoS5VJJk3hTqQLwpXYxGOZlWi3cEeQRxA06JkrjhdPmKCzVDX
	tJxgIYaLYlLSASC1LvnpVwbJRHquLOU3kw1N3bdhNrXfxKt9rB8RN8AcFjVE+zHm4Nnk
	dqjZAqTvvIm7Y3J/UbEAFI8PIqjD+BkRRcCXPsGYtrDHJbaL6LiRcjWPu8U/9PYKZrek
	C/AMwNWvYxxTk4Hmb7vUmGQRWL/ITLMS4eO2KgxX+XTNeZ+TpoWKrAyjBBKu7SqQjfQt
	BUOA==
X-Gm-Message-State: ALoCoQm88T+MC8/x5784gzEsVwX2bqTzjn6Erophewv2wAFNoA7zHXx3te8Kfx6YKOHlU+UuQMpl
X-Received: by 10.194.47.201 with SMTP id f9mr84331264wjn.17.1426157209216;
	Thu, 12 Mar 2015 03:46:49 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id n3sm9407300wja.36.2015.03.12.03.46.48
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 12 Mar 2015 03:46:48 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 64AD7561B1F; Thu, 12 Mar 2015 10:46:51 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 Mar 2015 10:46:36 +0000
Message-Id: <0b13fa709beb4d6f042682d8368860a3274f507c.1426156963.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <7f2019767b07ed0e1e4b831d2ec10f0708ef1f2f.1426156963.git.alexandru.damian@intel.com>
References: <7f2019767b07ed0e1e4b831d2ec10f0708ef1f2f.1426156963.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1426156963.git.alexandru.damian@intel.com>
References: <cover.1426156963.git.alexandru.damian@intel.com>
Subject: [PATCH 03/17] toastergui: fix project page layer branch names
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
X-List-Received-Date: Thu, 12 Mar 2015 10:46:48 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Change inconsistent branch name usage in project page to
the uniquely defined get_vcs_reference()

[YOCTO #7381]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/templates/project.html | 2 +-
 lib/toaster/toastergui/views.py               | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index 039601f..06fc6a5 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -271,7 +271,7 @@ vim: expandtab tabstop=2
     <div id="layer-container" class="well well-transparent span4">
       <h3>
         Layers <span class="muted counter">({[layers.length]})</span>
-        <i class="icon-question-sign get-help heading-help" title="OpenEmbedded organises metadata into modules called 'layers'. Layers allow you to isolate different types of customizations from each other. <a href='http://www.yoctoproject.org/docs/current/dev-manual/dev-manual.html#understanding-and-creating-layers' target='_blank'>More on layers</a>"></i>
+        <i class="icon-question-sign get-help heading-help" title="Bitbake reads metadata files from modules called 'layers'. Layers allow you to isolate different types of customizations from each other. <a href='http://www.yoctoproject.org/docs/current/dev-manual/dev-manual.html#understanding-and-creating-layers' target='_blank'>More on layers</a>"></i>
       </h3>
       <div class="alert" ng-if="!layers.length">
         <b>You need to add some layers </b>
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index a07f720..9f0bb99 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2135,7 +2135,7 @@ if toastermain.settings.MANAGED:
                         "url": x.layercommit.layer.layer_index_url,
                         "layerdetailurl": reverse("layerdetails", args=(x.layercommit.pk,)),
                 # This branch name is actually the release
-                        "branch" : { "name" : x.layercommit.commit, "layersource" : x.layercommit.up_branch.layer_source.name if x.layercommit.up_branch != None else None}},
+                        "branch" : { "name" : x.layercommit.get_vcs_reference(), "layersource" : x.layercommit.up_branch.layer_source.name if x.layercommit.up_branch != None else None}},
                     prj.projectlayer_set.all().order_by("id")),
             "targets" : map(lambda x: {"target" : x.target, "task" : x.task, "pk": x.pk}, prj.projecttarget_set.all()),
             "freqtargets": freqtargets,
@@ -2257,7 +2257,7 @@ if toastermain.settings.MANAGED:
             # return all project settings
             return HttpResponse(jsonfilter( {
                 "error": "ok",
-                "layers" :  map(lambda x: {"id": x.layercommit.pk, "orderid" : x.pk, "name" : x.layercommit.layer.name, "giturl" : x.layercommit.layer.vcs_url, "url": x.layercommit.layer.layer_index_url, "layerdetailurl": reverse("layerdetails", args=(x.layercommit.layer.pk,)), "branch" : { "name" : x.layercommit.up_branch.name, "layersource" : x.layercommit.up_branch.layer_source.name}}, prj.projectlayer_set.all().select_related("layer").order_by("id")),
+                "layers" :  map(lambda x: {"id": x.layercommit.pk, "orderid" : x.pk, "name" : x.layercommit.layer.name, "giturl" : x.layercommit.layer.vcs_url, "url": x.layercommit.layer.layer_index_url, "layerdetailurl": reverse("layerdetails", args=(x.layercommit.layer.pk,)), "branch" : { "name" : x.layercommit.get_vcs_reference(), "layersource" : x.layercommit.up_branch.layer_source.name}}, prj.projectlayer_set.all().select_related("layer").order_by("id")),
                 "builds" : _project_recent_build_list(prj),
                 "variables": map(lambda x: (x.name, x.value), prj.projectvariable_set.all()),
                 "machine": {"name": prj.projectvariable_set.get(name="MACHINE").value},
-- 
1.9.1


