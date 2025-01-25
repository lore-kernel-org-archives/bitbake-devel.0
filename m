Return-Path: <egyszeregy@freemail.hu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8642C0218C
	for <webhook@archiver.kernel.org>; Sat, 25 Jan 2025 12:28:55 +0000 (UTC)
Received: from smtp-out.freemail.hu (smtp-out.freemail.hu [46.107.16.242])
 by mx.groups.io with SMTP id smtpd.web10.8921.1737808134843248375
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 25 Jan 2025 04:28:55 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: message contains an insecure body length tag" header.i=@freemail.hu header.s=20181004 header.b=tapD2yOn;
 spf=pass (domain: freemail.hu, ip: 46.107.16.242, mailfrom: egyszeregy@freemail.hu)
Received: from localhost.localdomain (catv-178-48-208-49.catv.fixed.vodafone.hu [178.48.208.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.freemail.hu (Postfix) with ESMTPSA id 4YgDW81Kwwz1DJ;
	Sat, 25 Jan 2025 13:28:52 +0100 (CET)
From: egyszeregy@freemail.hu
To: bitbake-devel@lists.openembedded.org
Cc: =?UTF-8?q?Benjamin=20Sz=C5=91ke?= <egyszeregy@freemail.hu>
Subject: [PATCH v3 0/4] bitbake: knotty/progressbar: Optimize footer update and prints.
Date: Sat, 25 Jan 2025 13:27:48 +0100
Message-ID: <20250125122752.649-1-egyszeregy@freemail.hu>
X-Mailer: git-send-email 2.47.1.windows.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/relaxed; t=1737808132;
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 25 Jan 2025 12:28:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17083

	s=20181004; d=freemail.hu;

	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;

	l=861; bh=FXx49zmiscgfRbzJwarszJcsI4rYL6MWxDNToLOqrT0=;

	b=tapD2yOndckYH0Eo2+VzP2tr72i/Ze8TK7DzaplCZ8+3u2Zyu1ucalXX04W9EmsI

	Wyb2Gp9xMDJil8WQqQQLrRv2yHMM+ZbnxIXhBD/CfUsqGK2vIqUDRTr4sNkWnAtb22E

	eiR48k0SMTKtxo66DUywwj5JN9Qu9ufFvSW9N4vptlZZwGgm97LiZfohsPpYxxYkvLe

	BYiHgJUxLHl4ID3972Yv6Tc3Mim4AfBnwhR2PGNp5XxpLLKUoOa0VJ2Gvh5ambrr+4r

	xF5wNg9F5A97j0N7qV3UMawU07hqLqSRxniWP3PNEsyZTLXgHr8yYmU5wn/b5Oy4N4v

	y969TQilYw==
Content-Transfer-Encoding: quoted-printable

From: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>

- Add self._fd_console to use for self._handle_resize() in ProgressBar() =
class
- Optimize printing in footer update with use a StringIO buffer.
- Use 40 Hz refresh rate (FPS) for footer update.
- Cleaning and refactoring prints in code, print() functions were elimina=
ted from all loops for better performance.

Benjamin Sz=C5=91ke (4):
  bitbake: progressbar: Add self._fd_console to use for
    self._handle_resize()
  bitbake: knotty: Use a StringIO buffer for update footer.
  bitbake: knotty: Use 40 Hz refresh rate (FPS) for footer update.
  bitbake: knotty: print() was eliminated from all loops for better
    performance.

 lib/bb/ui/knotty.py            | 74 ++++++++++++++++++++++++----------
 lib/progressbar/progressbar.py | 11 ++++-
 2 files changed, 62 insertions(+), 23 deletions(-)

--=20
2.47.1.windows.2


