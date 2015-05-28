Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
	[209.85.212.173])
	by mail.openembedded.org (Postfix) with ESMTP id 7A63673236
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 May 2015 14:16:38 +0000 (UTC)
Received: by wicmx19 with SMTP id mx19so125119154wic.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 28 May 2015 07:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=SatUIr9Sy0DwOfrk1AQLgsFU39pabaajtb9UpgfkHNo=;
	b=WFVrJtG1X55NIyG+hNV3f4aedKgvMtZ7l+pn9iSIWhbWPjEtFaLH6zBZ61ljz9lNmC
	q9EB/S4c2FMkCjnioizl1AGEWHUuw/NL38MbyJ2G8nAjKUyzst0+MJCGJmoQZC1Udjng
	+G2BcAFh0IjUzCu7R6cFzqHnnIx9EKxmP96BpnUzSuximXQGW1UCTPv4s6MuC/6Bo5Gc
	xqDs4f439k26YvaduNAPMcBklTkUf8605RrbvQ2bHKf2gFz7T3kNv+JASrIYUyKnCXzQ
	mXggSPf2xeikMUn0HG5yxeRpT+AfbSjIJCVfB2oaGrX22R7qPCZdYlkN7GqzdWRaQSyy
	PeMQ==
X-Gm-Message-State: ALoCoQm+4oK/5GDvkcfqRsgtp3iwdya/ZsT/YKUQlcfyRFsxPfEMDUyRU6P0XM/bJ7UUMHKNfwjf
X-Received: by 10.180.81.3 with SMTP id v3mr16233885wix.36.1432822599079;
	Thu, 28 May 2015 07:16:39 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id fb3sm8752919wib.21.2015.05.28.07.16.38
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 28 May 2015 07:16:38 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id CA27A5612B9; Thu, 28 May 2015 15:14:17 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 28 May 2015 15:14:06 +0100
Message-Id: <24a4ca7fec490288e86b1b6fc56f4cd866478c82.1432822343.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <f4c88fd9e39602ab841967166a14593f92576079.1432822343.git.alexandru.damian@intel.com>
References: <f4c88fd9e39602ab841967166a14593f92576079.1432822343.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1432822343.git.alexandru.damian@intel.com>
References: <cover.1432822343.git.alexandru.damian@intel.com>
Subject: [PATCH 12/22] toastergui: Consider task name when restarting a build in /builds
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
X-List-Received-Date: Thu, 28 May 2015 14:16:39 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Previously the same issue was fixed for project view.
'Run again' button now restarts builds using target:task also in builds view.

[YOCTO #7442]

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 .../toastergui/templates/managed_mrb_section.html        | 16 ++++++++++++++--
 lib/toaster/toastergui/templates/runagain.html           |  7 +++++++
 lib/toaster/toastergui/templatetags/projecttags.py       |  7 ++++---
 3 files changed, 25 insertions(+), 5 deletions(-)
 create mode 100644 lib/toaster/toastergui/templates/runagain.html

diff --git a/lib/toaster/toastergui/templates/managed_mrb_section.html b/lib/toaster/toastergui/templates/managed_mrb_section.html
index abcc0bb..c93c2af 100644
--- a/lib/toaster/toastergui/templates/managed_mrb_section.html
+++ b/lib/toaster/toastergui/templates/managed_mrb_section.html
@@ -54,7 +54,17 @@
                 Build time: <a href="{% url 'buildtime' build.pk %}">{{ build.timespent|sectohms }}</a>
               </span>
           {% if build.project %}
-              <button class="btn {%if build.outcome == build.SUCCEEDED%}btn-success{%elif build.outcome == build.FAILED%}btn-danger{%else%}btn-info{%endif%} pull-right" onclick='scheduleBuild({% url 'xhr_projectbuild' build.project.id as bpi%}{{bpi|json}}, {{build.project.name|json}}, {% url 'project' buildrequest.project.id as bpurl%}{{bpurl|json}}, {{build.get_sorted_target_list|mapselect:'target'|json}})'>Run again</button>
+              <button class="btn
+                  {% if build.outcome == build.SUCCEEDED %}
+                      btn-success
+                  {% elif build.outcome == build.FAILED %}
+                      btn-danger
+                  {% else %}
+                      btn-info
+                  {%endif%}
+                  pull-right"
+                  {% include "runagain.html" %}
+              </button>
           {% endif %}
             </div>
     {%endif%}
@@ -104,8 +114,10 @@
               <span class="lead{%if not MANAGED or not buildrequest.project%} pull-right{%endif%}">
                 Build time: {{ buildrequest.get_duration|sectohms }}
               </span>
-              <button class="btn btn-danger pull-right" onclick='scheduleBuild({% url 'xhr_projectbuild' buildrequest.project.id as bpi%}{{bpi|json}},  {{buildrequest.project.name|json}}, {% url 'project' buildrequest.project.id as bpurl%}{{bpurl|json}}, {{buildrequest.get_sorted_target_list|mapselect:'target'|json}})'>Run again</button>
 
+              <button class="btn btn-danger pull-right"
+                  {% include "runagain.html" %}
+              </button>
             </div>
 
 
diff --git a/lib/toaster/toastergui/templates/runagain.html b/lib/toaster/toastergui/templates/runagain.html
new file mode 100644
index 0000000..a78c0dd
--- /dev/null
+++ b/lib/toaster/toastergui/templates/runagain.html
@@ -0,0 +1,7 @@
+{% load projecttags %}
+onclick='scheduleBuild(
+    {% url 'xhr_projectbuild' buildrequest.project.id as bpi %}{{bpi|json}},
+    {{buildrequest.project.name|json}},
+    {% url 'project' buildrequest.project.id as bpurl %}{{bpurl|json}},
+    {{buildrequest.brtarget_set.all|get_tasks|json}})
+'>Run again
diff --git a/lib/toaster/toastergui/templatetags/projecttags.py b/lib/toaster/toastergui/templatetags/projecttags.py
index 1bc3bc2..8028ae0 100644
--- a/lib/toaster/toastergui/templatetags/projecttags.py
+++ b/lib/toaster/toastergui/templatetags/projecttags.py
@@ -44,9 +44,10 @@ def sectohms(time):
     return "%02d:%02d:%02d" % (hours, int((tdsec - (hours * 3600))/ 60), int(tdsec) % 60)
 
 
-@register.filter(name = 'mapselect')
-def mapselect(value, argument):
-    return map(lambda x: vars(x)[argument], value)
+@register.filter(name = 'get_tasks')
+def get_tasks(queryset):
+    return list(target + ':' + task if task else target \
+                    for target, task in queryset.values_list('target', 'task'))
 
 
 @register.filter(name = "json")
-- 
1.9.1


