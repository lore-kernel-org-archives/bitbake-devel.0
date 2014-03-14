Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f175.google.com (mail-wi0-f175.google.com
	[209.85.212.175])
	by mail.openembedded.org (Postfix) with ESMTP id 6E5F16F84C
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Mar 2014 17:59:09 +0000 (UTC)
Received: by mail-wi0-f175.google.com with SMTP id cc10so5743251wib.8
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Mar 2014 10:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=X53zuJgqftr3bMDRJgQ6op3tuHqlRL1f1B7Ou733ZOU=;
	b=H62R1uEt5vW2rZ+Dg2DH6damp3j9nOMt1YqkLSX7lReLc5y9U9DSpG7sAC5CfuYHlA
	vErRuwerjBrVCgDVX91mwihGOK7pEuLlidgJWFn5hAkCofQuAiDf0FHY4yle2f4wyGa3
	LrA4NUVqf8l/2rHEP4v/uqeKlD+vlepjN/aGB7rhZB7iV1LpX1WdqrGDJfvQCFDG33+H
	k0m5QDR36lArXKhj/ZfGR+qFrOcLL8Dauimd0ktqjyxo0Y0tQ4PJSNgwqkPsQp8R1Wkz
	zIHSkG0HsatyXb+dHfrPeTZHsjZEqZeocLWuKqaqx+2Z5uOocQfLPY1dnAeauYs1JYp0
	fjlA==
X-Gm-Message-State: ALoCoQkym5wyH5OVG9aoBI2pLIbKGxIi8727SQYMWqSQC5pAMple4AxudTq15y5HQL9x3zLKgVkT
X-Received: by 10.180.165.15 with SMTP id yu15mr7289968wib.28.1394819947098;
	Fri, 14 Mar 2014 10:59:07 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id 12sm15557846wjm.10.2014.03.14.10.59.03
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Fri, 14 Mar 2014 10:59:05 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 187CE5611E8; Fri, 14 Mar 2014 17:59:01 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 14 Mar 2014 17:58:51 +0000
Message-Id: <3feff77091b3926c10ca8f30890c9049633ccb66.1394819783.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <9f34a1c5e94d73cdba1def7059c60211514e054c.1394819783.git.alexandru.damian@intel.com>
References: <9f34a1c5e94d73cdba1def7059c60211514e054c.1394819783.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1394819783.git.alexandru.damian@intel.com>
References: <cover.1394819783.git.alexandru.damian@intel.com>
Subject: [PATCH 10/19] toaster: Add no search results page
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
X-List-Received-Date: Fri, 14 Mar 2014 17:59:09 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

Adding the no search results page to the built packages
(bpackage.html), variables (configvars.html), recipes
(recipes.html) and tasks (tasks.html) tables.

The change copies the code from the build.html template
into the other 4 templates. There is probably a smarter way
of doing this, though.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/templates/bpackage.html   | 13 +++++++++++++
 lib/toaster/toastergui/templates/configvars.html | 14 ++++++++++++++
 lib/toaster/toastergui/templates/recipes.html    | 14 ++++++++++++++
 lib/toaster/toastergui/templates/tasks.html      | 15 +++++++++++++++
 4 files changed, 56 insertions(+)

diff --git a/lib/toaster/toastergui/templates/bpackage.html b/lib/toaster/toastergui/templates/bpackage.html
index 1eb1f8e..54f4bb4 100644
--- a/lib/toaster/toastergui/templates/bpackage.html
+++ b/lib/toaster/toastergui/templates/bpackage.html
@@ -20,6 +20,18 @@
  </h1>
 </div>
 
+{% if objects.paginator.count == 0 %}
+  <div class="row-fluid">
+      <div class="alert">
+        <form class="no-results input-append" id="searchform">
+            <input id="search" name="search" class="input-xxlarge" type="text" value="{{request.GET.search}}"/><a href="javascript:$('#search').val('');searchform.submit()" class="add-on btn" tabindex="-1"><i class="icon-remove"></i></a>
+            <button class="btn" type="submit" value="Search">Search</button>
+            <button class="btn btn-link" onclick="javascript:$('#search').val('');searchform.submit()">Show all packages</button>
+        </form>
+      </div>
+  </div>
+  
+{% else %}
 {% include "basetable_top.html" %}
 
     {% for package in objects %}
