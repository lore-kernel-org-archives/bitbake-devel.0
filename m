Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CD6C25B7C
	for <webhook@archiver.kernel.org>; Fri, 24 May 2024 15:12:12 +0000 (UTC)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
 by mx.groups.io with SMTP id smtpd.web11.18335.1716563527056524168
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 May 2024 08:12:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=P3Y/bBg6;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.208.170, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e73441edf7so57261031fa.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 May 2024 08:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716563525; x=1717168325; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YuZlwnR7BxBUrMFYytDdPppJ203LnrvSWGEdSStHS1I=;
        b=P3Y/bBg6+3lX7snQ51xUbaxbx5sNsSA9zV7RnCjbpt93Z0YS1v0EmPAKBIGzbwnyGh
         DszEgT2E5FaQTeSlL9jpbCarGZPBz0dVzTmdhVFnEeWxeUQOSMhcShJ4m6EaYHnGz9AJ
         Nu9LJfgjhVJa1Y2p6a+QYSfutQ3lWWkgX8epU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716563525; x=1717168325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YuZlwnR7BxBUrMFYytDdPppJ203LnrvSWGEdSStHS1I=;
        b=qz7dJOKgQYf8wE/7K03HJSAzchlbpnatfBV/l8qalLieAcn+AENaHZExV58tt/IU6h
         XNglj+h/I9D4wKJk0mqhLpN7lPtjTo0Zgh6/9kjoXFhWlMVNyt1X0chwrkABtT1JQwB6
         ldXTgislDJVjAtmPscTzDlxbzf0GOh60rzw/IPPpYfQHstZl5fZRdngXtn04te4hBJ3+
         o1ZBd7Ha/Tf8m8yuE+L0F/M5HPSuJyrcQG6CS6CNFv89LbjNApuWlbjggA4Wj0XpcO/D
         lPZFA5vgtagLFBam/fC5YHy+0GZZ0AdoM7Od4wKuWINgF+QziN296czEBuRg+dUzKDlz
         2KhQ==
X-Gm-Message-State: AOJu0Yzly6JBahU26P+ym2mI1tdXPFfg3YGjzkpkU+yAeOtE3haAZpHY
	2wcy0x1y5SZ3SDpHJwvi0KjRWJ3GEN4OzuXbNuhrCEB70e+toN4NwgeZbZF/bhtH+082pJCnHx9
	I
X-Google-Smtp-Source: AGHT+IFJ/kWfKpZmVNFLtLSs1SMm1eKUS6/WuDuYf5HuW/TXaTeNawrH93UHeLCqN0QZ6ayj5xntvA==
X-Received: by 2002:a05:651c:107b:b0:2dc:bf5c:9648 with SMTP id 38308e7fff4ca-2e95b09b355mr18669621fa.19.1716563524631;
        Fri, 24 May 2024 08:12:04 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:9ca4:3686:8521:57da])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579d7db23sm1841759f8f.23.2024.05.24.08.12.04
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 08:12:04 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 5/6] runqueue: Improve rehash get_unihash parallelism
Date: Fri, 24 May 2024 16:11:59 +0100
Message-Id: <20240524151200.2449512-5-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240524151200.2449512-1-richard.purdie@linuxfoundation.org>
References: <20240524151200.2449512-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 May 2024 15:12:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16259

Improve the rehash code to query unihashes in parallel since this is more
efficient on slower links.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 411c47eff9..5626ffcccb 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2578,13 +2578,21 @@ class RunQueueExecute:
         while next:
             current = next.copy()
             next = set()
+            ready = {}
             for tid in current:
                 if self.rqdata.runtaskentries[p].depends and not self.rqdata.runtaskentries[tid].depends.isdisjoint(total):
                     continue
+                # get_taskhash for a given tid *must* be called before get_unihash* below
+                ready[tid] = bb.parse.siggen.get_taskhash(tid, self.rqdata.runtaskentries[tid].depends, self.rqdata.dataCaches)
+
+            unihashes = bb.parse.siggen.get_unihashes(ready.keys())
+
+            for tid in ready:
                 orighash = self.rqdata.runtaskentries[tid].hash
-                newhash = bb.parse.siggen.get_taskhash(tid, self.rqdata.runtaskentries[tid].depends, self.rqdata.dataCaches)
+                newhash = ready[tid]
                 origuni = self.rqdata.runtaskentries[tid].unihash
-                newuni = bb.parse.siggen.get_unihash(tid)
+                newuni = unihashes[tid]
+
                 # FIXME, need to check it can come from sstate at all for determinism?
                 remapped = False
                 if newuni == origuni:
-- 
2.40.1


