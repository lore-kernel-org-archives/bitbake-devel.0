Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f170.google.com (mail-we0-f170.google.com
	[74.125.82.170])
	by mail.openembedded.org (Postfix) with ESMTP id E74B36EEFA
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Mar 2014 17:59:09 +0000 (UTC)
Received: by mail-we0-f170.google.com with SMTP id w61so2461979wes.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Mar 2014 10:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=dBEXtZhRX94Un3JCkVoG1qVeKNWrfBLkAqKYvBw179Q=;
	b=CtESxToHAW8nO5sSP7F390dTlgw3dG73+ftJMX3ZyXgikVIHV3nxkHB+iT00uq9ITf
	Z3Mp5Vra6yPLr+biJQSrrp6XIJbW+nE+PGsyPkuS95StGb9HOVGGM3H5BazM9ya+/Bk1
	ZSDzXCLiOUJr2wREqVN2EeLPoZs/jU+q7KLnOlwvydL6ph3+EgAroCvsEPjykvkREr6t
	V35O0gBCL6wWhmzchfYjOBZW3F5hhkEdhWR+dYeN92VRO5IMsEZB2PJAaNBv1TcBGP3L
	2sdJEJDTeasFMBfcoK4ungHY/ytxA7d/HTwOW4Z1cJIaEJYObDWzeIkQ3Rt5ESBvOlmm
	osHg==
X-Gm-Message-State: ALoCoQky+Lf6wyeYMz+tBa5is9aVgwpM6zGq/NxIK+IkNV59E3f26m/wBe8dIU0YnZLHMc1Te+qL
X-Received: by 10.180.103.227 with SMTP id fz3mr7195300wib.29.1394819950300;
	Fri, 14 Mar 2014 10:59:10 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	az1sm15557325wjb.11.2014.03.14.10.59.06 for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Fri, 14 Mar 2014 10:59:08 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 2328A561291; Fri, 14 Mar 2014 17:59:01 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 14 Mar 2014 17:58:57 +0000
Message-Id: <312ed2375e4bb66b66e4760ef8ada6e49fab516d.1394819783.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <9f34a1c5e94d73cdba1def7059c60211514e054c.1394819783.git.alexandru.damian@intel.com>
References: <9f34a1c5e94d73cdba1def7059c60211514e054c.1394819783.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1394819783.git.alexandru.damian@intel.com>
References: <cover.1394819783.git.alexandru.damian@intel.com>
Subject: [PATCH 16/19] toaster: Don't show clear search button if text input field is empty
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
X-List-Received-Date: Fri, 14 Mar 2014 17:59:13 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

The clear search button should only show when the search text input
field is populated. If it is empty (as it happens when a filter
returns no results) the clear search button should not display.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/templates/bpackage.html   | 2 +-
 lib/toaster/toastergui/templates/configvars.html | 2 +-
 lib/toaster/toastergui/templates/recipes.html    | 2 +-
 lib/toaster/toastergui/templates/tasks.html      | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/toastergui/templates/bpackage.html b/lib/toaster/toastergui/templates/bpackage.html
index 54f4bb4..7da8ce7 100644
--- a/lib/toaster/toastergui/templates/bpackage.html
+++ b/lib/toaster/toastergui/templates/bpackage.html
@@ -24,7 +24,7 @@
   <div class="row-fluid">
       <div class="alert">
         <form class="no-results input-append" id="searchform">
-            <input id="search" name="search" class="input-xxlarge" type="text" value="{{request.GET.search}}"/><a href="javascript:$('#search').val('');searchform.submit()" class="add-on btn" tabindex="-1"><i class="icon-remove"></i></a>
+            <input id="search" name="search" class="input-xxlarge" type="text" value="{{request.GET.search}}"/>{% if request.GET.search %}<a href="javascript:$('#search').val('');searchform.submit()" class="add-on btn" tabindex="-1"><i class="icon-remove"></i></a>{% endif %}
             <button class="btn" type="submit" value="Search">Search</button>
             <button class="btn btn-link" onclick="javascript:$('#search').val('');searchform.submit()">Show all packages</button>
         </form>
diff --git a/lib/toaster/toastergui/templates/configvars.html b/lib/toaster/toastergui/templates/configvars.html
index ae77be8..d705253 100644
--- a/lib/toaster/toastergui/templates/configvars.html
+++ b/lib/toaster/toastergui/templates/configvars.html
@@ -35,7 +35,7 @@
   <div class="row-fluid">
       <div class="alert">
         <form class="no-results input-append" id="searchform">
-            <input id="search" name="search" class="input-xxlarge" type="text" value="{{request.GET.search}}"/><a href="javascript:$('#search').val('');searchform.submit()" class="add-on btn" tabindex="-1"><i class="icon-remove"></i></a>
+            <input id="search" name="search" class="input-xxlarge" type="text" value="{{request.GET.search}}"/>{% if request.GET.search %}<a href="javascript:$('#search').val('');searchform.submit()" class="add-on btn" tabindex="-1"><i class="icon-remove"></i></a>{% endif %}
             <button class="btn" type="submit" value="Search">Search</button>
             <button class="btn btn-link" onclick="javascript:$('#search').val('');searchform.submit()">Show all variables</button>
         </form>
diff --git a/lib/toaster/toastergui/templates/recipes.html b/lib/toaster/toastergui/templates/recipes.html
index da5ac99..860d30d 100755
--- a/lib/toaster/toastergui/templates/recipes.html
+++ b/lib/toaster/toastergui/templates/recipes.html
@@ -24,7 +24,7 @@
   <div class="row-fluid">
       <div class="alert">
         <form class="no-results input-append" id="searchform">
-            <input id="search" name="search" class="input-xxlarge" type="text" value="{{request.GET.search}}"/><a href="javascript:$('#search').val('');searchform.submit()" class="add-on btn" tabindex="-1"><i class="icon-remove"></i></a>
+            <input id="search" name="search" class="input-xxlarge" type="text" value="{{request.GET.search}}"/>{% if request.GET.search %}<a href="javascript:$('#search').val('');searchform.submit()" class="add-on btn" tabindex="-1"><i class="icon-remove"></i></a>{% endif %}
             <button class="btn" type="submit" value="Search">Search</button>
             <button class="btn btn-link" onclick="javascript:$('#search').val('');searchform.submit()">Show all recipes</button>
         </form>
diff --git a/lib/toaster/toastergui/templates/tasks.html b/lib/toaster/toastergui/templates/tasks.html
index f484867..d881811 100644
--- a/lib/toaster/toastergui/templates/tasks.html
+++ b/lib/toaster/toastergui/templates/tasks.html
@@ -22,7 +22,7 @@
   <div class="row-fluid">
       <div class="alert">
         <form class="no-results input-append" id="searchform">
-            <input id="search" name="search" class="input-xxlarge" type="text" value="{{request.GET.search}}"/><a href="javascript:$('#search').val('');searchform.submit()" class="add-on btn" tabindex="-1"><i class="icon-remove"></i></a>
+            <input id="search" name="search" class="input-xxlarge" type="text" value="{{request.GET.search}}"/>{% if request.GET.search %}<a href="javascript:$('#search').val('');searchform.submit()" class="add-on btn" tabindex="-1"><i class="icon-remove"></i></a>{% endif %}
             <button class="btn" type="submit" value="Search">Search</button>
             <button class="btn btn-link" onclick="javascript:$('#search').val('');searchform.submit()">Show all tasks</button>
         </form>
-- 
1.8.3.2


