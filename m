Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685C6CD98DA
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 13:11:56 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.45172.1781183508331333378
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Jun 2026 06:11:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=DJfJCDpQ;
 spf=pass (domain: smile.fr, ip: 209.85.128.52, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490a76757e5so53234395e9.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 11 Jun 2026 06:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1781183507; x=1781788307; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=s3x1GjmXSapYaV4rpLaKM5FPSkkxhhN6W0614ZD40VQ=;
        b=DJfJCDpQF/6kTaFAMDvlDMuaBAELRLFuN3Po/8O2Vs9wLMuig/USLH2rcCERtqPTCi
         XmX1vIqrYExRzmh+Hv1mecDpjSncEQ2WMeQaeKw1UDpOjTZJrKVA8gDYNt9FUxBD54X/
         OATCDA41o/93eeP8hRJ0PI9b3H5LgBAu6wsfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781183507; x=1781788307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s3x1GjmXSapYaV4rpLaKM5FPSkkxhhN6W0614ZD40VQ=;
        b=Jfdl27nyRYPeMo0wK2UG06OK3v4e/BX55Zvg5G67bzY/YxFfAyUgqf/5tsnPL7lVRP
         7Logxid6Wo/NKxRGFl1HF2eidqlaTBqFC1uM4PKlDR/2xK5sszk20lBV3jU2oaiJkibY
         +AnJRs/k3z1GGBQC2cpIVg5XKDsmGjCS5LFRxltjzdpoIfWIhR1U5gZRqu3dVZHSlOGx
         JSJud3uONlsXNNKaJgSUzOiEdHIVHpkf/X1CdlOH/lCHd+P/M5+0aI1tB0a85lpneriQ
         s8JuDSm/LANC+hFphr3c4r26solObovPsXui8RdMjcdQfJBAE/zRixZdsQT5X0hwAxX9
         JIcw==
X-Gm-Message-State: AOJu0YzcpnKoNPkOunAJ36LWHtNLF9VjoRuLZTzq6uQE04RrvWSJX1g0
	Vvp9miGbwlP1VVfZhm4vA7jXAXGbPmF3D1oSkiSN48VIAHBLQ27dqH4+ph0bVKD0FC/B3+2bnCH
	+/aaD
X-Gm-Gg: Acq92OGpxlwkzfzUpoIs/4kNKDF9b7SsCf2Edq+hS6ByDRdBZb2rR6PaellCRyfamK7
	f7Q5/IY0JPrcYBm69FC2Fpv7NN+xsgu84YPW06zK3xQJDZjdd3XPX9AsHZFZ6Z8GZNgfGGRz05M
	Kc3Dx3+eeZW3CXJBQq8dEyTVY+BR+1YUzUKUQuvmHln9/UqKiX/hy9BfeyWP7qfYWX9kJGSHuvD
	lMhvTi4vTxiGkyAzUz9D5MQtpnLTFQpjyZrtNTNyo9QelmzEU3HXz3J5A2qgn/kKRakn00Tyg7g
	nUUGrnr3UlebtW8oX7GzsvfeczsNN7CxjW/AnHskiUJEBh9TQ9oAiV+T3/sPdasgbuIpIWZcOFb
	eSMO/yM8nYdiWY+/Zapsc4RgueSsPTBw+pUVQ29pRzPT5SAjo9cz+DSnCpA+M/XTBZfiI0gTmRH
	3bAUhkU1THue2T2zsJGQwzHJ84dbaQdobCimxpnT7+ZmxFGr3aVJ2gq5OT1I9qxD6gN8icAngqe
	yq9T9udGnN5wLZGG2qbP+0VW1AZMrsvrjdsVWk=
X-Received: by 2002:a05:600c:c054:b0:490:4b89:5362 with SMTP id 5b1f17b1804b1-490e56146admr24318945e9.24.1781183506503;
        Thu, 11 Jun 2026 06:11:46 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa0084744357c26c6744.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:8474:4357:c26c:6744])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3529e0sm82048251f8f.28.2026.06.11.06.11.45
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 06:11:45 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH v2 0/8] Patch review
Date: Thu, 11 Jun 2026 15:11:22 +0200
Message-ID: <cover.1781183212.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Jun 2026 13:11:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19660

Please review this set of changes for 2.18/wrynose and have comments back by
end of day Friday, June 12.

Passed a-full on autobuilder:
https://autobuilder.yoctoproject.org/valkyrie/?#/builders/29/builds/3975
* the meta-qcom warning is not related to this series and has been
  reported upstream:
  https://github.com/qualcomm-linux/meta-qcom/issues/2436

v1->v2:
* Added security fix "fetch2/wget: limit auth on checkstatus redirects"
  and associated test.

The following changes since commit 294074e65f37822a0f31bb11eb968d311b54a66a:

  toaster: use https for clones, remove cgit in links in defaults (2026-06-06 01:17:50 +0200)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.18-nut
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.18-nut

for you to fetch changes up to acfe02fa38b5da9e6a36c6cedcf91d4fcbefbfbd:

  tests/fetch: cover checkstatus redirect auth handling (2026-06-11 11:50:29 +0200)

----------------------------------------------------------------

Anders Heimer (2):
  fetch2/wget: limit auth on checkstatus redirects
  tests/fetch: cover checkstatus redirect auth handling

Anthony Squires (1):
  fetch2: reraise IOError during download

João Marcos Costa (1):
  layerindexlib: restapi.py: fix unbound variable

Marcio Henriques (1):
  bitbake: fix issue with varflag exclusion

Thomas Perrot (2):
  fetch2/crate: skip yanked versions when reading cargo index
  fetch2/crate: guard against empty version list

hongxu (1):
  fetch2: allow empty value for params while formatting URI string.

 lib/bb/data.py               |  2 +-
 lib/bb/fetch2/__init__.py    |  8 +++--
 lib/bb/fetch2/crate.py       |  7 ++--
 lib/bb/fetch2/wget.py        | 27 ++++++++++++--
 lib/bb/tests/fetch.py        | 68 ++++++++++++++++++++++++++++++++++--
 lib/layerindexlib/restapi.py |  2 +-
 6 files changed, 102 insertions(+), 12 deletions(-)


