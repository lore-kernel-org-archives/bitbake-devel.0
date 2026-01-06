Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CE9CE9D78
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 16:17:41 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.93600.1767716255883307978
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 06 Jan 2026 08:17:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=yJEKb3LY;
 spf=pass (domain: smile.fr, ip: 209.85.221.48, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43260a5a096so737347f8f.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 06 Jan 2026 08:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1767716254; x=1768321054; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2RPVImHlHpNPG4FcB+FK5wAu0FlT9TI7q2NStIxcGqY=;
        b=yJEKb3LYOlaN3fvI6SM+fHRREZP/qPHvMwZblhyTjfOJhpebO4CJu+X9R3pX6n8kaY
         g47z6Xh30ngytgTlOEQYH9VHWQNKP+xalcYaCpJUoh7031jhdvuA/qQ+4X5D7vAKWeCG
         DPl1HBf5U/Da9F5enuUvdvb5Loj5PJ9+6fzgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767716254; x=1768321054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2RPVImHlHpNPG4FcB+FK5wAu0FlT9TI7q2NStIxcGqY=;
        b=bZEv6D2BqTgW9lvJdHBYcMrV6cfEKxJaFK839YapoGwjl9FSSPbNECJh8pReSLGNEy
         PkMkpdzICEEcR5WdKGNUzlPYEuWc/i+VlawI3lBRw54BEWx89VvJnJWPgNLTUpxkUiPx
         v5XLXxXh/nizLm/MxMY0jL8VHt2udkjqHEbZiKjQggwwA044hzG+3B8LI7g9KWC5+Gbe
         RbjJwDIWInKzpTTLGe20YV9q8ROOKdk1qpsKDctLWQYhnRAeFVHxrO8RG4ExwBMB44LJ
         /5QrMnEQdPIDxorLh9Bd7YRQ6ih4pxGfSS2BYOQZBPYLxBb1hqHuH8pTPfZTPKaOW3Lq
         CCQQ==
X-Gm-Message-State: AOJu0YyYLbSRsF53TEORV2cKZh3quRplF9tfEd+7Osw9NF6jay/3OF8C
	VVGJDGCOgM62cqKoJyKzkFcjBzpqgYkHZ++OXJTMySk0BZU2PJ38qzLFlu1qSbEwGi/EwPJHesX
	ftgsW
X-Gm-Gg: AY/fxX6MJBLtdnH2rn0Ce6qFzflKGenlhpxLSUIyzMqbTRHuaaIwb9wLSIDKn1FNuXz
	30oCoFqFkKK74GaI0KNEDSX7JMT8N1tQaSWpiHzJG7RELVdwe0tc4jqQ7+TRD8Gc29XCaQUIwH5
	iQ0Nf7XeoeXA+9bLD44dvm/UYdN3jkz06fP74jyBZt+HcKYpqh5oGIknAFJFokfjCs4s9OYAi7k
	EjFEurtOX0tmnE15Lr35G8Y0yongqnyw42F7qnsoRs5byGiHDZTpP+oziGkzgAKROu3iJ5VEPj1
	WY7iZppuT9PAVmXvOJRtgZdzbqQnCHG0GhM1iAZ4b78axEgBMOF7G3uX2fXJQgf+ahEYYqwpTiP
	lSqK/si9DLvkBpAzt9EzAgfOZQP+ClC/TJRWm2GRhqyiP8NEy15TKg+EBjIkrOuX3m2ElkH0kPf
	xidzTy6zNSwIENJZXFyJvkOsM0W4SXvxpxtlIkyUZb9Sjouf9gNcvtAa/WLNnDhpI4CgBMbp9eD
	rqPZ2NgtSyddjbdorMinALVMiQ=
X-Google-Smtp-Source: AGHT+IFmqN6KLKJe5pB/RjLEClDCmgUh+0KKVotjRko8wiYsb/haGVKhWwT01aqxKlXamUmDtCjasA==
X-Received: by 2002:a05:6000:178f:b0:42f:bc61:d1bd with SMTP id ffacd0b85a97d-432bca525d4mr4808349f8f.45.1767716253711;
        Tue, 06 Jan 2026 08:17:33 -0800 (PST)
Received: from FRSMI25-LASER.home (2a01cb001331aa0051b13b00a50722a9.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:51b1:3b00:a507:22a9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e17aasm5186182f8f.15.2026.01.06.08.17.33
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 08:17:33 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][whinlatter][2.16][PATCH 0/2] Patch review
Date: Tue,  6 Jan 2026 17:16:55 +0100
Message-ID: <cover.1767715521.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 06 Jan 2026 16:17:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18703

Please review this set of changes for 2.16/whinlatter and have comments back by
end of day Thursday, January 8

Passed a-full on autobuilder(*):

https://autobuilder.yoctoproject.org/valkyrie/#/builders/29/builds/2997

(*): The builds/tests parts passed, only the "Send QA Email" step
failed. This is a known bug on AB side : https://bugzilla.yoctoproject.org/show_bug.cgi?id=15696.

The following changes since commit 720df1a53452983c1c832f624490e255cf389204:

  bitbake-setup: add whinlatter configs for poky and oe-nodistro (2025-11-27 11:11:07 +0000)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.16-nut
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.16-nut

Mathieu Dubois-Briand (2):
  bitbake-layers: Also hide os.fork() deprecation warning
  bin: Hide os.fork() deprecation warning in all bitbake scripts

 bin/bitbake          | 1 +
 bin/bitbake-diffsigs | 1 +
 bin/bitbake-getvar   | 1 +
 bin/bitbake-layers   | 1 +
 4 files changed, 4 insertions(+)


