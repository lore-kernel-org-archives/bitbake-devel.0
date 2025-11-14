Return-Path: <mathieu.dubois-briand@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3251DCE7B0E
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 13:27:50 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17871.1763126863119173593
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Nov 2025 05:27:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=QifnDdAW;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: mathieu.dubois-briand@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E1AA01A1AA0
	for <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 13:27:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B256D6060E
	for <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 13:27:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3DE5410371C5E;
	Fri, 14 Nov 2025 14:27:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763126860; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=6mX81wCY9kPGaWwK30SvXAMiN0DaAWy8O/P9wVIWiwg=;
	b=QifnDdAWwn9P9TBxUe98zKUejdGf7IWpJgqTcFoh6Wr7kI+WXYn3V0SCWyRDiGDHRpcBJi
	uwBBtw4EjmrYV0vteaCQOhc8zS588tv6DV2xbdAsy2D1CF/JO0wv83SQ7rdbytKhcGWRAZ
	CZPtvOkWrWhS21JAchSmXA/qbfH4vqLM4n+1Je+oh5f8u++wBagglE5DiidMaj0EChSD2P
	Czis/tSLW+rFBzZ63C47zWtYndZ+HPlUHF7AyF06KpgQVlwfdVKo/JpeShS1/tiRdXW6y+
	oe8+2y3l8XIjKVtsa3tvbCVj1RTup/UWuXE98pOT0dl9VGl+Eo1VjzxEvA+Wow==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Subject: [PATCH 0/2] data: Escape back quotes in environment
Date: Fri, 14 Nov 2025 14:27:32 +0100
Message-Id: <20251114-mathieu-back_quote_devshell-v1-0-45e83df2f362@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEQuF2kC/x3MTQqDMBAG0KvIrA04MV20VylF8vPZDLXaJiqCe
 HeDy7d5O2UkQaZHtVPCKlmmsYDriny04xtKQjHpRt+Y2aivnaNgUc76T/dfphldwJojhkE5dnw
 PrTeN0VSGX0Iv27U/X8dxAghUjFZtAAAA
X-Change-ID: 20251114-mathieu-back_quote_devshell-b1b19d3c4042
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763126859; l=1883;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=k8PKJlcCmnUKzDEvGe6Hv1Et6SIJqOb6zCci7sU2PGI=;
 b=xAdZiR1a5fJEVYTG57kchux/I3e5cL+KgyVMYiJihjL3gmsMSlH9SPBMvz01U4W8cYGmMZcDq
 8RxIutub13tDLJ8SseEn93KfuecYO17eqTvi3gC44ZkOOO5QIPiKp95
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 13:27:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18402

Fixing devshell when some environment variables contain a back quote. On
my side I had this issue using kitty terminal emulator, which sets the
KITTY_PUBLIC_KEY environment variable [1]:
KITTY_PUBLIC_KEY=1:`TB}~6^vgiFD2v6d}JRgt!X|qx#0~mO?&N=A1jfi

Trying to use devshell failed silently, but the parse error is visible
while launching the do_terminal script by hand:

tmp/work/qemux86_64-poky-linux/linux-yocto/6.16.11+git/temp/run.do_terminal.2972397: line 120: unexpected EOF while looking for matching ``'
WARNING: tmp/work/qemux86_64-poky-linux/linux-yocto/6.16.11+git/temp/run.do_terminal.2972397:119 exit 2 from 'export KITTY_PID="1985830"'
WARNING: Backtrace (BB generated script): 
	#1: main, tmp/work/qemux86_64-poky-linux/linux-yocto/6.16.11+git/temp/run.do_terminal.2972397, line 119

Escaping back quotes allows to launch the devshell correctly.

Also adding a non-regression test. The whole bb.data.emit_var() function
was not tested, I'm not sure if it was by choice or not, but I added
some.

I tested the most basic code paths of bb.data.emit_var() but I'm not
fully exhaustive. Notably, the return value remains untested as I was
not able to figure out what it means and it appears to be unused.

[1]: https://sw.kovidgoyal.net/kitty/glossary/#envvar-KITTY_PUBLIC_KEY

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
Mathieu Dubois-Briand (2):
      data: Escape back quotes in environment
      tests: data: Add tests on emitting environment variables

 lib/bb/data.py       |   1 +
 lib/bb/tests/data.py | 105 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+)
---
base-commit: ce90d59ff1c96d04856ca5e41a963af00d1783f1
change-id: 20251114-mathieu-back_quote_devshell-b1b19d3c4042

Best regards,
-- 
Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>


