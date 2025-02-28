Return-Path: <eric.meyers15310@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94CAC19776
	for <webhook@archiver.kernel.org>; Fri, 28 Feb 2025 13:01:38 +0000 (UTC)
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
 by mx.groups.io with SMTP id smtpd.web11.14763.1740747697352418258
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Feb 2025 05:01:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=MUIBSfrD;
 spf=pass (domain: gmail.com, ip: 209.85.210.65, mailfrom: eric.meyers15310@gmail.com)
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-728962151ffso409778a34.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 28 Feb 2025 05:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740747696; x=1741352496; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y0pKzo64fXmVTvnpa9SLpvr2kUIYxH8epNx41HFziQg=;
        b=MUIBSfrDIbTH8to8sj3MsUo3IyaTWLPixf/d9z9T29xWjNZo6K3l3Tj8FanpTNaclL
         D88KsuoxKsb9hE4BbkI210dGs4J5LSRo1LzKOPiJ74Y2q4dydQlwtA6UGzEjnRUcF1lW
         heGiI2WU7iiYa4C8OoaM9bSLPWKHyGXAsDwg9btqnSnEOr74xTAkz8dSfGDy3w9zIJMz
         Bk6qjF9OQdumoqJZoMg2YvXxvReh6wunUWWWlsBrujsa4z9xX1ljZYwa9Y4dReR1yBjC
         IdyX2mGtzMwtUtpC2sB1ODM54XRqGGCIe3OjxgvZjWJP9PA+A4+RUnQeqfIPM3cE12xo
         aE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740747696; x=1741352496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y0pKzo64fXmVTvnpa9SLpvr2kUIYxH8epNx41HFziQg=;
        b=D9/1o6zvSL4ZRTfs0AIf3lt7e9IU/81dWsarnlUCxyI5wS4RiGhOQJDmDphr3pSqFE
         RHEV3vO9kAemulX6jsKptZyKR8lWpFKVCQJtI8VPw2ZTIaKppvGxPDJPgk9PEWAmJVYr
         K/tsE6+xN6qUgj2Uztt31e4smRahS/Mdzp7MdWoJI+Bfv/QWhouEJjwdk8brMt+j5yBL
         iDqZ8eP9YwPkGr9Zxe5Xug4p5TI8IBu7+N2nMkgjBBIhMqp3blk47IjQp1m8F19d31DP
         Bm8a8UbjM6MbgaP8++zvz/InPZgfwl4Fv3fZBJGmPFN20XWS6552lA1QX1nCuTCuNL+0
         EPbA==
X-Gm-Message-State: AOJu0YzdhpilJaYOnrdmz47zG9ylqtydwjg/12wm5kpFgSguR7VwoPkJ
	AxanFGckrhZjs6gWkismnjMlk3V/mpBl87grtTNb7/A/6XajDpwiMOQABJ1g
X-Gm-Gg: ASbGncuSIxowcohgrvgusBNwlIfCiTBWL0GbxhmXk0U4WGc9jt/O6T8ZZJwT8dEwgZk
	Mu0N27myU3tGcUe4ieyVgiaV6xT4GutwEQWpHNzHJyPojJkqPPiK4aQ1LEWb5j9AZsyMgSDD56h
	0U0a833BTMhSZiZ0h1ZBDVcyNTwGj7ueJ17PCv8AOI2R/SLvnIEYhKdUSUU7NiGir+tBDA7nMhm
	xC62EwLimM8i3sk8V8R4CEk16nADiMFJWpvdzoUxtp2VtaoFR2AsoFRxw+JXkvFqjTRSSkZSzo7
	tKPUPHmBhH+6YSK3kuKquVNRXOMkikPX9ELsmmHHX7R6z2uZwQJvmJoVK+jrVjZA3rozEdrmvu3
	jKXYlLH48Hpj/yOVkhnC0
X-Google-Smtp-Source: AGHT+IEKE4Ic8TgMeY7FY6C2pGInmt0FityVS/xe0cSXHRBXdjJ8VOfNTiDBtZOmeLmHQwfFpliz8A==
X-Received: by 2002:a05:6830:6986:b0:727:3111:1416 with SMTP id 46e09a7af769-728b8303e73mr1889287a34.24.1740747696383;
        Fri, 28 Feb 2025 05:01:36 -0800 (PST)
Received: from ACT-L-SWD024.yourbase.domain.local (c-73-9-222-202.hsd1.il.comcast.net. [73.9.222.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976da32esm21749406d6.110.2025.02.28.05.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 05:01:35 -0800 (PST)
From: Eric Meyers <eric.meyers15310@gmail.com>
X-Google-Original-From: Eric Meyers <eric.meyers@arthrex.com>
To: bitbake-devel@lists.openembedded.org
Cc: Eric Meyers <eric.meyers@arthrex.com>
Subject: [PATCH v5 0/2] NPM Fetcher Private Registry Authentication Support:
Date: Fri, 28 Feb 2025 07:01:35 -0600
Message-Id: <20250228130137.400-1-eric.meyers@arthrex.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 28 Feb 2025 13:01:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17358

Changes in this commit include:
- npm fetcher changes:
    - Adding support to detect an .npmrc file within user's home directory if the
      BB_USE_HOME_NPMRC flag is set, then append the contents to the user_config.
- Added entry to bitbake documentation for BB_USE_HOME_NPMRC flag
- This is the fifth revision at adding npmrc support, with the first 4 revisions below:
   - v1: https://lists.openembedded.org/g/bitbake-devel/topic/110839321
   - v2: https://lists.openembedded.org/g/bitbake-devel/topic/111289667
   - v3: https://lists.openembedded.org/g/bitbake-devel/topic/111395041
   - v4: https://lists.openembedded.org/g/bitbake-devel/topic/111424927

Eric Meyers (2):
  fetch2/npm: Adding npmrc support for private registry authentication
  doc: bitbake-user-manual-ref-variables: document BB_USE_HOME_NPMRC

 .../bitbake-user-manual-ref-variables.rst         |  6 ++++++
 lib/bb/fetch2/npm.py                              | 15 +++++++++++++++
 2 files changed, 21 insertions(+)


