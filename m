Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C039BC4345F
	for <webhook@archiver.kernel.org>; Tue, 30 Apr 2024 17:15:31 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
 by mx.groups.io with SMTP id smtpd.web10.21658.1714497328835135969
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 30 Apr 2024 10:15:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=Uzn0Z+/k;
 spf=pass (domain: bootlin.com, ip: 217.70.183.194, mailfrom: michael.opdenacker@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2117E40003;
	Tue, 30 Apr 2024 17:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1714497326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fHcITbGCA85BtDF87RXzi5uAWsKDOxP7sj4N+bJ84Cg=;
	b=Uzn0Z+/klvu+mzU9cmCjA/I+gxfZM+vbEeOBtWMsvsc9nEPkFzR7A2V4fLg+VRxC+zMZGs
	STAHwlIPsa4lHAenvUNnOsffeU9iyonVZzfWNd0RB7Tp9hDBgUdjuvzSWvw8uj2+fTuS6N
	sLUWjoeJ8Ot2z8kUsMNmvM7SunNlosygHei+8VHZeMFZQBbvZ3ACJkFDmnfM9f8zyyHC5k
	foP3e3h4LIjDfL3piCLsf7NPLPqOf59bTvWNholftcp1M/RDYURRAFrsvT/66VO3wjJ2hA
	T7OJHt6sgjXWYLxT3YGKO1usl0OWkkj1oyFuChSN2sKfGfo6xz17aHF5GKaagw==
From: michael.opdenacker@bootlin.com
To: bitbake-devel@lists.openembedded.org
Cc: Michael Opdenacker <michael.opdenacker@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Joshua Watt <JPEWhacker@gmail.com>,
	Tim Orling <ticotimo@gmail.com>
Subject: [PATCH v6 0/8] prserv: add support for an "upstream" server
Date: Tue, 30 Apr 2024 19:15:04 +0200
Message-Id: <20240430171512.936371-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 30 Apr 2024 17:15:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16165

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

Changes in V6:

- Harden the store_value() code to protect
  it against storing the same value twice.

- Simplify the importone() hook, removing
  its unnecessary "history" parameter.

- This fixes all errors in "oe-selftest -r prservice",
  once this OE-core patch is merged:
  https://lore.kernel.org/openembedded-core/20240429194656.655509-1-michael.opdenacker@bootlin.com/T/#u

- Make tests work in temporary directories.
  Suggested by Joshua Watt

- Remove first version of readonly server tests
  which depended on the output of a previous test.
  One implementation of readonly server tests remains.

- Merge the upstream and read-only tests so that
  the read-only test part can reuse the databases
  and servers from the upstream one. Initially thought
  that the setUp (and tearDown) hooks were called only
  once for each test class, instead of for each test.
  Thanks to Joshua Watt for making me understand this.

- Merged two more tests and simplified their naming
  as, with one exception, the order of tests doesn't
  matter any more.

- Avoid a possible race condition at database
  creation time. Suggested by Joshua Watt.

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

Michael Opdenacker (8):
  prserv: declare "max_package_pr" client hook
  prserv: move code from __init__ to bitbake-prserv
  prserv: add "upstream" server support
  prserv: enable database sharing
  prserv: avoid possible race condition in database code
  prserv: store_value() improvements
  prserv: import simplification
  prserv: add bitbake selftests

 bin/bitbake-prserv     |  26 ++-
 bin/bitbake-selftest   |   2 +
 lib/prserv/__init__.py |  97 ++++++++-
 lib/prserv/client.py   |  15 +-
 lib/prserv/db.py       | 452 ++++++++++++++++++-----------------------
 lib/prserv/serv.py     | 139 ++++++++++---
 lib/prserv/tests.py    | 386 +++++++++++++++++++++++++++++++++++
 7 files changed, 816 insertions(+), 301 deletions(-)
 create mode 100644 bitbake/lib/prserv/tests.py

-- 
2.34.1


