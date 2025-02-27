Return-Path: <eric.meyers15310@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAA0C197BF
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 22:34:44 +0000 (UTC)
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
 by mx.groups.io with SMTP id smtpd.web11.2934.1740695679210018345
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Feb 2025 14:34:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fMRLK8Mt;
 spf=pass (domain: gmail.com, ip: 209.85.160.194, mailfrom: eric.meyers15310@gmail.com)
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-471f88518c8so8790551cf.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 27 Feb 2025 14:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740695678; x=1741300478; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CW4v4gGgqzbfkkRY2rB2M/5k8R7jb6PV5sInopddLlM=;
        b=fMRLK8MtghAydVu1FVB4BtUZkTDygbpp2lLFQOBsDemjqlRTeYfFCPCDZJJdQPOrPT
         l7lV1n3dQaBSCyLGDUvfSmYJRXLYUHHtE9pWahqQuBQcE4w52r2p5/DvoTa33svsex8R
         J6bwqqxK88+rFAC7Ybz3kOlgeHEz5oAzJfcZMB14XvcT9oOs/9/JC2qTuSh5gNzRM6zb
         CEMmnwSJDIOYIcEH+8HZZY5aqU2sG8I5cObNTgxK4LODWHRVObRgddJRZy0DhiSi2LBz
         Q4i2Mop8QdsyTenSn6BtcuWzAd3hlq1fdl4ddNqAJDA5F2vlTbpQ9NLb2OZkUuszO0Hx
         4F2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740695678; x=1741300478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CW4v4gGgqzbfkkRY2rB2M/5k8R7jb6PV5sInopddLlM=;
        b=Pn/jDotp22dtsML+RR42eUAIw2fLoqtU7OFqoC3/5cinl/djVFM2Juy6K9xife2Sy3
         9CMRNWSf8qX0zPvBf4JlhZpYD24gnVPlTvnM4IkyqC6/5tiTEk151l/kykGvgrCftKpS
         ZpfR9+52Nq/USm1uyQKmhL5Zkn3caCSocmbKlK3Ez1HB+VaQxCO8XVb1InkQquCgCwyL
         DRhSHo7NxkAqOXUGLwsCuY5MNZq3EGUMYVH3sEOXpJNVnoSb63RcGRIHnHYKXrBvBA2B
         C2ru93gL10kXAEuGtccdNpW5Fn/Xlc7Uyw8A5uuL1bEo8KD9eH8BjrMOkED77quc3wr5
         8O0Q==
X-Gm-Message-State: AOJu0YzDLADpMc3ZyftES0BihhMvjcsyJfVTdeUdvn2sgkMe9hvQ5PCB
	PzT4mC+0i5UjZev/tRbXsp+Ic5VE0TwYfLbz2r1JZdbIBtlPxEE8soxtqb9J
X-Gm-Gg: ASbGncvfNc6/7vsJ5ScxMutbHP0F6ub1zC6Gpw/LE6ckZX7bpXvQqPbiTAvLnvlAXMI
	3TuFLFKNLWFNjJY8GnR2BkAtoMlprYw/s7wV64u79haXi3vky7ZwfU1f1Lq/KY1ABOmlPcHFuOq
	8CN8XCL1uDPy2y2D/gGqHm92ZEqvhLAapFVsQbv8leheGgGADfdKsTd4faPamny4zrizj/qR1+y
	zrjDrbmVskWdn+RTDt+3TdJ/6dk+uQEkMBLOTbUPPI7oR5LlS/b61si6zQcvEpp2uj0tY4ImvJh
	C8p+gV3K2KuhMMxE+mUQQlZkNH3/1nlKAEJXx5Z6S11vyp0dSMvMB/lh653DmsvWhpqESTxS1h6
	J3LElc2upLU7P1NrV2srm
X-Google-Smtp-Source: AGHT+IF+JUDJl4TSuJhpOnQ9hvlr7V/lRAZPRqm/KeV0Eln0b1vctkMlNvD9IA8W8wjUF0TRG/QZYw==
X-Received: by 2002:a05:622a:20a:b0:471:8d66:cd68 with SMTP id d75a77b69052e-474bc0554ddmr12367101cf.3.1740695678127;
        Thu, 27 Feb 2025 14:34:38 -0800 (PST)
Received: from ACT-L-SWD024.yourbase.domain.local (c-73-9-222-202.hsd1.il.comcast.net. [73.9.222.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474721c0a64sm16763341cf.42.2025.02.27.14.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 14:34:37 -0800 (PST)
From: Eric Meyers <eric.meyers15310@gmail.com>
X-Google-Original-From: Eric Meyers <eric.meyers@arthrex.com>
To: bitbake-devel@lists.openembedded.org
Cc: Eric Meyers <eric.meyers@arthrex.com>,
	Geoff Parker <geoffrey.parker@arthrex.com>,
	Chuck Wolber <chuckwolber@gmail.com>
Subject: [PATCH v4 2/2] doc: bitbake-user-manual-ref-variables: document BB_USE_HOME_NPMRC
Date: Thu, 27 Feb 2025 16:34:36 -0600
Message-Id: <20250227223436.28224-3-eric.meyers@arthrex.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250227223436.28224-1-eric.meyers@arthrex.com>
References: <20250227223436.28224-1-eric.meyers@arthrex.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Feb 2025 22:34:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17354

Signed-off-by: Eric Meyers <eric.meyers@arthrex.com>
Cc: Geoff Parker <geoffrey.parker@arthrex.com>
Cc: Chuck Wolber <chuckwolber@gmail.com>
---
 .../bitbake-user-manual-ref-variables.rst                   | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 858de6347..00300d0d8 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -692,6 +692,12 @@ overview of their function and contents.
       Within an executing task, this variable holds the hash of the task as
       returned by the currently enabled signature generator.
 
+   :term:`BB_USE_HOME_NPMRC`
+      Controls whether or not BitBake uses the user's .npmrc file within their
+      home directory within the npm fetcher. This can be used for authentication
+      of private NPM registries, among other uses. This is turned off by default
+      and requires the user to explicitly set it to "1" to enable.
+
    :term:`BB_VERBOSE_LOGS`
       Controls how verbose BitBake is during builds. If set, shell scripts
       echo commands and shell script output appears on standard out

