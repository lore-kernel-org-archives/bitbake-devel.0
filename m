Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7825ECD11C2
	for <webhook@archiver.kernel.org>; Fri,  5 Apr 2024 16:41:38 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web11.17397.1712335297652128482
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Apr 2024 09:41:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=McwKGi9P;
 spf=pass (domain: bootlin.com, ip: 217.70.183.200, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 52FFC20007;
	Fri,  5 Apr 2024 16:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712335295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ee1kDCzQvMPwkMrS2XhnH2CV0NwfcwQU5MC8GCawW+k=;
	b=McwKGi9PQ6WRv7yVMW2zRFsDUavaoUdKkXseVelOxrJQQyBP/q6n71wUJPOxkbcP+9p2JX
	4kyloGhqZKZKLSdsA2RHZv7xXg/RtR4KLWYLtZJOOMco3e9eqQFWBt3Na76g4i2da2fojk
	24gDJ+x0RIvQi/xGAPGBsSpoVj6iFdwCvL4Sdd2ietEH0In7tfmlHFzTDCpwxRybb7t9Jk
	LHg5mffSfQ8I+GcM4Duen+r5f/c5JAEVscqUUJ/jmORGHaIx7RzNO7S+HPWGgkoMucKOri
	dHhb3fN4S15cEoqIAtC3q8XyXAXc0QG/5orTIuYd6aRH8V4lj2bjBGj58ygz8w==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH v2 00/12] prserv: add support for an "upstream" server
Date: Fri,  5 Apr 2024 18:41:13 +0200
Message-Id: <20240405164125.1652579-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Apr 2024 16:41:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16048

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

This makes it possible to customize an "upstream" distribution
by modifying local packages. If the "upstream" package bears
revision "x", the local one will have revision "x.y", this
having priority over the upstream one.

Multiple levels of upstream servers are supported, so "x.y.z" revisions
are possible too.

Take advantage of this work to clean-up and update the prserv code too.

Manual "sanity" tests have been run so far but automated tests
(based on Python unittest, as for the hash server tests)
are being prepared for the next iteration.

Code reviews are welcome, especially for more Pythonic
ways of implementing some details.

---

Changes in V2:
- Add this new commit:
  prserv: remove unused "hist" mode in the database backend
- Squash commit "prserv: fix read_only test" into
  commit "prserv: simplify the PRServerClient() interface"
  (Reported by Richard Purdie)
- Fix the code to support increasing "x.y.z" values, thus
  supporting several levels of upstream servers.
- db.py: remove duplicate definition of find_max_value() function in db.py
- prserv.py: remove tabs before comments (Python didn't complain)
- db.py: now stores the revision ("value") as TEXT.
  This way we can store "1.0" without having it transformed to "1"
  when the default type was INTEGER.
- This allows to fix a regression when the first packages were created
  with 'r0.1' instead of 'r0.0' initially.
- find_max_value: now returns None instead of '0' when no value is found
  Before we couldn't tell the difference between a '0'
  max value and the absence of such a value.

Michael Opdenacker (12):
  prserv: simplify the PRServerClient() interface
  prserv: use double quotes by default
  bitbake-prserv: replace deprecated optparse by argparse
  prserv: use self.logger instead of logger directly
  asyncrpc: include parse_address from hashserv
  prserv: capitalization and spacing improvements
  prserv: remove unused "hist" mode in the database backend
  prserv: add extra requests
  prserv: remove redundant exception handler
  prserv: correct error message
  prserv: remove unnecessary code
  prserv: add "upstream" server support

 bin/bitbake-prserv        |  99 ++++++++++-----
 lib/bb/asyncrpc/client.py |  23 ++++
 lib/hashserv/__init__.py  |  27 +---
 lib/prserv/__init__.py    |  21 +++-
 lib/prserv/client.py      |  42 +++++--
 lib/prserv/db.py          | 251 +++++++++++++++++---------------------
 lib/prserv/serv.py        | 219 ++++++++++++++++++++++++---------
 7 files changed, 415 insertions(+), 267 deletions(-)

-- 
2.34.1


