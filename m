Return-Path: <adrian.freihofer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A85ED2ECF7
	for <webhook@archiver.kernel.org>; Tue, 20 Jan 2026 05:55:22 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.788.1768888518911566010
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 19 Jan 2026 21:55:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=adrian.freihofer@siemens.com header.s=fm1 header.b=JNX2ZtJL;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-1329275-20260120055514825c20b380000207e2-e_tvlm@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260120055514825c20b380000207e2
        for <bitbake-devel@lists.openembedded.org>;
        Tue, 20 Jan 2026 06:55:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=adrian.freihofer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=3d1hlNh4JGI2tr/a1f3iw0YFFT3EzE9q4Iw6y6hmK7M=;
 b=JNX2ZtJLeuCnrdW36xnxC8K7/3YrkNLvGnIKN80VuDlkade7XxZoML7eAW54KzL/glZQvJ
 ZpmBCgN6D1/ab/oN/rxlxoXkZNh+c/itqMQPO/XcrQxbVzfGzO9RlOt8lnypl+We8vN+xB7s
 irkwBhme8B3r1wdtrS8vI9N8ByYH6n2H4FjwY2ZHNV8BBCIK3pWYAwULSzUUR9r9YgvwdHLF
 LYvmKiFK/CjPfI9c8tE284LEIZJCdmbmf7IEEsmGEFJ07XGj8cNVPoFxSe2IGy1lrSycLzg2
 dZ0lXbrE26HexV6Rfn7TGQP49iK0myFpIjxmUK6drb7TNUO5U8vKP84Q==;
From: AdrianF <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH 0/2] runqemu support .tar.zst, .tar.xz, and .tar
Date: Tue, 20 Jan 2026 06:54:04 +0100
Message-ID: <20260120055500.1749670-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1329275:519-21489:flowmailer
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 20 Jan 2026 05:55:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18807

From: Adrian Freihofer <adrian.freihofer@siemens.com>

Change oe-selftest to use the zstd compressed rootfs archive for testing
runqemu instead of the expensive bz2.

This has been tested with:
  bitbake-config-build disable-fragment machine/qemux86-64
  bitbake-config-build core/yocto/root-login-with-empty-password
  oe-selftest -v -r runqemu

Adrian Freihofer (2):
  runqemu: support .tar.zst, .tar,xz, .tar rootfs archives
  oe-selftest: runqemu: use zst rootfs for test

 meta/lib/oeqa/selftest/cases/runqemu.py | 28 ++++++++++++++++---------
 scripts/runqemu                         | 25 +++++++++++-----------
 2 files changed, 30 insertions(+), 23 deletions(-)

-- 
2.52.0


