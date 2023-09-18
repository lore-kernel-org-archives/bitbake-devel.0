Return-Path: <insu0.park@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BB4CD13D1
	for <webhook@archiver.kernel.org>; Mon, 18 Sep 2023 09:05:32 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
 by mx.groups.io with SMTP id smtpd.web10.47146.1695027929919941608
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 Sep 2023 02:05:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=gGfoxEm1;
 spf=pass (domain: gmail.com, ip: 209.85.216.46, mailfrom: insu0.park@gmail.com)
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-271914b8aa4so2646541a91.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 18 Sep 2023 02:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695027929; x=1695632729; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eqLo2U6PVx+Tpoiel3K5yvKB6JFwLi41hut6uruD4HQ=;
        b=gGfoxEm1pu4u4t0KeTFLwdrtS5nvClZG8Urdz/TqdxrM8vPc0JP1fOzQdsucXc/NkX
         xmjKSZn17MP9a5UFP6917cQCpe5ijG0m6r4ituy6G4QyJnSwzzMECD+TCZJA/i7lfBa+
         ipXlyAMyXcq0dNIVVefND5Iqknoz4oXz052UkS7pldGFcpNinlsocM20D7yqEq6RSUAM
         LQVztUUkC8UIp+3lgkd2f7TbacJOrmPmeS0j7dzMSt8lMTgH2+urSsDLZKqsHrcCEymH
         mAnfXoBvLrWIjNC8qZyWm4UigvJBX9lw+G4NwBG7zCgeo5PKy/G1BPBkqUPcEl2pNWHp
         KMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695027929; x=1695632729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eqLo2U6PVx+Tpoiel3K5yvKB6JFwLi41hut6uruD4HQ=;
        b=DuZ1Ae8em5S1ouZ6N4QaXfG3ULg6YIwCDuYM22HUtTmKtxGBI5qlPPSZwostIS2EJo
         XOl9ZaEhb3YXMzt3ZUSnpAG2Z+DDjXBulqv54Hiw6PptbkCEiVuI1C9qFIRCew9KS4gJ
         FC6XQRBy8gLorX0Yyt77PEx7JTqGOVCZsYD/MqFIi9NFeWpGel2C+nvJCQGoZcKpZEDb
         sc6Rzp1BGoL3+/W78TK/mK/CkiBGsZc7uqnHQLnjnlFj3faxvTFn8mLeLzCL8oUa6RRV
         CS/8cgBaNWvW5ZPUEH3bXIQ3NocsGpihyIjAeRA2/MyDcbrhXulvHcFHAwximTEAt9qV
         UK5g==
X-Gm-Message-State: AOJu0YyrFYfnSQ/dT/LUwa5xFaLD/iskb4PsjlLFwbp1JlVGBuo9E1Z2
	Dc8/h0g6PmcQ7Y44cE/CtoHI+U94tuBsGQ==
X-Google-Smtp-Source: AGHT+IHNYYoXmV8ypMUI6UXGMawHi0C4XzAZAisTWQ6EI2Hu/5dbbwDXXiFA2G1xwmSfcYrvh4l1bA==
X-Received: by 2002:a17:90a:648e:b0:269:c7d:aac5 with SMTP id h14-20020a17090a648e00b002690c7daac5mr5900717pjj.3.1695027929139;
        Mon, 18 Sep 2023 02:05:29 -0700 (PDT)
Received: from insu1park-bee-ccnc1.bee-live.svc.cluster.local ([27.122.242.65])
        by smtp.gmail.com with ESMTPSA id 28-20020a17090a191c00b00273744e6eccsm7438112pjg.12.2023.09.18.02.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 02:05:28 -0700 (PDT)
From: Insu Park <insu0.park@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Insu Park <insu0.park@gmail.com>
Subject: [PATCH 1/1] bitbake: data: Add missing dependency handling of :remove operation
Date: Mon, 18 Sep 2023 18:05:22 +0900
Message-Id: <20230918090522.659869-2-insu0.park@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230918090522.659869-1-insu0.park@gmail.com>
References: <20230918090522.659869-1-insu0.park@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Sep 2023 09:05:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15076

A recipe variable handles its dependencies even on the "contains"
variables within the "inline Python expressions" like bb.utils.filter().
And it also handles those in the :append operation correctly, but the
problem is that it does not so in the :remove operation.

Fix it by adding the missing dependencies every time the :remove
operation has been handled.

Signed-off-by: Insu Park <insu0.park@gmail.com>
---
 lib/bb/data.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index 3ee8f5e7..505f4295 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -285,6 +285,7 @@ def build_dependencies(key, keys, mod_funcs, shelldeps, varflagsexcl, ignored_va
             value += "\n_remove of %s" % r
             deps |= r2.references
             deps = deps | (keys & r2.execs)
+            value = handle_contains(value, r2.contains, exclusions, d)
         return value
 
     deps = set()
-- 
2.25.1


