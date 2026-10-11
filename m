Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BA2CA9EBD
	for <webhook@archiver.kernel.org>; Sun, 11 Oct 2026 08:49:00 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23563.1791708538168640314
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 11 Oct 2026 01:48:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=BmGK9REh;
 spf=pass (domain: smile.fr, ip: 209.85.128.44, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a16c1608faso12831705e9.0
        for <bitbake-devel@lists.openembedded.org>; Sun, 11 Oct 2026 01:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1791708536; x=1792313336; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fbqKDPwW4pSCiZf5Isd/DcAxe9Z5Ow2CmRrxlleIGhs=;
        b=BmGK9REhwFxb4J94owHc6y+beGANFIk6Mg1NBANmIomedSSah9VnXeas2Cz92rYkb1
         emwXANFwmOWBu1G8F7UWy86dFUDJtT3kK/oxQSEXm5rdPUKR4F1Wqb9qu5ATHG0cvxyO
         Z6YRopbSUmGGmehGyWhGd1aepegECkOrnqd2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791708536; x=1792313336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fbqKDPwW4pSCiZf5Isd/DcAxe9Z5Ow2CmRrxlleIGhs=;
        b=1uvIfJFBA+pLHLhsym1Fx1db1jqnYmBjQ/DnmCkKG14jlf2iuRVtYaf6BvKHwg6grT
         4aywkhSdomr7YgXOGTAbMh5y/aG8IlN1i1El6iUVOm/ZikCvJBVZWoHs81zDbOgcTFb/
         mGSSQPi15DjvN5zI7VKtE17aifEfJNJe6TXnk2g7ub2EQERBO6SxDIUscg58tCBKt65X
         fpQSaP9e0NMiwjhQEaRH531MIqRmBFcxUlczzQpIBO/SlK03OzBhDna76jCoIuIQSYMH
         RajGrTMmbg9oxCgxNfU+YrVBev2Lhs0zgSfbrmkVmwlu0XID0p4rWKlyseuIQqtls2td
         RKYw==
X-Gm-Message-State: AFq9FYJ3dd7U8YrPUk1Dl+ih7/EZA8pGy6kZJfRbP3TqELxVKU1TopWM
	8pVf7gLfcVwDStzk0Hlqt76+oxQD8WOO0CDitYya2BwIQtvZDvrY5E67yql4/N2gbQgoqG9pwJi
	OT6mDUEY=
X-Gm-Gg: AYBFou0LcGvwzk6i9GGkTGBT33juZgP53H9bLa6mR5YSNAdM6pNRGWwGKZVhUNL+gk3
	2FwtfnjuP5CYKHBex5DoEdrbuWJVdDYce46nbvDWd+/hc7UXXSEyzbpviVc2b4wvaWNW3CxLxjB
	/6jEeEpfQcWtC/dOofYET9thxjDybFm6itiIybeOSsfVuYskpmnS1UOWH3ZMOKBcNF6uwSba+NR
	HDie0WSBiMsaQDIjK1S/VJke8gKFLM3+ZGhrykuoo7aYeoVQo82h2IBGhpbAMAiCPf25ejQvwLT
	BN24CIOXOaXoKXv4oiBc9CBchZ4ibvrZz4gRWPR768l233L6pTtnD5uyuvpSB+kMyTZ2echUUw3
	1aO3zEmGkg5Ji3F30qcjdLEVVO9sK9D5UiJgpiGEH1bpqUnPi1ocK7wgQM/KucyB8W8Cg5UlvN/
	VneItFvzCC+TilMvcuFklWxDZaUzpsQz8xj2yHuEiKW7HbMfBNONyp7b5K6jUdyXAOqPiZlcZLm
	qU1A1AEuohgI7pefQ+J4Rp+y7WHEGuKtd0PK150Bpa1LJWwpwV6J61l049owSvK/+ND1Nyjig==
X-Received: by 2002:a05:600c:8a09:20b0:4a1:9c98:b9b8 with SMTP id 5b1f17b1804b1-4a19c98c153mr8916005e9.11.1791708536325;
        Sun, 11 Oct 2026 01:48:56 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9aca657sm13276677f8f.43.2026.10.11.01.48.55
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 01:48:55 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH 0/1] Patch review
Date: Sun, 11 Oct 2026 10:48:26 +0200
Message-ID: <cover.1791708353.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 11 Oct 2026 08:49:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20314

Please review this set of changes for wrynose and have comments back by
end of day Tuesday, October 13.

Passed a-full on autobuilder:
https://autobuilder.yoctoproject.org/valkyrie/?#/builders/29/builds/4907
qemuarm-tc failed due to disk space issue on the autobuilder worker.
Retried in https://autobuilder.yoctoproject.org/valkyrie/?#/builders/42/builds/4782

The following changes since commit 51fd94a67fa17650a9ff623492005972bbc7d26f:

  asyncrpc: Close the client event loop when the client is collected (2026-09-29 11:56:42 +0100)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.18-review
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.18-review

for you to fetch changes up to 6e260eb6ab1631607ea414d9ff8ede1155faa5d9:

  ast: Make PyLibNode support submodules in BBIMPORTS (2026-10-07 14:54:15 +0200)

----------------------------------------------------------------

Peter Kjellerstedt (1):
  ast: Make PyLibNode support submodules in BBIMPORTS

 lib/bb/parse/ast.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)


