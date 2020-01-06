Return-Path: <akuster808@gmail.com>
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
	[209.85.215.195])
	by mail.openembedded.org (Postfix) with ESMTP id 96A2C7FD75
	for <bitbake-devel@openembedded.org>;
	Mon,  6 Jan 2020 16:27:07 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id 6so27100912pgk.0
	for <bitbake-devel@openembedded.org>;
	Mon, 06 Jan 2020 08:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=aYPGjXLf6XivrgBH5cjcAjQXglcJR21U0Vx1oKVXJ2I=;
	b=LqSWTH0LpPtVnygotsbpo43MDDEY/dcWD1+nTC34S4jaYhNYfz5aweuifkwbf9WrmY
	HEXgjTztQx4LiqFeMg1WsIS3cvcNfl8KJC90lxvRj4t5WLOM74wF3h/ghZ17fW2ajygy
	/V0HJan6KNIQaSVkuPkCap6sVZ0INytGMy9t5RGBm4Az6U4sBxTHbgKrknRezgY1Bfxh
	1kAsm23TKYyOd+jBmPRHugl422gjM+b7/x2ScF6857+duGQHKcXgBsBILVA5t4A296DV
	zu29nqFQ/I10Pog6bjcsIPXVdiEqS+Hco01QbVH+mQ4BZOzRYjIfO1i6XgwIxq3LUBUz
	cRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=aYPGjXLf6XivrgBH5cjcAjQXglcJR21U0Vx1oKVXJ2I=;
	b=bz14ZQN8a4qYvSndgJGbotjMScf5hasSiO+d6UNjfcyZXNTTYylmEKcMWqDkAihlny
	Pvancvi81JGQd/+pY9nPVRqptycK02sUCFUZo79SPuQYvZc+CCIB/kzfjZOCoaT6fjpQ
	BL+q3paSov/w54fzD5vI2mP30Gh+4ICqz3kUYRUkaIQ8SmDRhDpciBdxdzkHJjkSW5iy
	vjHlIxmDz6KW+pdXTZ3MXrSYDTFZSu1nCM8twN9XeYOlvZo5YIpJ79rDDxC3WkgY2EB1
	bCi0hnv56ONGnJcld/VuGTvqe+QMNolrbALRKmPEvzjLKpZsiMhRehvjmbbpheKuE43e
	yCYA==
X-Gm-Message-State: APjAAAVO9HAwbLqNeUbDkvszeo48kVFXPDTjoiS6WyWeUbiYfKFN0G9K
	05LI8UT5FdUoUShf1nDu6Fz0bv3P
X-Google-Smtp-Source: APXvYqyfefQplB00WTFhsNmTLfmQKH+HUIxZK/ZZ66SUQWjJuR/5BV/BlWrQLZhcwLZqppsxF3BeKQ==
X-Received: by 2002:a65:6088:: with SMTP id t8mr112782970pgu.329.1578328028499;
	Mon, 06 Jan 2020 08:27:08 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:6832:e19c:36b9:d5e])
	by smtp.gmail.com with ESMTPSA id
	d3sm24538668pjx.16.2020.01.06.08.27.07
	for <bitbake-devel@openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 06 Jan 2020 08:27:07 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@openembedded.org
Date: Mon,  6 Jan 2020 08:26:39 -0800
Message-Id: <f224201b5003b89367d688b1f08a062754fce13a.1578327474.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578327474.git.akuster808@gmail.com>
References: <cover.1578327474.git.akuster808@gmail.com>
Subject: [1.44 18/25] lib/bb: Optimise out debug messages from cooker
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
X-List-Received-Date: Mon, 06 Jan 2020 16:27:07 -0000

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
index c144311b..ce519ba3 100644
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
2.17.1


