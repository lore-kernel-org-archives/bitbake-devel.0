Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
	by mail.openembedded.org (Postfix) with ESMTP id 5EAC573199
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 May 2016 14:10:46 +0000 (UTC)
Received: by mail-wm0-f45.google.com with SMTP id g17so138271509wme.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 May 2016 07:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=FDj2gwsQx6l2n8a+k+Peo2cgXdH9gK9/RCFPFIYU4yo=;
	b=IsBWWxN/01YWjLH3AWa6FeRc0sVveDQBtYq96zxhGRUhuPZ+x77BFQ1xWd+UpnieLZ
	0Q3OWCvPE7XnTtIyzfiB2ZqRGNhewh4PkEODsWTVxMjjpFY1+an+t3/t4ui2fmmqywB1
	ZFXo4ma+j8vUzBY0NuSopOcyMJ2LanuduDAq/utvup+5l/VFGECacwU6fwrPF+y771+s
	y0g8O60nyEzcfVZ+QMUb3Mkzz4tnpp54wmzdsSVM7/5mPC1mORlVkP08Lglmv6H0Ff71
	0K0GopPWOeEWZ3zlu64W2mUper7wPe6BwM6E20sI30RghPynIZLy2Gjs4Taa2azmaJfm
	PB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=FDj2gwsQx6l2n8a+k+Peo2cgXdH9gK9/RCFPFIYU4yo=;
	b=XAOn02azHyobj66rUFa69YMuk3ZiveWAf2Jn9TkbmF5trg8oSfmoW+x0xZPCle8pEl
	RFdYE3XeGU7HYDJiwKlFHL3veONxMg5YXOe3aGhEC6Pg/XwiA0demd7VxRmOeI65AuNf
	UKeYLZxNRjyTdLfqBMA3H0BJy9t1APAeaMjLOXZ3dawoAP7W3ck+srm8Q9zFOo95ruST
	w4/oUwVMIxsQkKijQjq8oU4pdFBerxm1q8VmPdtbWipOdokVZDfuZZDn5y/bWKVlrO0m
	5o7sv2pzQSFHh0hXMxZNHP0a/0qUzr+tKy8yYgDmx6QS/MFrgAnJNn2Js1f0ElW+ZBUO
	OKYw==
X-Gm-Message-State: AOPr4FWQzeMieTXYZsmjmiEjce0Qyz8g9NxP+8QtRYE07gPgWrWfmt6rhRn9Yv5DRkTA/vPA
X-Received: by 10.194.92.237 with SMTP id cp13mr10164990wjb.168.1463062247173; 
	Thu, 12 May 2016 07:10:47 -0700 (PDT)
Received: from orion.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id u4sm13653360wjz.4.2016.05.12.07.10.46
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 12 May 2016 07:10:46 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 May 2016 15:10:38 +0100
Message-Id: <1463062238-12007-4-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1463062238-12007-1-git-send-email-michael.g.wood@intel.com>
References: <1463062238-12007-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 3/3] toaster: don't show "Rebuild" button for cancelled cli builds
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
X-List-Received-Date: Thu, 12 May 2016 14:10:47 -0000

From: Elliot Smith <elliot.smith@intel.com>

[YOCTO #8515]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/templates/mrb_section.html | 25 +++++++++++++----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/lib/toaster/toastergui/templates/mrb_section.html b/lib/toaster/toastergui/templates/mrb_section.html
index b5e798d..212998a 100644
--- a/lib/toaster/toastergui/templates/mrb_section.html
+++ b/lib/toaster/toastergui/templates/mrb_section.html
@@ -125,8 +125,6 @@
                       pull-right"
                       data-request-url="{% url 'xhr_buildrequest' build.project.pk %}"
                       data-target='{{build.target_set.all|get_tasks|json}}'>
-
-
                         Rebuild
                   </button>
               {% endif %}
@@ -144,7 +142,7 @@
     <div class="lead span3 progress-info"><span id="build-pc-done-{{build.pk}}">{{build.completeper}}</span>% of tasks complete</div>
     {# No build cancel for command line builds project #}
     {% if build.project.is_default %}
-    <i class="icon-question-sign get-help get-help-blue pull-right" title="" data-original-title="Builds in this project cannot be cancelled from Toaster: they can only be cancalled from the command line"></i>
+    <i class="icon-question-sign get-help get-help-blue pull-right" title="" data-original-title="Builds in this project cannot be cancelled from Toaster: they can only be cancelled from the command line"></i>
     {% else %}
     <div class="lead pull-right progress-info">
       <button class="cancel-build-btn btn btn-info pull-right"
@@ -158,15 +156,20 @@
     {%endif%} {# end if in progress #}
 
     {% if build.outcome == build.CANCELLED %}
-    <div class="span4">
-      <p class="lead">Build cancelled</p>
-    </div>
-    <button class="btn btn-info pull-right run-again-btn"
-        data-request-url="{% url 'xhr_buildrequest' build.project.pk %}"
-        data-target='{{build.target_set.all|get_tasks|json}}'>
-      Rebuild
+      <div class="span4">
+        <p class="lead">Build cancelled</p>
+      </div>
 
-    </button>
+      {% if build.project.is_default %}
+        <i class="icon-question-sign get-help get-help-blue pull-right" title=""
+          data-original-title="Builds in this project cannot be rebuilt from Toaster: they can only be rebuilt from the command line"></i>
+      {% else %}
+        <button class="btn btn-info pull-right run-again-btn"
+                data-request-url="{% url 'xhr_buildrequest' build.project.pk %}"
+                data-target='{{build.target_set.all|get_tasks|json}}'>
+          Rebuild
+        </button>
+      {% endif %}
     {% endif %}
   </div>
 </div>
-- 
2.7.4


