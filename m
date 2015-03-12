Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
	[74.125.82.179])
	by mail.openembedded.org (Postfix) with ESMTP id C862573943
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2015 10:46:54 +0000 (UTC)
Received: by wesw62 with SMTP id w62so15466432wes.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2015 03:46:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=TwnjvnXM2bUtM6wIjjvNtSK1hi+pbB/lUtd7K03oajU=;
	b=SK6mLdF2h85XNfWH4VNFEZN1SO9nnoAdV5Hpv/4LpQMdlqkmnPCR8mOCQ5IRHSaBjd
	Je8LbwiUPXQvCVcpDqoBpBoVHLTFDPRuAdx4EU/Sgut5itGbxxT38LUWBS8ACNIIk51h
	ajiHkJkHuRRjZXia0R7vM5C0rSo66AvyutR4qOPrT6SEPHV7DPd0+PGFmRLdA4QgfO/F
	X2KzPMLA+Z+TdtRqxnNURGPwgi7S2rKGTDmQTDBGVNioBR/rkWKMBhSX1eXo0b/DxCFV
	OYsnDfEuNXqAcJBTpK6UsQvywP+CLtxYW2rDxbeXdXjJNGX/kknSeSZhBlO20lT5wZRb
	JJTw==
X-Gm-Message-State: ALoCoQkc5DakVhxlkIBbFDQx2TtwKAa26Nj5JVMgkmNtKKlcV4TO9FHUBQw/6C5dPR1bzusXCII0
X-Received: by 10.194.192.167 with SMTP id hh7mr86651131wjc.151.1426157215035; 
	Thu, 12 Mar 2015 03:46:55 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	gt4sm10081728wib.21.2015.03.12.03.46.51
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 12 Mar 2015 03:46:54 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 75FB1562760; Thu, 12 Mar 2015 10:46:51 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 Mar 2015 10:46:47 +0000
Message-Id: <a7c4c92e67bffb57397c489a18987842c64bc408.1426156963.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <7f2019767b07ed0e1e4b831d2ec10f0708ef1f2f.1426156963.git.alexandru.damian@intel.com>
References: <7f2019767b07ed0e1e4b831d2ec10f0708ef1f2f.1426156963.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1426156963.git.alexandru.damian@intel.com>
References: <cover.1426156963.git.alexandru.damian@intel.com>
Subject: [PATCH 14/17] toastergui: fix mrb Run again buttons
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
X-List-Received-Date: Thu, 12 Mar 2015 10:46:55 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

The button for error-ed builds had invalid javascript markup,
this patch fixes the buttons.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/templates/managed_mrb_section.html | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/toastergui/templates/managed_mrb_section.html b/lib/toaster/toastergui/templates/managed_mrb_section.html
index d6e32f8..edaa08e 100644
--- a/lib/toaster/toastergui/templates/managed_mrb_section.html
+++ b/lib/toaster/toastergui/templates/managed_mrb_section.html
@@ -54,8 +54,7 @@
                 Build time: <a href="{% url 'buildtime' build.pk %}">{{ build.timespent|sectohms }}</a>
               </span>
           {% if build.project %}
-              <button class="btn {%if build.outcome == build.SUCCEEDED%}btn-success{%elif build.outcome == build.FAILED%}btn-danger{%else%}btn-info{%endif%} pull-right" onclick='scheduleBuild({% url 'xhr_projectbuild' build.project.id as bpi%}{{bpi|json}}, {{build.project.name|json}},
-{% url 'project' buildrequest.project.id as bpurl%}{{bpurl|json}}, {{build.get_sorted_target_list|mapselect:'target'|json}})'>Run again</button>
+              <button class="btn {%if build.outcome == build.SUCCEEDED%}btn-success{%elif build.outcome == build.FAILED%}btn-danger{%else%}btn-info{%endif%} pull-right" onclick='scheduleBuild({% url 'xhr_projectbuild' build.project.id as bpi%}{{bpi|json}}, {{build.project.name|json}}, {% url 'project' buildrequest.project.id as bpurl%}{{bpurl|json}}, {{build.get_sorted_target_list|mapselect:'target'|json}})'>Run again</button>
           {% endif %}
             </div>
     {%endif%}
@@ -105,7 +104,7 @@
               <span class="lead{%if not MANAGED or not buildrequest.project%} pull-right{%endif%}">
                 Build time: {{ buildrequest.get_duration|sectohms }}
               </span>
-              <button class="btn btn-danger pull-right" onclick='scheduleBuild({% url 'xhr_projectbuild' buildrequest.project.id as bpi%}{{bpi|json}},  {{buildrequest.project.name|json}}, {% url 'project' buildrequest.project.id as bpurl%}|{{bpurl|json}}, {{buildrequest.get_sorted_target_list|mapselect:'target'|json}})'>Run again</button>
+              <button class="btn btn-danger pull-right" onclick='scheduleBuild({% url 'xhr_projectbuild' buildrequest.project.id as bpi%}{{bpi|json}},  {{buildrequest.project.name|json}}, {% url 'project' buildrequest.project.id as bpurl%}{{bpurl|json}}, {{buildrequest.get_sorted_target_list|mapselect:'target'|json}})'>Run again</button>
 
             </div>
 
-- 
1.9.1


