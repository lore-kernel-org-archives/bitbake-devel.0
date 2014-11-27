Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f45.google.com (mail-wg0-f45.google.com [74.125.82.45])
	by mail.openembedded.org (Postfix) with ESMTP id F2B3B723AA
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Nov 2014 17:08:13 +0000 (UTC)
Received: by mail-wg0-f45.google.com with SMTP id b13so6966267wgh.32
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Nov 2014 09:08:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=jTXSkINN5beImHvGarrM26TgWhBnNorljuZ27SgMu90=;
	b=Fs/2S+4AphJ72dFeiDLC4ucyXg7AEXQwrRYt+miWK4XgKhO1/WhQNarnbZJViTWoiK
	uX3+/BXCG1MlqUwY9D7gBPB8nwrQGRRBJZ2rN93wpq41qsaShDzl3qwCnBjpI1qcvlha
	vHQnVJ8KB/Ia7YI9ZwdDPAICwq67U8lJ2wjfLMaIs9MRABwBCgSslnb2AaGWhj8Ovk5F
	1XkuhevnQAirnigPoXU/K62nsmIRgMcLB02+H5O0GO98pLMeSFB2PuetCChOCXuoM0we
	nj9jxSoEl6rMYn6fthcMwPyFapjU3WYZV/skCQTo9MpLyHsX0YtE1DoxtR3Im9+83WC+
	6HSg==
X-Gm-Message-State: ALoCoQkjNmLiNR/JF35X7NpVOS87wWs7ZqSZcH0lIPWV4LvwAvjn3jNyHeIYMXdVLlwUfY6dwHwH
X-Received: by 10.194.150.148 with SMTP id ui20mr60408398wjb.90.1417108094046; 
	Thu, 27 Nov 2014 09:08:14 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id hs1sm26086627wib.1.2014.11.27.09.08.09
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 27 Nov 2014 09:08:10 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 0A5ED5641DA; Thu, 27 Nov 2014 17:08:07 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 27 Nov 2014 17:08:00 +0000
Message-Id: <3f6b33472820e339c0f057c2e30f25ec2a04366b.1417107946.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <9f3cf52b3a96768e5b9764dde02833b078fe61e4.1417107946.git.alexandru.damian@intel.com>
References: <9f3cf52b3a96768e5b9764dde02833b078fe61e4.1417107946.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1417107946.git.alexandru.damian@intel.com>
References: <cover.1417107946.git.alexandru.damian@intel.com>
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>,
	Belen Barros Pena <belen.barros.pena@linux.intel.com>
Subject: [PATCH 09/14] toaster: fix errors and warnings display
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

In the 'Latest builds' section of the project page,
show number of errors and number of warnings as we
show them in the all builds page.

Signed-off-by: Belen Barros Pena <belen.barros.pena@linux.intel.com>
Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/toaster/toastergui/templates/project.html | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/templates/project.html b/lib/toaster/toastergui/templates/project.html
index 18a52bf..0b2821c 100644
--- a/lib/toaster/toastergui/templates/project.html
+++ b/lib/toaster/toastergui/templates/project.html
@@ -178,8 +178,24 @@ vim: expandtab tabstop=2
                  {[b.build[0].completed_on|date:'dd/MM/yy HH:mm']}
               </ngif>
             </div>
-            <div class="span2"><span><a href="{[b.build[0].build_page_url]}#errors" class="lead error" ng-if="b.build[0].errors">{[b.build[0].errors]}</a></span></div>
-            <div class="span2"><span><a href="{[b.build[0].build_page_url]}#warnings" class="lead warning" ng-if="b.build[0].warnings">{[b.build[0].warnings]}</a></span></div>
+            <div class="span2">
+              <ngif ng-if="b.build[0].errors">
+                <span>
+                  <i class="icon-minus-sign red lead"></i>
+                  <a href="{[b.build[0].build_page_url]}#errors" class="lead error">{[b.build[0].errors]}
+                  <ng-pluralize count="b.build[0].errors" when="{'1':'error','other':'errors'}"></ng-pluralize></a>
+                </span>
+              </ngif>
+            </div>
+            <div class="span2">
+              <ngif ng-if="b.build[0].warnings">
+                <span>
+                  <i class="icon-warning-sign yellow lead"></i>
+                  <a href="{[b.build[0].build_page_url]}#warnings" class="lead warning">{[b.build[0].warnings]}
+                  <ng-pluralize count="b.build[0].warnings" when="{'1':'warning','other':'warnings'}"></ng-pluralize></a>
+                </span>
+              </ngif>
+            </div>
             <div> <span class="lead">Build time: <a href="{[b.build[0].build_time_page_url]}">{[b.build[0].build_time|timediff]}</a></span>
                 <button class="btn pull-right" ng-class="{'Succeeded':  'btn-success', 'Failed': 'btn-danger'}[b.build[0].status]"
                     ng-click="targetExistingBuild(b.targets)">Run again</button>
-- 
1.9.1


