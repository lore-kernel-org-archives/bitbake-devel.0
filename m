Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f171.google.com (mail-we0-f171.google.com
	[74.125.82.171])
	by mail.openembedded.org (Postfix) with ESMTP id A69B2714A0
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  4 Sep 2014 16:45:20 +0000 (UTC)
Received: by mail-we0-f171.google.com with SMTP id u56so10583948wes.16
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 04 Sep 2014 09:45:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=GuRXgMwb+GY35mBN+jNCUXQWweRtyqN9Na1Jt0QQm6k=;
	b=l6RSMWSodDEjX1uEpnp9WqRbqz1QM4o8r8DpYPydp9efxSlstBMdd0R256Boqx9RrJ
	91e0yMZK5taORbNZNHY3gaUNK1/S8BSwbqAucbxWCLdiP2xCnL7j54VyuqDzjzv1MkmI
	OYaeqe8WRVZAHrITB/qr/T+zWvb8XWSIghp0JDtGbrCMNZFcOQBKGLcz4TjUlfS+GN7/
	5f5Pj5tgwrxXFKVE1ZfDYuaVJn7fTemfqbXP1WoMCC8jd5ZtCdyAwKBddS8vGWDux5c8
	vrE+HaZiJuNrfiZkBc2i2Vwc+FNy+GBCTgvsen8u4z77QxzrN2TgZ/t/fYB4PHGmtYow
	TpqQ==
X-Gm-Message-State: ALoCoQmXJr5eiaDl0bHN70Mj5Dh3xH3jKDXrIByWiaMJ0FrOD0Rrro6SI2yI5ck7lIOrQi0WIhxk
X-Received: by 10.194.19.200 with SMTP id h8mr7444136wje.40.1409849120564;
	Thu, 04 Sep 2014 09:45:20 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	au4sm20002911wjc.15.2014.09.04.09.45.18 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 04 Sep 2014 09:45:19 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 61A605624B8; Thu,  4 Sep 2014 17:45:19 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: toaster@yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Date: Thu,  4 Sep 2014 17:45:15 +0100
Message-Id: <39d0f0c2e87d4b161f1eeaa2657e61b5a6bc9ee2.1409848901.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <a37f2c194d7e59611177cb8755524b7ad702fe91.1409848901.git.alexandru.damian@intel.com>
References: <a37f2c194d7e59611177cb8755524b7ad702fe91.1409848901.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1409848901.git.alexandru.damian@intel.com>
References: <cover.1409848901.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 4/6] toaster: do not save objects in session
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
X-List-Received-Date: Thu, 04 Sep 2014 16:45:21 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

In order to avoid problems when using JSON serializer for
saving sessions, we move from storing the objects themselves
in the session to storing the object id and reloading the
object when retrieved.

This allows, for example, to use cookie-storage sessions if the
infrastructure owner so desires.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/views.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 13788b0..22b26d0 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1774,8 +1774,8 @@ if toastermain.settings.MANAGED:
             "projects": Project.objects.all(),
             "MANAGED" : toastermain.settings.MANAGED
         }
-        if 'project' in request.session:
-            ret['project'] = request.session['project']
+        if 'project_id' in request.session:
+            ret['project'] = Project.objects.get(pk = request.session['project_id'])
         return ret
 
     # new project
@@ -1841,7 +1841,7 @@ if toastermain.settings.MANAGED:
             puser = None
 
         # we use implicit knowledge of the current user's project to filter layer information, e.g.
-        request.session['project'] = prj
+        request.session['project_id'] = prj.id
 
         context = {
             "project" : prj,
@@ -1937,8 +1937,8 @@ if toastermain.settings.MANAGED:
         (filter_string, search_term, ordering_string) = _search_tuple(request, Layer_Version)
 
         queryset_all = Layer_Version.objects.all()
-        if 'project' in request.session:
-            queryset_all = queryset_all.filter(up_branch__in = Branch.objects.filter(name = request.session['project'].release.name))
+        if 'project_id' in request.session:
+            queryset_all = queryset_all.filter(up_branch__in = Branch.objects.filter(name = Project.objects.get(pk = request.session['project_id']).release.name))
 
         queryset_with_search = _get_queryset(Layer_Version, queryset_all, None, search_term, ordering_string, '-layer__name')
         queryset = _get_queryset(Layer_Version, queryset_all, filter_string, search_term, ordering_string, '-layer__name')
@@ -2023,8 +2023,8 @@ if toastermain.settings.MANAGED:
         (filter_string, search_term, ordering_string) = _search_tuple(request, Recipe)
 
         queryset_all = Recipe.objects.all()
-        if 'project' in request.session:
-            queryset_all = queryset_all.filter(Q(layer_version__up_branch__in = Branch.objects.filter(name = request.session['project'].release.name)) | Q(layer_version__build__in = request.session['project'].build_set.all()))
+        if 'project_id' in request.session:
+            queryset_all = queryset_all.filter(Q(layer_version__up_branch__in = Branch.objects.filter(name = Project.objects.get(pk=request.session['project_id']).release.name)) | Q(layer_version__build__in = Project.objects.get(pk = request.session['project_id']).build_set.all()))
 
         queryset_with_search = _get_queryset(Recipe, queryset_all, None, search_term, ordering_string, '-name')
         queryset = _get_queryset(Recipe, queryset_all, filter_string, search_term, ordering_string, '-name')
@@ -2107,8 +2107,8 @@ if toastermain.settings.MANAGED:
         (filter_string, search_term, ordering_string) = _search_tuple(request, Machine)
 
         queryset_all = Machine.objects.all()
-#        if 'project' in request.session:
-#            queryset_all = queryset_all.filter(Q(layer_version__up_branch__in = Branch.objects.filter(name = request.session['project'].release.name)) | Q(layer_version__build__in = request.session['project'].build_set.all()))
+#        if 'project_id' in request.session:
+#            queryset_all = queryset_all.filter(Q(layer_version__up_branch__in = Branch.objects.filter(name = Project.objects.get(request.session['project_id']).release.name)) | Q(layer_version__build__in = Project.objects.get(request.session['project_id']).build_set.all()))
 
         queryset_with_search = _get_queryset(Machine, queryset_all, None, search_term, ordering_string, '-name')
         queryset = _get_queryset(Machine, queryset_all, filter_string, search_term, ordering_string, '-name')
-- 
1.9.1


