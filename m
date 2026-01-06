Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CB6CE9D77
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 16:17:41 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.93602.1767716257522341802
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Jan 2026 08:17:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=rc+5Xsjl;
 spf=pass (domain: smile.fr, ip: 209.85.128.50, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so11982505e9.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 06 Jan 2026 08:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1767716256; x=1768321056; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i2Wu1zX8Za3TjluSqlzz6U1VJK39pz2JDNXC0dJzr2g=;
        b=rc+5XsjlTx6dXBTh5oEXlFQjvzV9hS4EHLY/m7SKsC7ZKlrt/dHBhe7hIghC3rErxX
         TIJ0vIb+Zr1KX8uSHp1plHL8oo8eGFXJUpqLBG2RQZJltCxh4XoPYSkROZ2OJmUsFMiP
         3DvM393f04GXmj1vwVFZDEWTOYEdNNNGLC5g4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767716256; x=1768321056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i2Wu1zX8Za3TjluSqlzz6U1VJK39pz2JDNXC0dJzr2g=;
        b=nLv/F7oPpfbF5x2oXU0HkFDoTbMTf0hKJtcvnAtbtOJmMOPVKZDBdhgDKlpHnSx1YK
         G8GJaybbx05WijVlEdC3Iap//zRVUkMRqqs5scpju/S6vh+iqXmUBkaMlXhxiw4pWCEU
         i5H0rFmiAUZqGzA8GifoRm6WeiRRHOn9HLgekbcU6lanrCWxR858eXYrdBfiYQkBZ4+7
         MucAaZc67b+wOcqCLiYTUGDsGkgdZxYQCi+OoOFbBvVcKPfC4RpHsr5giC/GMvyiq3Ga
         TtqV4Nhb3KXPWFVNufYrPM3Qt9ooZdr4c5uD7YPb3vWiP65nV89boV+SowCdnLbeOCrB
         uhbw==
X-Gm-Message-State: AOJu0YwEx8h27fglqsDhNS43b2eApTrMY97YWNcc5FdyCaXINdrLe4dx
	0ZMnGNirpggNDiBFMQL8MgTXH5kVjqlfbBOFMYe2fPYrPvG93pD8wf1I4EG+/4DJnrueUlCwcFM
	G+MA4
X-Gm-Gg: AY/fxX4xT0KT4jXQTX3ygpAqFlAYR1+lon7RZWUUjcrRFlgApXrP+W/OJkMXYbr8IAL
	DhqEdYypRbR4OGgdFUBAIRHlW7KAx+8U+3sJDbSL4+OHHRnthO5HbzqHhh1RiVdYKjO24EvV6hs
	/EMejQjHGb5VJ1llTN+vzLTJ9IbBZWk07eGNxyvg3uyk4+rIjZ1epuZQO4FFWQtrWzWCDJXCSLF
	Da9aC66XlNTtZR5HO9ahqHiHzTINmDqO7GzhbsyHzvwdaFSjlo3uOr6JPoEk/56z2PczNBbuMV/
	6z1GsF+HSFmzTxUWWkV4qtvu6tPGQoUHW0HyHq1HklCSfpJPZJu7ghDVI1n+Jo/zblz0gn352po
	cn3x7IWnc+HSL/14Ha1Qn4CLTudkgCyJmHs6rU7rwkPmsp37Joyru6J5Vnkk+ui5EVDWJt/XR93
	nfiNBG6dspo2vW5BnKVRK5RljzNZiQfxcKN49OGjgM7UYjU8XyOl9d69Cn/kUirzurfjWgVB7QY
	CzhYN4iWFS5gMMrwr6lScEgy4M=
X-Google-Smtp-Source: AGHT+IHSxSM8gWaFSyosHt4sgro/oqmzKAe1KqRZQt7b21zKxdlqw9XtZIzQBLO8mORUpz0i50Dz5Q==
X-Received: by 2002:a05:600c:3e15:b0:479:3a87:2092 with SMTP id 5b1f17b1804b1-47d7f0a3e4fmr44108665e9.36.1767716255424;
        Tue, 06 Jan 2026 08:17:35 -0800 (PST)
Received: from FRSMI25-LASER.home (2a01cb001331aa0051b13b00a50722a9.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:51b1:3b00:a507:22a9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e17aasm5186182f8f.15.2026.01.06.08.17.34
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 08:17:34 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][whinlatter][2.16][PATCH 2/2] bin: Hide os.fork() deprecation warning in all bitbake scripts
Date: Tue,  6 Jan 2026 17:16:57 +0100
Message-ID: <abf7064d86ea9fa67a6a407af3a6f42458cfbf48.1767715521.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1767715521.git.yoann.congal@smile.fr>
References: <cover.1767715521.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 06 Jan 2026 16:17:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18705

From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

As the previous patch [1] was missing some occurrences, make sure to
mask the deprecation warning in all scripts that might fork, i.e. all
scripts using a BitBakeServer instance at some point.

Justification is still the same, we are being fairly careful here
and believe this code is safe.

Fixes [YOCTO #16080]

[1] https://git.openembedded.org/bitbake/commit/?id=8b02d65a6439b21d8bd5590dc0009f2cf29c1de8

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 bin/bitbake          | 1 +
 bin/bitbake-diffsigs | 1 +
 bin/bitbake-getvar   | 1 +
 3 files changed, 3 insertions(+)

diff --git a/bin/bitbake b/bin/bitbake
index a995bd665..2eb5f9103 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -14,6 +14,7 @@ import os
 import sys
 import warnings
 warnings.simplefilter("default")
+warnings.filterwarnings("ignore", category=DeprecationWarning, message=".*use.of.fork.*may.lead.to.deadlocks.in.the.child.*")
 
 sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(__file__)),
                                 'lib'))
diff --git a/bin/bitbake-diffsigs b/bin/bitbake-diffsigs
index 9d6cb8c94..0974e8d4a 100755
--- a/bin/bitbake-diffsigs
+++ b/bin/bitbake-diffsigs
@@ -13,6 +13,7 @@ import sys
 import warnings
 
 warnings.simplefilter("default")
+warnings.filterwarnings("ignore", category=DeprecationWarning, message=".*use.of.fork.*may.lead.to.deadlocks.in.the.child.*")
 import argparse
 import logging
 import pickle
diff --git a/bin/bitbake-getvar b/bin/bitbake-getvar
index 378fb1357..1c4283779 100755
--- a/bin/bitbake-getvar
+++ b/bin/bitbake-getvar
@@ -12,6 +12,7 @@ import sys
 import warnings
 import logging
 warnings.simplefilter("default")
+warnings.filterwarnings("ignore", category=DeprecationWarning, message=".*use.of.fork.*may.lead.to.deadlocks.in.the.child.*")
 
 bindir = os.path.dirname(__file__)
 topdir = os.path.dirname(bindir)

