Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C0EC27C79
	for <webhook@archiver.kernel.org>; Mon, 17 Jun 2024 12:24:15 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web10.55380.1718627047156171078
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Jun 2024 05:24:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=RTEwS0oZ;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.50, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2c2dee9d9cfso3687872a91.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 17 Jun 2024 05:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1718627046; x=1719231846; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NSb25w6o2ZCorJwNSUyBgz47BK44vJAml5Tmmp8dkXE=;
        b=RTEwS0oZfR2O3VqetZftMLG5eYgqqlJ5EdP4VHboEzsoe2OdXXN21KRehjb5lgtae3
         WThhviqmTSONLjbqXC+PqO5QT2MlkkU9KORiyjowe/upYDN7IDkfvXPr8O8WcpWjBdM3
         PuqXF28kM8t0vcDQOi917DRVT4Xt2Pw438MsGdRtNOhRyfTv0wRhSSUEymtSx93CgIr+
         dsIoPOyuSWR7jQZSV5RaNn5+lEAmNOC/+L6Tv2RKmJoevm4KnwlZu8BtWzI55TiF6nLp
         OSM5p9iVaEfNfpMIm/uB34sZ5d8p0sk6THN0jMMwqDt+OLEXWyvv3XHkDUL+bVVbvdUg
         ElsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718627046; x=1719231846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NSb25w6o2ZCorJwNSUyBgz47BK44vJAml5Tmmp8dkXE=;
        b=eRTW0DJZxVboaYKZ7ca/r0dMRKImJW09ddH/c7dCQpPbD5Q9YLXmOba5cyHlG7SgMQ
         dFdV7czIDpQYj9t/eLXUj0nI+G2f9RTQFm3X66Y4+ch4MimIM5+zMYNvA3UkBThDXOrv
         xiMdww9NrAt1FNzYaF3eBIqB8lUJj694LIokU+eYrVuFmLBddi+EgHTqlO/8afSaYQIj
         5Ts6x7e/SZ6q6WySp+2sX6xyErin1sZqdasT/O+MKouw3kIZeYx16SrVZ2pj16gpOkRz
         T7QLWDtg+3hm1sZSe8FQHYGaLEwxXoAKf52BXYb44/OIOryfmsUn0ddNSki1xgYjD20c
         sPrg==
X-Gm-Message-State: AOJu0YwzcL0BLrw+RlrJ2Wp72UeJo0I+B9F8ZQQyM7kjnKJhlOmlVs0a
	W6/nI02VV8nviCWT4D/wq8+S5T3nTkcLiw8c+NwLgN2oZhV3azVc7fF1XFkcRitE4FnfkCH7Gjx
	Gnhk=
X-Google-Smtp-Source: AGHT+IFUMPgGqTCK1o0XdtBZ1MV1v5O6wgFT4whH5awtgbVSCdxF6CQuuoyGzjOFjujYVxDqh3Xy3Q==
X-Received: by 2002:a17:90a:c086:b0:2c2:cd03:4758 with SMTP id 98e67ed59e1d1-2c4db132120mr8750970a91.1.1718627046319;
        Mon, 17 Jun 2024 05:24:06 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fedf39b75csm6608259a12.45.2024.06.17.05.24.05
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 05:24:05 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 0/3] Patch review
Date: Mon, 17 Jun 2024 05:23:58 -0700
Message-Id: <cover.1718626914.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Jun 2024 12:24:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16360

Please review this set of changes for scarthgap/2.8 and have comments back by
end of day Wednesday, June 19

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/typhoon/#/builders/83/builds/7047

The following changes since commit 0791e66a47185d6f202af6be0d39e36a8e41850a:

  tests/fetch: Tweak test to match upstream repo url change (2024-06-10 05:57:30 -0700)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.8-nut
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.8-nut

Richard Purdie (2):
  tests/fetch: Tweak to work on Fedora40
  fetch2/wget: Fix failure path for files that are empty or don't exist

Rudolf J Streif (1):
  fetch2/wget: Canonicalize DL_DIR paths for wget2 compatibility

 lib/bb/fetch2/wget.py | 25 +++++++++++++------------
 lib/bb/tests/fetch.py |  6 +++---
 2 files changed, 16 insertions(+), 15 deletions(-)

-- 
2.34.1


