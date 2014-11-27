Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f44.google.com (mail-wg0-f44.google.com [74.125.82.44])
	by mail.openembedded.org (Postfix) with ESMTP id 066E3723AC
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Nov 2014 17:08:13 +0000 (UTC)
Received: by mail-wg0-f44.google.com with SMTP id b13so6981887wgh.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Nov 2014 09:08:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=4vEClwX0cLppZTuNEdLlYVmg9nTJgyW20GIgmQWvIZY=;
	b=LiBE1Z94bLU8mg7rCLrhfK3dhGNfqSC6NAuqjSTupWX8BcFDg16DkcpW6tczALWImb
	J9da1yIaTbFf9TFz3Cx6CSPu4VRgdVUytBtm+U+rVO2daa+lea2hh9a+T9r7LbJPEFIF
	xP0SW0uCtHkRzTMewJ00QIWD1E21g00zFawtBtlA2FhVnZeu0fFqoW0XhNViEjlNrhe+
	/wN/alKgimi0kgxdJoMMDlNDwc9OkqtL1Y0iqjbHKJHk5yGjZAJMJIG/rCt07z3+kNmQ
	F3L39GuIHtl8R2rbgG3MqFOKrq+6YyyPGcWBImk2EeDJcmsHVlCLY9fXgnzcCHNTI6zV
	kwWA==
X-Gm-Message-State: ALoCoQmOJv8I7oC0iL5oh2vwLRHxb+HxcOkhRI8CZ1TJbxsuvfv/cemYOtrZJw2iINBJWCffhRW2
X-Received: by 10.180.96.10 with SMTP id do10mr53744155wib.16.1417108093661;
	Thu, 27 Nov 2014 09:08:13 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id ef6sm12187021wic.1.2014.11.27.09.08.10
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 27 Nov 2014 09:08:10 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 0BF1C5641D7; Thu, 27 Nov 2014 17:08:07 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 27 Nov 2014 17:08:01 +0000
Message-Id: <99ac7379e5df6c5cc491c2be591b15ad7ec04caa.1417107946.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <9f3cf52b3a96768e5b9764dde02833b078fe61e4.1417107946.git.alexandru.damian@intel.com>
References: <9f3cf52b3a96768e5b9764dde02833b078fe61e4.1417107946.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1417107946.git.alexandru.damian@intel.com>
References: <cover.1417107946.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>,
	Belen Barros Pena <belen.barros.pena@linux.intel.com>
Subject: [PATCH 10/14] toaster: make 'latest builds' section consistent across pages
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
X-List-Received-Date: Thu, 27 Nov 2014 17:08:14 -0000

From: Belen Barros Pena <belen.barros.pena@linux.intel.com>

Make sure that the 'latest builds' sections in the all builds
page and the project page are identical:

* no icon to represent build outcome
* remove machine name
* show date only when the build is more than 24 hours old
* same date and time format

Signed-off-by: Belen Barros Pena <belen.barros.pena@linux.intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/templates/mrb_section.html  | 15 +++++++++++----
 lib/toaster/toastergui/templatetags/projecttags.py |  8 ++++++++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/lib/toaster/toastergui/templates/mrb_section.html b/lib/toaster/toastergui/templates/mrb_section.html
index 4237980..33afb7b 100644
--- a/lib/toaster/toastergui/templates/mrb_section.html
+++ b/lib/toaster/toastergui/templates/mrb_section.html
@@ -7,7 +7,7 @@
 
   <div class="page-header top-air">
       <h1>
-          Latest Builds
+          Latest builds
        </h1>
   </div>
   <div id="latest-builds">
@@ -18,16 +18,23 @@
     {% endif %}
 
         <div class="row-fluid">
-            <div class="span4 lead">
-                {%if build.outcome == build.SUCCEEDED%}<i class="icon-ok-sign success"></i>{%elif build.outcome == build.FAILED%}<i class="icon-minus-sign error"></i>{%else%}{%endif%}
+            <div class="span3 lead">
     {%if build.outcome == build.SUCCEEDED or build.outcome == build.FAILED %}
                 <a href="{%url 'builddashboard' build.pk%}" class="{%if build.outcome == build.SUCCEEDED %}success{%else%}error{%endif%}">
     {% endif %}
-                <span data-toggle="tooltip" {%if build.target_set.all.count > 1%}title="Targets: {%for target in build.target_set.all%}{{target.target}} {%endfor%}"{%endif%}>{{build.target_set.all.0.target}} {%if build.target_set.all.count > 1%}(+ {{build.target_set.all.count|add:"-1"}}){%endif%} {{build.machine}} ({{build.completed_on|naturaltime}})</span>
+                <span data-toggle="tooltip" {%if build.target_set.all.count > 1%}title="Targets: {%for target in build.target_set.all%}{{target.target}} {%endfor%}"{%endif%}>{{build.target_set.all.0.target}} {%if build.target_set.all.count > 1%}(+ {{build.target_set.all.count|add:"-1"}}){%endif%}
+		        </span>
     {%if build.outcome == build.SUCCEEDED or build.outcome == build.FAILED %}
                 </a>
     {% endif %}
             </div>
+            <div class="span2 lead">
+                {% if build.completed_on|format_build_date  %}
+                    {{ build.completed_on|date:'d/m/y H:i' }}
+                {% else %}
+                    {{ build.completed_on|date:'H:i' }}
+                {% endif %}
+            </div>
     {%if build.outcome == build.SUCCEEDED or build.outcome == build.FAILED %}
             <div class="span2 lead">
       {% if  build.errors_no %}
diff --git a/lib/toaster/toastergui/templatetags/projecttags.py b/lib/toaster/toastergui/templatetags/projecttags.py
index 99fd4cf..f564edf 100644
--- a/lib/toaster/toastergui/templatetags/projecttags.py
+++ b/lib/toaster/toastergui/templatetags/projecttags.py
@@ -268,3 +268,11 @@ def get_dict_value(dictionary, key):
         return dictionary[key]
     except (KeyError, IndexError):
         return ''
+
+@register.filter
+def format_build_date(completed_on):
+    now = timezone.now()
+    delta = now - completed_on
+
+    if delta.days >= 1:
+        return True
-- 
1.9.1


