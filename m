Return-Path: <foss@0leil.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC45AC55164
	for <webhook@archiver.kernel.org>; Thu, 30 Jul 2026 15:19:47 +0000 (UTC)
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14123.1785424780263237005
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Jul 2026 08:19:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@0leil.net header.s=20231125 header.b=jeU/U2fz;
 spf=pass (domain: 0leil.net, ip: 84.16.66.170, mailfrom: foss+yocto@0leil.net)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h9tCs6GTgzMll;
	Thu, 30 Jul 2026 17:19:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1785424777;
	bh=guDIowEiDPxIrHzi75eHOlyOzyBCTotjRxvpzNyxo2A=;
	h=From:Subject:Date:To:Cc:From;
	b=jeU/U2fzPPUgxyDXnToNVj1pJ1ui+FRBepLUGIHLXC/9mW0FvbRBMLFSWxKZ/iqli
	 3ASK18iJ2ZymunCpxrqRGdD4T4Zoz7X8NsMfB60+1oBgXUhJvaeuXF5BM6a0Xkv67E
	 vATsGNruQk2YiLT0hKY3gaPaDS0Zbw7QHTaZOz/ygxCPfR07oqWzvV1S6jztX3v0ef
	 x7Zz6DSDURE4Z7cSjWNxLG0kbJ+FylJgvE73yPouM463FW0lrJ/0ZN9qjE8/HFl5KB
	 9G4Z7z+v6yGNMeclruhR5sYQoDGuCqR2Q70uLLEPlNmg9ieOsnTKToZ5b5rgZbfVms
	 Vzg8AMIqS0Gog==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4h9tCs1FKrz844;
	Thu, 30 Jul 2026 17:19:37 +0200 (CEST)
From: Quentin Schulz <foss+yocto@0leil.net>
Subject: [PATCH 0/3] doc: fix build + add cross-reference to DL_DIR
Date: Thu, 30 Jul 2026 17:19:29 +0200
Message-Id: <20260730-doc-fix-build-v1-0-f79ae06a270b@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDc2MD3ZT8ZN20zArdpNLMnBTdtGTTJJO0JEvz5DQDJaCegqJUoCTYvOh
 YCL+4NCkrNbkEZIhSbS0AwjJ0o3EAAAA=
X-Change-ID: 20260730-doc-fix-build-fc5b4fb97cf0
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.16-dev
X-Infomaniak-Routing: alpha
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 30 Jul 2026 15:19:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19877

This fixes the doc build in master and also adds a missed
cross-reference to DL_DIR.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (3):
      doc/bitbake-user-manual-environment-setup: fix reference to non-existing term
      doc/bitbake-user-manual-ref-variables: fix reference to non-existing entry in variable glossary
      doc/bitbake-user-manual-environment-setup: cross-reference DL_DIR

 doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst | 4 ++--
 doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst     | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)
---
base-commit: d1886335f0d7fa86e87c6001d5be306a8e90586b
change-id: 20260730-doc-fix-build-fc5b4fb97cf0

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>


