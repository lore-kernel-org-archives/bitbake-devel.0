Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A567C19F32
	for <webhook@archiver.kernel.org>; Wed,  5 Mar 2025 22:09:46 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web10.6331.1741212584116017905
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Mar 2025 14:09:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=D7yxnz+m;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.171, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22403cbb47fso16334875ad.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 05 Mar 2025 14:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1741212583; x=1741817383; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=R+OSasI3+/dKoynd73Rt5fdMi9gjAkmy1Ij7WwY9UbI=;
        b=D7yxnz+mc8rt4ucOfs9/1Rt6HuGbiwTM++dsnvzEWZPjtuFaoD1v08UIo3RGH5fQYD
         djptGbimutM6q1tXbN5G592fS3u58+6+YdJWe+AJWLjtVDjN2fWyduxTZ12l+bbLb1iP
         ByVzsLweElcZCj0qf4h+fG5DUxtNvDU4LTw0xgZZFs7jjda7exmE8yE1QXTYaKompumU
         XcnrtNWw9uCn+aMoK3ehuB0szOq0et+HrQ7ZYPiofxZiDg/lg4coJB4Sf48UjbTkp9Uc
         uX4M2KMXBA5JGffhriAPmMMpZl0XUBwUZD2xgXC5h+sZbkVcQPIbwwi6985r799ChceY
         8vsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741212583; x=1741817383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R+OSasI3+/dKoynd73Rt5fdMi9gjAkmy1Ij7WwY9UbI=;
        b=pMgE9PQv2TOzC9PRgZ+3/TZjG2XA2Mte/87dh+TKRsOieYp8AeWlt09T4eW4PFrXbk
         5Mqu+TWvl5/ojh/dncnt4whsKkkyXr8/68yRq5RgKBVfqB9id4Fj/rsevOUf7ib4hSWt
         GhDpUI/tdd4yIptu5HYBPgO8QxZF9nZ1oEUdSvi9BgxipIH2JgwtqRcZ7MngH6DWqpVS
         IH7b30U2dOSN3ce+GPxYT8GCeY9UTTsDXRphM7WC1SdrdGdQ/uMZeCUh56l/2dL/KKFc
         7CbsUMizUBqtCiLNEZqsotY8bL8vFBRlhe8MX+FDk26xvde9BJDXbSLb0WACbcfo/u8a
         OMlg==
X-Gm-Message-State: AOJu0Yxa0keSpvdGcZvMsQaee62iQRKD7PvjXLgEjZhDgS5+bQ3RsrQJ
	gLzPeJHmGd6Bs95GDHEf9u/8B0ku7x8tbG5jVTAq1fp/avhgI/nDjQ3wL08kEsjTKGsar+iVAXt
	e
X-Gm-Gg: ASbGncvsZSoGr3X0x474BgZ2tF949pMerhPd85WmLESbgrztYdTLg1yvvb9JiRzqXB9
	HK3pNe738NwTBfUpvlFeQvMB0BHh1z7Kjjies+xF0nR59YJgvkuSMejp9qqjFLH5jp8r+QbPQCI
	h2ZHgGbb1OYihQuqP/A1SplGSy9IgXUieefr80jfUIDAZ3LoSKgbPL8GEZdfUE/T5CwAFO5PHn6
	ueybQcRXIGOEmuGRvJTwntFyCOCmOWE05XPU0ssnnc/3Y4XEg1h7XnqL8eCvG2i2sdIPMz/6E3h
	KhdtJtdcxTcQVNX+htnImNs5L2iXWrnnO0w=
X-Google-Smtp-Source: AGHT+IGXbgufkm3kKAdSL+V7SOEqIsVeI6bxRPircMkywmaDjyhUm3YZYjzzpqqijZjm1DvwmQfPzg==
X-Received: by 2002:a17:902:d487:b0:220:ec62:7dc8 with SMTP id d9443c01a7336-223f1c64413mr71804525ad.2.1741212583095;
        Wed, 05 Mar 2025 14:09:43 -0800 (PST)
Received: from hexa.. ([2602:feb4:3b:2100:2308:d28:2350:a5eb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d35a4sm118602405ad.35.2025.03.05.14.09.42
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 14:09:42 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 0/4] Patch review
Date: Wed,  5 Mar 2025 14:09:25 -0800
Message-ID: <cover.1741206585.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Mar 2025 22:09:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17387

Please review this set of changes for 2.8/scarthgap and have comments back
by end of day Friday, March 7

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/1127

The following changes since commit 4e443aeab9096b41c9e5ba41cd21027ecaa20285:

  bitbake-diffsigs: fix handling when finding only a single sigfile (2025-03-05 14:24:43 +0000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.8-nut
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.8-nut

Richard Purdie (4):
  utils: Print information about lock issue before exiting
  utils: Tweak lock_timeout logic
  utils: Add signal blocking for lock_timeout
  event/utils: Avoid deadlock from lock_timeout() and recursive events

 lib/bb/event.py | 10 +++++++++-
 lib/bb/utils.py | 20 +++++++++++++++++++-
 2 files changed, 28 insertions(+), 2 deletions(-)

-- 
2.43.0


