Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B20C27C4F
	for <webhook@archiver.kernel.org>; Fri, 21 Jun 2024 12:07:10 +0000 (UTC)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
 by mx.groups.io with SMTP id smtpd.web11.71430.1718971626254068801
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Jun 2024 05:07:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=xvmw8RP2;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.171, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70601bcfddcso1826838b3a.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 21 Jun 2024 05:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1718971625; x=1719576425; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BpGSjntHTfa8gUanvmzYHOqpWfpnxmPJcmcmwwH1O8c=;
        b=xvmw8RP2SaLOUxL356Cd4sbOUKr10ZwGcsNpztiXJgGNNR/tT0FuqqPZDgQcs/jYMk
         PSs8E4hdW3KA2jgsxxUKRSTbYqJirhZekhEb5LojFeG9g/Jq/bO0acxv7As/shSVJERl
         nszcX4NVCLvxOHYHswBNQAPmGNHdGOKUes3B7YP9zLYLPCHMRwa+2uQQGrhSkBHW9o8/
         pi3OeOkmyXrvFIgigPXb1r7XcuK5bCofPzPhJRnD1XWkTusVSXjzAzqvcTlqZEQE1Ygn
         /mQh7TJLUaN0zuey+jkfFAxRwggE0CjipQ+QJA2nu2qcLxQzqbI+uh5OGSXPrfX3juox
         A5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718971625; x=1719576425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BpGSjntHTfa8gUanvmzYHOqpWfpnxmPJcmcmwwH1O8c=;
        b=TajX0INFv5ZiS8SW59u5ZzJ4lbw7in9BD1cgzpGtUHp+qb0K6w2vUZwqtDaOzEoBNR
         1DhzEYAzc06QlO+x/LkltcISlM60GeRts7x+M7EqtGPTsDC/+y5HPaHzg431Xj8CcplN
         3ZkzXuJFX9g3/Es1gE8vxQDnNP04+M1OfExlUqvsQ4T1nadVAFbKO5NymJMSRiB8FBRN
         9OghJuTo82v253+Z72cskCyR3y6khH68zZ9q6AXFaI1we+9GdAN5aHU/PXjDCPlOfc6S
         E4oe+3++qF01ZeaRsjfixbdfEjT98cPj1tEJ5z77MY00Z+jtIbYHrVsVd9SLpYYB1Pkd
         iShQ==
X-Gm-Message-State: AOJu0Yy1tpviqNWJwORO5b6fGwrR3xtVx8xzuHgFmhHmAJ9+JPK+qCxC
	qYTjDU0pGKLcq+34M2YHkLPy3br5a7IlH4yJvFZfZQsfK5WW5eOrAEC8S33DUZkQINfoVtnHxsw
	P
X-Google-Smtp-Source: AGHT+IGq7BHmRsZgO9srjbhHGgkykjIHbssaVejohzjDlcKAsinQ6F498ntQwAlk3XTNRu1sr7PXaQ==
X-Received: by 2002:aa7:9291:0:b0:706:337f:1ab7 with SMTP id d2e1a72fcca58-706337f1d69mr7589860b3a.34.1718971625181;
        Fri, 21 Jun 2024 05:07:05 -0700 (PDT)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706512d3034sm1281665b3a.170.2024.06.21.05.07.04
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 05:07:04 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 0/3] Pull request (cover letter only)
Date: Fri, 21 Jun 2024 05:06:53 -0700
Message-Id: <cover.1718971544.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Jun 2024 12:07:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16369

The following changes since commit 0791e66a47185d6f202af6be0d39e36a8e41850a:

  tests/fetch: Tweak test to match upstream repo url change (2024-06-10 05:57:30 -0700)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.8-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.8-next

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


