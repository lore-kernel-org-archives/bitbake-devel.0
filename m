Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD35F588F7
	for <webhook@archiver.kernel.org>; Mon, 20 Apr 2026 16:29:58 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23617.1776702588314145807
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 20 Apr 2026 09:29:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=2jk5wOHM;
 spf=pass (domain: smile.fr, ip: 209.85.128.52, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso33011365e9.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 20 Apr 2026 09:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1776702586; x=1777307386; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IzOoGjz11nr/q1EasMWNoxEoBldEFDaUKaIj3yojxD0=;
        b=2jk5wOHMs2KaleDXJmW9Q89F+oU2ewMG8VCx+66qewUuMKxWw/qUvZxgEDrpUqM+cS
         CUJXFsAs3w9BHa35/IJc5x/Wkq9ZB5V96vr2T62hQ8VDUYdynRoCjdlfexmwa3YWanCO
         Pd291F2zXPTPr4agJ0qyNexL4arGwKAOqlZOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776702586; x=1777307386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IzOoGjz11nr/q1EasMWNoxEoBldEFDaUKaIj3yojxD0=;
        b=Ye5hFNa+a7NgEqN9p5Blb6aFkLztMc11lpkyT19f0JFbMDCC/RJMG2fJ76abzwNsLQ
         GQtKnJA+LJDWJkVmoQ50HQIYSpM2ZPIp7xNVm+UjxAWnGVvK7IIL8Gz9jOt0TtpiVz8N
         5rlk2K1XFC4TMEaDESH3YdY/jTUiOhMmf2Chd9Pt8aPUp0wNSF0NVTz/FoxEflIagb4j
         alC+2xtXEIRGOu+ElyzDp8m/dQHRU0OKjJsMJYqeA/POsRqEYRdaa8wzSh+a5qydyEBg
         agMfNualocVvNTcrNGVR3tcSCH+TY3YVhw4DTr1Gfd/T5QOV0O8/sbBL6ujF1AZGecN3
         TQQg==
X-Gm-Message-State: AOJu0YwgVa3uWdjNM4gJrOTYEcVzOnFqki2j5g5iixYycCMfmaHpwA5n
	a6Bff5h6GSgpMCC51HKRx1c7cXer9+HeEf9gilJU2POK9JPCGq0+0KKhqnD3ueojSBTxIgsaQiv
	zkHgj1H8=
X-Gm-Gg: AeBDieuKr+ArKMVjVZGsqqDKfLOhw1FScnAjnM/i92pyFPyurOBGUrWB90OWBV8rQRc
	/1avBUODZrQ4NTo/HcuYtWr/EbpcLYCIpSl/uZ7/Xz5UVz/qofYQbR8CwjKVeZkgmwFyauD7Xnk
	qg3wjZm7kOyXDDnKpD2zDQ1++pYvfs7j9khQaiM19MQUrvxs2ZgD10lMVzTHJgmCmzPnSKykjGP
	vkANDPimIR4h9HztdhaEsgv/EBQQnN99QxEgKlpRssXQovdla2jszuY0rH2C6vZSUhdqRapjQB3
	tDXaZUexBjtrwlft6MD0EGu/l5DanivPEIWD7Omgt/ZMHdmTTwZv/94JTkPjq/oRxNtFH0IGi0v
	N7iGiFk/qs8X04vAFgV/+YH5UNsvYp3I9cKzUWku9ziZIOxY3vzBFchVWqvq7rMA1AcCzoh9LDP
	ld6NJVGxImM3252a4PLKb6Lf1GTYwtdP3x6L0oXDb+NTt2Qlh4YREHU3mQcSAxMc5UuefI53dDQ
	QTkX7jjJtQOSgmjpwsj1NTzhshWTtW1RPoFcDj8SyR6
X-Received: by 2002:a05:600c:48a1:b0:489:a4:e58a with SMTP id 5b1f17b1804b1-48900a4e881mr98480545e9.19.1776702586325;
        Mon, 20 Apr 2026 09:29:46 -0700 (PDT)
Received: from FRSMI25-LASER.idf.intranet (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d6casm28431943f8f.32.2026.04.20.09.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 09:29:45 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [bitbake][whinlatter][2.16][PATCH 0/2] Pull request (cover letter only)
Date: Mon, 20 Apr 2026 18:29:38 +0200
Message-ID: <cover.1776702471.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 20 Apr 2026 16:29:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19371

Those are the patches from the last patch review:
https://lore.kernel.org/bitbake-devel/cover.1776322491.git.yoann.congal@smile.fr/T/#t

Passed a-full on autobuilder:
https://autobuilder.yoctoproject.org/valkyrie/?#/builders/29/builds/3678
* qemuarm64-ptest failed with #16150 - AB-INT: oe-selftest-armhost: Failed to start QEMU (hangs with drm)
  https://autobuilder.yoctoproject.org/valkyrie/?#/builders/61/builds/3503
  * ... but was sucessfully retried as:
    https://autobuilder.yoctoproject.org/valkyrie/?#/builders/61/builds/3505

The following changes since commit 7af7e04f3adc8ba144d9e2e6b37ed4ddb3b59df0:

  bitbake-setup: ensure paths with timestamps in them are unique (2026-01-26 09:06:04 +0000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.16-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.16-next

for you to fetch changes up to 713fbbdb9ecc195ceb2216a2345e0d79dbee2135:

  runqueue.py: make sure we use bb multiprocessing (2026-04-13 16:17:31 +0200)

----------------------------------------------------------------

Richard Purdie (1):
  tests/fetch: Avoid using git protocol in tests

Trevor Gamblin (1):
  runqueue.py: make sure we use bb multiprocessing

 lib/bb/runqueue.py    | 3 ++-
 lib/bb/tests/fetch.py | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)


