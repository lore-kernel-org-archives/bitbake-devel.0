Return-Path: <zhangfei.gao@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939B71098796
	for <webhook@archiver.kernel.org>; Fri, 20 Mar 2026 15:03:34 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15013.1774019009384453130
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Mar 2026 08:03:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=iEDPggew;
 spf=pass (domain: linaro.org, ip: 209.85.128.53, mailfrom: zhangfei.gao@linaro.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso18886635e9.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 20 Mar 2026 08:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774019007; x=1774623807; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b0aItrdv4AukKW9E4HFaYiFlbyH7pKb+rL1OfNWSWzA=;
        b=iEDPggewUZzs/Uxf/sXp/e2lYjdaZNytkU6q27ZCp2QET/5hdtAW+IFR+LX1GQK+AL
         I76QH2xmDEN1eMNI6M7aoBbvgWOz5n6X87imnnK7e97cPKieM2OmMzrSle+UPjvUWgys
         RsBSNcDQ8NOB3tPNth4/5D5KNEmMt+ENTShDVFliFMci/dgPX8m4XMEOgFmpxTTtki3Y
         ttnI03Hc6575KtW3Alq8V9i5fpmUyTQzavZlY7jR/V56l0FZ8Yn3dY2mbOGQIChwUtQV
         Nt23bPoCAPmtgQFF/bjTwMkr2d3PspJZhVPWF7qoAPsUU/J4Jl7IQCUwWNCFUQ/4TasU
         +rgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774019007; x=1774623807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0aItrdv4AukKW9E4HFaYiFlbyH7pKb+rL1OfNWSWzA=;
        b=VOOjCNFCfr4zVbXzn1UIH6TqqxDPGh+hBN4aocVuPDRKgAgZSL54rWnhgso6NBC2Yq
         zCbGIs335jVpvjswplcjwCluxA5YsWa3pemBy/GLoF6Op0EOp85p2aP/MLbEGVHMuNTB
         bTK2DjHAUJhBlSqQf7qxZ3e+FIkefYsJXxPPZJugylL+cPdsvbBzOHY/GTLxvaR/ZDKu
         x5m2IPDOGKjEjEyL14IKhExPakFW9YHeIw1IzYN+rePpMtnRtNh7QvsBqvMx1oMQgt5S
         U5y/tDknsoweQMAxSpW+MhhAvmKA0a0kf7gazdMKiG4atrugqduG2INcCWo4z8yZ1zsn
         WBdQ==
X-Gm-Message-State: AOJu0YwZzL7AlybnxD7RzGnK+hcVznKSxKGG0Bobm5klrZjHY+ooWxmS
	V5lf/Q+AsJFg8WOkzFqknAj2gZumPf6dvOQ8G0BYdLKMWONPIdT1ZkB0dXD2a0EKtQyjFAHPweA
	BbxCNvX/nZg==
X-Gm-Gg: ATEYQzz/bUT/ZACK7zk1CV4FAICT4X5kBimzhUlFAULfH0IugdjyS7UOsrJDpzrjB+H
	soejZ3b9QIXGBS4L6wnBLQWptlsm0XeaVio9WOVgUPWSZcZWZz6AKvjWMk70zCGkMtXFJ0Z2cbW
	AjJHyd/AvcxoE0LZUD73PB84H1gZ5hoxrencxBGqPcX+8aG5MZLE18WxKcNK/xe7Z5XgFVsaaVW
	5lXSzbOtw/nHjnMo8OSqG3aw0zUSaGGZ+xwcqCWABYiGDHU4YeY4gW87b7vORNQkdz+1auexwgO
	PmPurC+vgOII2yJWs3iROeAAUr0N4TG7qB0rpzFVw+TYJEWNsY6CFV0/awLsjpUKtcPTGIZjPs1
	VHyDrRy51e3hkkaTqeDWg+W0SJLNFLcZyMWtDzUJAYFpGVp7fl0HJTzuSHd/HRt91dSitMKrL34
	Fj4vqE83h+lUVcmPNxrmCVk1GiM+ufjoPCJGdpHwFN8rCX8UimJEdmEuqPdAZCVpLtjRyakPQu
X-Received: by 2002:a05:600c:a416:b0:480:69b6:dfed with SMTP id 5b1f17b1804b1-486ff0303admr44808405e9.24.1774019007299;
        Fri, 20 Mar 2026 08:03:27 -0700 (PDT)
Received: from hackbox2.linaro.org ([2a00:2381:fd67:101:f4c1:e8ff:fe8f:2fb2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8b322d9sm132096145e9.8.2026.03.20.08.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 08:03:24 -0700 (PDT)
From: Zhangfei Gao <zhangfei.gao@linaro.org>
To: bitbake-devel@lists.openembedded.org
Cc: christopher.obbard@linaro.org,
	Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [RFC PATCH 0/3] bitbake-setup: config-driven local.conf, default target and docs
Date: Fri, 20 Mar 2026 15:03:09 +0000
Message-Id: <20260320150312.1243270-1-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Mar 2026 15:03:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19191

Hi all,

This RFC explores small additions to reduce project-side wrapper logic
when using bitbake-setup for machine-specific build flows.

Patch 1 allows local.conf snippets to be provided by configuration data.
Patch 2 allows a default build target to be provided by configuration
and exposed via a generated build-target helper script.
Patch 3 documents both new optional keys in the user manual.

The field names in this RFC are intentionally aligned with existing
bitbake-setup naming style and kept open for feedback:
- bb-local-conf-header
- bb-target

Goal:
- move common project policy from external wrappers into setup config
- keep setup usage closer to one-command build workflows

Before/after example (qemux86-64):

With this RFC, config can define:
- bb-target = "xxx-image-minimal-sdk"
- bb-local-conf-header = [
    "MACHINE ?= \"qemux86-64\"",
    "DISTRO ?= \"xxx\"",
    "EXTRA_IMAGECMD:ext4 = \"-O ^metadata_csum,^dir_index\""
  ]

Then a plain:
  bitbake-setup init --non-interactive qemux86-64.conf.json

is enough to:
- populate build/conf/local.conf with the configured lines
- generate setupdir/build-target for default target build

Without this RFC, projects must do extra wrapper steps for each machine,
for example:

1) Initialize setup:
   bitbake-setup init --non-interactive qemux86-64.conf.json

2) Append machine policy into local.conf (manually or via wrapper):
   echo 'MACHINE ?= "qemux86-64"' >> <setup>/build/conf/local.conf
   echo 'DISTRO ?= "xxx"' >> <setup>/build/conf/local.conf
   echo 'EXTRA_IMAGECMD:ext4 = "-O ^metadata_csum,^dir_index"' >> \
        <setup>/build/conf/local.conf

3) Source environment and build an explicit target in wrapper logic:
   . <setup>/build/init-build-env
   bitbake xxx-image-minimal-sdk

This is functional, but significantly more verbose and error-prone,
especially when scaling across many machine configs.

This is RFC because naming/schema expectations may need adjustment.

Thanks for review.

Zhangfei Gao (3):
  bitbake-setup: support bb-local-conf-header injection
  bitbake-setup: add bb-target build wrapper
  doc: document bb-local-conf-header and bb-target

 bin/bitbake-setup                                   | 34 +++++++++++++++++++++
 .../bitbake-user-manual-environment-setup.rst       | 23 ++++++++++++++
 2 files changed, 57 insertions(+)

-- 
2.34.1

