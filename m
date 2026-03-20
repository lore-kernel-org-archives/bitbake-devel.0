Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48396109193B
	for <webhook@archiver.kernel.org>; Fri, 20 Mar 2026 00:26:17 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2597.1773966375675948163
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 19 Mar 2026 17:26:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=fJW2u432;
 spf=pass (domain: smile.fr, ip: 209.85.128.53, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-486ff3a0fc1so1347345e9.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 19 Mar 2026 17:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1773966374; x=1774571174; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IcE4gdpqjIv0gOpkeuL0eIZwySoFPZG1R4dvAKSUbVw=;
        b=fJW2u432MQ+jwHrjqAl3pwmrOvmPs/SUgThKxvoPts497Os8mwWXI5YpP2UaOF5I7F
         MNK1MnVsyE2xBs5QbO2PKSXL/tlbeNTj22ZIyDdBTBOIR+fy+BdHSB8bpUOjpLxWOc0P
         DUKk2xleNy276NL002zfhTmNzCwttab1u6Q00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773966374; x=1774571174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IcE4gdpqjIv0gOpkeuL0eIZwySoFPZG1R4dvAKSUbVw=;
        b=f4g7t9Mn3Tn4usMZa+dHYBJmgpX5UCSRlcpYppo5+mAhBTjdgH9sn/3fNRz4LHJUCI
         9umHAuZH9HjRcRbKb1Xjr9K2hjObSaob1LyvBHNl8pFSCn6aTxF1NbCwWZw6kF2whvqe
         USZ6aP52Cw4GB7EpYmvPsg5JUGA6YsD4yHqEMW/OTgLjykaQk8hEUNX5ekPLKsr5Tv2B
         W+rTmx20M9yrFfQLMBanzzCJiXL5nKR3cEMcwD7h+aPooHOVnFIVC3BcEceprfimksPG
         stPlgkQYEXk0jbS89ge7m9wlOnJCpkrVQmZXt89jZ6M3qg8uPMrCTpjgRKn2rmLlFhl0
         wvmg==
X-Gm-Message-State: AOJu0YzUONUasZf8JepndLCFErL8OtjpFKp5uLG2nsm/XWOZ1JFtSZQX
	w8qKidmsVifSQqcfN+uC3VI9rl9nKXWY8ZvNvwysf3D5scD4EJejLl/OunARZNA/wUu2qRHqreP
	kJ40S
X-Gm-Gg: ATEYQzyInkm8+LDeYylqHTVfp6TX241szmeCKIcP9tQVnVrv8L0R/H/6wb7YVgpA+/T
	qt34YeXUjqpYgorGxhNADGd9UGA7IbEyzRKk5uNQJVnAvYP/JeJP/aYF7f+91zZ14e0UR2MVHE7
	GjAsALago/xXiW+Nr2vxz5znGc0nhFjIiHDXia/VfGoPkX0ARvw7tCyHiN+DfJvx9HGe/zuWax8
	c5EuTMSO0TUGx2bMnumptUy8o+lMOl8oISEG6yb81UDVGfVYwZzIwJFi5Lr0qilLEnUKAzEuoML
	YxqVMfFkyRXUZ8nohzhQJI6tTcyhTpfrXA1x1PNi/ye8QgfBmAVr8woySefMVS60G+n6Wh3FA/C
	dvndH3QHvquTZFygYBpr80w/sOv32aiwdcXLvB0SBwIj/wYzcF3PbUX9FDGYOE9+rH1WwMWfqVS
	SeDLV7Bph7Ta+Hp/lUYuB+buKihaQjgY/wHmwaYbvRMCn7IMYfeRwrBvEjbOVHALfAJJxMK3uwR
	tCeyMVLX5Cl9VNj4Pahi/PxCXtuB8WKfAgTBQ==
X-Received: by 2002:a05:600c:8b6e:b0:485:3949:e5c6 with SMTP id 5b1f17b1804b1-486febb56a2mr15675415e9.3.1773966373581;
        Thu, 19 Mar 2026 17:26:13 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fb4309d1sm106036545e9.3.2026.03.19.17.26.13
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 17:26:13 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 0/4] Patch review
Date: Fri, 20 Mar 2026 01:26:07 +0100
Message-ID: <cover.1773966318.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Mar 2026 00:26:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19179

Please review this set of changes for 2.8/scarthgap and have comments back by
end of day Monday, March 23.

Passed a-full on autobuilder:
https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/3457

The following changes since commit a0a5ce49f28d886b1dac173842642e69517b44e3:

  COW: Fix hardcoded magic numbers and work with python 3.13 (2026-03-16 09:24:26 +0000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.8-nut
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.8-nut

for you to fetch changes up to d3b4c352dd33fca90cd31649eda054b884478739:

  fetch2: Fix LFS object checkout in submodules (2026-03-19 00:14:50 +0100)

----------------------------------------------------------------

Philip Lorenz (2):
  fetch2: Fix incorrect lfs parametrization for submodules
  fetch2: Fix LFS object checkout in submodules

Robert Yang (1):
  gitsm: Add clean function

Ross Burton (1):
  fetch2: don't try to preserve all attributes when unpacking files

 lib/bb/fetch2/__init__.py |  2 +-
 lib/bb/fetch2/gitsm.py    | 26 +++++++++++++++++++-------
 2 files changed, 20 insertions(+), 8 deletions(-)


