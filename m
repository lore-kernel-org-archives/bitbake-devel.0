Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
	[209.85.220.45])
	by mail.openembedded.org (Postfix) with ESMTP id 994BC7701C
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Sep 2015 04:44:02 +0000 (UTC)
Received: by pablk4 with SMTP id lk4so97503718pab.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Sep 2015 21:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:in-reply-to:references;
	bh=VcDowU9Ke4WaDsYV2NQW77hI6V7pO/k2fb91RZ7J7pM=;
	b=hCk0027jQUpwG9PqzvvjSxnGl2htguRovP4ES/GPY6ZIVkMClebodToL8le0Gtf1DD
	ywoA1VkGSrRuKner8OBzVAlGAWBxtvCFS6Lp17DE+ji0DwsfSfRg1fDuLkAVFzOlaUK6
	A0N5BNohb9pVOztT/7Ar2wR+BrykHHuWQr7aYi+j42rMQZTTsxmG5BUaoFmyDuRRMmVJ
	XNgPo9YYa7GextVzjuSRtbZOqHgUpMcw4e94+m0egUs8qbfN0KK1iqutL4kFWMIrI8Hv
	a0GxacrayV+W9DuaexH7aOaVJ6MfqhyO7VqlvEM3nlB3bxoF8gA0cqhhLzyit4u5JT2X
	AT7A==
X-Received: by 10.67.22.196 with SMTP id hu4mr30416982pad.20.1443501842723;
	Mon, 28 Sep 2015 21:44:02 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	g5sm22686368pat.21.2015.09.28.21.44.01
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 28 Sep 2015 21:44:02 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 28 Sep 2015 21:45:19 -0700
Message-Id: <d56f819335a53f8270cd81c297820d1d94e24d03.1443497922.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <8b0eb0f272c0658ba98db30c17a688f87c75d134.1443497922.git.avery.brian@gmail.com>
References: <8b0eb0f272c0658ba98db30c17a688f87c75d134.1443497922.git.avery.brian@gmail.com>
In-Reply-To: <cover.1443497922.git.avery.brian@gmail.com>
References: <cover.1443497922.git.avery.brian@gmail.com>
Subject: [PATCH 09/22] toaster: add toggle for enabling image customisation feeature
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
X-List-Received-Date: Tue, 29 Sep 2015 04:44:02 -0000

From: Michael Wood <michael.g.wood@intel.com>

This feature is currently under heavy development and should be used
with caution.

Signed-off-by: Michael Wood <michael.g.wood@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/toaster/toastergui/views.py     | 1 +
 lib/toaster/toastermain/settings.py | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index 8689a12..2e3b822 100755
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -1867,6 +1867,7 @@ def managedcontextprocessor(request):
     ret = {
         "projects": Project.objects.all(),
         "DEBUG" : toastermain.settings.DEBUG,
+        "CUSTOM_IMAGE" : toastermain.settings.CUSTOM_IMAGE,
         "TOASTER_BRANCH": toastermain.settings.TOASTER_BRANCH,
         "TOASTER_REVISION" : toastermain.settings.TOASTER_REVISION,
     }
diff --git a/lib/toaster/toastermain/settings.py b/lib/toaster/toastermain/settings.py
index b149a5e..6439d68 100644
--- a/lib/toaster/toastermain/settings.py
+++ b/lib/toaster/toastermain/settings.py
@@ -23,6 +23,11 @@
 
 import os, re
 
+# Temporary toggle for Image customisation
+CUSTOM_IMAGE = False
+if os.environ.get("CUSTOM_IMAGE", None) is not None:
+    CUSTOM_IMAGE = True
+
 DEBUG = True
 TEMPLATE_DEBUG = DEBUG
 
-- 
1.9.1


