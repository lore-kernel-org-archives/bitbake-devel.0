Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
	[209.85.212.170])
	by mail.openembedded.org (Postfix) with ESMTP id F2BE96FB4A
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Mar 2014 18:37:36 +0000 (UTC)
Received: by mail-wi0-f170.google.com with SMTP id bs8so2707698wib.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Mar 2014 11:37:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=3mRBj9glRff6LGLxVzAKaf3EPKDjfYzLdmjnEjDW5sI=;
	b=l0vmSlEMXguoDwygoSwe4I7QCMWG+yovw+6wdbIHmtvW9dtrm2u8dGE6IWEOh3FAyA
	Sp5qKDQZpSoSHqbzN4kBgtO3TtK/z0QUMVmqCodNXsF8f+0kIWF1rW0WVZXU6U7dCmKk
	C7i31dXs3wpvj5OJrROnjpqdZOgqLq1PkcoAL2bucQBwUoOwnWRJ/k5KluGS4JYdnW6G
	W1Jizlcuu2q8IWE+WnS8GUa0I6ipHYYXL8nSWEgBmmJvNCgW09Ife6SDl8VttnthgdXC
	xKH601hS/XaD/xpMlePutBTW4adT9n/y0MJbi1NHmJaG4nsU3rn2kagiAno84ktqYOnH
	reBw==
X-Gm-Message-State: ALoCoQlKYoMMSXjS0TP5qjoMXsXkjhCCzgQ4FgaY3O8Zj5LVcdhpeHdcaftwjp9bWoua7SGFT8Ru
X-Received: by 10.180.89.102 with SMTP id bn6mr17821114wib.28.1395686257395;
	Mon, 24 Mar 2014 11:37:37 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id jd2sm41562124wic.9.2014.03.24.11.37.33
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Mon, 24 Mar 2014 11:37:35 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id BDC735614E3; Mon, 24 Mar 2014 18:37:29 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 24 Mar 2014 18:37:19 +0000
Message-Id: <8d71bd39947dd909d02c8d33847e5852c9f20f19.1395686148.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <7e59b6b1cb44de00c512facece5ede96375a411f.1395686148.git.alexandru.damian@intel.com>
References: <7e59b6b1cb44de00c512facece5ede96375a411f.1395686148.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1395686148.git.alexandru.damian@intel.com>
References: <cover.1395686148.git.alexandru.damian@intel.com>
Cc: David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 09/18] toaster: Change "0 found" to "No found"
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
X-List-Received-Date: Mon, 24 Mar 2014 18:37:37 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

Change the string in the h1 when search returns no results
from "0 things found" to "None things found". The change
applies to the BitBake variables, tasks, recipes, packages
built, time, CPU and disk I/O tables.

[YOCTO #5981]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/templates/bpackage.html   | 6 +++---
 lib/toaster/toastergui/templates/configvars.html | 6 +++---
 lib/toaster/toastergui/templates/recipes.html    | 6 +++---
 lib/toaster/toastergui/templates/tasks.html      | 6 +++---
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/lib/toaster/toastergui/templates/bpackage.html b/lib/toaster/toastergui/templates/bpackage.html
index 7da8ce7..dad0d7f 100644
--- a/lib/toaster/toastergui/templates/bpackage.html
+++ b/lib/toaster/toastergui/templates/bpackage.html
@@ -10,10 +10,10 @@
 <div class="span10">
 <div class="page-header">
 <h1>
-  {% if request.GET.filter or request.GET.search and objects.count > 0  %}
+  {% if request.GET.search and objects.paginator.count > 0  %}
       {{objects.paginator.count}} package{{objects.paginator.count|pluralize}} found
-  {%elif objects.paginator.count == 0%}
-      No Packages
+  {%elif request.GET.search and objects.paginator.count == 0%}
+      No packages found
   {%else%}
       Packages
   {%endif%}
diff --git a/lib/toaster/toastergui/templates/configvars.html b/lib/toaster/toastergui/templates/configvars.html
index d705253..24cb2a5 100644
--- a/lib/toaster/toastergui/templates/configvars.html
+++ b/lib/toaster/toastergui/templates/configvars.html
@@ -10,10 +10,10 @@
 <div class="row-fluid span10">
  <div class="page-header">
  <h1>
-  {% if request.GET.filter or request.GET.search and objects.count > 0  %}
+  {% if request.GET.filter and objects.paginator.count > 0 or request.GET.search and objects.paginator.count > 0 %}
       {{objects.paginator.count}} variable{{objects.paginator.count|pluralize}} found
-  {%elif objects.paginator.count == 0%}
-      No variables
+  {%elif request.GET.filter and objects.paginator.count == 0 or request.GETs.search and objects.paginator.count == 0 %}
+      No variables found
   {%else%}
       Configuration
   {%endif%}
diff --git a/lib/toaster/toastergui/templates/recipes.html b/lib/toaster/toastergui/templates/recipes.html
index 860d30d..22c3d1a 100755
--- a/lib/toaster/toastergui/templates/recipes.html
+++ b/lib/toaster/toastergui/templates/recipes.html
@@ -10,10 +10,10 @@
 <div class="span10">
 <div class="page-header">
 <h1>
-  {% if request.GET.filter or request.GET.search and objects.count > 0  %}
+  {% if request.GET.search and objects.paginator.count > 0  %}
       {{objects.paginator.count}} recipe{{objects.paginator.count|pluralize}} found
-  {%elif objects.paginator.count == 0%}
-      No Recipes
+  {%elif request.GET.search and objects.paginator.count == 0%}
+      No recipes found
   {%else%}
       Recipes
   {%endif%}
diff --git a/lib/toaster/toastergui/templates/tasks.html b/lib/toaster/toastergui/templates/tasks.html
index d881811..a2629dc 100644
--- a/lib/toaster/toastergui/templates/tasks.html
+++ b/lib/toaster/toastergui/templates/tasks.html
@@ -8,10 +8,10 @@
 <div class="span10">
 <div class="page-header">
 <h1>
-  {% if request.GET.filter or request.GET.search and objects.count > 0  %}
+  {% if request.GET.filter or request.GET.search and objects.paginator.count > 0  %}
       {{objects.paginator.count}} task{{objects.paginator.count|pluralize}} found
-  {%elif objects.paginator.count == 0%}
-      No tasks
+  {%elif request.GET.filter or request.GET.search and objects.paginator.count == 0%}
+      No tasks found
   {%else%}
       {{title}}
   {%endif%}
-- 
1.8.3.2


