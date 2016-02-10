Return-Path: <michael.g.wood@intel.com>
Received: from mail-pf0-f172.google.com (mail-pf0-f172.google.com
	[209.85.192.172])
	by mail.openembedded.org (Postfix) with ESMTP id AB1A3731BA
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Feb 2016 00:05:20 +0000 (UTC)
Received: by mail-pf0-f172.google.com with SMTP id e127so2024687pfe.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 09 Feb 2016 16:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=irtQPCoTQPU0XMLw7YXFhMlto9vmKpMpd56EqR8Ym0E=;
	b=CAvbOc2wnEOHoSmtfUZ0CqzOf5xyzWEIQ3/YTNr61rIVyKcAdcKRyDrxJwEPV98DeQ
	V/kejc2/K3ipR/kViDGfm6FxJBPS+OsF+jPHEZXvi4X2vMxDkp3c/4VCPoCFya5h9oep
	OVjtf+fcf4pabqwKD4ULmUJ9+JUeVNNbc1/MyM8gDATAcbkrcNQiM35Zx7MhGthvHAxd
	ti1jtinvHgYN87XCBn0LLN0izmBgxApFvj+QHnvsyAk/Y8yiGzXHQWX8G3Qytr17DWiK
	32d0ZoB0hts/9HbbpCFFZMApwt0cKb/6mwKAYq/UgXM0Qv2rXCGUkeLcfSG2h37bis/F
	LBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=irtQPCoTQPU0XMLw7YXFhMlto9vmKpMpd56EqR8Ym0E=;
	b=SGnKgg3J7CbVO2k7j2kfW6AeDeME36KLBaF18vC5M5gonDUKXrkTPWTh+On3AMBBAd
	prw6q5Saa/sKhuzEH3WM88aakonFNcIDyEhWQmpcc3wXpsb8rXhl+X/iIpxrk4WrvkbI
	yeMtswivnl+XcXJlvRpLiMzAIYTHOb4UDLFz+N7D+X7grYR+2wleQvgevhyyPu93GZhh
	kQ5Kfe4hPWF4cw3I8BKVNH8J6nNOE7OsjQV9Zyh/g/lSMOjKheUMCsGJi2sAijXhGjWn
	Hx5Zmbo39fdIReLyZO1tJ0ptwIYqCnxsAhZ7nlcRolXejRsNZXwbpXcgOWmLdTMvUj8R
	JwkA==
X-Gm-Message-State: AG10YOQCQq0wPcPMoGKwNeMYqLy1krcOupA0SCTQG1aT+MPN+kRwvKVZ3MyNTy/5V7zzbv8N
X-Received: by 10.98.0.194 with SMTP id 185mr16720488pfa.139.1455062721261;
	Tue, 09 Feb 2016 16:05:21 -0800 (PST)
Received: from dorado.ger.corp.intel.com ([192.55.54.40])
	by smtp.gmail.com with ESMTPSA id 82sm345777pfn.89.2016.02.09.16.05.19
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 09 Feb 2016 16:05:20 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 10 Feb 2016 00:05:07 +0000
Message-Id: <1455062707-14501-2-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1455062707-14501-1-git-send-email-michael.g.wood@intel.com>
References: <1455062707-14501-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 2/2] toaster: build section Improve display of builds when > 1 targets
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
X-List-Received-Date: Wed, 10 Feb 2016 00:05:20 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

* Display always the first target in alphabetical order to match what we
do in the breadcrumbs and the build dashboard heading

* Remove the extra space between the '+' and the additional number of
targets

* Make sure the tooltip with the full target list takes the Bootstrap
tooltip styles

* Replace the word 'targets' in the tooltip with 'recipes', since that's
how we call build targets everywhere else in Toaster

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/js/libtoaster.js    |  8 ++++++--
 lib/toaster/toastergui/templates/mrb_section.html | 11 ++++++-----
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/libtoaster.js b/lib/toaster/toastergui/static/js/libtoaster.js
index 1012034..a370051 100644
--- a/lib/toaster/toastergui/static/js/libtoaster.js
+++ b/lib/toaster/toastergui/static/js/libtoaster.js
@@ -443,8 +443,12 @@ $(document).ready(function() {
         $('.tooltip').hide();
     });
 
-    // enable help information tooltip
-    $(".get-help").tooltip({container:'body', html:true, delay:{show:300}});
+    /* Initialise bootstrap tooltips */
+    $(".get-help, [data-toggle=tooltip]").tooltip({
+      container : 'body',
+      html : true,
+      delay: { show : 300 }
+    });
 
     // show help bubble only on hover inside tables
     $(".hover-help").css("visibility","hidden");
diff --git a/lib/toaster/toastergui/templates/mrb_section.html b/lib/toaster/toastergui/templates/mrb_section.html
index 2f4820c..d1d52ef 100644
--- a/lib/toaster/toastergui/templates/mrb_section.html
+++ b/lib/toaster/toastergui/templates/mrb_section.html
@@ -38,8 +38,9 @@
             {% if build.target_set.all.count > 0 %}
                 <span data-toggle="tooltip"
                   {% if build.target_set.all.count > 1 %}
-                    title="Targets:
-                    {% for target in build.target_set.all %}
+                    {{build.get_sorted_target_list.0.target}}
+                    title="Recipes:
+                    {% for target in build.get_sorted_target_list %}
                         {% if target.task %}
                             {{target.target}}:{{target.task}}
                         {% else %}
@@ -49,12 +50,12 @@
                   {% endif %}
                 >
                 {% if build.target_set.all.0.task %}
-                    {{build.target_set.all.0.target}}:{{build.target_set.all.0.task}}
+                    {{build.get_sorted_target_list.0.target}}:{{build.target_set.all.0.task}}
                 {% else %}
-                    {{build.target_set.all.0.target}}
+                    {{build.get_sorted_target_list.0.target}}
                 {% endif %}
                 {% if build.target_set.all.count > 1 %}
-                    (+ {{build.target_set.all.count|add:"-1"}})
+                    (+{{build.target_set.all.count|add:"-1"}})
                 {% endif %}
                 </span>
              {% endif %}
-- 
2.5.0


