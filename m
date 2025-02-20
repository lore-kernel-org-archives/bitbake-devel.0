Return-Path: <eric.meyers15310@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20BCC021B2
	for <webhook@archiver.kernel.org>; Thu, 20 Feb 2025 14:30:32 +0000 (UTC)
Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
 by mx.groups.io with SMTP id smtpd.web11.50644.1740061830987860904
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Feb 2025 06:30:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=PMUDIYhX;
 spf=pass (domain: gmail.com, ip: 209.85.219.68, mailfrom: eric.meyers15310@gmail.com)
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-6e65d6e1f12so11232586d6.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 20 Feb 2025 06:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740061830; x=1740666630; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GJq2J9mo0rsPm2nXi9SUbbnNK8e81BUKCcNwXRlmBJQ=;
        b=PMUDIYhX++z9pv24bGCmMZ+TD5jP1yS2A03vNY3THS36+6mC97FI79p8i3Ey99m+z+
         rruBalfrh9HbEqrf8JE1uwKyknQCz2C9fbM2upRarsk6fBYFtJadi0gMVSYQDL6fD4lg
         LWc1HCS3svZRvOmHCIVKmGlSpPco6Zft3jVd0b8gz2zv9EA/8P6AWgujjNXGtizjebZ5
         1awqVvv36OtG6C+UYNFW7BrBE4yuTzuVcJmwxC6S53K33VdrzXVtz+rODRG9gSAb9Sly
         FLvn0I+zS+CJjH/NsJ+4Y9HJhu7PWcYBsNZ0bKHtEdxE/EeA3v1RGRii00oSflJFAJUY
         GAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740061830; x=1740666630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GJq2J9mo0rsPm2nXi9SUbbnNK8e81BUKCcNwXRlmBJQ=;
        b=UFcdQCGfIsnTcjJoCDioZfHaAmAgddu0r6bT2bLzU1zWG831wL7Fu5SFsMJx0HxuwV
         NpDnBDLUe+9WHq4lXagv1AG+gx8nqfHoaPYlIEPCZNuR8eKr0iGlxaBFykYsd618U24y
         +iNpAsZVKMFLWeYSNX+ih7eT+pxo7luM3ZGwrpqc58au2HB0MRrKyvI77KBtYaY40k9E
         UlQBAXGrzXWi/Rod1EJwSqTi07d+p+l0TXji8bRa+FoGDA6SeHuPoynWjpu79dJDtv/P
         YqwoDztjPiKJgnAlQXevVSW58dN1kTRFPud3hmHr5Ho9QeTLOqZqh62K8HYPCa+njNY2
         Qjvg==
X-Gm-Message-State: AOJu0YxMC+VX6kG91djVgKaLqqio4rCITnCEc3qFQv68pEkk0mQOEW5H
	Bvd3507bX6Jay8D16k02ur+AX0F4xi0B/C956G2jvrGkFc1PZL10pkKFje5m
X-Gm-Gg: ASbGncu3TpVQRG4BTdqQUIu6HVuPb1NBrO8pusPdsIV35XHbKCxB2UxutyJbr1xgH69
	52OvGF6hGVZNLdiTFLSQRCFFxnfc7HJWzcsWzJgDfa07z0f9vX9PkjQJajkgIYBdjkUWWCbqtQ5
	62n+3y3lf7W5psVwPxttNIf8wRQQfszADysDWidM4mGj0oppm4vH0C3mvlJC+mRm/pVeLSqUsuj
	V88sF0jdgyBIJxoX6itbpWeMvTKzwk3i1DnnsDMNrFmaoxnHtsl3izJWDJGxjTbn98E8Dbu5U/n
	R6XgD54AQe4AQHDMnG+ayMLhHnSEWSic+c5OwGP/v4wqrOkM8ZGN3FbX43laIKnTBqeTgfkP93d
	619GytEHTsENk
X-Google-Smtp-Source: AGHT+IGvCPB2yKQNO0eaU4BU06mrFrIo+Re+NGGJZhsl/mm8hXW4LGRvqLoEHKkrhAsxtBrVNAlFLw==
X-Received: by 2002:a05:6214:ac7:b0:6d8:9062:6616 with SMTP id 6a1803df08f44-6e66cc8b65emr378403636d6.7.1740061829796;
        Thu, 20 Feb 2025 06:30:29 -0800 (PST)
Received: from 5748df6bdb91.yourbase.domain.local (c-73-168-239-54.hsd1.il.comcast.net. [73.168.239.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d785a4asm87110116d6.29.2025.02.20.06.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 06:30:29 -0800 (PST)
From: Eric Meyers <eric.meyers15310@gmail.com>
X-Google-Original-From: Eric Meyers <eric.meyers@arthrex.com>
To: bitbake-devel@lists.openembedded.org
Cc: Eric Meyers <eric.meyers@arthrex.com>
Subject: [PATCH v2 0/1] NPM Fetcher Private Registry Authentication Support:
Date: Thu, 20 Feb 2025 14:30:29 +0000
Message-Id: <20250220143030.12982-1-eric.meyers@arthrex.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Feb 2025 14:30:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17255

Changes in this commit include:
- npm fetcher changes:
    - Adding support to detect .npmrc file within user's home directory, copy it over
      to the tmp npm environment, then append on any user configs passed in. This models
      similar behavior within the wget fetcher (which uses a netrc file for auth).

Eric Meyers (1):
  fetch2/npm: Adding npmrc support for private registry authentication

 lib/bb/fetch2/npm.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)


