Return-Path: <philip.lorenz@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B5AC2D0CD
	for <webhook@archiver.kernel.org>; Thu, 15 May 2025 14:52:05 +0000 (UTC)
Received: from esa6.hc324-48.eu.iphmx.com (esa6.hc324-48.eu.iphmx.com [207.54.71.69])
 by mx.groups.io with SMTP id smtpd.web11.14631.1747320715712778162
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 May 2025 07:51:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=qJ9rhB89;
 spf=pass (domain: bmw.de, ip: 207.54.71.69, mailfrom: prvs=22331e167=philip.lorenz@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1747320716; x=1778856716;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2VYYTJ1QhTsDelEoq/cNwjjaVTzEmmJPeT1FkR9PSYI=;
  b=qJ9rhB89G78oHBVM2cKX1XgrXzJ+P29L9UxEqvDp2nRBk0z425y76xa/
   KbD5lMZhyaV2fjBFxN3jgp0FyBWlIacx8P9p2Gw9TJXXnzHipnO7yP3Kj
   dhdGy6q8t8D5/gmVd4yeD6RdGHAJm124bImsq7C8XZ9cduCdcRFSp21Z7
   Q=;
X-CSE-ConnectionGUID: ER1TUdMJRsubFPlyzE9zWg==
X-CSE-MsgGUID: 8NkLsg+yTbyEC6yDE18JaA==
Received: from 160.46.252.38.spf.bmwgroup.com (HELO esagw2.muc) ([160.46.252.38]) by
 esa6.hc324-48.eu.iphmx.com with ESMTP/TLS; 15 May 2025 16:51:53 +0200
Received: from esabb4.muc ([160.50.100.33])  by esagw2.muc with ESMTP/TLS;
 15 May 2025 16:51:53 +0200
Received: from smucmp19d.bmwgroup.net (HELO smucmp19d.europe.bmw.corp)
 ([10.30.13.170]) by esabb4.muc with ESMTP/TLS; 15 May 2025 16:51:53 +0200
Received: from localhost.localdomain (10.30.85.209) by smucmp19d.europe.bmw.corp
 (2a03:1e80:a15:58f::205d) with Microsoft SMTP Server (version=TLS;
 Thu, 15 May 2025 16:51:53 +0200
X-CSE-ConnectionGUID: tg5Sh7UTQDqLVRuatgv5LA==
X-CSE-MsgGUID: LzHdV9s/Spmhiu8q360vng==
X-CSE-ConnectionGUID: Fzz0Z8N8TwqYhWKCb158DA==
X-CSE-MsgGUID: jfzAwJaSTRmQ4+zMi4XQSQ==
From: Philip Lorenz <philip.lorenz@bmw.de>
To: <bitbake-devel@lists.openembedded.org>
CC: Philip Lorenz <philip.lorenz@bmw.de>
Subject: [RFC PATCH 0/1] siggen: Support non-compressed sigdata files
Date: Thu, 15 May 2025 16:44:54 +0200
Message-ID: <20250515144455.2799533-1-philip.lorenz@bmw.de>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: smucmp09d.europe.bmw.corp (2a03:1e80:a15:58f::2040) To
 smucmp19d.europe.bmw.corp (2a03:1e80:a15:58f::205d)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 May 2025 14:52:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17617

To gain a better understanding of sstate invalidations in our CI systems, we
are planning to collect all sigdata files produced by all of our builds.
However, our typical builds produce 200 - 300 MB of sigdata files which would
significantly increase the log data we store for each build.

Evaluations showed that using zstd to compress uncompressed sigdata files
yielded significant compression rate improvements (in the order of 6-16x) which
lead to the creation of this patch. The patch adds support for creating
uncompressed sigdata files, and more importantly, transparent support for
consuming them. In turn, utilities such as bitbake-dumpsig can operate both
on compressed and uncompressed files, which allows mixing of compressed and
uncompressed files (e.g. compressed .siginfo files from sstate and uncompressed
.sigdata files produced by a build).

We've also tried other approaches (e.g. recompressing the files using zstd with
a dictionary trained on the decompressed files) and these also yielded somewhat
improved compression ratios. However, the results were still 10 times larger
than compressing the uncompressed files which finally lead to the
implementation of the patch.

Let me know if this is something that would be appropriate for inclusion and
I'll add some unit tests and resubmit for inclusion.

Signed-off-by: Philip Lorenz philip.lorenz@bmw.de

Philip Lorenz (1):
  siggen: Support non-compressed sigdata files

 lib/bb/siggen.py | 84 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 76 insertions(+), 8 deletions(-)


