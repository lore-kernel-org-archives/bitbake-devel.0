Return-Path: <michael.siebold@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAC0FCA191
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 21:21:49 +0000 (UTC)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.25833.1773091304701530853
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 09 Mar 2026 14:21:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=JW3WGcwF;
 spf=pass (domain: gmail.com, ip: 209.85.160.177, mailfrom: michael.siebold@gmail.com)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50912a097b0so9219491cf.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 09 Mar 2026 14:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773091304; x=1773696104; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oLHJEuN+vnMcN6TIgGNlXsHdyL+iooPu6iA447Fnd+0=;
        b=JW3WGcwFrEr0TB0Yn2Hf/n0MwzJ54qldw9FYSSFRuvb9lkv7HZJ7k5H45sQKRHZ/S6
         OdjaxPRjHl7C4Yl5Buo8kg9EU6z/MwO7LXwBZExBWOByT17I5R0f90r7GZMnPq/5SC4k
         6id53PGTfUiVPdP5MahB2NUA/CIv29YC/a+vmaMA10lYdCXEjSL93yitScwfRQ6XsWqf
         v0DyNRomHFXd7k4Q+/PdgmhykOSPkOrh52j/so745gRimoT+LyugjdNsu+aoWeSr3c9M
         04jFgAxS62h4ufbMFVJkaIKy8crTOE0oclTGxup6Qrz7c3U8LgOidANFr4YE+HPEDKvD
         b95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773091304; x=1773696104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLHJEuN+vnMcN6TIgGNlXsHdyL+iooPu6iA447Fnd+0=;
        b=pttomypVkd/TwtnM0vubeTDVLBQVitHexPvScbxUySDdf3n5t14o2nWQ/Oczziw+7l
         3H6NZILAUCwbaHqWUnmaCpEby3dwfjakg9aHDiow1upww6JvSsZ0Hwn0wrIXZsc+MYDb
         TsL0KrnPuGml2eed0DNA/J66TM0IE5F3TymLoPPUMTW6GyhEkhdWJpmBXqDj1C494pY2
         O9fUaK/eZ6OgcYdlM+lsFupVMJEtELUEKi2A6dgNIlwuHAspgCnfLCY3HFge6Rzs4rv9
         vv1WEyvBSrcIOc47v+iann17siSKrrIgNMorkC/DndVyDLIkCSSeRhuEvy1F/rC77woV
         8hvA==
X-Gm-Message-State: AOJu0Ywk7TJ8yPuEMsEAMZzoZIJJWPoaNf24V/APcMVKpA6ve3oW70WQ
	ILADzZen9ALCV2OW5wADcTQ+TlU3eIdc6+zGw5kXqSXMRkmLfJoXxqow
X-Gm-Gg: ATEYQzw+/3ZruPEeMncUcqLZ4/5cICttuD02LHoxkneR1OUMGxaS8v/c0FRViH/OwKX
	LQ1D8kpHedWvxzf3rqU1ORv4SDJdMW7QWwrQOvjAFyEyA9C2T6AtpNJboi6YVAAd+P4IwDoQZpM
	uKvLZw0z4IHW00JCdAHlYB58ETS20dMnkNv7KoTQXRCwipKelL95PpIslyBB9YWtkUyJ1P4EVtg
	yDwppeapbKIQOMijS2E5TxV9fHR+schWBApEjXE65lgyGDCdyJx3LqLz+nW4Be957PPM/yxJTng
	dtL60hRwPRYIVIAhhTdszQuoA4Mt24UJaCY2frejyve3xoxgDv2Xay+6dqdOl86EJ6GndYMeIYR
	KHZVq18H+BkmSIakj9/kKQNRfPBO9FfhRzo9+w+6RXcLXDx6sqjjGLdOxEUD49i1w2QFdD2DUXn
	U+2TsNl+K8nqzpubZYohoqQeo74tkj8K4L7hwRBO8KZEC9X+I=
X-Received: by 2002:a05:622a:44c:b0:509:21ce:1a9 with SMTP id d75a77b69052e-50921ce043fmr36227741cf.10.1773091298750;
        Mon, 09 Mar 2026 14:21:38 -0700 (PDT)
Received: from beeblebrox.pc.cognex.com ([143.170.79.157])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50924937718sm8522881cf.29.2026.03.09.14.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 14:21:37 -0700 (PDT)
From: Michael Siebold <michael.siebold@gmail.com>
To: Yoann Congal <yoann.congal@smile.fr>
Cc: bitbake-devel@lists.openembedded.org,
	Michael Siebold <michael.siebold@gmail.com>
Subject: [scarthgap][PATCH 0/3] Fix git lfs submodule expansion
Date: Mon,  9 Mar 2026 14:21:22 -0700
Message-Id: <20260309212125.3172717-1-michael.siebold@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 09 Mar 2026 21:21:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19128

These commits are required to avoid trouble when a submodule includes
large files via git lfs.

Testing:  Verified via bitbake with manual inspection of artifacts

Philip Lorenz (2):
  bitbake: fetch2: Fix incorrect lfs parametrization for submodules
  bitbake: fetch2: Fix LFS object checkout in submodules

Robert Yang (1):
  bitbake: gitsm: Add clean function

 bitbake/lib/bb/fetch2/gitsm.py | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

-- 
2.34.1


