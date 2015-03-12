Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f178.google.com (mail-we0-f178.google.com
	[74.125.82.178])
	by mail.openembedded.org (Postfix) with ESMTP id 803B973B64
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2015 10:46:53 +0000 (UTC)
Received: by wesx3 with SMTP id x3so15429554wes.4
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2015 03:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=0Dj8YSiKDLi0dw8b2/vNV26Nv1r45UaQXEe8cJqlINI=;
	b=lmxMO0PN+/dx4t150AcLU0WOyUZDJ5V21QibIJ1z/qgNMmZZqwHYeFqqkJXA8rWs89
	kgVcjYMqa1CvJO5+Mq5bg/YcH5Rh9NFnLQ7qnu8wlcnUuJ86OSYShHkxdNX/Tqtz3N6K
	Nj2UFQ9lPWPjzMdWLTXp4SdPPT6JnAGLLqr3aPsYqUm763SuHRq0vnGWKs1qa4PKKkvo
	rVKQxUj5DuJjwk9+ZnbsQPjxNP1jwhaipExLmVkKWqjOhCvjMs1RnRYdnz8pPRqi5TO4
	qTikrHWq3GjWnPz4g03+sGj55VR0KND98ooibBJbE1GqLahRI+2KdA9jmvagEVCBDdip
	Vxjw==
X-Gm-Message-State: ALoCoQnNKaV0o65Vs16mIZ3nUqAWQuxsaYuK01EcSEIFa+Fg9vB9QFENZ5w4D24wf3Ja81dWhxn2
X-Received: by 10.180.24.233 with SMTP id x9mr16107740wif.9.1426157214744;
	Thu, 12 Mar 2015 03:46:54 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	lx10sm9438913wjb.17.2015.03.12.03.46.51
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 12 Mar 2015 03:46:54 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 778875627A7; Thu, 12 Mar 2015 10:46:51 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 Mar 2015 10:46:48 +0000
Message-Id: <fb0092cc008b7e90b6d3807e93f98405d92d8b46.1426156963.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <7f2019767b07ed0e1e4b831d2ec10f0708ef1f2f.1426156963.git.alexandru.damian@intel.com>
References: <7f2019767b07ed0e1e4b831d2ec10f0708ef1f2f.1426156963.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1426156963.git.alexandru.damian@intel.com>
References: <cover.1426156963.git.alexandru.damian@intel.com>
Subject: [PATCH 15/17] toastergui: replace ETA with percentage
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
X-List-Received-Date: Thu, 12 Mar 2015 10:46:56 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

We replace the ETA (which was an inaccurate estimation)
with the percentage of completed tasks.

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/templates/managed_mrb_section.html | 2 +-
 lib/toaster/toastergui/templates/project.html             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/templates/managed_mrb_section.html b/lib/toaster/toastergui/templates/managed_mrb_section.html
index edaa08e..51610e4 100644
--- a/lib/toaster/toastergui/templates/managed_mrb_section.html
+++ b/lib/toaster/toastergui/templates/managed_mrb_section.html
@@ -64,7 +64,7 @@
                     <div style="width: {{build.completeper}}%;" class="bar"></div>
                 </div>
             </div>
-            <div class="lead pull-right">ETA: in {{build.eta|naturaltime}}</div>
+            <div class="lead pull-right">{{build.completeper}}% tasks completed</div>
     {%endif%}
         </div>
     </div>
diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index f4a3a75..badc8a6 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -202,7 +202,7 @@ vim: expandtab tabstop=2
                       <div style="width: {[b.build[0].completeper]}%;" class="bar"></div>
                   </div>
                 </div>
-                <div class="text-right lead">ETA in {[b.build[0].eta|toeta|timediff]}</div>
+                <div class="text-right lead">{[b.build[0].completeper]}% tasks completed</div>
               </case>
           </case>
 
-- 
1.9.1


