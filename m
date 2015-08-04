Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
	[209.85.212.170])
	by mail.openembedded.org (Postfix) with ESMTP id F06C976541
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Aug 2015 15:07:41 +0000 (UTC)
Received: by wicgj17 with SMTP id gj17so154763920wic.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 04 Aug 2015 08:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=2W5qJ4KZcSQokc5YJwEm8h4EQqAJrEncRHiGBIY1Gw0=;
	b=c2SAh/p78aCgYGNs4M1qP0wFpkToE0PPd8zCn+TPO79FmEd+mwKfv5jestFimsESCc
	QnUpA5FH2/cvTtZIcagvJvSs99B9RMAaUKiGrzxzBFu8sv42lT3nbxk5j16EqEXZx/F0
	DeSJdRvqEnoXUdpLIwiOxTsUVB7zohbUuHnBv7AnKQpU4rqVQGYHJB99cx4UiAL3rmJo
	zHaa8B2jIIUYTd99+HhIRrh9dq8H30QarJl++AQOVjVsv5LgWPs8zIEE7K/ge2ZKY4FN
	/GpdEBl9GuwDzzPhB/cR4NzdWMy4hntenlWgX9ABZMf/PfNNVBp2qXqoet73aAcK4eS4
	w4IQ==
X-Gm-Message-State: ALoCoQmJb67Szytsux3BD2UFtXkhz6Azp+lieDE3du3MIW+dV7xwiXPCpiTR4dSdfz2EHwzdaJQ8
X-Received: by 10.180.108.19 with SMTP id hg19mr8873429wib.35.1438700861761;
	Tue, 04 Aug 2015 08:07:41 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id
	gm20sm2314260wjc.17.2015.08.04.08.07.40
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 04 Aug 2015 08:07:41 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  4 Aug 2015 16:07:10 +0100
Message-Id: <1438700831-26829-5-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1438700831-26829-1-git-send-email-michael.g.wood@intel.com>
References: <1438700831-26829-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 5/6] bitbake: toastergui: fix spacing in the import layers page
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
X-List-Received-Date: Tue, 04 Aug 2015 15:07:42 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

Adjust the space between the first fieldset and the tabs,
and the help text and the first form field.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/templates/importlayer.html | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/toastergui/templates/importlayer.html b/lib/toaster/toastergui/templates/importlayer.html
index bec5f1a..ce3d724 100644
--- a/lib/toaster/toastergui/templates/importlayer.html
+++ b/lib/toaster/toastergui/templates/importlayer.html
@@ -26,7 +26,7 @@
                   </script>
 
                 <form class="span11">
-                   <fieldset class="air">
+                   <fieldset>
                       <legend>Layer repository information</legend>
                       <span class="help-block">The layer you are importing must be compatible with <strong>{{project.release.description}}</strong>, which is the release you are using in this project.</span>
                       <div class="alert alert-error" id="import-error" style="display:none">
@@ -37,7 +37,7 @@
                       </div>
 
                       <div class="control-group" id="layer-name-ctrl">
-                        <label class="control-label" for="import-layer-name">
+                        <label class="control-label air" for="import-layer-name">
                             Layer name
                             <span class="icon-question-sign get-help" title="Something like 'meta-mylayer'. Your layer name must be unique and can only include letters, numbers and dashes"></span>
                         </label>
-- 
2.1.4


