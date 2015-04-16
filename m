Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f172.google.com (mail-wi0-f172.google.com
	[209.85.212.172])
	by mail.openembedded.org (Postfix) with ESMTP id 69EE373D54
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Apr 2015 14:47:42 +0000 (UTC)
Received: by widdi4 with SMTP id di4so197757395wid.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Apr 2015 07:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=SL+KKc2IsGqpcprUq/gjNt7zu7N/akmDyfulJyHIKCU=;
	b=M30wl5bwc8GJvs3xj2WR/TXf0MsNe05plQ4eW0qLHi/aLJ2r6W98iQoFi8TiuK9x3q
	J3YfEs0eGPvh1kyNlAUaCICb8bM8ORm1AihvL9yR9aZln+NPgw9DNFg5wdIGgASoo5Cp
	m/7CfGs1pv2mPO/VYR9c3bOL7xSDMKcHB4JUWDZlqFUdKDDzY8HG6i+G8NK+CbOUQE+P
	DBj11zzd72qXaY/7GeB2oY4ZaA7DtqzTSFzqOdY1K0//6wgQAc/N1kG2sULvAc4C2jg4
	5oWbM81CnFETIkCT4DNsRvX1GrG/Fg1CK1AV1CThgzrCjAeRCH4VndlD8OQyaSMSdlXL
	1IFA==
X-Gm-Message-State: ALoCoQnk3ZX+X7K1b990PnYwo0JOg6T/0CNtMX07NsWwvQGuMtRrp6cl0DR3trLnMyHicyrXZrMN
X-Received: by 10.194.174.225 with SMTP id bv1mr61546979wjc.101.1429195663770; 
	Thu, 16 Apr 2015 07:47:43 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	i13sm26366254wic.13.2015.04.16.07.47.41
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 Apr 2015 07:47:41 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id BD53C560A82; Thu, 16 Apr 2015 15:47:41 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 16 Apr 2015 15:47:35 +0100
Message-Id: <7e89a57e2dba7a149c427d62519c8d3dc1c3f015.1429195580.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <e4e9f956e8370ba543578054ea7e889a9f689632.1429195580.git.alexandru.damian@intel.com>
References: <e4e9f956e8370ba543578054ea7e889a9f689632.1429195580.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1429195580.git.alexandru.damian@intel.com>
References: <cover.1429195580.git.alexandru.damian@intel.com>
Subject: [PATCH 2/8] toaster: BuildButton target input allow building targets with tasks
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
X-List-Received-Date: Thu, 16 Apr 2015 14:47:43 -0000

From: Michael Wood <michael.g.wood@intel.com>

Allow the input for targets to contain tasks in the form target:task

[YOCTO #7501]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/js/base.js | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/toaster/toastergui/static/js/base.js b/lib/toaster/toastergui/static/js/base.js
index 241c5d2..667c5df 100644
--- a/lib/toaster/toastergui/static/js/base.js
+++ b/lib/toaster/toastergui/static/js/base.js
@@ -88,10 +88,9 @@ function basePageInit (ctx) {
       if (!newBuildTargetInput.val())
         return;
 
-      if (!selectedTarget)
-        selectedTarget = { name: newBuildTargetInput.val() };
+      var selectedTargetName = newBuildTargetInput.val();
       /* fire and forget */
-      libtoaster.startABuild(ctx.projectBuildUrl, ctx.projectId, selectedTarget.name, null, null);
+      libtoaster.startABuild(ctx.projectBuildUrl, ctx.projectId, selectedTargetName, null, null);
       window.location.replace(ctx.projectPageUrl+ctx.projectId);
     });
 
-- 
1.9.1


