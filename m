Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0182C47072
	for <webhook@archiver.kernel.org>; Fri, 29 Dec 2023 16:15:08 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.web11.151765.1703866504720440988
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 Dec 2023 08:15:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=cI+h/Hq4;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.179, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6d9b1589a75so1395624b3a.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 29 Dec 2023 08:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1703866503; x=1704471303; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KJwiyq6pE1D6ApFyYT3pE/bs75rhnnUaX8D+b+4x6RI=;
        b=cI+h/Hq4ac002+h0ywv263Si6D2gQQ7lDdFGFTLJ/miw6uTdrmqanmxo8II8BtIU2t
         ZzMLK9dlniuNzd/YcgYxVFTFyU0w1K3NCTPx0oD/fNo/UOFpewT7iAhUByjFSFTyjAAi
         1j2w3XgCgPNvwRLiGBdkuFeeqUQn3EED1ArlcY/k8S7FBOtB6Zw74MbMaAIR4hYeJDuT
         hiGCEu2QeApfhloekOzAwuNhONvnsu75um9vTndwkhWwTbyxjj+nbXlT5MSNErSfpsIt
         ko1scpm6p2mfWMCHbG25WibJI0FMxRzSBq/mW6iOgF86HlGcyPsUazRLDCH0+ZWwUlph
         o3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703866503; x=1704471303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KJwiyq6pE1D6ApFyYT3pE/bs75rhnnUaX8D+b+4x6RI=;
        b=lrTvnzwlUa5N5tT38/6+/y372IN20Awy6GGWm4OKqkkCwBqXqwx8Bl4m6hVEzKo+sg
         M03IZ9Mgs+fTA5l40SnU3qdsiyeqssTVW2POJsbj/daX2kTRa0dYvF1wIEb2bZRfddkw
         yMQevyK8QxkPkpmj2hUwvST9S16YVNL5/MGyTFDkyHFzMBsTRXYfigzABlF3gN/o/wb6
         FxSsTRjcug5d6FwyODw1+Xp0dXP57EI2qItMuwoRPRAMMcawRVj3Bfhfwb7yVzpD4mfI
         MUGUoEQnSRXb4GBr9HLkuKucgVVmI7x/ZKE5iEELcS0T8cIxYXNEvB3Cn6VYxY3ZXfFO
         XH1g==
X-Gm-Message-State: AOJu0Yz17CqddZMYcN0FcpBECeT2SSZZuGecXWueUrRJNHQiXerwAwAP
	XeTy9Z4UdCCgtBN1Tu0ZXT0P6Y0eOTNb8IEB/cx7+FfCvWsxHw==
X-Google-Smtp-Source: AGHT+IGxJBtlg+qhXWSJGz9X0+UqwnO1DSwRQXHrW35cSJMPhhFPjdGeu/Tw653L7az/Rp5X7EeriA==
X-Received: by 2002:a05:6a00:13a1:b0:6d9:98ea:e8ad with SMTP id t33-20020a056a0013a100b006d998eae8admr6479413pfg.47.1703866503379;
        Fri, 29 Dec 2023 08:15:03 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-234-108-41.hawaiiantel.net. [72.234.108.41])
        by smtp.gmail.com with ESMTPSA id lo12-20020a056a003d0c00b006d70b0d4639sm9977231pfb.107.2023.12.29.08.15.02
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Dec 2023 08:15:02 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 0/1] Pull request (cover letter only)
Date: Fri, 29 Dec 2023 06:14:47 -1000
Message-Id: <cover.1703866393.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 Dec 2023 16:15:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15725

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/6384

The following changes since commit de1cf0e31f3836a449cbd17490a2f6b6a86b17f9:

  toastergui: verify that an existing layer path is given (2023-12-21 12:31:19 +0000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.0-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.0-next

Insu Park (1):
  data: Add missing dependency handling of remove operator

 lib/bb/data.py             |  1 +
 lib/bb/tests/codeparser.py | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

-- 
2.34.1


