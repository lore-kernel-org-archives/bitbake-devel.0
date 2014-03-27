Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f178.google.com (mail-we0-f178.google.com
	[74.125.82.178])
	by mail.openembedded.org (Postfix) with ESMTP id 5B01C6F8DF
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Mar 2014 16:50:05 +0000 (UTC)
Received: by mail-we0-f178.google.com with SMTP id u56so1926059wes.23
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Mar 2014 09:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=RFX7WVZHUxmCxSCXLjdccVM95f7lPNrMdbPT8EVmHS8=;
	b=m8LGPlN/m5T0BkrY55Hwzliw1edq/AxKRV7pm10sDrwDDzk+VHWiRQM+BcsfcB2vd4
	hqpNkjlWkSZxDR32yMy7qSR0gIEfv3rcvBiPyhl9P5XgQYhxV+2e/QgffDQP4a+ixFlO
	2qRdGplOLuxR8OKuwRfonVijRGowA1oL24JdRvVUuj2DPV29MnBWGTUm5rDK4RsXpwau
	FNzw70xzuk4bzMw3XNwdQ9l/3e42heqdAcE0B73YomiqbVj8c7pVlzSZv6NiGr0xjqV9
	MJh6kUYZ/GcVonRB7nWqb+evA1WlerYVg6PI+ES57GZ1kdhNom5CrdS4PaRR5zcyfBUl
	dDoQ==
X-Gm-Message-State: ALoCoQk/Qq+vk1+Ui9/u7OrZEukwG+2o6+kg4fHBx8mHQrULt3qWKocfsATK9iBt0q4uiFveNLBv
X-Received: by 10.180.12.115 with SMTP id x19mr41339587wib.19.1395939006299;
	Thu, 27 Mar 2014 09:50:06 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id q2sm10625352wix.5.2014.03.27.09.50.04
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Thu, 27 Mar 2014 09:50:04 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 841C9560DC9; Thu, 27 Mar 2014 16:50:02 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 27 Mar 2014 16:49:58 +0000
Message-Id: <9df7f458d131b3b1de2adab71ee445d561f5f220.1395938903.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <30647848c4c202df4537eb2c1810ec0999dab4bd.1395938903.git.alexandru.damian@intel.com>
References: <30647848c4c202df4537eb2c1810ec0999dab4bd.1395938903.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1395938903.git.alexandru.damian@intel.com>
References: <cover.1395938903.git.alexandru.damian@intel.com>
Cc: David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 6/9] toaster: add support for empty states in pages
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
X-List-Received-Date: Thu, 27 Mar 2014 16:50:07 -0000

From: David Reyna <David.Reyna@windriver.com>

Add support for empty states in the top build page,
the all packages page, and the all tasks page.

