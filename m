Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
	by mail.openembedded.org (Postfix) with ESMTP id 7D18977194
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Apr 2016 16:47:24 +0000 (UTC)
Received: by mail-wm0-f54.google.com with SMTP id f198so81802880wme.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 06 Apr 2016 09:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
	:references; bh=IC9qkYjc7PbZnSlIHkb81G6s3851mB2T+R5s0lYs36M=;
	b=VBpPEY/KyXic+B3yPQZWryuhLJ0FtqHhExRHCU7MH9aYE43M4L4CxHplKi62oKoPNa
	R350AkYyIA0AwUzLiR6MZuFXwQJ02Nr4nv2KyWuaoZSBydbwzw+9ZzXt9Hf5q2C/wYqc
	MwSvqjACqScS+M2NwZ9psjid5Td7AGZjoD1lQobVuAw50VzvbqsJNBOw0CvTSE94PRsQ
	JVv38EOF/FI3TmfTyk/10qJG5mSKJF7Ux/KzPNU6xPIr5/jTZ3Hn6BVBhBETakFR/z5X
	tSHtG8IWkJdXB0tzZcvfJO2cWD3AaF+QBCuvGkKuVHYgn1S5DpqQpcueaga3sU89FHbV
	fWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=IC9qkYjc7PbZnSlIHkb81G6s3851mB2T+R5s0lYs36M=;
	b=UpnWqq751DzXKZ6NzRYLX/R8Jj6f774tY0oHwwfbKDaPzajuatzTgDWAsnYH7LXxj2
	NiK3wrbDKDK5QqJPnynKfEvLs9RbdxXvwoBgnRt+kBJEBsdZ/zHG3OYdve4e43CMTc1m
	+bILkziiRGLdliWM0KsWwlYpCpcvkKXGfivZUFbpb5p2Z5Ho/xfjQhcXm8cCGSZf8xdQ
	h0nu0G4ZbOJGOXouGiJKUQZMt2K30uo6o0vYYbfUiCdatXlLG7u36mMNfUByXAGf6744
	pZSUTJSiwdt89ajeMcoEco1hYIEIGMQ562lYyT0xh0hNR5YOJbfIL/LWtK7nN/HmBOJ/
	i6UA==
X-Gm-Message-State: AD7BkJLTtJUQm0uXWhqUp/GooMIKGX7bM3OfLrAbwSzbL4UKFHUuxA05uxqjZjVRiep3en2T
X-Received: by 10.28.60.134 with SMTP id j128mr15684586wma.71.1459961244822;
	Wed, 06 Apr 2016 09:47:24 -0700 (PDT)
Received: from draco.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id gt7sm4145345wjc.1.2016.04.06.09.47.24
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 06 Apr 2016 09:47:24 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Apr 2016 17:46:28 +0100
Message-Id: <0d9519d7a24bdbf0b845b51724bf9be4b5803f27.1459960764.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
References: <c991037b9fb1fe7bf4ef2d96d16c7187b0f4299c.1459960764.git.michael.g.wood@intel.com>
In-Reply-To: <cover.1459960764.git.michael.g.wood@intel.com>
References: <cover.1459960764.git.michael.g.wood@intel.com>
Subject: [PATCH 18/38] toasterui: shutdown on BuildCompleted event
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
X-List-Received-Date: Wed, 06 Apr 2016 16:47:25 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

toasterui exits event loop on one of the following events:
CommandCompleted, CommandFailed or CommandExit.
Unfortunately none of them come from bitbake when build fails.
This is normai if toasterui runs in observer mode. However, if it's
in build mode this causes toasterui to stuck in the infinite loop
waiting for new events.

The only event we can rely on is BuildCompleted as it always
comes from bitbake unlike 3 above mentioned events.

Modified the code to always shutdown toasterui in build mode
on BuildCompleted event.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/bb/ui/toasterui.py | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
index 39a4fe5..6bf4c1f 100644
--- a/lib/bb/ui/toasterui.py
+++ b/lib/bb/ui/toasterui.py
@@ -377,11 +377,14 @@ def main(server, eventHandler, params):
                 buildinfohelper.close(errorcode)
 
                 # we start a new build info
-                logger.debug("ToasterUI prepared for new build")
-                errors = 0
-                warnings = 0
-                taskfailures = []
-                buildinfohelper = BuildInfoHelper(server, build_history_enabled)
+                if params.observe_only:
+                    logger.debug("ToasterUI prepared for new build")
+                    errors = 0
+                    warnings = 0
+                    taskfailures = []
+                    buildinfohelper = BuildInfoHelper(server, build_history_enabled)
+                else:
+                    main.shutdown = 1
 
                 logger.info("ToasterUI build done, brbe: %s", brbe)
                 continue
-- 
2.1.4


