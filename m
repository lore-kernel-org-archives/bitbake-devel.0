Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D5FF3C269
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 14:12:47 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15118.1773065563899733779
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Mar 2026 07:12:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=UhH6Mq+y;
 spf=pass (domain: gmail.com, ip: 209.85.221.50, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-439c6fc2910so3928727f8f.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 09 Mar 2026 07:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773065562; x=1773670362; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9OpLINlxeB0uaBbWfimSlgPUORd7YPui3mqQdkdIro8=;
        b=UhH6Mq+yRMVGAADlFJpO/NYSCmD2atsyteoGZyeWoYYWDVjngyT+6DcdvLQzb6wQg0
         9MCGzC39YiC8jvsZFzY7coxv3yI3A8qRUkVCosJV4U1+YEC9vbul/jxaHjlPlOc0woTQ
         lw8KPJAPSm2QLYdKv61cRQcJh619mvYmQyZkdWiVX9yXolyJ757ysDgUpKqcfX6ht73k
         1/I8/10cLVravJ8HQe2DLcGzvTH40w3LJS4B3BqRWmizTTdWOylWR0x/MvLrBrpmw2nO
         81gstsFL4CipmBiPF60Sy3oFMX/zjeBcnSwB5YcLAU0PSn/6qB5h6+OU4xsfszXSAhtK
         NChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773065562; x=1773670362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OpLINlxeB0uaBbWfimSlgPUORd7YPui3mqQdkdIro8=;
        b=xSGLBOHn+rUIbV9uFhg8fabI6MXIiKKYKPIUNcl4CjpZpyZzO0eGbydecBBXG/Bid5
         YBI370r7ylIs9WJyT6+vvWEyQzx+4X4UmdC5KaXNk2O08bxUpxmG09X+4AfbFJelGCl2
         qar/UOZH4fDMbMV7QuGQP0vI2elJMqQe7jCkrP443syJ9hd0NMlpFkfHwpqS4ESpFBgc
         8j7qivvyraNEW3mKZ25UYY8KRTIRDm+aFPWPwXR1ZdOQU44CN5NM7O6NcFqblhYTqUBW
         6uDab+SydlUX7UVSIcZ3XSxRxyve9N+d30NJqwlPZF4QfffyLrlxXQH2FraHQGeRQ+0X
         c+Wg==
X-Gm-Message-State: AOJu0YxXJTO9rUV26SSjVnjgQv9VBi/CrbVMZZqnzB+7iVZ/YWL1nXcR
	QGq0ZUfhA8iQrpO4I8bEk4KxqfRNHhFMqMuoH/+Ci7+fgsnZRKhxiJ0ppZ4dtg==
X-Gm-Gg: ATEYQzxnpqiQpvOGh6mWVjrbS9/6gpnpd1D44mLhuMo71b4IeeOo10ugaY9G5sAHCJ4
	1zDIHcFgVATT1sGcNgV4HBWn01xTGfVegTHIjk59eu9K/FKjpbgEVIPu0OGbgP2apOgIskSN/yQ
	D3Lynp5+P5Bz1Xgai0mOlG7GJD32SlVxy0klSaX059hLMSHgTGs/9U6yDtpGPs+Qrzyf+03wZXL
	SbBy+u7mAklYatVIZHhb2y7OO2ex7VxUyKFe4ZbTaBDM7I9o6T227TT2UgYRi7eMKY7U7erDk2t
	Ut3h1uemSnuB5T5WJFQ0YarUJMmg7rUl6tQEXQcPEG38KkD8k63LFFuOTJHQ55d1ZzlUAhF1H1N
	1hHfYZILOPURf1uE7sCK5pWoOrsou0v2AQ14/40s8RZibZQZ5WXYq7bs0LJurc1RrV5JBbUf+jM
	2Tj56XXmdgrXuzW1THnYEXx/ZwLrCYpNoNquQWCiwFCo/jmBL7TvS0zF+SAcY=
X-Received: by 2002:a05:6000:2884:b0:439:cbc2:63b with SMTP id ffacd0b85a97d-439da6693eamr20475637f8f.29.1773065561698;
        Mon, 09 Mar 2026 07:12:41 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d973sm25443458f8f.3.2026.03.09.07.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:12:41 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH v2 1/3] bitbake-setup: ensure that config_id is always an absolute path
Date: Mon,  9 Mar 2026 15:12:36 +0100
Message-ID: <20260309141238.1785102-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Mar 2026 14:12:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19124

From: Alexander Kanavin <alex@linutronix.de>

If config_id (given on command line in 'init' operation) is provided and
interpreted as a relative path to a local file (by checking for the file
existence), it should be recorded into configuration instance as an absolute path.

Otherwise status/update operations will fail if executed from a different
directory that the template file was in, as they won't be able to find
the file.

Note that the patch context doesn't show where having the absolute path actually matters:
further down in the function, config_id is used to set a 'non-interactive-cmdline-options'
property in configuration instance dictionary. This property is used by status/update
operations.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bin/bitbake-setup | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index bdf134aea..54f2015a2 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -600,9 +600,10 @@ def obtain_config(top_dir, registry, args, source_overrides, d):
         config_id = args.config[0]
         config_parameters = args.config[1:]
         if os.path.exists(config_id):
+            config_id = os.path.abspath(config_id)
             logger.info("Reading configuration from local file\n    {}".format(config_id))
             upstream_config = {'type':'local',
-                               'path':os.path.abspath(config_id),
+                               'path':config_id,
                                'name':get_config_name(config_id),
                                'data':json.load(open(config_id))
                                }
-- 
2.47.3


