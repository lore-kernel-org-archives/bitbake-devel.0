Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3CFC04FFE
	for <webhook@archiver.kernel.org>; Mon, 29 Apr 2024 20:14:30 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
 by mx.groups.io with SMTP id smtpd.web11.32225.1714421668644054266
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 29 Apr 2024 13:14:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=hJ07swGr;
 spf=pass (domain: bootlin.com, ip: 217.70.183.198, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 95C1BC0002;
	Mon, 29 Apr 2024 20:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714421666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QJ3P5Ekd4ZtW55f57GCRDNp/0cSJ9H1PtLskBkODH9M=;
	b=hJ07swGrncNKk/hr5rfHb480nWsV881JF9u2Hpkz0yVV3gnQHrO/ZWVSknd9vt+MQQ71uy
	+MuAbeaaY6B4VfSGRXifFivRDzHs2ibhIQB5rmVDgOO4NEUxpQ8xgqVdMmrOkkaKxOMAKG
	V4cv9M09vBbCREq89Q3IgvDET/x8iTcOIXmarSqJzmh7F7ppqiN8KhhhqfSCtM3nEpA3oi
	k/HeUJw7UFdAaQ5/crzyWcVqFbJstfiFsrQC6E/RR1JigNhuxBVEdzbmsWA6h4qNoNqf8i
	HbJU9KDWim90Q5jfXCAOf5oi4xDo415ujR4FdJEvx5HQ4NFt3Z4YahxA4OfQ2Q==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Tim Orling <ticotimo@gmail.com>
Subject: [PATCH v5 0/5] prserv: add support for an "upstream" server
Date: Mon, 29 Apr 2024 22:14:13 +0200
Message-Id: <20240429201418.657042-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 29 Apr 2024 20:14:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16149

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

This makes it possible to customize an "upstream" distribution
by modifying local packages. If the "upstream" package bears
revision "x", the local one will have revision "x.y", this
having priority over the upstream one.

Multiple levels of upstream servers are supported, so "x.y.z" revisions
are possible too.

This version also supports multiple servers sharing the same database.

This also includes BitBake selftests to check the expected
functionality and detect future regressions.

Note that database import and export functions aren't tested yet.

---

Changes in V5:

- Change the way the database is accessed and modified.
  As done in the Hash Server code, the database is not
  accessed through the cursor API.

  This makes it possible to have multiple servers accessing
  the same database, typically one read-write server that
  is fed by the build machine, and one read-only server that
  is used to publish PR data to downstream users.

  This switched sqlite3 to "WAL" journaling mode, and to
  "OFF" synchronous mode.

- Fix revision ordering issues, now computing the min and max
  values through dedicated Python functions, instead of letting
  the database do this with just string comparison, which
  was wrong in our case. Typically, "1.20" is greater for us
  than "1.3".

- Add BitBake selftests, in particular to make sure revision
  ordering is correct and the maximum and minimum values are
  correctly computed.

- An issue remains: the BitBake selftests that test database
  access through a read-only server while a read-write server
  is still running, still fail, because the database changes
  are apparently not stored to disk.

  FAIL: test_3b_readonly (prserv.tests.PRUpstreamTests)

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
  prserv: enable database sharing
  prserv: add bitbake selftests

 bin/bitbake-prserv     |  26 ++-
 bin/bitbake-selftest   |   2 +
 lib/prserv/__init__.py |  97 ++++++++-
 lib/prserv/client.py   |  19 +-
 lib/prserv/db.py       | 461 ++++++++++++++++++++---------------------
 lib/prserv/serv.py     | 142 ++++++++++---
 lib/prserv/tests.py    | 416 +++++++++++++++++++++++++++++++++++++
 7 files changed, 880 insertions(+), 283 deletions(-)
 create mode 100644 bitbake/lib/prserv/tests.py

-- 
2.34.1


