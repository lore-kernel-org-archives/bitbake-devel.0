Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f44.google.com (mail-wg0-f44.google.com [74.125.82.44])
	by mail.openembedded.org (Postfix) with ESMTP id B881673B4F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2015 10:46:50 +0000 (UTC)
Received: by wghk14 with SMTP id k14so15364151wgh.7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2015 03:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=Q9VCtE4yntmafdeTwFuF5Ysadj7uvhyjuXH3rfv1LXQ=;
	b=JEHY5tJPO8w7KFW+n9gRM3KfNDDXbT5bVVtYCExAWPuwAXDxiEqP+Z/5rYIvm7iza8
	uJWLiOCry2jpyLChmD4ce9gpcz8l5Ec2XBlNBbDaNrHZFY6RudUf1ISX9mVkJNxfH6wZ
	fXuALk4N/51TkEicQXZplRafvDKT8LA0O5mIXVGN2ndDVqIAIEqAMbYb2tbA0xXVpnjt
	eZFack3yK4SWHxe+u18vC8IkWJCd4bRvirlQ5TTR62orjjfY6Obik14vcv1NnBMfJQri
	6xLXa+XAn4yUshRw/q602TL4WeXjhArYgGirGZWhQxKWVCVDphizsRvA0t6P9KR357vz
	hhog==
X-Gm-Message-State: ALoCoQl42Q0CLBmzvUFsFFrADUf2LU20Xs51Xvh+Af7IxWHH/iJ9lD90kdud82/WF8s7ns/7mYM2
X-Received: by 10.194.220.7 with SMTP id ps7mr87975584wjc.84.1426157211619;
	Thu, 12 Mar 2015 03:46:51 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id w3sm2983774wiz.5.2015.03.12.03.46.48
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 12 Mar 2015 03:46:50 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 660CC561B81; Thu, 12 Mar 2015 10:46:51 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 Mar 2015 10:46:37 +0000
Message-Id: <6cc55788bea490e7aaa39fb7150a251b4e23b467.1426156963.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <7f2019767b07ed0e1e4b831d2ec10f0708ef1f2f.1426156963.git.alexandru.damian@intel.com>
References: <7f2019767b07ed0e1e4b831d2ec10f0708ef1f2f.1426156963.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1426156963.git.alexandru.damian@intel.com>
References: <cover.1426156963.git.alexandru.damian@intel.com>
Subject: [PATCH 04/17] toastergui: improve data suggestion
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

We improve the data suggestions in the project page.

The machines suggestions now contain the layer name.

The targets and machine do not show the layer branch.

For targets, the layer name is searchable.
For machines, the description field is searchable.

[YOCTO #7153]
[YOCTO #7154]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/templates/project.html |  2 +-
 lib/toaster/toastergui/views.py               | 14 ++++++++------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index 06fc6a5..f4a3a75 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -355,7 +355,7 @@ vim: expandtab tabstop=2
               You cannot really compare the builds for the new machine with the previous ones.
         </div>
         <form ng-submit="editProjectSettings('#select-machine')" class="input-append">
-              <input type="text" id="machine" autocomplete="off" ng-model="machineName" typeahead="m.name for m in getAutocompleteSuggestions('machines', $viewValue)"/>
+              <input type="text" id="machine" autocomplete="off" ng-model="machineName" typeahead="m.name for m in getAutocompleteSuggestions('machines', $viewValue)" typeahead-template-url="suggestion_details" />
               <input type="submit" id="apply-change-machine" class="btn" type="button" ng-disabled="machineName == machine.name || machineName.length == 0" value="Save"></input>
               <input type="reset" id="cancel-machine" class="btn btn-link" ng-click="toggle('#select-machine')" value="Cancel"></input>
               {% csrf_token %}
diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 9f0bb99..9f1fbca 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -2353,7 +2353,8 @@ if toastermain.settings.MANAGED:
 
             # returns targets provided by current project layers
             if request.GET['type'] == "targets":
-                queryset_all = Recipe.objects.filter(name__icontains=request.GET.get('value',''))
+                search_token = request.GET.get('value','')
+                queryset_all = Recipe.objects.filter(Q(name__icontains=search_token) | Q(layer_version__layer__name__icontains=search_token) )
                 layer_equivalent_set = []
                 for i in prj.projectlayer_set.all():
                     layer_equivalent_set += i.layercommit.get_equivalents_wpriority(prj)
@@ -2361,11 +2362,11 @@ if toastermain.settings.MANAGED:
 
                 # if we have more than one hit here (for distinct name and version), max the id it out
                 queryset_all_maxids = queryset_all.values('name').distinct().annotate(max_id=Max('id')).values_list('max_id')
-                queryset_all = queryset_all.filter(id__in = queryset_all_maxids).order_by("name")
+                queryset_all = queryset_all.filter(id__in = queryset_all_maxids).order_by("name").select_related("layer_version__layer")
 
 
                 return HttpResponse(jsonfilter({ "error":"ok",
-                    "list" : map ( lambda x: {"id": x.pk, "name": x.name, "detail":"[" + x.layer_version.layer.name + (" | " + x.layer_version.up_branch.name + "]" if x.layer_version.up_branch is not None else "]")},
+                    "list" : map ( lambda x: {"id": x.pk, "name": x.name, "detail":"[" + x.layer_version.layer.name +"]"},
                         queryset_all[:8]),
 
                     }), content_type = "application/json")
@@ -2376,10 +2377,11 @@ if toastermain.settings.MANAGED:
                 if 'project_id' in request.session:
                     queryset_all = queryset_all.filter(layer_version__in =  prj.projectlayer_equivalent_set()).order_by("name")
 
-                return HttpResponse(jsonfilter({ "error":"ok",
-                    "list" : map ( lambda x: {"id": x.pk, "name": x.name, "detail":"[" + x.layer_version.layer.name+ (" | " + x.layer_version.up_branch.name + "]" if x.layer_version.up_branch is not None else "]")},
-                        queryset_all.filter(name__icontains=request.GET.get('value',''))[:8]),
+                search_token = request.GET.get('value','')
+                querysetall = queryset_all.filter(Q(name__icontains=search_token) | Q(description__icontains=search_token))
 
+                return HttpResponse(jsonfilter({ "error":"ok",
+                        "list" : map ( lambda x: {"id": x.pk, "name": x.name, "detail":"[" + x.layer_version.layer.name+ "]"}, queryset_all[:8])
                     }), content_type = "application/json")
 
             # returns all projects
-- 
1.9.1


