Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
 by mx.groups.io with SMTP id smtpd.web10.31953.1613400433406457569
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Feb 2021 06:47:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=XKWzpxAL;
 spf=softfail (domain: sakoman.com, ip: 209.85.161.42, mailfrom: steve@sakoman.com)
Received: by mail-oo1-f42.google.com with SMTP id z36so1582242ooi.6
        for <bitbake-devel@lists.openembedded.org>; Mon, 15 Feb 2021 06:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iE6uNk2tW7qmAouBX90Nkmv0Uwbc+ZgQMq9xKKGEvkI=;
        b=XKWzpxALFeKaSAHyoMGBNYLxu4f0InYkgssSEvFMr1WzKCkDOkGyXZLIF+uam+I+7s
         c5Ku0xToxRrFAUd2TEFFgoaho+h66cPuDJ2jYDrqstoijXZHrrXiyFhZFoPMSr+UQpQx
         /pqFhfhLnwZK2MLol2mxKVs/PcqIyuL+LOCCcaJ8xGjrFULzGZkp4lLaf7JgJzan48ZQ
         IXWVRbpEzggnq4r5eAwVi1SttKXrDoRfO6RPdwFexvvzQunP0Drlr+eC23txgw7vUSI7
         02GO8vyshYMS+L9BfijHrvbH0Jw1hvqPPz5CEgcy5oE1yTFbPPjYoHWDaUepfelwsmDA
         N89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iE6uNk2tW7qmAouBX90Nkmv0Uwbc+ZgQMq9xKKGEvkI=;
        b=jcJJYcFlsU7rJnYAlf68WhJb20sYmnodDHK7x8XuCt4XJwKP+tJ1upwljG7JFuod9D
         jfEHz5lsTUJeZpsk1M/oapmy9wdMsO4Hsp38HVJcod7nCOb+j1V2zhHiEGQGZ4qV0qFd
         Rw8l31AEn1w1VZOpK4v9nm0mJEYFj9yjkCrkQTxII8B5DSVzgDYoDslNtZAnoSk8KpAQ
         lAsALbFSNr7H3XsfmtMBBs31hebUFfYktZ/WRPoCQOEz81IDrTRCgPRHemqhN8RnMaTn
         j4HZTlWwRhrvTIWV/1t8UAuY6wZpB+XP8+8iHSWHUZXYxR8LKQoX0Qg5403Z1gMyNxHL
         lbuQ==
X-Gm-Message-State: AOAM532O72tTrS9xrramPa9oRDQuJNLe/atyyrg/noJrhWMUGpd8q1jL
	mGthKFRtblqu8Y8kGCQGJpWv0Z+Zpi7s4F/3
X-Google-Smtp-Source: ABdhPJyl930c6ZQ7HPaCBRTXAb8r1HxCak5C3WEIPI/8Ac3P+9Y9CYfoCXresPmW2Ch1JfIhPYgpkw==
X-Received: by 2002:a4a:e978:: with SMTP id i24mr5664207ooe.89.1613400432361;
        Mon, 15 Feb 2021 06:47:12 -0800 (PST)
Return-Path: <steve@sakoman.com>
Received: from hexa.router0800d9.com ([72.173.249.164])
        by smtp.gmail.com with ESMTPSA id i23sm3785995oik.10.2021.02.15.06.47.09
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 06:47:11 -0800 (PST)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 0/1] Patch review
Date: Mon, 15 Feb 2021 04:46:51 -1000
Message-Id: <cover.1613400108.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch is associated with the python3targetconfig patches currently being
reviewed for oe-core.

Passed a-full when tested with those patches on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/1852

The following changes since commit 2351b496bb63b96920d4ae67bec816f00d510df2:

  fetch/git: download LFS content too during do_fetch (2021-02-05 12:18:26 +0000)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.46-nut
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.46-nut

Alexander Kanavin (1):
  lib/bb/fetch2/__init__.py: drop _PYTHON_SYSCONFIGDATA_NAME unsetting

 lib/bb/fetch2/__init__.py | 5 -----
 1 file changed, 5 deletions(-)

-- 
2.25.1

