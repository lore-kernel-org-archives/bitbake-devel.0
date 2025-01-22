Return-Path: <egyszeregy@freemail.hu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF6BC0218C
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 23:25:17 +0000 (UTC)
Received: from smtp-out.freemail.hu (smtp-out.freemail.hu [46.107.16.211])
 by mx.groups.io with SMTP id smtpd.web11.8139.1737588312750431242
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Jan 2025 15:25:13 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@freemail.hu header.s=20181004 header.b=F+Iqee6W;
 spf=pass (domain: freemail.hu, ip: 46.107.16.211, mailfrom: egyszeregy@freemail.hu)
Received: from localhost.localdomain (catv-178-48-208-49.catv.fixed.vodafone.hu [178.48.208.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.freemail.hu (Postfix) with ESMTPSA id 4YdgCm5wslzKsw;
	Thu, 23 Jan 2025 00:25:08 +0100 (CET)
From: egyszeregy@freemail.hu
To: bitbake-devel@lists.openembedded.org
Cc: =?UTF-8?q?Benjamin=20Sz=C5=91ke?= <egyszeregy@freemail.hu>
Subject: [PATCH v2 0/4] bitbake: knotty/progressbar: Optimize footer update and prints.
Date: Thu, 23 Jan 2025 00:24:07 +0100
Message-ID: <20250122232411.133-1-egyszeregy@freemail.hu>
X-Mailer: git-send-email 2.47.1.windows.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1737588309;
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 Jan 2025 23:25:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17058

	s=20181004; d=freemail.hu;

	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;

	l=845; bh=wCAz1kJFGU6x5XIcVruNfIrdFNZ+cbFWs4l3pbMJK/0=;

	b=F+Iqee6Wp0hEaYJRrNW03FBQHF+WSypPxCENwTDK/4JtMAekPNAUvho6F9wm7hHE

	s4H4t1w7oXaNXyJvJzlzTLx3HtTx5aZIpFrnM49AIEf/iwFffEnEUn3V2+Cm0RskbbM

	MLChdAN5QbJXRgWakwIVRcNkMhKRJP8Tc3IQVqGr/XWqCtfzkzKyiWB5ulqCkKaUBtK

	S9z/DSJZQWtnyuJbx8b40CSajkmkmQx707KIPH2FJKHgvS1uNSck7EzErsrTWFLIi8n

	GL13wFt3XE5avGIqKfxrLF/0RgNEyjk3Gh2B0K/W4b2uY7xI4ewtiiz9AfXsdI8hlqF

	A8zJwDXzPw==
Content-Transfer-Encoding: quoted-printable

From: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>

- Check file descriptor in ProgressBar() class init to see if it is resiz=
able.
- Optimize printing in footer update with use a StringIO buffer.
- Use 10 Hz refresh rate (FPS) for footer update.
- Cleaning and refactoring prints in code, print() functions were elimina=
ted from all loops for better performance.

Benjamin Sz=C5=91ke (4):
  bitbake: progressbar: Check resizable file descriptor.
  bitbake: knotty: Use a StringIO buffer for update footer.
  bitbake: knotty: Use 10 Hz refresh rate (FPS) for footer update.
  bitbake: knotty: print() was eliminated from all loops for better
    performance.

 lib/bb/ui/knotty.py            | 69 ++++++++++++++++++++++++----------
 lib/progressbar/progressbar.py | 25 +++++++-----
 2 files changed, 66 insertions(+), 28 deletions(-)

--=20
2.47.1.windows.2


