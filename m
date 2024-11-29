Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB88AD6EC1E
	for <webhook@archiver.kernel.org>; Fri, 29 Nov 2024 22:10:17 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web10.123950.1732918210235948764
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 Nov 2024 14:10:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=SXWh761O;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385e2c52c21so162661f8f.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 29 Nov 2024 14:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1732918208; x=1733523008; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lx9cYxNz8yhfJM7qDA0Tzjh+ABKzdKA+nZZjnHghE7Y=;
        b=SXWh761OPT6wdW005Lss0SzuyCL0Zci5wkTzVh6SheO6On6bful33T0Dkbrgw4tFsS
         ZV0OfizQwOrCbWRQC3aoGr4Du7hoGd6ETQVl5Oqw4nvph6CNvo/IdJI3LjUWgg8//kXu
         dE4oae4NGYTpjFRUmSjVqvlnpHLP01yX5YMcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732918208; x=1733523008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lx9cYxNz8yhfJM7qDA0Tzjh+ABKzdKA+nZZjnHghE7Y=;
        b=iwQjm9XFlhlU1x34pATHACAbRR+939ATMMIuN2KfZpbaS3UNXD3gyLoCowCSbgv4Ab
         IqsqonMPLbcs+h3qB4lJw3HXW7XlqVKGmX++0xSMCttXXd4bBwj1w384EhPtIuqgfyjt
         MhmgjFU+NEP6pF0augfIoNgkgTEb3Mt+e9Ggj2IhPZ3SHCHEYoJiA3810bWrwN7OvbcR
         5LWAokbuIBBRN2m5X2rAVItzQV38MZOAcHeCE/lk3YOQHa95lYMCbbYY3620J57XfTQj
         ybWFEa57WdtWDdrtANBoPARgRiQSEnJB4Pvmz8ThYpCp0h+OT/4mEXVFYWvLsDg6ZST/
         xc6Q==
X-Gm-Message-State: AOJu0Yy62B1eAjhV8p/3k48CnFQ5qFxtXcgwqCfHxpBZchRRj7FM0jol
	yg2J7bg0YTc9CEUZQ5xROqhsXH5j0eJJ6LTGvbUhJCcuiloagV6w1iXgNPN9JZxdbDef8i+o4C7
	w
X-Gm-Gg: ASbGncuSnP92YiuSAoc3HIr8viTPJzrEz0msNXFEJGTtmZLjDXFYLcRNcMgkrRS4XSl
	Qd2Rf0WIyWyMBs3n5vb/D5uadJcNpc/V4j3TNADiGx+sp8O7DYJ6dk8rSVYtuhasH5qTICVaNCS
	ooA6lOF4QxZYg6CBtdwOH7J3Y5zAN340TRD/k41agCZT/m76gmzkoGkG5XMZTK4stHZwG6uBM/P
	/G8RPhsGmtqxIYlkGAWnX5EFxeG2pNMfhrqmq8TYLAuNg1tJ7RJf/KdyCmrF7/HkwmWrxIirhbO
	G9E=
X-Google-Smtp-Source: AGHT+IHQaA9Fxuau3AqmB2Ep1SMqmKpaT8A29VdUf9gerY8kvjNvD9gFpfzuQQM4Et+pWiKeUE5+Fw==
X-Received: by 2002:a5d:64ac:0:b0:382:383e:84d9 with SMTP id ffacd0b85a97d-385c6ee1decmr12141133f8f.48.1732918208045;
        Fri, 29 Nov 2024 14:10:08 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:1083:22d7:abf5:ae6f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e16d722fsm1228038f8f.41.2024.11.29.14.10.05
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 14:10:06 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] runqueue: Fix scenetask processing performance issue
Date: Fri, 29 Nov 2024 22:10:02 +0000
Message-ID: <20241129221002.770402-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241129221002.770402-1-richard.purdie@linuxfoundation.org>
References: <20241129221002.770402-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 Nov 2024 22:10:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16853

Analysis shows that "bitbake core-image-ptest-all" spends a lot of
time in scenequeue_updatecounters and much of it is rebuilding a set
which doens't change. Reorder the code to avoid that performance
glitch.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 6457726d96..ffb2d28494 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2771,8 +2771,12 @@ class RunQueueExecute:
                 logger.debug2("%s was unavailable and is a hard dependency of %s so skipping" % (task, dep))
                 self.sq_task_failoutright(dep)
                 continue
+
+        # For performance, only compute allcovered once if needed
+        if self.sqdata.sq_deps[task]:
+            allcovered = self.scenequeue_covered | self.scenequeue_notcovered
         for dep in sorted(self.sqdata.sq_deps[task]):
-            if self.sqdata.sq_revdeps[dep].issubset(self.scenequeue_covered | self.scenequeue_notcovered):
+            if self.sqdata.sq_revdeps[dep].issubset(allcovered):
                 if dep not in self.sq_buildable:
                     self.sq_buildable.add(dep)
 

