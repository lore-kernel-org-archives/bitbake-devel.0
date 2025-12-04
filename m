Return-Path: <david.partain@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA33D1D87A
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 06:53:23 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.31248.1764807983456313056
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Dec 2025 16:26:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=nPByBptd;
 spf=pass (domain: gmail.com, ip: 209.85.210.178, mailfrom: swami310@gmail.com)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so323780b3a.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 03 Dec 2025 16:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764807982; x=1765412782; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hRDtGfkpeWdiat83F+xY1PLYIemYVJYUJhseH6gCYM0=;
        b=nPByBptddEB0xGGge09pPc2DGGgirrrqzUC3uLHUfxLcR65VWa1NPZI6rF6bKcdrph
         GvWKBc2LgdYMAW6qmEMm7O8MBALlf25xC+/P4N6uQQwH8WLGew17VlXYpg1BdJ2JgTRh
         NfT2dYC/VT0OMuDMFgG31Qragn0I8lwir1udOhJdrrvJi8+1C76N6n/7FBSaEB5MGRhl
         d8LOvAPpmaRcvtsecvyDlAXaE9N1GP4algJw4WQnsUkXPeNG5fnrg8onLfc0r6RPrZyq
         3Q9XzeHKKTIuJ/LF4l5yEEuUu35Z5GSS3yibplCgQ0Eltey6tfQ9HDWsYDyfHeGLeoq7
         8I+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764807982; x=1765412782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRDtGfkpeWdiat83F+xY1PLYIemYVJYUJhseH6gCYM0=;
        b=FSGGq+1dPYoSh0pseHzrijmFPsi9aGrQNnww8sMfMBKFBv9yAc8LRo96Ncjm+7V1OX
         eh8bzyT+N15yLZzE9kJl9cNdBQ/XJiVJLfg9zYh2rPxOusNe5VZTDIO4JsFpZqSS62nh
         juiLvQnzFwxYP+z72TceJwWaLMDaP8JDjHbXgmvWPQjarQIaPjuXIkF2h8gQ2fatC2z3
         5Y3B5t+GflPD3nM8ixyYEkuRiGHE7UEhA6NEvtdMc8GNlGdSJM64irxBZW0whD+TltnL
         6V6eH1WXuD2Rn8xR9H9f/uVbmQnAfudASdHDZjrxjSFSQN7zUdxG2gUK1BayIFqldFhs
         a6eA==
X-Gm-Message-State: AOJu0YwunpxeLcxhViP6nLJiP4143u+7gKSmMdzBtcPP24vfFCkoIyaj
	Yn9occwA0u45KgrWYNQkVJVKlLceGp+jWXHYDlwC7ZA/JOYsTxiigc4V/I1kLLLr
X-Gm-Gg: ASbGnctOczoKekzk8h5M8LHF6/eeKI3Kf4MAkMgeN5hHwUSSuEyjczIfB0IuqEw//Sl
	6ZWwqGAT6MiObsfvos/nHDRS1S27MFkIp//08dVXAZPahEDrk9IPvf8O5f7GX5563Wf2ruQQuew
	WGhacFthYWuBm3DkHHUQbL7xGbeRhFmh5P4sNfsMXhD1QQON8ixqQAOTOXavFzR6PJ7pVwzpg5Q
	jOTi7ZuGtEFL0dJqFW/39dBGB5x/vBBpjis1vCvZlrQzuD/+L6Nso5d6dfz3ES2WVuQA8Td6OGf
	qW0HpQZ/DED3qHSqM3XfsySw0hY97aPSHGgydbT1PHAy0mKLNtOHiXFUsVnlkyUZHSNgQBFIUnc
	U4xSzRQfADElCO6/GozhzAQP8UiPV9AcDHIW/Yq2bKRRvIwjE3Tj2MDYu4W4rg6gCstP1Nl8Pq2
	DrfEeIzvGB6m3gGNeWdDme622r1UHbHaQZmsc/
X-Google-Smtp-Source: AGHT+IEFqKB7bq6VPpOYEORfbjNX15UDCMZggr+kj0PlfNVzJAKneSOq34F19X8/Ml5x32exDCukNA==
X-Received: by 2002:a05:6a20:7d9d:b0:363:9906:4679 with SMTP id adf61e73a8af0-363f5e94f74mr5266057637.56.1764807982398;
        Wed, 03 Dec 2025 16:26:22 -0800 (PST)
Received: from lenovo-ThinkPad-T480.. ([2405:201:e00e:f828:cf64:d6ea:c5eb:bb55])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be509d59f9dsm19315566a12.32.2025.12.03.16.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 16:26:21 -0800 (PST)
From: "Swami" <swami310@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	docs@lists.yoctoproject.org
Cc: michael.opdenacker@rootcommit.com,
	Swami <swami310@gmail.com>
Subject: [PATCH v5] bitbake-user-manual: Documenting BB_CMDLINE
Date: Thu,  4 Dec 2025 05:55:31 +0530
Message-ID: <20251204002531.7660-1-swami310@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 04 Dec 2025 06:53:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18536

Add documentation for the internal read-only variable :term:`BB_CMDLINE`.
Fixes [YOCTO #15746]
Signed-off-by: Swaminathan K <swami310@gmail.com>
---
 doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 734c7858a..00b28519a 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -116,6 +116,10 @@ overview of their function and contents.
       Specifies if SSL certificates should be checked when fetching. The default
       value is ``1`` and certificates are not checked if the value is set to ``0``.
 
+   :term:`BB_CMDLINE`
+      :term:`BB_CMDLINE` is an internal variable and is read-only. It captures the exact
+      command line used for the current invocation of BitBake.
+      
    :term:`BB_HASH_CODEPARSER_VALS`
       Specifies values for variables to use when populating the codeparser cache.
       This can be used selectively to set dummy values for variables to avoid

