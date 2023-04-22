Return-Path: <bluelightning@bluelightning.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29923C77B76
	for <webhook@archiver.kernel.org>; Sat, 22 Apr 2023 03:05:36 +0000 (UTC)
Received: from mail2.g23.pair.com (mail2.g23.pair.com [66.39.132.40])
 by mx.groups.io with SMTP id smtpd.web11.1123.1682132728593614556
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Apr 2023 20:05:28 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=none, err=permanent DNS error (domain: bluelightning.org, ip: 66.39.132.40, mailfrom: bluelightning@bluelightning.org)
Received: from mail2.g23.pair.com (localhost [127.0.0.1])
	by mail2.g23.pair.com (Postfix) with ESMTP id 4C5B8E6109;
	Fri, 21 Apr 2023 23:05:27 -0400 (EDT)
Received: from linc.fritz.box (unknown [161.29.131.251])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mail2.g23.pair.com (Postfix) with ESMTPSA id 5D0D7E5F87;
	Fri, 21 Apr 2023 23:05:26 -0400 (EDT)
From: Paul Eggleton <bluelightning@bluelightning.org>
To: bitbake-devel@lists.openembedded.org
Cc: michael.opdenacker@bootlin.com
Subject: [PATCH 0/3] BitBake user manual updates for 2.4
Date: Sat, 22 Apr 2023 15:05:20 +1200
Message-Id: <cover.1682131637.git.bluelightning@bluelightning.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Scanned-By: mailmunge 3.11 on 66.39.132.40
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 22 Apr 2023 03:05:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14735

Documentation updates for the 2.4 branch / master (to correspond with
the Yocto Project 4.2 release).

Note: I am electing to add BB_GLOBAL_PYMODULES and BB_HASH_CODEPARSER_VAL=
S
here without pointers from the Yocto reference manual currently, since th=
ey
are highly specialized.


The following changes since commit 66131fa6a3e12c28710d09e1dbf3c03f298128=
0d:

  cooker: do not abort on single ctrl-c (2023-04-20 12:36:18 +0100)

are available in the Git repository at:

  https://git.openembedded.org/bitbake-contrib paule/doc-updates-2.4
  http://cgit.openembedded.org/bitbake-contrib/log/?h=3Dpaule/doc-updates=
-2.4

Paul Eggleton (3):
  bitbake-user-manual: document BB_CACHEDIR
  bitbake-user-manual: add addpylib and BB_GLOBAL_PYMODULES
  bitbake-user-manual: add BB_HASH_CODEPARSER_VALS

 .../bitbake-user-manual-metadata.rst          | 18 ++++++++++++++
 .../bitbake-user-manual-ref-variables.rst     | 24 +++++++++++++++++++
 2 files changed, 42 insertions(+)

--=20
2.34.1