[YOCTO #4865]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/toaster/toastergui/static/css/default.css  |   4 +-
 lib/toaster/toastergui/static/img/toaster.png  | Bin 0 -> 51986 bytes
 lib/toaster/toastergui/templates/bpackage.html |  34 +++++++++++++----
 lib/toaster/toastergui/templates/build.html    |  50 ++++++++++++++++++++-----
 lib/toaster/toastergui/templates/tasks.html    |  34 +++++++++++------
 5 files changed, 93 insertions(+), 29 deletions(-)
 create mode 100755 lib/toaster/toastergui/static/img/toaster.png

diff --git a/lib/toaster/toastergui/static/css/default.css b/lib/toaster/toastergui/static/css/default.css
index d960f4b..260f5d4 100644
--- a/lib/toaster/toastergui/static/css/default.css
+++ b/lib/toaster/toastergui/static/css/default.css
@@ -106,7 +106,9 @@ select { width: auto; }
 .task-name { margin-left: 7px; }
 .icon-hand-right {color: #ccccc; }
 .help-inline { margin: 5px; }
-
+.hero-unit { margin: 20px 0 30px; }
+.hero-unit > .close { font-size:40px; }
+.hero-actions { margin-top: 30px; }
 
 
 
diff --git a/lib/toaster/toastergui/static/img/toaster.png b/lib/toaster/toastergui/static/img/toaster.png
new file mode 100755
index 0000000000000000000000000000000000000000..11bb5d51b1efc54084aa94d1bc84f4d00ee3d59e
GIT binary patch
literal 51986
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

literal 0
HcmV?d00001

diff --git a/lib/toaster/toastergui/templates/bpackage.html b/lib/toaster/toastergui/templates/bpackage.html
index 77f7894..22609e2 100644
--- a/lib/toaster/toastergui/templates/bpackage.html
+++ b/lib/toaster/toastergui/templates/bpackage.html
@@ -12,8 +12,27 @@
 
 {% block buildinfomain %}
 <div class="span10">
+
+{% if not request.GET.filter and not request.GET.search and not objects.paginator.count %}
+
+<!-- Empty - no data in database -->
 <div class="page-header">
-<h1>
+  <div class="page-header">
+    <h1>
+    Packages
+    </h1>
+    </div>
+  <div class="alert alert-info lead">
+    <STRONG>No packages were built.</STRONG> How did this happen? Well, BitBake reuses as much stuff as possible.
+    If all of the packages needed were already built and available in your build infrastructure, Bitbake
+    will not rebuild any of them. This might be slightly confusing, but it does make everything faster.
+  </div>
+</div>
+
+{% else %}
+
+<div class="page-header">
+  <h1>
   {% if request.GET.search and objects.paginator.count > 0  %}
       {{objects.paginator.count}} package{{objects.paginator.count|pluralize}} found
   {%elif request.GET.search and objects.paginator.count == 0%}
@@ -21,10 +40,10 @@
   {%else%}
       Packages
   {%endif%}
- </h1>
+  </h1>
 </div>
 
-{% if objects.paginator.count == 0 %}
+  {% if objects.paginator.count == 0 %}
   <div class="row-fluid">
       <div class="alert">
         <form class="no-results input-append" id="searchform">
@@ -35,8 +54,8 @@
       </div>
   </div>
 
-{% else %}
-{% include "basetable_top.html" %}
+  {% else %}
+  {% include "basetable_top.html" %}
 
     {% for package in objects %}
 
@@ -84,7 +103,8 @@
     </tr>
     {% endfor %}
 
-{% include "basetable_bottom.html" %}
-{% endif %}
+  {% include "basetable_bottom.html" %}
+  {% endif %} {# objects.paginator.count #}
+{% endif %} {# Empty #}
 </div>
 {% endblock %}
diff --git a/lib/toaster/toastergui/templates/build.html b/lib/toaster/toastergui/templates/build.html
index 8f557e9..38ab2bf 100644
--- a/lib/toaster/toastergui/templates/build.html
+++ b/lib/toaster/toastergui/templates/build.html
@@ -1,11 +1,30 @@
 {% extends "base.html" %}
 
-
+{% load static %}
 {% load projecttags %}
 {% load humanize %}
 
 {% block pagecontent %}
 <div class="row-fluid">
+  {% if not objects.paginator.count and not request.GET.filter and not request.GET.search %}
+    <!-- Empty - no data in database -->
+    <div class="hero-unit span12">
+        <button type="button" class="close" data-dismiss="alert">&times;</button>
+        <div class="row-fluid">
+            <div class="span6">
+                <h1>This is Toaster</h1>
+                <p>A web interface to <a href="http://www.yoctoproject.org/tools-resources/projects/bitbake">BitBake</a>, the <a href="http://www.yoctoproject.org">Yocto Project</a> build system.</p>
+                <p class="hero-actions">
+                    <a class="btn btn-primary btn-large" href="https://www.yoctoproject.org/documentation/toaster-manual">Show me the manual</a>
+                    <a class="btn btn-large" href="https://wiki.yoctoproject.org/wiki/Contribute_to_Toaster">I want to contribute</a>
+                </p>
+            </div>
+            <div class="span5">
+                <a href="http://www.yoctoproject.org"><img src="{% static 'img/toaster.png' %}" class="thumbnail" alt="Yocto Project"/> </a>
+            </div>
+        </div>
+    </div>
+  {% endif %}
 
   {%if mru.count > 0%}
   <div class="page-header top-air">
@@ -53,9 +72,20 @@
 
   {% endfor %}{%endif%}
 
+  {% if not objects.paginator.count and not request.GET.filter and not request.GET.search %}
+    <!-- Empty - no data in database -->
+    {% if mru.count == 0 %}
+    <div class="page-header top-air">
+       <h1>All builds</h1>
+    </div>
+    <div class="alert alert-info lead">
+        Toaster has not recorded any builds yet. Go build something with <a href="http://www.yoctoproject.org/docs/current/yocto-project-qs/yocto-project-qs.html#test-run">Knotty</a> or <a href="https://www.yoctoproject.org/documentation/hob-manual">Hob</a>
+    </div>
+    {% endif %}
+  {% else %}
   <div class="page-header top-air">
      <h1>
-      {% if request.GET.filter or request.GET.search and objects.count > 0  %}
+      {% if request.GET.filter and objects.count or request.GET.search and objects.count > 0  %}
           {{objects.paginator.count}} build{{objects.paginator.count|pluralize}} found
       {%elif objects.paginator.count == 0%}
           No builds
@@ -65,8 +95,8 @@
      </h1>
   </div>
 
- {% if objects.paginator.count == 0 %}
-  <div class="row-fluid">
+  {% if objects.paginator.count == 0 %}
+    <div class="row-fluid">
       <div class="alert">
         <form class="no-results input-append" id="searchform">
             <input id="search" name="search" class="input-xxlarge" type="text" value="{{request.GET.search}}"/>{% if request.GET.search %}<a href="javascript:$('#search').val('');searchform.submit()" class="add-on btn" tabindex="-1"><i class="icon-remove"></i></a>{% endif %}
@@ -74,11 +104,11 @@
             <button class="btn btn-link" onclick="javascript:$('#search').val('');searchform.submit()">Show all builds</button>
         </form>
       </div>
-  </div>
+    </div>
 
 
-{% else %}
-{% include "basetable_top.html" %}
+  {% else %}
+  {% include "basetable_top.html" %}
         <!-- Table data rows; the order needs to match the order of "tablecols" definitions; and the <td class value needs to match the tablecols clclass value for show/hide buttons to work -->
         {% for build in objects %}
         <tr class="data">
@@ -98,9 +128,9 @@
         {% endfor %}
 
 
-{% include "basetable_bottom.html" %}
-
-{% endif %}
+  {% include "basetable_bottom.html" %}
+  {% endif %} {# objects.paginator.count #}
+{% endif %} {# empty #}
 </div><!-- end row-fluid-->
 
 {% endblock %}
diff --git a/lib/toaster/toastergui/templates/tasks.html b/lib/toaster/toastergui/templates/tasks.html
index 8c73dc2..ca7e187 100644
--- a/lib/toaster/toastergui/templates/tasks.html
+++ b/lib/toaster/toastergui/templates/tasks.html
@@ -36,19 +36,30 @@
 
 {% block buildinfomain %}
 <div class="span10">
-<div class="page-header">
-<h1>
-  {% if request.GET.filter or request.GET.search and objects.paginator.count > 0  %}
+{% if not request.GET.filter and not request.GET.search and not objects.paginator.count %}
+  <!-- Empty - no data in database -->
+  <div class="page-header">
+  <h1>{{title}}</h1>
+  </div>
+  <div class="alert alert-info lead">
+  No data was recorded for this build.
+  </div>
+
+{% else %}
+
+  <div class="page-header">
+  <h1>
+  {% if  request.GET.filter and objects.paginator.count >  0 or request.GET.search and objects.paginator.count >  0 %}
       {{objects.paginator.count}} task{{objects.paginator.count|pluralize}} found
-  {%elif request.GET.filter or request.GET.search and objects.paginator.count == 0%}
+  {%elif request.GET.filter and objects.paginator.count == 0 or request.GET.search and objects.paginator.count == 0 %}
       No tasks found
   {%else%}
       {{title}}
   {%endif%}
- </h1>
-</div>
+  </h1>
+  </div>
 
-{% if objects.paginator.count == 0 %}
+  {% if objects.paginator.count == 0 %}
   <div class="row-fluid">
       <div class="alert">
         <form class="no-results input-append" id="searchform">
@@ -60,8 +71,8 @@
   </div>
 
 
-{% else %}
-{% include "basetable_top.html" %}
+  {% else %}
+  {% include "basetable_top.html" %}
 
     {% for task in objects %}
         <tr {{ task|task_color }} class="flash" id="{{task.order}}" name="{{task.order}}">
@@ -102,7 +113,8 @@
         </tr>
     {% endfor %}
 
-{% include "basetable_bottom.html" %}
-{% endif %}
+  {% include "basetable_bottom.html" %}
+  {% endif %} {# objects.paginator.count #}
+{% endif %} {# empty #}
 </div>
 {% endblock %}
-- 
1.8.3.2


