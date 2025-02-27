Return-Path: <eric.meyers15310@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D50CC282C5
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 22:34:44 +0000 (UTC)
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
 by mx.groups.io with SMTP id smtpd.web11.2929.1740695677649484621
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Feb 2025 14:34:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=kiot8En1;
 spf=pass (domain: gmail.com, ip: 209.85.160.195, mailfrom: eric.meyers15310@gmail.com)
Received: by mail-qt1-f195.google.com with SMTP id d75a77b69052e-471f9d11176so15432181cf.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 27 Feb 2025 14:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740695676; x=1741300476; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rg7b0h9HryF0MPH/UDRt86Q+UJRb524lJk6R+iFm3cU=;
        b=kiot8En1wdkpo0QElN9bZ24yPQrOhLdChDrM14FVrAUInBi5I3/3YNIOj89cfwIp39
         l03wnJOC4W/c5M90+sAXHxrAEPiKrNYXTc/9pUMPO0r0nCsh7felPm3eVt8YsG6o/zte
         Lc+pDOTKgmPtMpBFzEyjI1YVs5IF1QvyKetI0utdqqvQ7FNtCh1AIAiy+igc+ScfTt1q
         LOlxa8sVFu6ZuQHqjNwmBK5SifMzLI+LC79PdkiPhjq/xRa4jfiJXpno6mfeVsoCGGfZ
         QgP5vC13oe/G1+SpyJ6+eFdnw5WbgCo5hQGRyzIfjT69llK+K89HYoyn6adi3sZZgLNM
         UrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740695676; x=1741300476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rg7b0h9HryF0MPH/UDRt86Q+UJRb524lJk6R+iFm3cU=;
        b=gO8RTLLZHokmKpolYm8lwgX2rOw0HLF1SORqa9M6DXEzp9vLM9iH+zGLIIO3BA6jZM
         aY+csblYrQOwJZBArNyW3XnV2tmE2n8Fo95cSeBwj5Hrf2AvUpTp1quFiC7vtMFOBoHn
         EpZhXdP1tbNawMGBzRdDfRMYX61LEHR9kfuZLc2PvN4+PNOsldy2IeGzM0znhqr2vmCV
         of2jD6NBSLDw57q87RJMudA8dtaMpgABJ6+tHI9lIZV0A1a9jYpXkAHzvuUm++5t+eVj
         bR5q9eBLCx5IlG30+dd7mGrecvTO+9RKJMzQ8AoFEcO9Gk/9ZIX52qMM3B70zyASyCJK
         isAg==
X-Gm-Message-State: AOJu0Yxr4Dg+T3AMZmwxZwOY+qy0U+1HDyTfbupmHZzWYov7TdsoUXm9
	lBS6PS6rBdMJMZ0pNEGIYVHnETa+JNNH8g4T4bHQZQxRQeOKAJXZw8zJ9vC3
X-Gm-Gg: ASbGncs8VD8OlOiVui2hL9Japfa2EcmshhVYKVT1LqQ86lLwGuJ3hTSw/fur54bz00B
	NljCWcLoEVAb22PxcEZt5KFDihmf5I/DlI9Xew7QR+GYK8dncE5i2MNFCVOCWM7mKfAKAs4QSOu
	ss0pKquzFHxDomPjEAdXNhLMyMc4vk4jzPqPr6Jn2IrDQXIzV/eCbMNS/J/SIS8KBTosrEAjaZ+
	O5/4acRYifZrWF0RcUHmQgqMksFpQ6Q5RuaqxRILtjHa/WIPHLqucwDhWgLMy5hMeo8fKK5QIu6
	L6HDvI8bI72kSYaaxEFs4pqEnuoR6T0vxnM1SFuN3PG0WSZFkuNcr5cdps2jyN7mFoaGers8Tx0
	KJbtogCjOJO1moD/wfzS6
X-Google-Smtp-Source: AGHT+IESFZpO6dhTo45s397rMyrkXd2lFJMMEATatnmygUPxsK2eMqczmMVG5m49Hy5cJSsIRLAnuQ==
X-Received: by 2002:a05:622a:14ca:b0:472:11b8:918d with SMTP id d75a77b69052e-474bc0992c8mr12548511cf.30.1740695676541;
        Thu, 27 Feb 2025 14:34:36 -0800 (PST)
Received: from ACT-L-SWD024.yourbase.domain.local (c-73-9-222-202.hsd1.il.comcast.net. [73.9.222.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474721c0a64sm16763341cf.42.2025.02.27.14.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 14:34:36 -0800 (PST)
From: Eric Meyers <eric.meyers15310@gmail.com>
X-Google-Original-From: Eric Meyers <eric.meyers@arthrex.com>
To: bitbake-devel@lists.openembedded.org
Cc: Eric Meyers <eric.meyers@arthrex.com>
Subject: [PATCH v4 0/2] NPM Fetcher Private Registry Authentication Support:
Date: Thu, 27 Feb 2025 16:34:34 -0600
Message-Id: <20250227223436.28224-1-eric.meyers@arthrex.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Feb 2025 22:34:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17352

Changes in this commit include:
- npm fetcher changes:
    - Adding support to detect an .npmrc file within user's home directory if the
      BB_USE_HOME_NPMRC flag is set, then append the contents to the user_config.
- Added entry to bitbake documentation for BB_USE_HOME_NPMRC flag
- This is the fourth revision at adding npmrc support, with the first 3 revisions below:
   - v1: https://lists.openembedded.org/g/bitbake-devel/topic/110839321
   - v2: https://lists.openembedded.org/g/bitbake-devel/topic/111289667
   - v3: https://lists.openembedded.org/g/bitbake-devel/topic/111395041

Eric Meyers (2):
  fetch2/npm: Adding npmrc support for private registry authentication
  doc: bitbake-user-manual-ref-variables: document BB_USE_HOME_NPMRC

 .../bitbake-user-manual-ref-variables.rst     |  6 ++++++
 lib/bb/fetch2/npm.py                          | 21 +++++++++++++++++++
 2 files changed, 27 insertions(+)


