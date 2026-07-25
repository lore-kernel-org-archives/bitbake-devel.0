Return-Path: <zizuzacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C75C53200
	for <webhook@archiver.kernel.org>; Sat, 25 Jul 2026 14:30:14 +0000 (UTC)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.311.1784989808479753755
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 25 Jul 2026 07:30:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=Q+U4pujD;
 spf=pass (domain: gmail.com, ip: 209.85.215.171, mailfrom: zizuzacker@gmail.com)
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c9eefcf9175so1338730a12.3
        for <bitbake-devel@lists.openembedded.org>; Sat, 25 Jul 2026 07:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784989808; x=1785594608; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=M4h9Uv5etWF1FfZya79L8HoVhbl/EQXThMlkI7rkvrI=;
        b=Q+U4pujDyuqNMfY9oO1OFqaRvlPIGgbakkvEMXwuBqgP+U0qTVnDBqxHFY+eyhJMtM
         5f8pQS7EO5R/CiQJqs0/ccPMQWyo8cTF1vSO8zFmosq0QK/2cb54w5pub5USCtG5j1hH
         a/4jKrGmZBaRqzcNv75qxsDQHIr6ikysxDXtgNedFLF5cXxeiBwNcSq4wrt4rXtgHoF2
         OzJNS10RxSeB/VE7BVT+MPMm/3fmwhtV/+2wxwzNoT+jWJ9xsEFCxizFTQSXkwYmNcol
         YTT3fLiPa22In6NAIsgkjzY71K+4Yik/O9QTHpu0qkaIc4xlGapIVj8Xt+KNwZGoGZQc
         K/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784989808; x=1785594608;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M4h9Uv5etWF1FfZya79L8HoVhbl/EQXThMlkI7rkvrI=;
        b=hRUFBYBFi5q/JQnxsVqcRtC209Svu6BpFLO0Q3lD9NKNdvOMNFNy4UJbTRi3CtEXiL
         7xhg7ZP/G3k8rlF+otj3v/sCMtesD5NmpeTZuiLh+q8qCqCPPwjQ7go3sEhotbIM/GM5
         V+K47QmaNIqDleSmY9Y53fKfmb5MzR6vm30NPWrYTUAOhGlSHu6beXGpvEwk3NTO73cA
         84/9ALip1Iu3QMOZqKKrlB/W4SpDaPdcDALlImuAMHd+Nm3hXWcvzYhRcnWCDmufkuDv
         GsZXhb/uC+WQw10Nj1bAoWOtzNLcczh1P3VUnmf9z/PosGABsRn12WNWhOIzvTO+zimY
         Sa+g==
X-Gm-Message-State: AOJu0YxGvfu2XYf5Zp6dtOwITkK6vwZpopbuCJPq7lforjEJIAhmwTby
	96xnCrgQQZbCC3qdDnNgZP1MNSfnWphBddPS5tCf2hnqQRFqgAIVaEJDYSp//2ED
X-Gm-Gg: AR+sD11QpAIrOUC2RRjo00hbK8QRD+cmIXgfEVrPEHOpRcMsfwq70JZ0jamQyHoZtrl
	ma3zxZRL4AtSe0KWbJKTglPkjR1kuZBZErWcoTwUaL0bzNZc2CS5f4HfNTiTWqP9Ot5mfhE81oP
	78ceKNp03Vnqy9Ihfhw1LZfFFiB29V8C5kXk/P+WTzMKKI2tWC87IhpeMUa0prgBXPLoucwr7YK
	SYGUvGjokrmtCEIN9ZtOq4ncFqkY/g5/LAyIvSam5Uv4OVM/eMnjHJLvW4p1659khRWp1gp2N8X
	eCDOm91tgbdB6PxEPzhzbppsKfDmbNk14hHIXkNU4brrCG/BFrBWXHfJI/9jKl8Qw1elGZNEFcS
	cRiToqRBiv4Xal73Snw5hyJWUv/bJy+wuKg0AMxQ7XgmXM3NyaIUVcKLy10YmuFR57k2qOg==
X-Received: by 2002:a05:6a20:4324:b0:3c4:3321:4ffd with SMTP id adf61e73a8af0-3c67da310ddmr2505589637.20.1784989807681;
        Sat, 25 Jul 2026 07:30:07 -0700 (PDT)
Received: from ltu.. ([2001:ee0:4041:efc5:bfb0:104e:8f:340f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc5cb670sm16909480eec.31.2026.07.25.07.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 07:30:06 -0700 (PDT)
From: Nguyen Minh Tien <zizuzacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: zizuzacker@gmail.com
Subject: [PATCH 0/1] data_smart: fix key expansion in conditional overrides
Date: Sat, 25 Jul 2026 21:30:01 +0700
Message-Id: <20260725143002.23596-1-zizuzacker@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 25 Jul 2026 14:30:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19857

An :append whose override name still contains a variable is silently
dropped. From the report:

    RDEPENDS:${PN}:append:pn-packagegroup-cross-canadian-${MACHINE} = " ..."

Still reproduces on master (c251833d2). The mechanism is in the patch;
briefly, renameVar() rebuilds dependent override keys with a string
replace, so renaming RDEPENDS:${PN} leaves the ${MACHINE} behind and the
append lands on a key no override can ever match.

The part worth flagging is the '${' not in newkey guard. Expanding
unconditionally looks like the obvious fix but regresses parsing:
native.bbclass renames to a key that is itself still unexpanded, before
expandKeys() runs, and expanding the dependent keys there turns the later
rename into a no-op. oe-core then parses with three warnings master does
not have, in dbus and python3-psutil. The second of the two added tests
covers this and fails without the guard.

Tested against bitbake c251833d2 and oe-core 9d89b3b802:

 - bitbake-selftest: 790 tests, no failures. Six bb.tests.fetch errors
   remain, host issues that occur identically on master
 - all 952 oe-core recipes parse with no warnings, same as master
 - bitbake -e for dbus-native and python3-psutil-native, the two recipes
   that hit this path, identical to master
 - same parse with multilib enabled, exercising multilib_global.bbclass
 - core-image-minimal builds for qemux86-64, 5275 tasks

Nguyen Minh Tien (1):
  data_smart: fix operations lost when an override name contains a
    variable

 lib/bb/data_smart.py | 11 +++++++++--
 lib/bb/tests/data.py | 25 +++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 2 deletions(-)

-- 
2.34.1