@@ -69,5 +81,6 @@
     {% endfor %}
 
 {% include "basetable_bottom.html" %}
+{% endif %}
 </div>
 {% endblock %}
diff --git a/lib/toaster/toastergui/templates/configvars.html b/lib/toaster/toastergui/templates/configvars.html
index ecd5a0f..5c552c9 100644
--- a/lib/toaster/toastergui/templates/configvars.html
+++ b/lib/toaster/toastergui/templates/configvars.html
@@ -30,6 +30,19 @@
 
   <!-- variables -->
   <div id="variables" class="tab-pane">
+  
+  {% if objects.paginator.count == 0 %}
+  <div class="row-fluid">
+      <div class="alert">
+        <form class="no-results input-append" id="searchform">
+            <input id="search" name="search" class="input-xxlarge" type="text" value="{{request.GET.search}}"/><a href="javascript:$('#search').val('');searchform.submit()" class="add-on btn" tabindex="-1"><i class="icon-remove"></i></a>
+            <button class="btn" type="submit" value="Search">Search</button>
+            <button class="btn btn-link" onclick="javascript:$('#search').val('');searchform.submit()">Show all variables</button>
+        </form>
+      </div>
+  </div>
+  
+  {% else %}
   {% include "basetable_top.html" %}
 
   {% for variable in objects %}
@@ -52,6 +65,7 @@
 {% endfor %}
 
 {% include "basetable_bottom.html" %}
+{% endif %}
 </div> <!-- endvariables -->
 
 <!-- file list popups -->
diff --git a/lib/toaster/toastergui/templates/recipes.html b/lib/toaster/toastergui/templates/recipes.html
index 724bcf5..da5ac99 100755
--- a/lib/toaster/toastergui/templates/recipes.html
+++ b/lib/toaster/toastergui/templates/recipes.html
@@ -19,6 +19,19 @@
   {%endif%}
  </h1>
 </div>
+
+{% if objects.paginator.count == 0 %}
+  <div class="row-fluid">
+      <div class="alert">
+        <form class="no-results input-append" id="searchform">
+            <input id="search" name="search" class="input-xxlarge" type="text" value="{{request.GET.search}}"/><a href="javascript:$('#search').val('');searchform.submit()" class="add-on btn" tabindex="-1"><i class="icon-remove"></i></a>
+            <button class="btn" type="submit" value="Search">Search</button>
+            <button class="btn btn-link" onclick="javascript:$('#search').val('');searchform.submit()">Show all recipes</button>
+        </form>
+      </div>
+  </div>
+
+{% else %}
 {% include "basetable_top.html" %}
 
     {% for recipe in objects %}
@@ -80,5 +93,6 @@
     {% endfor %}
 
 {% include "basetable_bottom.html" %}
+{% endif %}
 </div>
 {% endblock %}
diff --git a/lib/toaster/toastergui/templates/tasks.html b/lib/toaster/toastergui/templates/tasks.html
index ce75b75..f484867 100644
--- a/lib/toaster/toastergui/templates/tasks.html
+++ b/lib/toaster/toastergui/templates/tasks.html
@@ -17,6 +17,20 @@
   {%endif%}
  </h1>
 </div>
+
+{% if objects.paginator.count == 0 %}
+  <div class="row-fluid">
+      <div class="alert">
+        <form class="no-results input-append" id="searchform">
+            <input id="search" name="search" class="input-xxlarge" type="text" value="{{request.GET.search}}"/><a href="javascript:$('#search').val('');searchform.submit()" class="add-on btn" tabindex="-1"><i class="icon-remove"></i></a>
+            <button class="btn" type="submit" value="Search">Search</button>
+            <button class="btn btn-link" onclick="javascript:$('#search').val('');searchform.submit()">Show all tasks</button>
+        </form>
+      </div>
+  </div>
+
+
+{% else %}
 {% include "basetable_top.html" %}
 
     {% for task in objects %}
@@ -58,5 +72,6 @@
     {% endfor %}
 
 {% include "basetable_bottom.html" %}
+{% endif %}
 </div>
 {% endblock %}
-- 
1.8.3.2


