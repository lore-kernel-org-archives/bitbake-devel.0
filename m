Return-Path: <michael.g.wood@intel.com>
Received: from mail-wg0-f49.google.com (mail-wg0-f49.google.com [74.125.82.49])
	by mail.openembedded.org (Postfix) with ESMTP id 68EC3607BB
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  2 Jul 2015 16:58:28 +0000 (UTC)
Received: by wgjx7 with SMTP id x7so68314567wgj.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 02 Jul 2015 09:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=fCWyLqywSVtuCmAFzyZe1AdkYAchyqrcKe/1W7AqO9A=;
	b=DMbHqZSDAm4boEOw6f0TnSFv7q65pbSVhoYg/vI5zuHO5h9eCuC3v5olp5HYaFYiza
	t5TqG0iN/nLc00gVFZyV4PBEbRYNaXS3x0VEpTysVq8/ewiS+M7uW3KwveOo4f7zwpwb
	1jz87udG1z5zLlyp0RvR45tFBi6yPhmVAiBgWp7oojeVZ34ExFx3uTliARx39jfnHBFM
	2j75dWKqxSF+FnvLxwxdbr3mC5HHuw3+G60G52UwGEEWqzxgL0OTXiUmRI+4v2Niho3X
	HNpvomgHrKEiCPtpKqcySYWWpGjkzL40yueLU/fAYLWuVxycmwNu/msln6JJuO5J879W
	BI+Q==
X-Gm-Message-State: ALoCoQmM7yIqh4RzMjQRzoQVAu4D/3Y+2TpUKfCUNWhMgYjdNPJgr+00rFwlEF1gjBnKHP8IJ9SR
X-Received: by 10.194.78.110 with SMTP id a14mr63802762wjx.87.1435856308895;
	Thu, 02 Jul 2015 09:58:28 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id ka7sm9007084wjc.36.2015.07.02.09.58.28
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 02 Jul 2015 09:58:28 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  2 Jul 2015 17:58:14 +0100
Message-Id: <1435856296-12531-4-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1435856296-12531-1-git-send-email-michael.g.wood@intel.com>
References: <1435856296-12531-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 3/5] bitbake: toaster: Remove erroneously committed template include
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
X-List-Received-Date: Thu, 02 Jul 2015 16:58:29 -0000

Partial revert of bb commit 6e46e1e3882b9770872d8a0bb459bc7d5d6bfed3

The non managed mrb_section defined the title 'All builds' which is already
defined correctly for the projects page as 'All projects'

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 bitbake/lib/toaster/toastergui/templates/projects.html | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/bitbake/lib/toaster/toastergui/templates/projects.html b/bitbake/lib/toaster/toastergui/templates/projects.html
index e651953..efc3349 100644
--- a/bitbake/lib/toaster/toastergui/templates/projects.html
+++ b/bitbake/lib/toaster/toastergui/templates/projects.html
@@ -7,9 +7,6 @@
 {% block pagecontent %}
 
 
-  {% include "mrb_section.html" %}
-
-
   <div class="page-header top-air">
       <h1>
       {% if request.GET.filter and objects.paginator.count > 0 or request.GET.search and objects.paginator.count > 0 %}
-- 
2.1.4


