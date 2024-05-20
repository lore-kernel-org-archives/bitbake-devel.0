Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E51C25B78
	for <webhook@archiver.kernel.org>; Mon, 20 May 2024 13:38:26 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web10.60459.1716212304676046076
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 20 May 2024 06:38:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=BNCk9zpC;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.181, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1eb0e08bfd2so77036875ad.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 20 May 2024 06:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1716212304; x=1716817104; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=318IvN8EsiCRPceSev1XVSRgLEp4MuZ0e4cwbJkjmTU=;
        b=BNCk9zpC2HqYiDC+tBXtWg2SBaDm2ZXmw0FhBGyiZ3ubVrMJbxuD5zCvUGyjIHqlvP
         1g3lakiESZlxolbufX3cL49hMdInaxeL090w0igbUj2kr6/CMtRqjabb/c63c0nT4hvA
         dIn/DePQjV4tMwJZRN6cGNol1JVuFUCB2szbE30rleZRWa2ehSsHmmKw7ZkI0SK7uB/9
         ZI2HMi2M7beKb7cvBtNv68xQDxItsg/kEAgUZSjsbc+EBbihqyKT4s5GHWmMqSU/ZiJn
         Gka2rGwI45legjOgs/trhEVKsrN/T2b5c+7BC7mNk2+DIjp5cQmBW9nuX7rfQ0D18G87
         J+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716212304; x=1716817104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=318IvN8EsiCRPceSev1XVSRgLEp4MuZ0e4cwbJkjmTU=;
        b=jxB5JCpLhi+C6Hx+VHqhHd50cSpSCgEYIFjU5MXdOP0Ye1hqDteiv7le5kU6PlQnmD
         EcmHZLohWvjS+SO562qVM/4K0EF0z3DmwUYybyoLS/KxDxc3e+gJnLTRJmYzoEVneqFK
         sY72zfPHJ1pnTmzH8hMA3WU+l7r+K6Zlx0Y3GKlm2WfFknnaxhyrubLS3saqhCsJoLik
         aLX0S22luDwsTzz/a5uSZpnSkWT6qfUKUmegXHbUU1RGG/GYqeW7wxAGr2DFrg/XsVUy
         +CRzdRuo4WWcv6A3bCOvmf856c1xO332cTg2mG1KsaNQtrxvDrXoed91ArzVahQAAmID
         S2tA==
X-Gm-Message-State: AOJu0YzWCDpmY7Jfl+pPgQCtpxKCUbChMsf9ddlUN4yXAelVXB2oPwxi
	eonb9UB/SLDNKAADHayf4i1qgTQASUdi1WsbGbD6/OInSkj6irnnLYbkv18YuNLqr504uox34ek
	g
X-Google-Smtp-Source: AGHT+IGIATUJGY9wOyCJ3ltOR9ev7lZKSzgPlxC9OT/oEVG/Y0wScinsqRH4ubejdqNqUUtVJ7gX4A==
X-Received: by 2002:a17:902:d4c3:b0:1f3:633:976e with SMTP id d9443c01a7336-1f30633987cmr14841125ad.54.1716212303749;
        Mon, 20 May 2024 06:38:23 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad62bfsm203943405ad.74.2024.05.20.06.38.23
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 06:38:23 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 0/1] Patch review
Date: Mon, 20 May 2024 06:38:01 -0700
Message-Id: <cover.1716212099.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 20 May 2024 13:38:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16233

Please review this change for scarthgap and have comments back by
end of day Wednesday, May 22

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/6937

The following changes since commit 8f90d10f9efc9a32e13f6bd031992aece79fe7cc:

  cooker: Use hash client to ping upstream server (2024-05-02 16:07:18 +0100)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.8-nut
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.8-nut

joshua Watt (1):
  cooker: Handle ImportError for websockets

 lib/bb/cooker.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.34.1


