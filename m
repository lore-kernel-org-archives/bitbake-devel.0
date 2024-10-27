Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9DAD13584
	for <webhook@archiver.kernel.org>; Sun, 27 Oct 2024 20:20:45 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web11.36969.1730060437460248251
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 27 Oct 2024 13:20:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=khfVaGRE;
 spf=pass (domain: gmail.com, ip: 209.85.221.52, mailfrom: martin.jansa@gmail.com)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d6a2aa748so2397637f8f.1
        for <bitbake-devel@lists.openembedded.org>; Sun, 27 Oct 2024 13:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730060436; x=1730665236; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+mhRyUnYiFras+YF5AHMDacLcrjznH8Qc+IIuo5wzSM=;
        b=khfVaGREV0GcM5ZA0cAF3uayd+vzmwvhlw8VWJqRhF+RwQmRbFhSe2loulx1kfP2Uf
         QpC01eoQaWcFXYVUaFrx2AtzvbsZya0rFPRvEh3Y0hS+8xYYxtCFA9rXNUqHvxTeuXfv
         rKuLdT4QWqk1JKq5s6NXwF12z8B/vn7tw4dk1J9lepwCnZ/7Hxas3tVZ19VB7vYC8qk2
         Uxt1a5g5V7StN+cO1iVSxvZV+Lwoss9M3jxvv/+wwXNCrLWCfndaHBEj4Zxh31v2GDMm
         bqXdIEoDCbAbD4SGhA7nFzD3VPYaBYzWBvgnAUXfyh1JhxaMTNTYeikKhkriul9+9n/6
         9LOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730060436; x=1730665236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+mhRyUnYiFras+YF5AHMDacLcrjznH8Qc+IIuo5wzSM=;
        b=nHUMj/uBCyJykCX1SxCE7tC4x5w7//Uz0e+A9cEhI8J6uVh3BPcv5U+9vkVRVgKnHJ
         KyYEtSqXaviQxAbIAspHQEcSyUSzwDUFboIfwLbICFZKjWn35g/qAqtzT/EJvCzgHBug
         NK6p6v40BTa2hsD7Tsb39hMMdezYoGNwbWf22HZkOMrGH3NzBFT07YsBUAv2tdWdKoOX
         RUT+jBqtxVz8O5rf9i/Ugf4Lq0LbhJAclUWfLhcFbbsn/NEi3qHLvlWJqTT4G+AQMdvL
         chNfR9JFLaZ6T4DdvIjOecaBPEoBdd0Q9j5Bx2NhXbS2BPwSdp/Bp1VYrJjQf0e6zpDw
         duEA==
X-Gm-Message-State: AOJu0Yw/7sIg1Ds3yh5TzESvX/qL3WUedP7r3vNfPGMIRrMqsHrcF+6A
	faJctIyOfM9IA9giFyZT/MlEdxonc9sBNo0til09FDxQugbXoiwGTz+cMA==
X-Google-Smtp-Source: AGHT+IFoXINnx/rXJGsEMNkTdcLVilvH7rggvtPd19hxu7OylFg9NEgNOYeNS4ykkcP5bvG4XoaPGA==
X-Received: by 2002:a5d:6083:0:b0:37d:48ee:d6fc with SMTP id ffacd0b85a97d-380610f43f7mr4299711f8f.7.1730060435508;
        Sun, 27 Oct 2024 13:20:35 -0700 (PDT)
Received: from localhost (ip-109-238-218-228.aim-net.cz. [109.238.218.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4319360eb09sm85307545e9.48.2024.10.27.13.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 13:20:35 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: steve@sakoman.com,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [2.0][PATCH] fetch2/git: Use quote from shlex, not pipes
Date: Sun, 27 Oct 2024 21:20:30 +0100
Message-ID: <20241027202030.3875780-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 27 Oct 2024 20:20:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16732

From: Richard Purdie <richard.purdie@linuxfoundation.org>

The pipes module is removed in python 3.13. It was already using the
quote function from shlex so use that directly instead.

The module already imports shlex too so it is an easy substitution.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/git.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 9ecc855af..dc86aabfe 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -861,9 +861,8 @@ class Git(FetchMethod):
             commits = None
         else:
             if not os.path.exists(rev_file) or not os.path.getsize(rev_file):
-                from pipes import quote
                 commits = bb.fetch2.runfetchcmd(
-                        "git rev-list %s -- | wc -l" % quote(rev),
+                        "git rev-list %s -- | wc -l" % shlex.quote(rev),
                         d, quiet=True).strip().lstrip('0')
                 if commits:
                     open(rev_file, "w").write("%d\n" % int(commits))
-- 
2.47.0


