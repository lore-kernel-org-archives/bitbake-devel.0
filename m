Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B93FC4345F
	for <webhook@archiver.kernel.org>; Tue, 23 Apr 2024 09:38:01 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web10.14466.1713865070830445011
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 23 Apr 2024 02:37:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=Rm2P8qfG;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id F187DC000C;
	Tue, 23 Apr 2024 09:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713865069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GAN9r9neS1DrB1kfOYM3i1zcLAEWM7Q8uZQsbfsEa0M=;
	b=Rm2P8qfGGHKkeqMesdO0DpAqKylBcIvGadG5l5ox1tQzml86Phx04w6WIg6ulC/z+5SvwS
	sKunwcCe26J5H+7+GcD4/EqAdgQ4bN633es6NuVcbP8i+5htqJPaLQ753srtHqPoP0u9Bh
	wvKAhI9ZzaNTNHqgRQ8OlS5AFzhfsHnXKXwP1lph8y4D16Ehcq3/6DiEV7AjGga9kw8CJu
	IgfYcGASEh5oRbv43dOPy1UL9NLGGTR5TPuYB5VdkCuXQb4yzMG1SmfrHU3vUg7nZwNj1g
	efXOxo1GF1fI/GkHtCs0cCVaFLmT6GTWW0K2R5VUePjOzDjLPAHyxPjevVz0hw==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Tim Orling <ticotimo@gmail.com>
Subject: [PATCH v4 0/5] prserv: add support for an "upstream" server
Date: Tue, 23 Apr 2024 11:37:34 +0200
Message-Id: <20240423093739.364140-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 23 Apr 2024 09:38:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16123

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

This makes it possible to customize an "upstream" distribution
by modifying local packages. If the "upstream" package bears
revision "x", the local one will have revision "x.y", this
having priority over the upstream one.

Multiple levels of upstream servers are supported, so "x.y.z" revisions
are possible too.

This also includes BitBake selftests to check the expected
functionality and detect future regressions.

Note that database import and export functions aren't tested yet.

---

Changes in V4:

- Add BitBake selftests for the legacy and new PR server features
  (database, client, server, support for upstream server, read-only mode, "history" and "no history" modes)
  To run only these tests:
  bitbake-selftest prserv.tests

- Pass the "history" mode through the client requests, instead
  of storing it (globally) in the database name.

  The PR database is now called "PRMAIN" instead of "PRMAIN_nohist".
  This should cause a regression for builds which already
  have a PR database.

- Fixes for "history" modes:
  - Allow to store multiple PR values for the same checksum,
    needed for the "no history" mode.
  - Make the "history" mode return the minimum stored
    PR value.

- Fixes and code reorganization for issues uncovered by the tests.

- Update the server version to "2.0.0"

Changes in V3:

- Revert the commit removing the so far unused "hist" mode, which
  we wish to keep for binary reproducibility sake.

- Simplification of get_value() function to take
  both "hist" and "nohist" modes with the same shared code.

- Add "history" parameter to the "getPR" request,
  so that the client can ask for the mode of its choice.
  This will also make it possible to implement tests
  for both modes.

  Note that more requests ("export", "import"...)
  will also need a "history" parameter, in a future version,
  after the first tests are implemented.

- Several bug fixes.

- Put all the new features at the tip of the branch,
  to make the cleanup commits easier to merged.

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

Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Joshua Watt <JPEWhacker@gmail.com>
Cc: Tim Orling <ticotimo@gmail.com>

Michael Opdenacker (5):
  prserv: declare "max_package_pr" client hook
  prserv: move code from __init__ to bitbake-prserv
  prserv: add "upstream" server support
  prserv: sync the database after each change
  prserv: add bitbake selftests

 bin/bitbake-prserv     |  26 ++-
 bin/bitbake-selftest   |   2 +
 lib/prserv/__init__.py |  87 ++++++++--
 lib/prserv/client.py   |  19 +-
 lib/prserv/db.py       | 194 ++++++++++-----------
 lib/prserv/serv.py     | 137 ++++++++++++---
 lib/prserv/tests.py    | 381 +++++++++++++++++++++++++++++++++++++++++
 7 files changed, 703 insertions(+), 143 deletions(-)
 create mode 100644 bitbake/lib/prserv/tests.py

-- 
2.34.1


