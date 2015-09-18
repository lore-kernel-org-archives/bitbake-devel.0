Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f176.google.com (mail-wi0-f176.google.com
	[209.85.212.176])
	by mail.openembedded.org (Postfix) with ESMTP id 6B5AE73243
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Sep 2015 14:46:41 +0000 (UTC)
Received: by wiclk2 with SMTP id lk2so34151225wic.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Sep 2015 07:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=ITTxNJvzrSpSfm+T2FUhQMQ4EWZBgoU/v/Idbr5WyR4=;
	b=ffLEcXzgyFM6G9zkFFd2TuQTdk77JpN9F8xjSN/MOjlCIipnNq0XluZeBPP3McugFE
	ztHZPEGwuYreS1WE/NsdMiPoO0nz6IlJWCUxU0XFbEB8Lo0a2mWT99tBX9CmG1OKB0a8
	yk5aewJ99O+pf7GWervzENw8fO0SrqoYh8m0m5f9AckyPSMXRtGvlRXeKyY6yRSJM2GC
	xhC3iERhkUgl20q9bxYVnb2e+ngiQ9Oz52+Ld6XaYD/2YrsUm3ed5tTJXaQaSRcB2AL3
	6elZQ90lrrRW6ih7Zx91w7AVFKRDQpW0ySgE0Orwlv1vA3/j7PAKi/PQNFphx4c7NnLZ
	N3tg==
X-Gm-Message-State: ALoCoQkDfBpRyxI3I6KPI44K96Q4W93no6CKzXffdywm9EMPbxNz4KaJRZM26DrEBAePn5eJ/+NP
X-Received: by 10.194.21.199 with SMTP id x7mr8207259wje.63.1442587601714;
	Fri, 18 Sep 2015 07:46:41 -0700 (PDT)
Received: from dorado.Home ([90.212.179.178]) by smtp.gmail.com with ESMTPSA id
	qq4sm9225676wjc.14.2015.09.18.07.46.40
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 18 Sep 2015 07:46:40 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 18 Sep 2015 15:46:28 +0100
Message-Id: <1442587588-5720-1-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH] toaster: start script warning text formatting small improvement
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
X-List-Received-Date: Fri, 18 Sep 2015 14:46:43 -0000

From: Cristian Iorga <cristian.iorga@intel.com>

Add a carriage return to build environment warning message to
avoid it being  mixed up with shell prompt.

Signed-off-by: Cristian Iorga <cristian.iorga@intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 bin/toaster | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/toaster b/bin/toaster
index 411ce2c..ac27826 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -197,7 +197,7 @@ if [ `basename \"$0\"` = `basename \"${SRCFILE}\"` ]; then
     fi
 
     if [ -n "$BUILDDIR" ]; then
-        printf "Error: It looks like you sourced oe-init-build-env. Toaster cannot start in build mode from an oe-core build environment.\n You should be starting Toaster from a new terminal window." 1>&2
+        printf "Error: It looks like you sourced oe-init-build-env. Toaster cannot start in build mode from an oe-core build environment.\n You should be starting Toaster from a new terminal window.\n" 1>&2
         exit 1
     fi
 
-- 
2.1.4


