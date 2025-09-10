Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD43CAC58C
	for <webhook@archiver.kernel.org>; Wed, 10 Sep 2025 15:59:22 +0000 (UTC)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
 by mx.groups.io with SMTP id smtpd.web11.22658.1757519959747907550
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Sep 2025 08:59:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=Kg5+859c;
 spf=softfail (domain: sakoman.com, ip: 209.85.215.173, mailfrom: steve@sakoman.com)
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b49b56a3f27so4404209a12.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 10 Sep 2025 08:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1757519959; x=1758124759; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KUmrPVTxSxoy1nhUVD5vzHBRE0lGb8mpz2Izh/Vislc=;
        b=Kg5+859c4cKGzYWIze2GIMMzVFYgG5j8W7bGNfLqRQwIqvmxYGFjioQc1ibJ8UeZSB
         UQCgZr9pRGdp6Vcvh8VBxMgyHElNCL/FI2bDrknyTxgcA6ujucaVdYWHgGocUhf8qxME
         GHJxLgV5fv9RzNqACj5hdslW6ofclkfnuomiXIR1Rv6fRrqzbUT5ITFpia5a9gsptFBx
         iRpGfA6mF0R9EyfxzcDi8+UI6G/0LZUS8mYSTgv2PD4sev9gL/kcRswNauItmNsHEtg5
         701wvpRRELHF4GDrKHRfHmDMYZKCan+Lq2DR/bjgoQem5I5v9n5ceVZwfmsg8+20HCUy
         aP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757519959; x=1758124759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KUmrPVTxSxoy1nhUVD5vzHBRE0lGb8mpz2Izh/Vislc=;
        b=iYi2hX2D02PJ+WcpLzeh1u8Ppcee/EfNzHWvSxjRui5DYK7W6a8aFk12UVeo0wikkT
         Pc735eSEV+xu25uli0KsdcyFczdKX1QFLjcb103TqCZlAkxd3ElXzlq7C8R7GObKI/io
         1MfKZXvjrI2AsC71tz3CtBGVFQGiPL/q96w5hgW9RrdDuoAjCL7P8h5E9L8WTbxDhKvh
         R+6wPo/nDHP1bFueO9jlCS1tlAqutA9btVe+23+q8gnXlyBuu4Yvly5TJ+Ng4RwDlyly
         psyZmBf0cJC1pkZiMZL50px6vMblygS00b+UBvvED28eoM5qsO79F+0ixFSJ9OA2HE1Q
         FSDg==
X-Gm-Message-State: AOJu0Yz6RuVbBcenfkRa1CVD2CLTEVYo2L8IPbqqdLdUa0sPFJMI6qr7
	1PAiJvXQJDrdrnVCOV/Qgl5J0d+eHziMMBuyVsiuUGCfVeb+uFwFb6ReoMBFibcZ547SvsMSDOY
	SWGsA
X-Gm-Gg: ASbGnctNlvFNRIySvDJmHa/yhDH4Ewil7yvvi+LhTib/4xUewCFLRugrw3L2yU3bOzs
	IL366xsAG0GoVVoedxrBeDKCLWkfk8IZ/RLfjojW+LUXlf1rjsKbdu7IozQRe9eBIVgQ3ANLcWc
	qSV1g8Sbw1cUpOqNEwyW24n4QnXnm6O6jMQ4ZeovWiRZRAMWHq4EHTvL3Wsqmz20xyzCKjdsdOL
	7EBdZtlK7/JsmApILESVYIuxApLx6sbP7c9swD8Z20Ex4QOV6pQwY+BQG6uQxATV6AUEvQ+a8P3
	drZwBApuY4BzGolaJawiFeJ8b4KZgNGzkheIrX6H4ipCqOPo1TT/FzLREYNOf8y+3bZ8B/XNE0t
	JLhwZ3OKIPp9vEmCh2rBCT5Gf
X-Google-Smtp-Source: AGHT+IFSPXS6uFe5qKr0+y53g3FdrKLTRuaV4IklFRxpOc5I9B+lGb5nlmo5lCHn4oPQyrEjH4Hdag==
X-Received: by 2002:a17:903:38c7:b0:258:c13d:9b1a with SMTP id d9443c01a7336-258c14cdffamr98123425ad.41.1757519958932;
        Wed, 10 Sep 2025 08:59:18 -0700 (PDT)
Received: from hexa.. ([2602:feb4:3b:2100:5b33:a32c:9e59:27d3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a2acff4c4sm31235405ad.124.2025.09.10.08.59.18
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 08:59:18 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 0/2] Patch review
Date: Wed, 10 Sep 2025 08:59:12 -0700
Message-ID: <cover.1757519842.git.steve@sakoman.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Sep 2025 15:59:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18000

Please review this set of changes for 2.18/scarthgap and have comments back
by end of day Friday, September 12

Passed a-full on autobuilder:

https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/2347

The following changes since commit 982645110a19ebb94d519926a4e14c8a2a205cfd:

  utils: Optimise signal/sigmask performance (2025-07-31 09:21:27 -0700)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.8-nut
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.8-nut

Bin Lan (1):
  bb/fetch2/__init__.py: remove a DeprecationWarning in uri_replace()

Joshua Watt (1):
  Use a "fork" multiprocessing context

 lib/bb/__init__.py                 | 28 ++++++++++++++++++++++++++++
 lib/bb/asyncrpc/serv.py            |  2 +-
 lib/bb/cooker.py                   |  2 +-
 lib/bb/fetch2/__init__.py          |  2 +-
 lib/bb/server/process.py           |  2 +-
 lib/bb/tests/support/httpserver.py |  4 ++--
 lib/bb/utils.py                    |  4 +---
 lib/hashserv/tests.py              |  2 +-
 8 files changed, 36 insertions(+), 10 deletions(-)

-- 
2.43.0


