Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
	by mail.openembedded.org (Postfix) with ESMTP id ADF9873569
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Feb 2015 17:53:29 +0000 (UTC)
Received: by mail-wg0-f51.google.com with SMTP id y19so30737430wgg.10
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Feb 2015 09:53:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=koqnJ2+QQRQ3PwHOnFwdzf39pYyzJUz2tTRmKXsuHu0=;
	b=dMpsbMa8OZgTBuUR35utLJQccpH3+/yofAR5SfGjQcEjMiW6xvTcyELSbrFs76kgCC
	aBCXhFGYAs5onHRg1nOow9Ivx8lJltSvANQIvP8xXsjV6f3A+DjvZkSl7lAwuBSjI/8u
	Ah4zfsppCDbrNdRRd3TVoCYg9JEtqAh2sxDrVg7dTU5RP2c/oek6PPSj/FXjEPhh5jqP
	IjhJwbC/ch/O2n/fUuzkbIh88DCPJjRIygppxy78o1O8WMHfVtpeRCLlHPx3LZPXwH6q
	hUSnHvOroL0r+AMHp/Y67W6HbV8K5m0aOgrQg3cxHwy8gPB+yLXURgO1Mqh8/ElOArbe
	Zu9g==
X-Gm-Message-State: ALoCoQmvDIyfZ+FfHXrtlI8EDNQS3lC7JwR5TsxUx5dT5Qqx2hwsocawym9JIf8iGzpPgwEf8tm6
X-Received: by 10.194.110.233 with SMTP id id9mr53190969wjb.136.1424109210075; 
	Mon, 16 Feb 2015 09:53:30 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id hs7sm16668338wib.4.2015.02.16.09.53.28
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 16 Feb 2015 09:53:29 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id D15B75608A6; Mon, 16 Feb 2015 17:53:29 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 Feb 2015 17:53:22 +0000
Message-Id: <d753db7a18eb9218016e586171d2a08298a0b05d.1424108976.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <2060be8d31baa0cd302aa8dc0b6d179df853ee99.1424108976.git.alexandru.damian@intel.com>
References: <2060be8d31baa0cd302aa8dc0b6d179df853ee99.1424108976.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1424108976.git.alexandru.damian@intel.com>
References: <cover.1424108976.git.alexandru.damian@intel.com>
Subject: [PATCH 06/10] toaster: New build button allow arbitrary build targets
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
X-List-Received-Date: Mon, 16 Feb 2015 17:53:30 -0000

From: Michael Wood <michael.g.wood@intel.com>

Target input field needed to support both selecting suggestions and
typing targets, since Toaster doesn't always know about all the targets
provided by the layers in the project.

[YOCTO #7187]

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/toastergui/static/js/base.js | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/toaster/toastergui/static/js/base.js b/lib/toaster/toastergui/static/js/base.js
index 0302b80..777ab43 100644
--- a/lib/toaster/toastergui/static/js/base.js
+++ b/lib/toaster/toastergui/static/js/base.js
@@ -88,6 +88,8 @@ function basePageInit (ctx) {
       if (!newBuildTargetInput.val())
         return;
 
+      if (!selectedTarget)
+        selectedTarget = { name: newBuildTargetInput.val() };
       /* fire and forget */
       libtoaster.startABuild(ctx.projectBuildUrl, ctx.projectId, selectedTarget.name, null, null);
       window.location.replace(ctx.projectPageUrl+ctx.projectId);
-- 
1.9.1


