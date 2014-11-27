Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
	[209.85.212.169])
	by mail.openembedded.org (Postfix) with ESMTP id 488897239D
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Nov 2014 17:08:09 +0000 (UTC)
Received: by mail-wi0-f169.google.com with SMTP id r20so18921177wiv.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Nov 2014 09:08:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=4LB1KzTWY6yDD+cXdxmXbHVsH8YorsZYSNTP1pjKAY4=;
	b=kcpVn/lNv0VY5mgIK63xEJaGE+TOAycDtictZdk/uVyECRzGve4uEU4nA3S1VG7pym
	m6taXj3UchKbBop3b5OaVASHYdNrtzXQut32tpyKaIDGj2A6OtN2pmgaDSOB+lQv/ApW
	TTwRaGW+uf/h4JjBJujugHBxG+TPWeGntA//f1cdwHcOV0FB+MSuX2Dg+S4q8X88um8R
	AZ+AlBZv2rCChY1++7EXEANE/RZK/fQWW38/NFWZii/V9e7pVU4Bt1hZZAndqhk+FEi8
	NMtHPPYMusNQPBzSrI8JYetL5jZxvUeBCdSmKGbH2OKZ5i64+KqgC1r9iyjzh8yN748t
	taKg==
X-Gm-Message-State: ALoCoQkr4YB1KKrhfJ5iY5L3VIpInsmVgWXkyAfwCKTYT44IrSl/30jzvpP5EgR4q6ejQ9A+DSFS
X-Received: by 10.194.92.176 with SMTP id cn16mr59445702wjb.62.1417108090331; 
	Thu, 27 Nov 2014 09:08:10 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id e7sm11505437wjx.31.2014.11.27.09.08.07
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 27 Nov 2014 09:08:07 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 01EA25604B7; Thu, 27 Nov 2014 17:08:06 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 27 Nov 2014 17:07:55 +0000
Message-Id: <86dced90db666aa73ebb7ebb48d64fc08f66e7e2.1417107946.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <9f3cf52b3a96768e5b9764dde02833b078fe61e4.1417107946.git.alexandru.damian@intel.com>
References: <9f3cf52b3a96768e5b9764dde02833b078fe61e4.1417107946.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1417107946.git.alexandru.damian@intel.com>
References: <cover.1417107946.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 04/14] toastergui: do not show project info in interactive mode
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
X-List-Received-Date: Thu, 27 Nov 2014 17:08:12 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

The most recent builds section showed the project name and the Run Again
buttons regardless whenever the Toaster was in interactive or managed
modes. These widgets have no meaning in interactive mode, and this
patch disables the widgets if toaster is not running in Managed mode.

[YOCTO #6776]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/templates/mrb_section.html | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/toastergui/templates/mrb_section.html b/lib/toaster/toastergui/templates/mrb_section.html
index 586c47b..4237980 100644
--- a/lib/toaster/toastergui/templates/mrb_section.html
+++ b/lib/toaster/toastergui/templates/mrb_section.html
@@ -13,7 +13,7 @@
   <div id="latest-builds">
   {% for build in mru %}
     <div class="alert {%if build.outcome == build.SUCCEEDED%}alert-success{%elif build.outcome == build.FAILED%}alert-error{%else%}alert-info{%endif%}" style="padding-top: 0;">
-    {% if build.project %}
+    {% if MANAGED and build.project %}
        <span class="label {%if build.outcome == build.SUCCEEDED%}label-success{%elif build.outcome == build.FAILED%}label-danger{%else%}label-info{%endif%}" style="font-weight: normal; margin-bottom: 5px; margin-left:-15px; padding-top:5px;"> {{build.project.name}} </span>
     {% endif %}
 
@@ -40,10 +40,10 @@
       {% endif %}
             </div>
             <div class="lead ">
-              <span class="lead{%if not build.project%} pull-right{%endif%}">
+              <span class="lead{%if not MANAGED or not build.project%} pull-right{%endif%}">
                 Build time: <a href="{% url 'buildtime' build.pk %}">{{ build.timespent|sectohms }}</a>
               </span>
-          {% if build.project %}
+          {% if MANAGED and build.project %}
               <a class="btn {%if build.outcome == build.SUCCEEDED%}btn-success{%elif build.outcome == build.FAILED%}btn-danger{%else%}btn-info{%endif%} pull-right" onclick="scheduleBuild({% url 'xhr_projectbuild' build.project.id as bpi%}{{bpi|json}}, {{build.project.name|json}}, {{build.get_sorted_target_list|mapselect:'target'|json}})">Run again</a>
           {% endif %}
             </div>
-- 
1.9.1


