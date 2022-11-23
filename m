Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26490C433FE
	for <webhook@archiver.kernel.org>; Wed, 23 Nov 2022 14:13:05 +0000 (UTC)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
 by mx.groups.io with SMTP id smtpd.web11.21107.1669212783273896549
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Nov 2022 06:13:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=x54SrZE9;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.50, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f50.google.com with SMTP id v3-20020a17090ac90300b00218441ac0f6so3810798pjt.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Nov 2022 06:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pmuc4urGGZ+1OhAsZnnEe7aeJaciWr9Qdcw78R+yHpM=;
        b=x54SrZE9iF26ygRrCOW+3lIz3Ge1g9xD3E4dSOoAtiERW8ClqF112nfS2XyIJgFomb
         lpSt4sqO+N+TQJ+gwcARR1jZUd0vHoFrTowut5HFzNs+XdbDHf7hUFyhbooqE4t733Ga
         JTdt+vLRMg138VXJlgBydPGL5bH+0eM5BOUnoZnb1kKuQgN2YnuzaitntM3bYiUv1xeR
         oG9YrYBRbFK1EoWPGx3tajtUA0F3QVoZVu23mHUmfDHyfaPx8pNTA6Hi+HAtVZ1G8AsI
         uSOfnQk6tyj6d5IllK6zJdrOLZXYG1GEZYgWcc3oUTadHVOGQiqR8Rg4ll+Bu7ZX17pD
         eR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pmuc4urGGZ+1OhAsZnnEe7aeJaciWr9Qdcw78R+yHpM=;
        b=4IyjmesghKnVryYeSRXBV7wpdRu8qMHshFvMgdBJ4Ky3liwjH4Rzv24a4O1e5JoNAG
         GNaIrtez++qYZrCJofQAu5L6IyvAaf/m7w+5rFfqgBfZHTBYJqRQvx+GQpixqUiNXkSI
         V7WS1f1Yh3o+VZsOoegPljeu8PnkLyj+blYGzPioek6Cs7YzjKcHRoR5r3fjfNVfRGVk
         Lpx5aeCk2ZwUCLYqP+raWsWqiNhxnn2cn5Q9CvHHoJQ7831N83IOCma6Qlc/Xgy2NDgq
         WNuvvI5/mQKjLThkb2awL1Sg6bQeQQJ3/DUM0yCo9X9m38kUeRrWys58Ydkxk3OZijml
         as9w==
X-Gm-Message-State: ANoB5pmRIacprpFMkIpyU+uevyI6fP7KWjrh6rAleRzG0Vmfgp5YBFv3
	oIGtQ1Em2uzwyeN/+maPMmNK/snBmWyXCZX3jU8=
X-Google-Smtp-Source: AA0mqf7JbvVYoVkkle3cmBgmSbAOUGjKG+2oH833jsYLt8xviaIONjv4Wx1XvHM5ZgQDRMr7yzKRFQ==
X-Received: by 2002:a17:902:c946:b0:186:99e3:c079 with SMTP id i6-20020a170902c94600b0018699e3c079mr9021911pla.149.1669212781912;
        Wed, 23 Nov 2022 06:13:01 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net. [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id a24-20020a1709027d9800b00186ac812ab0sm14268675plm.83.2022.11.23.06.13.00
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 06:13:01 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 0/1] Pull request (cover letter only)
Date: Wed, 23 Nov 2022 04:12:55 -1000
Message-Id: <cover.1669212070.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Nov 2022 14:13:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14103

The following changes since commit c90d57497b9bcd237c3ae810ee8edb5b0d2d575a:

  tests/fetch: Allow handling of a file:// url within a submodule (2022-10-27 16:38:48 +0100)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.0-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/2.0-next

Richard Purdie (1):
  runqueue: Fix race issues around hash equivalence and sstate reuse

 lib/bb/runqueue.py | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

-- 
2.25.1


