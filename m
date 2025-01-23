Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622B2C02182
	for <webhook@archiver.kernel.org>; Thu, 23 Jan 2025 20:15:13 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
 by mx.groups.io with SMTP id smtpd.web10.21107.1737663304148296795
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 23 Jan 2025 12:15:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=GWTvDHto;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.44, mailfrom: steve@sakoman.com)
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2eec9b3a1bbso2081313a91.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 23 Jan 2025 12:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1737663303; x=1738268103; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FsJdQ8zPzuyoiUa2chH+fxXCl0jhojNYBcalyMSBxsY=;
        b=GWTvDHtoMWYjFL2zdTixhILBkUoflbjklzUVvVtkmXSCxRyEbwLgDTQPgtsvHtZISg
         E4hpWMMl0b9snlruG9JKH9ulogBu9ylbMkZ26B1967FjM0ije8zKRKuw9StsGhKvYNgz
         oYsigMLAuYshQAOvvn7cA/Jt6VVySz0PhfciNjfmrHFuPDifgLVc4+4+y0nlonqTuhZ3
         up6v5p7nsRrWzjpsc7JuPONHazMJ1E/zrTLuTtVqMR6A+U/NCCyTFFUv3svfjIeKH5lT
         q0+fiFvOas4nxfUsIytXyqAYL1tL6ypH7N4f2MFmhhXOwrV0cyyviWPlpHxfXW5joOt+
         ENTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737663303; x=1738268103;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FsJdQ8zPzuyoiUa2chH+fxXCl0jhojNYBcalyMSBxsY=;
        b=nn3MI0cS3LwBf8vsuvbaOXj7LtlubK/kxa4rEWEwUqZLEfCLUd/rPYXQ4LN0Cn3Ac6
         VEZGM/kqBa3SiOw2Cj3jlH8jSwa7MrpQwUmQ4g0R5LZ1kPUDPw2kDKdtjIVj4RBuU3/9
         rU6XXraxgGuuH406B/d2yaYUG9EzZ+S7/tsKETOM8XloRokqYOdm/A/RPd3xH4w/1q8F
         8G/QrZy21YETcoHxemhbo7Y3BqqIz7KQKhn6Jlp8+gO5H3D38jpB+PLrR5dQ8t6Mg0vm
         pYqFa9ATl4I1JOOCP3yVtF4zkMmmluMhbiEvT/jgnNNyRrHgTfGSaSYMHZ0yUkIsmrgI
         cqTw==
X-Gm-Message-State: AOJu0YxB5VDh7s3B+XqP9nFpX08QKRRVEwJ4IU6MBwkT2Ase/okYsBpu
	0XPu7VtZdWvN8/yaasuKRUg3ROYn/9uJGI2Ei2gtLJ6dg64k/ufTKh6fgJSZqLJksw4y3N3kYuY
	Hm6c=
X-Gm-Gg: ASbGncv8lK5J/mnqTuT47G9bDrlod2rqgJY5v0vFkcVHJuPaeP6ELuNlrnnQryDdpua
	WpkUEzPJHq8HsSljXrK6MNhKXdzkuACJq5CXjL2uwo1PUpcjUKhEozdjnrOLWJtLjYc/qXg2AyO
	0oiq2S2xBI/vzHbz8k99w8klp4PJqtQAiSVWdpDeMwV8QpR0E0UlrJl4EJgEkWjoPvC3iWeDK3L
	KBceAfzucLF3PdxFgPDcvOuk24XpQ3ou0UjxzCQGaLpFW2K1A3JBUWYRZL80Mf1JTu/lw==
X-Google-Smtp-Source: AGHT+IHZWkxOLC+gV37mNavsfHqmZey/8Gee966ChOXLZcC5P148DVEd6DsctBEYtjofNrZW3uGXdw==
X-Received: by 2002:a17:90a:d887:b0:2ea:3f34:f194 with SMTP id 98e67ed59e1d1-2f782c90219mr43066050a91.10.1737663303347;
        Thu, 23 Jan 2025 12:15:03 -0800 (PST)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa5662esm142386a91.14.2025.01.23.12.15.02
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 12:15:02 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 0/3] Pull request (cover letter only)
Date: Thu, 23 Jan 2025 12:14:53 -0800
Message-ID: <cover.1737663180.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 23 Jan 2025 20:15:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17072

The following changes since commit f40a3a477d5241b697bf2fb030dd804c1ff5839f:

  runqueue: Fix scenetask processing performance issue (2024-12-03 06:34:38 -0800)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.8-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.8-next

Chris Laplante (3):
  ui/knotty: print log paths for failed tasks in summary
  ui/knotty: respect NO_COLOR & check for tty; rename print_hyperlink =>
    format_hyperlink
  cooker: Make cooker 'skiplist' per-multiconfig/mc

 lib/bb/command.py     | 21 ++++++++++++++++++---
 lib/bb/cooker.py      | 11 ++++++-----
 lib/bb/tinfoil.py     | 16 ++++++++++++----
 lib/bb/ui/knotty.py   | 20 +++++++++++++++++---
 lib/bblayers/query.py | 14 +++++++-------
 5 files changed, 60 insertions(+), 22 deletions(-)

-- 
2.43.0


