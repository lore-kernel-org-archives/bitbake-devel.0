Return-Path: <raj.khem@gmail.com>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
	[209.85.220.43])
	by mail.openembedded.org (Postfix) with ESMTP id 0852860657
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 24 Oct 2015 21:56:37 +0000 (UTC)
Received: by pasz6 with SMTP id z6so149165684pas.2
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 24 Oct 2015 14:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=K+zkl59CFR9GmGv+yMWs67DDZbuNt/y7hAVJ1M+MZrU=;
	b=R5HeP6XPkTdm67FQZtGHiMNqZUok99lDZcXURN4vdimUZlXZyymDa97N+bk46Rdxbo
	z9sXPmJaO7Tpg4EDOcewiLwq8cSNmgh21mwpmKXLH4WdHKgWIyvPqu9FbxVxrw5y1rVM
	sYcib7oiJYpZJ/bZNUK7+z/cm2gRgGLTKoV5ssAWuPms52APbtRjSfnrSPrfdUk17ycn
	+kkpO7uuTj6YfiASbeYO7m7YcjHa5pw3YML6s/JBxMlA6f0Uk0wOGgRoZvgZS/o3JX8Q
	4ktXLAjisOoUFld0MH17z58bko5oEIO6rl9uaSYe3ZIhksklJuppnBoBkYilNGucGS1h
	RalA==
X-Received: by 10.68.182.161 with SMTP id ef1mr13297095pbc.79.1445723797449;
	Sat, 24 Oct 2015 14:56:37 -0700 (PDT)
Received: from arch.hsd1.ca.comcast.net (c-76-103-142-85.hsd1.ca.comcast.net.
	[76.103.142.85]) by smtp.gmail.com with ESMTPSA id
	zi1sm25827955pbc.10.2015.10.24.14.56.35
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 24 Oct 2015 14:56:36 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 24 Oct 2015 14:56:29 -0700
Message-Id: <1445723789-7493-1-git-send-email-raj.khem@gmail.com>
X-Mailer: git-send-email 2.6.2
Subject: [PATCH] toaster: Point to meta/conf for default toasterconf.json
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
X-List-Received-Date: Sat, 24 Oct 2015 21:56:40 -0000

meta-yocto may not exist in nodistro env

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 bin/toaster | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/toaster b/bin/toaster
index 2c3432c..c1a01f0 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -196,7 +196,7 @@ fi
 # in the local layers that currently prevent using an arbitrary
 # toasterconf.json
 if [ "$TOASTER_CONF" = "" ]; then
-    TOASTER_CONF="$(dirname $TOASTER)/../../meta-yocto/conf/toasterconf.json"
+    TOASTER_CONF="$(dirname $TOASTER)/../../meta/conf/toasterconf.json"
     export TOASTER_CONF=$(python -c "import os; print os.path.realpath('$TOASTER_CONF')")
 fi
 if [ ! -f $TOASTER_CONF ]; then
-- 
2.6.2


