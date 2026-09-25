Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CA5C9830E
	for <webhook@archiver.kernel.org>; Fri, 25 Sep 2026 22:36:10 +0000 (UTC)
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9499.1790375766637118843
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 25 Sep 2026 15:36:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=h3883ddN;
 spf=pass (domain: smile.fr, ip: 74.125.225.141, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e79a408deso8014315e9.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 25 Sep 2026 15:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1790375765; x=1790980565; darn=lists.openembedded.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=67XVh2x36QIQMkrSQh7Ypb9twb/MULuL66wAHAI7J8Q=;
        b=h3883ddNs/WmbyrnoxOS1NkcJGNYIn4VQqg751kzWUwmsYlrjc7OsFhPg/d6x1JcIE
         lSkuZ7tMdkvt4YdCX7Xemw972cYUWv/0yBhhy7WChWH0eb4mJMC/jE8ZSZXtfeNXlWK9
         YaCvAIPS7Yzg7jCBJnFk/qDLstIqIAzv8fCXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790375765; x=1790980565;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=67XVh2x36QIQMkrSQh7Ypb9twb/MULuL66wAHAI7J8Q=;
        b=j3Uo4PBwpfKW48A7kfMYxp99cFWGI8Yq3cP8ED2pFaFiCB3BOQa3eJtgFe9ga8OEg0
         d3twCEpP8IPTDFaxlT20m2zPDW6QbbPG9WgfP3+OIbaKqPuqOf0WXKbanVcAjirMAqUQ
         4QaA97Yh8qrIPUJv8JM0qxvB+248z/EBc9dVAG4UPicHnskE7Te84dcVeOjzBo0bIOd6
         bgbW0Q5wvNyIxdokE+7gGAFF4OHXU38maBSJbVWp+87oXNgXJW+71Bvqyg+HTEg/F1LG
         T3t9aZ9qecJdBWCIUIztZO8J6YiwDlDetpKpecsxiDLyZkiWUA2zRK+ePcnfMGsr0xc/
         d9kw==
X-Gm-Message-State: AFuF++kNK4JZsd7UNEe10N5lcG8h6iX2vUyoXpb1813Ghab6y43/Y7aV
	Vg6d0B98e6eFl3e8sHZbbz1/r7w+qfxlbRiUHCeuyqpZhwWgOMb3OrgudJqEce9KkbOv+tNWvEG
	jZjVcGQI=
X-Gm-Gg: AYBFou3SWc9Y0FPVwsEqk/954291dqG1wTzyTGqQ/dMn4bwO2wu2nlEYWJiEjY5Qh5e
	V6sn5V9nvs+5kB/MwQYMV0dCHq3Wz5pIc6WOARSsh1vSyoVYHva/ViOYVY2FtanvlBLol7w68SD
	YrXXvuBOYFIokgOmfQUGu9AE3nZ5O0EE6CBnNcAfRINHdQnll499pJYmjdCPL3SwPIbcOuOn2Qk
	Zjs1QkxJGkix7C0dJLOEXqt2K49MDLbWAT153DrPq50AAI1uPmNxnDYiOcPzYbLQffaG+jHwewF
	KmZELOvuMDec60uP5CHBKFqaYIO9xS/dRepw0QNgwJuSC9T63+K4PwLr+71k08Eex/xYi+pnWbP
	KtkKKn1nFMe0xlGSNkR+rW1oslYHKa97UBcO358wuEfpS6BfdQIVGHUtLVp/Dvrpjy4yKwHW6uI
	FT3EeHccDQsEVb0Go7ikY6/q0SjCrkcqxehxqJjEPOEmSJ4omnPOrgs1AZDYHY67xEvjT2eU7j2
	ZHDrptenW1ROGMGM0i4P20OQ/4RBfWW+kpAjYUfn93RiBZPQklUlZGFPL9IorXwP1SEtLncww==
X-Received: by 2002:a05:600c:4ec6:b0:49d:e0c:e55e with SMTP id 5b1f17b1804b1-49fe66f9ddcmr125707215e9.23.1790375764640;
        Fri, 25 Sep 2026 15:36:04 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a6470b7sm9935776f8f.27.2026.09.25.15.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 15:36:04 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [bitbake][scarthgap][2.8][PATCH 0/3] Pull request (cover letter only)
Date: Sat, 26 Sep 2026 00:35:39 +0200
Message-ID: <cover.1790375672.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 25 Sep 2026 22:36:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20258

Those are the patches from the last patch review:
https://lore.kernel.org/all/cover.1790154568.git.yoann.congal@smile.fr/

Passed a-full on autobuilder:
https://autobuilder.yoctoproject.org/valkyrie/?#/builders/29/builds/4792
oe-selftest-fedora failed with 16206 – [scarthgap] AB-INT: runtime_test.SystemTap.test_crosstap_* failures
retried in https://autobuilder.yoctoproject.org/valkyrie/?#/builders/48/builds/4720

The following changes since commit cd50c3481e32afff995a143c3459cfa5ae25abd5:

  tests/fetch: Swap bitbake github mirror for YP one (2026-09-09 17:57:33 +0200)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib stable/2.8-next
  https://git.openembedded.org/bitbake-contrib/log/?h=stable/2.8-next

for you to fetch changes up to 1b619d136c01c97ab1b76a75e8845cddc5e49735:

  tests/fetch: Drop github url from testing (2026-09-18 15:48:17 +0200)

----------------------------------------------------------------

Richard Purdie (3):
  tests/fetch: Drop ftp checkstatus test
  tests/fetch: Switch to YP mirror repos instead of github
  tests/fetch: Drop github url from testing

 lib/bb/tests/fetch.py | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)


