Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4067C25B74
	for <webhook@archiver.kernel.org>; Thu, 16 May 2024 07:00:45 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web10.7130.1715842835190160930
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 May 2024 00:00:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ARtagfYF;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-351da5838fcso171039f8f.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 16 May 2024 00:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1715842833; x=1716447633; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=l8cBAKlEBVqDIegf/g1+sqrNXXC/vJlDDN3IuVGn0/s=;
        b=ARtagfYF2fa1ZK88nHgqdFqWEvscv3gPvN9Dqz4E3LRmQVvKJvU11hcJvo15jsA5vw
         F/3ni+0zJWT+IDf3y+7sYqXULGbsPkygXR7Ef5xmu/kaLk/N1yrz3CY1a7i0PJg3Rd9k
         fsnuzGDKjZXxyuXOTizwEyrpGVG333HY47+9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715842833; x=1716447633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l8cBAKlEBVqDIegf/g1+sqrNXXC/vJlDDN3IuVGn0/s=;
        b=YAKaDNOnPXwtKEiwvLfZnWr7/5iDsQCjEAHlZX/BEDsJnhLlqU6OTr7FZP7esGlZ4W
         9P73yR1OR9rGFvlrlF1ifPwBz7TulYjZZAGp5vyKAUm++OuVCAPtu0YqLYQXNy0HgyBb
         +gElkkfXW3cJRMsZOIL0W+eI7LUVP2T4KXnnPz4iwu5Zk4ZMlLOg6AOBANQoggU6ZQq4
         bi/I02PnCJ60YrIB/mp2cflt70lyrNl3aAGT9UhYONaoCxSX6qfqzSo6/+hQKGSTJh8t
         itMdtCzXRvuouCFCtRX0mtrlwaXk0Np5nMKEGOlyzppsfYXgL08WfMZG2albViCtkPir
         O28w==
X-Gm-Message-State: AOJu0YxmxKLMaySMOoMhMHTzQCWBxN0fOCfsCgk02FrsDT41VPrO3KoS
	fO6D8JM/sWkYWr6cWdMk0Ldh2US0IjRgm9kyX8214QFoXxKUhGjoI57w912OmxnYZ5QSTT1R8Gh
	y3uQ=
X-Google-Smtp-Source: AGHT+IFBnhu1UbuDKrdcOuXUUoVJc9LIGHZvQ3Rj/63otno1Jf7HyH534CLYThgHj/1h7iwGeCLpvg==
X-Received: by 2002:adf:f8c4:0:b0:34a:80ed:9930 with SMTP id ffacd0b85a97d-3504a633241mr11507691f8f.8.1715842833213;
        Thu, 16 May 2024 00:00:33 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:27f7:a21e:9b36:73bf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-351d7861323sm1051163f8f.74.2024.05.16.00.00.32
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 00:00:32 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] cooker: Add an os.sync() call to revalidateCaches()
Date: Thu, 16 May 2024 08:00:31 +0100
Message-Id: <20240516070031.590112-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 16 May 2024 07:00:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16225

Unfortunately we've seen issues where changes are made by the UI side and are
in the disk cache but these tests don't pick up the file changes as they're
still proceeding through the VFS.

Any example is [YOCTO #15318] where logs showed a workspace and bbappend
being setup with devtool-source intercept but the server did not fully
pick up those changes leading to initial_rev (from devtool-source.bbclass)
being missing.

Add a sync call to try and avoid this despite the speed implications.

This was probably the kind of issue which led us to removing the inotify
code since that was also unsafe with concurrency since there was no way
to flush it.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 939a999974..d4595c1ec2 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -350,6 +350,11 @@ class BBCooker:
     def revalidateCaches(self):
         bb.parse.clear_cache()
 
+        # Unfortunately we've seen issues where changes are made by the UI side and are
+        # in the disk cache but these tests don't pick up the file changes as they're
+        # still proceeding through the VFS. Use the sync to avoid this.
+        os.sync()
+
         clean = True
         for f in self.configwatched:
             if not bb.parse.check_mtime(f, self.configwatched[f]):
-- 
2.40.1


