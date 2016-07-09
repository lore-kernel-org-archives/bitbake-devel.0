Return-Path: <avery.brian@gmail.com>
Received: from mail-pf0-f178.google.com (mail-pf0-f178.google.com
	[209.85.192.178])
	by mail.openembedded.org (Postfix) with ESMTP id 3E5DE607A4
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  9 Jul 2016 00:52:50 +0000 (UTC)
Received: by mail-pf0-f178.google.com with SMTP id c2so17413663pfa.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 08 Jul 2016 17:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=fGCEr4LgenvB0cocBWr4xZtS7jminO6/CnZCXDfUmpw=;
	b=pB9odNmvIgVEmZXKAYGM5VhBircuYwb4oTAIwqVTcB12XOb8ZQQogBBBVUv54XCu8T
	MoXr95uIrc9YI44Gso3D8+mrLwMPLe3fmZd1hdmRsm08/xJBWKrAfiZjZTK22ywhOEj4
	tDzHeRX5GAldrs/rXYXbv6fStBmpJjioKhrBZQKqDsTnPQHK84jYHxhBXbOsEyKEpjlX
	2SJeTsiEbHNgH518C/XQALvG1CpvStCWmIS8PQ/i2b9fcylpXRdt2ELV0bDngUXzG+Yq
	dhVtaK2NtE31mSX76DmD3LKBKJuxX3zyUOp7gUo6XCozHWnfS3FJ7g+prIOms2MfbzEj
	XZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=fGCEr4LgenvB0cocBWr4xZtS7jminO6/CnZCXDfUmpw=;
	b=dTTM1OGpiL0GzYBpmBOu2KZ464AyfBS2UoVjjlao05vpobuF/C3my3+YMpHd2H4xSr
	RROUd1IlYOuKc5SmsX4ll9OOz/5IhdX0Buf1BUwt/pYUqBSX8s21e1s8RwrAJcn5TVW+
	Y2W3e+TJAquz7vw02vvjcPTWkvmKPYu/I0qqnzE3tplWro3frKykh/rE2Ht0j3G4wrBN
	OobPtSqfnb/KmjL1OnhT4MSbXSwIB0usFTyh7fDLG/9vQeEHPIjzcUhNf7HGPdWMP+XE
	lSsYcbRn1gTcCVkkJjYxOh2uz14PjNfT53XzU1YhT6QYW3Arw0iHmxWjchJQfHvfUOrw
	wYNA==
X-Gm-Message-State: ALyK8tIbOUu0Wts5naR4C0h/i1MsD3c4D+09XfEw66iRVxT4Ucrn738BbeXRV8/e9xJA/Q==
X-Received: by 10.98.41.198 with SMTP id p189mr14531149pfp.18.1468025571462;
	Fri, 08 Jul 2016 17:52:51 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id bm8sm213836pad.10.2016.07.08.17.52.50
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 08 Jul 2016 17:52:50 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
X-Google-Original-From: brian avery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  8 Jul 2016 17:52:42 -0700
Message-Id: <c6b1985584b95826bbe0f901e7fbf1205c64e69e.1468024992.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <fb5a436289d7cfd1c86e0308b996e1db36ae63bb.1468024992.git.brian.avery@intel.com>
References: <fb5a436289d7cfd1c86e0308b996e1db36ae63bb.1468024992.git.brian.avery@intel.com>
In-Reply-To: <cover.1468024992.git.brian.avery@intel.com>
References: <cover.1468024992.git.brian.avery@intel.com>
Cc: brian avery <brian.avery@intel.com>
Subject: [PATCH 2/7] toaster: display Target targets in build dashboard
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
X-List-Received-Date: Sat, 09 Jul 2016 00:52:51 -0000

From: Elliot Smith <elliot.smith@intel.com>

The build dashboard was showing the targets for the build in the page
heading and title as "Target object".

Add a filter which extracts the "target" from each Target object
as a string so that the heading and title display correctly.

Also sort the image file suffixes alphabetically.

[YOCTO #8556]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: brian avery <brian.avery@intel.com>
---
 lib/toaster/toastergui/templates/builddashboard.html   |  9 +++++----
 .../toastergui/templatetags/field_values_filter.py     | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+), 4 deletions(-)
 create mode 100644 bitbake/lib/toaster/toastergui/templatetags/field_values_filter.py

diff --git a/lib/toaster/toastergui/templates/builddashboard.html b/lib/toaster/toastergui/templates/builddashboard.html
index 04a57ef..dcda2a8 100644
--- a/lib/toaster/toastergui/templates/builddashboard.html
+++ b/lib/toaster/toastergui/templates/builddashboard.html
@@ -1,8 +1,9 @@
 {% extends "basebuildpage.html" %}
 {% load humanize %}
 {% load projecttags %}
+{% load field_values_filter %}

-{% block title %} {{build.target_set.all|dictsort:"target"|join:", "}} {{build.machine}} - {{build.project.name}} - Toaster {% endblock %}
+{% block title %} {{build.get_sorted_target_list|field_values:"target"|join:", "}} {{build.machine}} - {{build.project.name}} - Toaster {% endblock %}
 {% block parentbreadcrumb %}
 {% if build.get_sorted_target_list.count > 0 %}
   {{build.get_sorted_target_list.0.target}}
@@ -15,7 +16,7 @@
 <!-- page title -->
 <div class="col-md-10">
  <div class="page-header build-data">
-     <h1>{{build.target_set.all|dictsort:"target"|join:", "}} {{build.machine}}</h1>
+     <h1>{{build.get_sorted_target_list|field_values:"target"|join:", "}} {{build.machine}}</h1>
  </div>

 <!-- build result bar -->
@@ -113,7 +114,7 @@
             </dt>
             <dd>
                 <ul class="list-unstyled">
-                    {% for i in target.imageFiles %}
+                    {% for i in target.imageFiles|dictsort:"suffix" %}
                         <li>
                             <a href="{% url 'build_artifact' build.pk 'imagefile' i.id %}">
                                 {{i.suffix}}
@@ -261,7 +262,7 @@
         if (location.href.search('#warnings') > -1) {
             $('#warning-info').addClass('in');
         }
-
+
 	//show warnings section when requested from the build outcome
 	$(".show-warnings").click(function() {
 	    $('#warning-info').addClass('in');
diff --git a/lib/toaster/toastergui/templatetags/field_values_filter.py b/lib/toaster/toastergui/templatetags/field_values_filter.py
new file mode 100644
index 0000000..5a73af7
--- /dev/null
+++ b/lib/toaster/toastergui/templatetags/field_values_filter.py
@@ -0,0 +1,18 @@
+from django import template
+
+register = template.Library()
+
+def field_values(iterable, field):
+    """
+    Convert an iterable of models into a list of strings, one for each model,
+    where the string for each model is the value of the field "field".
+    """
+    objects = []
+
+    if field:
+        for item in iterable:
+            objects.append(getattr(item, field))
+
+    return objects
+
+register.filter('field_values', field_values)
\ No newline at end of file
--
1.9.1

