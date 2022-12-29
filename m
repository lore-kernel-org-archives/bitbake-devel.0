Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30996C3DA79
	for <webhook@archiver.kernel.org>; Thu, 29 Dec 2022 17:07:43 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web10.208596.1672333654310683953
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 29 Dec 2022 09:07:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=MSBNR7NW;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id z16so1435667wrw.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 29 Dec 2022 09:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j3gxZxNly1tt9kHCQ0/8kkyqm5WtNyYvsg/tu1b/yo4=;
        b=MSBNR7NWTFhCriLTNxzLC5Z+4mnfNsBF9yBmqmIbg8tM8mJ/3Uhs1b7ix4aMadLSAX
         TM8EjI0Qh0mN3mnP71gTivRx1n6+Dt+c7HYPVVLeK7zlQ92xRpG8NxI9u21TLaOdxUCf
         eJjfwhoLVphJXzA8ANqlt0D9+vXAkaJ5Mjpzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3gxZxNly1tt9kHCQ0/8kkyqm5WtNyYvsg/tu1b/yo4=;
        b=8Jp6b7bpb8qn2bYore+Xgpk/ZaVCfkEGo3pgxjOavglQkQsEGbOGyWB+BA+9BowaYF
         JLC0JpoB8TY2VbsciELYUL3E7qlrQ3zz527eLBG64wTh3WC6z7nILTG4AHxJ/Qv7xb4X
         F8HK/5BkC/RHkZALJuOBuoWQfxLG/1geLsgs7LkpT/lNXizT62rWItYbFtnY7Kgz6Dlo
         6WhA2Ep2WD67lxrrrlT9gxIohxOp4TLjUf6MpkMC9R3AZCDSpFRYgOX4DLIYhKQkpZC4
         y4JDLgPJiTv8mcagUY89Hz+IjziIFz9AkPEwissaJWneT0y08+tysMDUaYfegO4nvd4v
         qxZA==
X-Gm-Message-State: AFqh2kqHPPGSS5KIOOQ+/Q9JKRFN6nSytaQxOwMLYlJgIH/Goyxno9uG
	8OskXJbJasccf7LQyUDTiaYjCymLbc3wEJEx
X-Google-Smtp-Source: AMrXdXvVz3lYnGQY/EC0VOIUW9JBKfHvMbu2WTZS5IlPTg0KHq+x7Vw+n0CjeloBykGlQ/+AkiKRzQ==
X-Received: by 2002:a05:6000:80b:b0:274:c846:4211 with SMTP id bt11-20020a056000080b00b00274c8464211mr19116322wrb.54.1672333660107;
        Thu, 29 Dec 2022 09:07:40 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:43af:59a1:5bcf:54fb])
        by smtp.gmail.com with ESMTPSA id t12-20020a05600001cc00b0027b35baf811sm12308721wrx.57.2022.12.29.09.07.39
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 09:07:39 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 15/15] server/process: Add debug to show which handlers are active
Date: Thu, 29 Dec 2022 17:07:28 +0000
Message-Id: <20221229170728.880367-16-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221229170728.880367-1-richard.purdie@linuxfoundation.org>
References: <20221229170728.880367-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 29 Dec 2022 17:07:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14258

Add some logging to show when handlers are added/removed to allow
a better idea of what the server code is doing from the server log
file.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 365758f85a..b69432ead2 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -112,6 +112,7 @@ class ProcessServer():
         """Register a function to be called while the server is idle"""
         assert hasattr(function, '__call__')
         self._idlefuns[function] = data
+        serverlog("Registering idle function %s" % str(function))
 
     def run(self):
 
@@ -380,10 +381,12 @@ class ProcessServer():
                 try:
                     retval = function(self, data, False)
                     if isinstance(retval, idleFinish):
+                        serverlog("Removing idle function %s at idleFinish" % str(function))
                         del self._idlefuns[function]
                         self.cooker.command.finishAsyncCommand(retval.msg)
                         nextsleep = None
                     if retval is False:
+                        serverlog("Removing idle function %s" % str(function))
                         del self._idlefuns[function]
                         nextsleep = None
                     elif retval is True:
-- 
2.37.2


