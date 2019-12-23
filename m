Return-Path: <akuster808@gmail.com>
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com
	[209.85.216.67])
	by mail.openembedded.org (Postfix) with ESMTP id D25AD7F85F
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Dec 2019 04:50:59 +0000 (UTC)
Received: by mail-pj1-f67.google.com with SMTP id t101so6933157pjb.4
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 22 Dec 2019 20:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=xIJPttv3fL4RmSejdO/4k+0rctvuV5k2jY4SsyrToBU=;
	b=bP5pAV3sZY/gFoG6yv+yzbAgR4d7G97eKsiEJQRW9/J6a8XN5XE3tgMVIvY7/Iur1R
	p6LB6p14TdbPaayJl5Iszm+fqQjOqDH3hIXQr7YhgSaP2vpzKwdMJYZqQrX95DRm/J3M
	uK0VlF2R5Xz+odh1LtBL9GZSPWWKc5CCj0VnADsw0lNDUwfT2zbdgZXZcW6RNe1OUHWr
	SXLqmMqCrp9vPMAW9brtpsGwY6KoRlffCHguuiK+a/l8wErg53mrKBq288Mx921euQSw
	6c20Biml9tzoyZELIpexKTiE+zcAgq0xy1VnGBi4ghhxGcyivaOePptOcxFBp0ZLJfDm
	nvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=xIJPttv3fL4RmSejdO/4k+0rctvuV5k2jY4SsyrToBU=;
	b=amghNU4uVjfp1r2EyXuoqxXzF3XJOFhK10neGYqQeAPdARKWwG6g2AVZw3IvQOoJuZ
	Fe4LBdYihs6NxI6uzU9wZdGQ5NoHwXM60UFgPUuzKLahaCzWYE53YswPsN0kGuqoTVI9
	c0q8VnOXKrv/Gq70IVIkWGWAAqFLDFRz98sqFeQ4L7Kz0fzk6lp2vqexRv9iE5aOZRYE
	A2r/TAsb5DjwrJhQrPRMLhOo5Lik3bJHFa4xzO38n2UMpnLEGnrGLr7ND3ry76qp/qNP
	BfMPZgfVEK3QQYKJAV+KGQPOTYLTa4ghoLEiHXReupoT7AXcZsGbaDVWZID6s7wEVgii
	1+jg==
X-Gm-Message-State: APjAAAUOA6Y0Z98plEYjaPAhJn7k/QjM462wm4p0eYk94cKYnaMT1MxV
	V/u3GN8XI6itX/IYOBi7T2YBCCUVe7M=
X-Google-Smtp-Source: APXvYqxsUk3NkUPxIAzucC4qmzShYNwL/h1KF6N8k7FtDKSj/FBsW4DtO7IIopUAlj+AFu2a+k3gjA==
X-Received: by 2002:a17:90a:840a:: with SMTP id
	j10mr2816351pjn.35.1577076660887; 
	Sun, 22 Dec 2019 20:51:00 -0800 (PST)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:a5c0:30f1:af1:c5e0:a746])
	by smtp.gmail.com with ESMTPSA id
	q11sm22276726pff.111.2019.12.22.20.51.00
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sun, 22 Dec 2019 20:51:00 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 22 Dec 2019 20:50:42 -0800
Message-Id: <f224201b5003b89367d688b1f08a062754fce13a.1577076251.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1577076251.git.akuster808@gmail.com>
References: <cover.1577076251.git.akuster808@gmail.com>
Subject: [1.44 18/18] lib/bb: Optimise out debug messages from cooker
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
X-List-Received-Date: Mon, 23 Dec 2019 04:50:59 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We have bb.debug(2, xxx) messages in cooker which are useful for debugging
but have really bad effects on performance, 640,000 calls on recent profile
graphs taking tens of seconds.

Rather than commenting out debug which can be useful for debugging, don't
create events for debug log messages from cooker which would never be seen.
We already stop the messages hitting the IPC but this avoids the overhead
of creating the log messages too, which has been shown to be signficiant
on the profiles. This allows the code to perform whilst allowing debug
messages to be availble when wanted/enabled.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit f04cd931091fb0508badf3e002d70a6952700495)
---
 lib/bb/__init__.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index c144311..ce519ba 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -43,6 +43,11 @@ class BBLogger(Logger):
         Logger.__init__(self, name)
 
     def bbdebug(self, level, msg, *args, **kwargs):
+        if not bb.event.worker_pid:
+            if self.name in bb.msg.loggerDefaultDomains and level > (bb.msg.loggerDefaultDomains[self.name]):
+                return
+            if level > (bb.msg.loggerDefaultDebugLevel):
+                return
         return self.log(logging.DEBUG - level + 1, msg, *args, **kwargs)
 
     def plain(self, msg, *args, **kwargs):
-- 
2.7.4


