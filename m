Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f172.google.com (mail-wi0-f172.google.com
	[209.85.212.172])
	by mail.openembedded.org (Postfix) with ESMTP id 1EEA47260C
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Dec 2014 15:12:21 +0000 (UTC)
Received: by mail-wi0-f172.google.com with SMTP id n3so11538573wiv.5
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Dec 2014 07:12:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=5ArIDNhf78mwjRkonnGMDvV3xh5cif3/AHg+fFBVby4=;
	b=JPk3pj0QJL3t9Iva2ZPgSKsQBgxqxEfDe20X2jBhbN8RF4YIN4qnJtJu5OJ/8jGCQW
	LY63/GNyvk/8hAGvqNLM7d7Wd+Jlcrf2eFT+aAzk3t6Ds+Kfrzz2VsD2RIkMEyeBqhCk
	ySNNjvgevm9b/7jqfNpCX10+mO2KzK27d2+rd9MzLw8uNBcaTP1oMECM3HGMJHoVRaCP
	ZrWBspCuugkyC6dq3Y+T9lzm6OYURauV0qpPnxbgcx8M4JMLBTTzv+w4DPoLIBvqquDi
	gr+swjan0mub6ip26zhABaroN7AAf6vpdcoovELW1l1Tt8JjrzMPtkmz0S3iHsqcZe2r
	WIMw==
X-Gm-Message-State: ALoCoQk1bCRhFFRB5wyCllXbBL/Pj89N1eS8dKynx3Ki8vy/xeBr6yubK4550fB14n0TtJ4wHUgo
X-Received: by 10.180.228.101 with SMTP id sh5mr13800500wic.62.1418224341606; 
	Wed, 10 Dec 2014 07:12:21 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id ce1sm6236603wjc.2.2014.12.10.07.12.19
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 10 Dec 2014 07:12:20 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 6D541564225; Wed, 10 Dec 2014 15:12:17 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 10 Dec 2014 15:12:11 +0000
Message-Id: <6c17f94dafad053e292705dbb646d9e24f19fb97.1418224064.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <879045f69bd20c11f83ed36f88482dd500d71592.1418224064.git.alexandru.damian@intel.com>
References: <879045f69bd20c11f83ed36f88482dd500d71592.1418224064.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1418224064.git.alexandru.damian@intel.com>
References: <cover.1418224064.git.alexandru.damian@intel.com>
Subject: [PATCH 06/11] toaster: base Only show change project icon when > one project
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
X-List-Received-Date: Wed, 10 Dec 2014 15:12:23 -0000

From: Belen Barros Pena <belen.barros.pena@intel.com>

In the new build button, it only makes sense to change
the selected project when there is more than one project
in the Toaster instance. If the number of projects is 1,
we hide the change project icon.

Signed-off-by: Belen Barros Pena <belen.barros.pena@intel.com>
---
 lib/toaster/toastergui/static/js/base.js | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/toaster/toastergui/static/js/base.js b/lib/toaster/toastergui/static/js/base.js
index fac59e6..619ad28 100644
--- a/lib/toaster/toastergui/static/js/base.js
+++ b/lib/toaster/toastergui/static/js/base.js
@@ -11,6 +11,10 @@ function basePageInit (ctx) {
       return;
   }
 
+  /* Hide the change project icon when there is only one project */
+  if (ctx.numProjects == 1){
+     $('#project .icon-pencil').hide(); 
+  }
 
   newBuildButton.show().removeAttr("disabled");
 
-- 
1.9.1


