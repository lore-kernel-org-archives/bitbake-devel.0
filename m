Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACD5C6FD1F
	for <webhook@archiver.kernel.org>; Fri, 29 Mar 2024 14:40:18 +0000 (UTC)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
 by mx.groups.io with SMTP id smtpd.web11.20.1711723213532879921
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 29 Mar 2024 07:40:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=TtsTCrzh;
 spf=pass (domain: bootlin.com, ip: 217.70.183.199, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A8236FF80A;
	Fri, 29 Mar 2024 14:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711723211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dZdyeHiW/enyrKzNenMuuU+EzXGp3EQ0RqKa6jZ6OSI=;
	b=TtsTCrzh5fjv7cClxg11ObVFwTswJ4AtpA6NCfE7AbAN75DrloQNnR3/hifHt8z1dSUAHX
	XKd8AZ0C4RzaBe1mv2orfh6HLhsY0FfVpiHhZe0DATVEQOipYgyN1Ygbn8h+pLDnxhI1nS
	vG+xUwhf2AfM5osZhX+bMSSTta0F/IcturLa1x7Y8VJLpg5bgufkoNPRI5Zh0rhVizFoDn
	CMqjdAB7dAfu6oMe2G7YAxAp4OUSmOY46LsnDSlaUfZ73t1X2fwcacDiWh6DXPKw7M8Vne
	/4DmeIeVywItfcoo8UVFmo3+/wOesGTx224Pkv8o8y3MkDJXfVZCprflI+WS7A==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH 00/12] prserv: add support for an "upstream" server
Date: Fri, 29 Mar 2024 15:39:44 +0100
Message-Id: <20240329143956.1602707-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 Mar 2024 14:40:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16022

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

This makes it possible to customize an "upstream" distribution
by modifying local packages. If the "upstream" package bears
revision "x", the local one will have revision "x.y", this
having priority over the upstream one.

Take advantage of this work to clean-up and update the prserv code too.

Michael Opdenacker (12):
  prserv: simplify the PRServerClient() interface
  prserv: use double quotes by default
  bitbake-prserv: replace deprecated optparse by argparse
  prserv: use self.logger instead of logger directly
  asyncrpc: include parse_address from hashserv
  prserv: capitalization and spacing improvements
  prserv: fix read_only test
  prserv: add extra requests
  prserv: remove redundant exception handler
  prserv: correct error message
  prserv: remove unnecessary code
  prserv: add "upstream" server support

 bin/bitbake-prserv        |  99 ++++++++++++-----
 lib/bb/asyncrpc/client.py |  23 ++++
 lib/hashserv/__init__.py  |  27 +----
 lib/prserv/__init__.py    |  21 +++-
 lib/prserv/client.py      |  42 +++++--
 lib/prserv/db.py          | 176 ++++++++++++++++++++---------
 lib/prserv/serv.py        | 228 ++++++++++++++++++++++++++++----------
 7 files changed, 434 insertions(+), 182 deletions(-)

-- 
2.34.1


