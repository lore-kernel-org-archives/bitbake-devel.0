Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0E7C282EC
	for <webhook@archiver.kernel.org>; Mon, 10 Mar 2025 14:58:27 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.39914.1741618703809673174
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 10 Mar 2025 07:58:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=gqpmFp+L;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cf257158fso8214965e9.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 10 Mar 2025 07:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741618702; x=1742223502; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zcibEHsFNibk8JunDYYzH612jbSR82k3YbJRW4OOFI0=;
        b=gqpmFp+LeZjo3wJCIhFU5PjwAoD6MiNHqMSKclyQloKH+Re0mzdbeu2eXKT3DVpLly
         1BTJ1ZEklV4F8Uhqc9Gdnri8WMCY26ZsltlsMjkEwXMCEEDrsuphI4xg7QjVdcWSL4ZT
         HzsULk9/sgICt+W4qpLBMS/vj9GUJLLuVfNls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741618702; x=1742223502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zcibEHsFNibk8JunDYYzH612jbSR82k3YbJRW4OOFI0=;
        b=f2ljIlzl5KrpB/hovDYyI4qhoeux1aALSf2yfvfWfwaTR77//I42hbMilWJETr+wlM
         dI1+wffa7NSnhWHT/zx+LYOnd+lwzY8Z3IjOy4EnN2BulWXewQFfO4FGhYA15CLNabqH
         P+xS+QLTRwwq7mdCXhzq5vZB5RX9R73RVoxSS2kn3F7KhxuofpW3enCdunkjCYt+zBcr
         kGOzRCXE8vdHmRKajDnuCX9rSEGen4FvlJx7xOkOHHpzLjPtSA4k2yDicL2UTVTYdKPo
         A2eUaA0fQ57TwtHhojj1LNwCtW0qukEOmeeeZY2dc5eCT98IocjB4lYAc6E6FF3vJ3fO
         dLKg==
X-Gm-Message-State: AOJu0Yw8An8XflEhiUjkjI3qcG5qdhCSsnjMpbCRC9jEmHGfHdjg98Nl
	+crSdX+eR7ImKR0Io1hOMYJFe+ulM//+9g9NtgyV9VgIGR7wjdFbjr2iJwQfL/mcLsA87jXyOxL
	A
X-Gm-Gg: ASbGncugW9p6aZBxd5qva64qibYZCBrL5PqUABTn9JdYM0/7tlTNIflQN2RGJQ87Neo
	U3mxvEpXG1dEiRr2I9C/eYlWshfD9H5X4E+WDlkoNFvcvvgWg38My2vL7Gjo3//ES4bfof2bp7y
	GpgI3YMpDl9+/83CUJpk1ZrH7HW6kclM6chOgHr1/vDIwYZq4uSS3dKg5qmZwlMiMgxlZk3AB3B
	/LL65rA9+i3OU6cQEX+iWAy1v+VthUv4c+SOA6ZnxbKpim2+YgF02FTYKsOUCbwQmFjRyPMkpmE
	7YlpTsqevA/1d35nD2WB5ZhEx0+/hqBuckjxzeY2oUrONKYhJ/SyvvFyhHfEdFGuicfMESX0Nw=
	=
X-Google-Smtp-Source: AGHT+IFgRtKFywZNC+M24xbu3VWRPQpr/q51717jc9AAhYf87wd4ZXzyuI9PvVzdD+L9AIznsOqcBA==
X-Received: by 2002:a05:600c:4ec6:b0:43b:c0fa:f9c5 with SMTP id 5b1f17b1804b1-43c6024bf6bmr80413375e9.21.1741618701800;
        Mon, 10 Mar 2025 07:58:21 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:3d30:def0:6e8d:cbc8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cea4619e9sm62353735e9.1.2025.03.10.07.58.20
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 07:58:21 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] command: Fix command complete event ordering
Date: Mon, 10 Mar 2025 14:58:19 +0000
Message-ID: <20250310145819.2869616-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250310145819.2869616-1-richard.purdie@linuxfoundation.org>
References: <20250310145819.2869616-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 10 Mar 2025 14:58:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17424

The command complete event triggers the UI to start new commands.
We should send this once we've cleaned up existing commands since
on very slow systems, this could otherwise cause failures. There
is a 30s timeout on incomming commands but slow systems have been
known to hit this on poorly configured I setups.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/command.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index baa7cbade1..59a979ee90 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -143,14 +143,14 @@ class Command:
                 return bb.server.process.idleFinish(traceback.format_exc())
 
     def finishAsyncCommand(self, msg=None, code=None):
+        self.cooker.finishcommand()
+        self.process_server.clear_async_cmd()
         if msg or msg == "":
             bb.event.fire(CommandFailed(msg), self.cooker.data)
         elif code:
             bb.event.fire(CommandExit(code), self.cooker.data)
         else:
             bb.event.fire(CommandCompleted(), self.cooker.data)
-        self.cooker.finishcommand()
-        self.process_server.clear_async_cmd()
 
     def reset(self):
         if self.remotedatastores:

