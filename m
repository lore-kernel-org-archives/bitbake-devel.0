Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f47.google.com (mail-wg0-f47.google.com [74.125.82.47])
	by mail.openembedded.org (Postfix) with ESMTP id 0E48873B41
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2015 10:46:49 +0000 (UTC)
Received: by wghl18 with SMTP id l18so15370548wgh.5
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2015 03:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=UAZQ54WESSFIZCQ/ToAUrqdIbdBbQB6Fw2Yy+9VvrZY=;
	b=XhhbI1NXO0eTcMaSzagm0RAZyr3QkiPgx+DqNY+VBuQKjg8d5JVuGdUguQmI3cpiP4
	UCvsCUNl8N+Dqr9ihhKBs0980H8/7R5FYhYlzWayAFDkwzWNlgFRWrAFh4OPH6w71tdJ
	HbV1SJNXMC8MSyyT5hj4cpRcQkQzDdpkBfs0Adl9mjVEVjJr/YWrd/fikpyml8fEcX+i
	hYyIA9FQsOlyEDxfnvfAG+hQbhOg9UPP/lDrTAFMZW6BzH6IxqHH/X6/iwbTBmX3ry2v
	hOjz0D6N2CcH7rMU2FKnlEBHggGqSKKNvdsdVmqmBXD6sxnPS9s/I0c3cw8+gp3iqOyw
	AFww==
X-Gm-Message-State: ALoCoQl7ZGFj/rIqnGjpmuGsoP7iQDihv9CxA7rjSKYdh+GQEMq6bD7cfXS8820+hkXn3n8Fw7xm
X-Received: by 10.180.80.199 with SMTP id t7mr12526235wix.52.1426157210626;
	Thu, 12 Mar 2015 03:46:50 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	dm6sm10081056wib.22.2015.03.12.03.46.48
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 12 Mar 2015 03:46:49 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 61D8C561ABE; Thu, 12 Mar 2015 10:46:51 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 Mar 2015 10:46:35 +0000
Message-Id: <b0ff86713fc82806b857b22febff77a3701692d5.1426156963.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <7f2019767b07ed0e1e4b831d2ec10f0708ef1f2f.1426156963.git.alexandru.damian@intel.com>
References: <7f2019767b07ed0e1e4b831d2ec10f0708ef1f2f.1426156963.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1426156963.git.alexandru.damian@intel.com>
References: <cover.1426156963.git.alexandru.damian@intel.com>
Subject: [PATCH 02/17] toastergui: suggestion in alphabetical order
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
X-List-Received-Date: Thu, 12 Mar 2015 10:46:50 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Patch bringing ordering in alphabetical order for
targets, machines and layers suggestion in typeaheads.

[YOCTO #7152]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/views.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 1e9df3f..a07f720 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2304,7 +2304,7 @@ if toastermain.settings.MANAGED:
                 # and show only the selected layers for this project
                 final_list = set([x.get_equivalents_wpriority(prj)[0] for x in queryset_all])
 
-                return HttpResponse(jsonfilter( { "error":"ok",  "list" : map( _lv_to_dict, final_list) }), content_type = "application/json")
+                return HttpResponse(jsonfilter( { "error":"ok",  "list" : map( _lv_to_dict, sorted(final_list, key = lambda x: x.layer.name)) }), content_type = "application/json")
 
 
             # returns layer dependencies for a layer, excluding current project layers
@@ -2314,7 +2314,7 @@ if toastermain.settings.MANAGED:
 
                 final_list = set([x.get_equivalents_wpriority(prj)[0] for x in queryset])
 
-                return HttpResponse(jsonfilter( { "error":"ok", "list" : map( _lv_to_dict, final_list) }), content_type = "application/json")
+                return HttpResponse(jsonfilter( { "error":"ok", "list" : map( _lv_to_dict, sorted(final_list, key = lambda x: x.layer.name)) }), content_type = "application/json")
 
 
 
@@ -2361,7 +2361,7 @@ if toastermain.settings.MANAGED:
 
                 # if we have more than one hit here (for distinct name and version), max the id it out
                 queryset_all_maxids = queryset_all.values('name').distinct().annotate(max_id=Max('id')).values_list('max_id')
-                queryset_all = queryset_all.filter(id__in = queryset_all_maxids)
+                queryset_all = queryset_all.filter(id__in = queryset_all_maxids).order_by("name")
 
 
                 return HttpResponse(jsonfilter({ "error":"ok",
@@ -2374,7 +2374,7 @@ if toastermain.settings.MANAGED:
             if request.GET['type'] == "machines":
                 queryset_all = Machine.objects.all()
                 if 'project_id' in request.session:
-                    queryset_all = queryset_all.filter(layer_version__in =  prj.projectlayer_equivalent_set())
+                    queryset_all = queryset_all.filter(layer_version__in =  prj.projectlayer_equivalent_set()).order_by("name")
 
                 return HttpResponse(jsonfilter({ "error":"ok",
                     "list" : map ( lambda x: {"id": x.pk, "name": x.name, "detail":"[" + x.layer_version.layer.name+ (" | " + x.layer_version.up_branch.name + "]" if x.layer_version.up_branch is not None else "]")},
-- 
1.9.1


