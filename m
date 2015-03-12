Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f44.google.com (mail-wg0-f44.google.com [74.125.82.44])
	by mail.openembedded.org (Postfix) with ESMTP id 47DE973B5B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2015 10:46:53 +0000 (UTC)
Received: by wghk14 with SMTP id k14so15364418wgh.7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2015 03:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=wzAKsUgHQ9Ql8CPS4t1Weh/fr6HhuKM/jQQwoTBMu9U=;
	b=bDmCftZxAY6IkBOZRcFX2bYcmVStEucmSF5qwLQnuXE6gRjn1j7IdKUNj8XodBEVEz
	LNU4wb8b2/3AX+v9iRkAQZffw6gk7x2+kpbewk+49OBCP/U1HsaP+hT1jtGwDglyjRBF
	x7AW/l9JVoPGLrzpZLajaXpSLfBnEyqL4BPeHoi6h1HBU1W7+DnJQPy5PJxGx19V45PL
	7X7rbjddIIlHDvvCrJtfvlnQmdAWTwsK5Dr1gOVgAgy+nn/tKh10BJLib+TvsfRHpbR7
	6TGPFVSAfoGAsAYb3HxR1vrhFi7a00xXyjVWpSKSEnw6GiGHO2D6Ts6KY+iJAbenk4Ow
	ZVyQ==
X-Gm-Message-State: ALoCoQksfUvkLY2EUvzacovnf/+XWWmLVhr/pg+rcJn7hkAuiBqMYmuCkTb2Tm8cm4KCLeho3Yol
X-Received: by 10.180.208.107 with SMTP id md11mr44454779wic.10.1426157214433; 
	Thu, 12 Mar 2015 03:46:54 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id u16sm9458637wjr.5.2015.03.12.03.46.51
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 12 Mar 2015 03:46:51 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 719C15621D1; Thu, 12 Mar 2015 10:46:51 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 Mar 2015 10:46:44 +0000
Message-Id: <409600a7e2291c4b98ed09fd47164551666d05c9.1426156963.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <7f2019767b07ed0e1e4b831d2ec10f0708ef1f2f.1426156963.git.alexandru.damian@intel.com>
References: <7f2019767b07ed0e1e4b831d2ec10f0708ef1f2f.1426156963.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1426156963.git.alexandru.damian@intel.com>
References: <cover.1426156963.git.alexandru.damian@intel.com>
Subject: [PATCH 11/17] toastergui: improve toaster suggestion
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
X-List-Received-Date: Thu, 12 Mar 2015 10:46:53 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Improving the suggestions by ordering entries
based on position of the search string.

Speed improvements in suggestion calls.

[YOCTO #7152]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/views.py | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 541b16a..807bf9b 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2259,7 +2259,7 @@ if toastermain.settings.MANAGED:
             # return all project settings
             return HttpResponse(jsonfilter( {
                 "error": "ok",
-                "layers" :  map(lambda x: {"id": x.layercommit.pk, "orderid" : x.pk, "name" : x.layercommit.layer.name, "giturl" : x.layercommit.layer.vcs_url, "url": x.layercommit.layer.layer_index_url, "layerdetailurl": reverse("layerdetails", args=(x.layercommit.layer.pk,)), "branch" : { "name" : x.layercommit.get_vcs_reference(), "layersource" : x.layercommit.up_branch.layer_source.name}}, prj.projectlayer_set.all().select_related("layer").order_by("id")),
+                "layers" :  map(lambda x: {"id": x.layercommit.pk, "orderid" : x.pk, "name" : x.layercommit.layer.name, "giturl" : x.layercommit.layer.vcs_url, "url": x.layercommit.layer.layer_index_url, "layerdetailurl": reverse("layerdetails", args=(x.layercommit.pk,)), "branch" : { "name" : x.layercommit.get_vcs_reference(), "layersource" : x.layercommit.up_branch.layer_source.name}}, prj.projectlayer_set.all().select_related("layer").order_by("id")),
                 "builds" : _project_recent_build_list(prj),
                 "variables": map(lambda x: (x.name, x.value), prj.projectvariable_set.all()),
                 "machine": {"name": prj.projectvariable_set.get(name="MACHINE").value},
@@ -2356,11 +2356,13 @@ if toastermain.settings.MANAGED:
             # returns targets provided by current project layers
             if request.GET['type'] == "targets":
                 search_token = request.GET.get('value','')
-                queryset_all = Recipe.objects.filter(Q(name__icontains=search_token) | Q(layer_version__layer__name__icontains=search_token) )
-                layer_equivalent_set = []
-                for i in prj.projectlayer_set.all():
-                    layer_equivalent_set += i.layercommit.get_equivalents_wpriority(prj)
-                queryset_all = queryset_all.filter(layer_version__in =  layer_equivalent_set)
+                queryset_all = Recipe.objects.filter(layer_version__layer__name__in = [x.layercommit.layer.name for x in prj.projectlayer_set.all().select_related("layercommit__layer")]).filter(Q(name__icontains=search_token) | Q(layer_version__layer__name__icontains=search_token))
+
+#                layer_equivalent_set = []
+#                for i in prj.projectlayer_set.all().select_related("layercommit__up_branch", "layercommit__layer"):
+#                    layer_equivalent_set += i.layercommit.get_equivalents_wpriority(prj)
+
+#                queryset_all = queryset_all.filter(layer_version__in =  layer_equivalent_set)
 
                 # if we have more than one hit here (for distinct name and version), max the id it out
                 queryset_all_maxids = queryset_all.values('name').distinct().annotate(max_id=Max('id')).values_list('max_id')
@@ -2368,8 +2370,13 @@ if toastermain.settings.MANAGED:
 
 
                 return HttpResponse(jsonfilter({ "error":"ok",
-                    "list" : map ( lambda x: {"id": x.pk, "name": x.name, "detail":"[" + x.layer_version.layer.name +"]"},
+                    "list" :
+                        # 7152 - sort by token position
+                        sorted (
+                            map ( lambda x: {"id": x.pk, "name": x.name, "detail":"[" + x.layer_version.layer.name +"]"},
                         queryset_all[:8]),
+                            key = lambda i: i["name"].find(search_token) if i["name"].find(search_token) > -1 else 9999,
+                        )
 
                     }), content_type = "application/json")
 
@@ -2383,7 +2390,12 @@ if toastermain.settings.MANAGED:
                 queryset_all = queryset_all.filter(Q(name__icontains=search_token) | Q(description__icontains=search_token))
 
                 return HttpResponse(jsonfilter({ "error":"ok",
-                        "list" : map ( lambda x: {"id": x.pk, "name": x.name, "detail":"[" + x.layer_version.layer.name+ "]"}, queryset_all[:8])
+                        "list" :
+                        # 7152 - sort by the token position
+                        sorted (
+                            map ( lambda x: {"id": x.pk, "name": x.name, "detail":"[" + x.layer_version.layer.name+ "]"}, queryset_all[:8]),
+                            key = lambda i: i["name"].find(search_token) if i["name"].find(search_token) > -1 else 9999,
+                        )
                     }), content_type = "application/json")
 
             # returns all projects
-- 
1.9.1


