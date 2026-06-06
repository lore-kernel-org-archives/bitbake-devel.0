Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66516CD8C88
	for <webhook@archiver.kernel.org>; Sat,  6 Jun 2026 21:12:46 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23180.1780780359729199660
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 06 Jun 2026 14:12:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=crwvdDZn;
 spf=pass (domain: smile.fr, ip: 209.85.128.46, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490bc6a7958so27297885e9.1
        for <bitbake-devel@lists.openembedded.org>; Sat, 06 Jun 2026 14:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1780780358; x=1781385158; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=19aS7vgv1du4Ht+7WPbVAuLhjgw9hWf2EahN3mB6qDk=;
        b=crwvdDZnEU9EROC9Y8Lrdd3RU7WFMCJeo4ANLr/0NqxrILl1ogkX4E7EPIRRSBdGPl
         eGugde54C0HiWBxyA0m2RIgaP0F5GabyZCOglrXgcIWFq6SZu9WeeTQvV+zWfGHdlH1e
         URCtBf64Ly0prRkeYjMqVyi9I+p0y7tRauc5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780780358; x=1781385158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19aS7vgv1du4Ht+7WPbVAuLhjgw9hWf2EahN3mB6qDk=;
        b=XpkZVF7ajJ6/fnyjjT9JNLuHZY47wKGUDalH2D2n8gaD9kL5ymAATm8VL8TaJxd2z0
         +TgFKef832Xl9dSEvmRsI+B95UYl1X6MMd1ogmhFYXK8aT2vNz0pzoFGqKb+QTqBBuAy
         r1OUZstVkedLs4NDhXToln0upWYZISrnuwKqp2q96PJ4Py1boYx372FETLpreOJHFax+
         iMu1g4qIt2Mx4btIxFCvQ1aydeqAsHExKLlnjI9eRHlDi+a7+LskqZ8ZxXRtrR032nU3
         cuoLim9bNFzF1Nyt9cFh+PLK9e4iW5gOvEiBx9OwwIpOhY0oLacnQQEWCEfO5l4XgZpP
         TCIA==
X-Gm-Message-State: AOJu0YxYtG5BuuoJWt5tnonBdHdm12Q3xji1Fgesf7TaaQl49+Etx51y
	CEFIxtuwNlGjR9gXoGEp0kgSGd3j+cmuAq5dYnvj8000kb3HHY4cg34eAbjPQrpP01YFAQsWhEZ
	w5/Hi
X-Gm-Gg: Acq92OGFbKlJKpDwyy32d0ZqZPtLMKb/lLvKBjBZexL0nly0fL0JlL8D3UAMp6+30UT
	ZJsoIHrkkID1Qihz/4d+e/1NKTBhk439lLwHyXjOj3aYomFFm+6RgClr3M6wEkTPb3Od+HYfBbL
	Uog3f1JGgFkdWISt40+W9cYwCP73PqvpooWpttdGt8OoqG8q8BXuCB285TQZtYcmf/J/FLt1Rwj
	d8ml8tDEXBbTjd7pQn1U9CiLuPJNM7oc4DKAbc4909t7Y9N1VGklJzC8Q/nD56rpEGj+eaWvVpK
	7iht8ZuAHLF3L1kxGKYkSCXDyNsJ7SgKJ1SKEJ55AuE3hJoZtcPeVFMdMxN+XmrlEZ4nWnntLYS
	YEdfNoRTnkHOwGxcA1iQf+KNLvf+5CqRUjFanWByUPRY25WQ/QGdz2BjkvDH9ewFP8s+kjmB4Wx
	K/l/1IIoS23PeqdSyOJxPVNM3SOczNLM5WU8DgN/UDtkplMhNNRuajJyrn63di6asbFUItjbScJ
	ujdiQyflPiZv45c2pOle+Mp/E9BSPh8KNG8bQ==
X-Received: by 2002:a05:600c:1c29:b0:490:7df7:9190 with SMTP id 5b1f17b1804b1-490c2ceb6f6mr136153595e9.8.1780780357757;
        Sat, 06 Jun 2026 14:12:37 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa000f4f58971dfc8e81.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:f4f:5897:1dfc:8e81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d37edbsm169994915e9.2.2026.06.06.14.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 14:12:37 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [bitbake][scarthgap][2.8][PATCH 0/2] Pull request
Date: Sat,  6 Jun 2026 23:12:11 +0200
Message-ID: <cover.1780780220.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 06 Jun 2026 21:12:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19626

Passed a-full on autobuilder:
https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/3943

The following changes since commit 37beb06ba9329cd16976273efbb341f781d4e749:

  fetch2: Unpack RPMs with --no-absolute-filenames (2026-06-05 12:50:29 +0200)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.8-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.8-next

for you to fetch changes up to a4daa14312d659333984aa1ae58ddfe0c96392f1:

  hashserv: validate unihash values (2026-06-06 15:52:19 +0200)

----------------------------------------------------------------

Anders Heimer (2):
  hashserv/tests: use valid 64-character unihashes
  hashserv: validate unihash values

 lib/bb/siggen.py         |   9 +-
 lib/bb/tests/siggen.py   |  48 ++++++++
 lib/hashserv/__init__.py |   7 ++
 lib/hashserv/server.py   |  27 ++++-
 lib/hashserv/tests.py    | 235 ++++++++++++++++++++++++++-------------
 5 files changed, 245 insertions(+), 81 deletions(-)


