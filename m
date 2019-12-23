Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
	[209.85.214.174])
	by mail.openembedded.org (Postfix) with ESMTP id CCB217F847
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Dec 2019 04:50:45 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id g6so3756144plp.6
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 22 Dec 2019 20:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id;
	bh=+Twtl7frfVSPDYPrlRwqIDtLpNMCpOrhfzuFllQIvdw=;
	b=d7zdYykkX+30vtR8LW2+726Ebi+SU12lQHDJcGKXI47hxvAUML5wQH2x35+rrRPgFf
	2yEp1xw9c90gRXVkYrp6UfYcyRqFUagt+llgBxjMxat18iyICz7o2OQZ4v5qkzfcN0Ys
	CUyo219Bj1dauzHBx902/hIjd45OWQv5wveXkyTMoWPiDEb2kvR52mMuYWLxqEiFipEB
	/AkPeN1GqqhnM/4BTNkDFnoFKky/QVcFqgUYbFpwSfY9TZVshB/J5Zpebzk5XjmE1dL/
	G7qdVE8OIF+0m+3s2wED+/lq5zN0AQI116e7K3yyBhi+cpKRWuNpP3H34rvArFTwl6lW
	+F/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=+Twtl7frfVSPDYPrlRwqIDtLpNMCpOrhfzuFllQIvdw=;
	b=HG0G8yNz7weFolm9ggJ5VDqyiLrI4FUWLzK46wPvMLqNinURpMLzfsSu9xAJU9lpnd
	ySb/2sLQSV/bmSWhPtE4nKkZSbG54NeFgvMUhN0rUm+dBcbL4pop/zFiicsMxkALslbQ
	qWRQzKAAIN2n1lUHTu/Plucc8h0/l8iByFS7LdPZsOHQqhshOhSgFLCdQWy4cgAFiRaH
	pwWtRGLmzmRwBiZCswtqduBilYsLhNcDVfq+itwnpwQ+umpOmTQerSY57iyKpUgRaa/u
	MjCdtodygJIq5PIl+rXzXGSjxGIogqegG1k+XPbpp4sUA4CZuUXm/N8ZERA1RWGkp67V
	pLaw==
X-Gm-Message-State: APjAAAWlyPiDClaqKQ5l5OZL70lrRZXeI2fjG14ss8k0M1KQm75QYfA0
	DzqUxH8Li3L4DBMw/2vDFfdzewB/8IY=
X-Google-Smtp-Source: APXvYqyR9txWFHz5U+rxxTimGIWpaqR2jPpvodTqd3ZgL34MQ0AYQW9xUxi9CCYvS3mjRj5cRZGyCg==
X-Received: by 2002:a17:902:8481:: with SMTP id
	c1mr1344262plo.319.1577076646570; 
	Sun, 22 Dec 2019 20:50:46 -0800 (PST)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:a5c0:30f1:af1:c5e0:a746])
	by smtp.gmail.com with ESMTPSA id
	q11sm22276726pff.111.2019.12.22.20.50.45
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sun, 22 Dec 2019 20:50:46 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 22 Dec 2019 20:50:24 -0800
Message-Id: <cover.1577076251.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
Subject: [1.44 00/18] Patch review
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 23 Dec 2019 04:50:46 -0000

This series has been run on the AB.

I relize the hash work is progress for fixes to 1.44.

This is what I have so far.
The following changes since commit cfa307aabf710d79c404a8571b4158b864a94727:

  runqueue.py: not show warning for deferred multiconfig task (2019-11-29 11:26:07 +0000)

are available in the git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.44-nut
  http://cgit.openembedded.org//log/?h=stable/1.44-nut

Chris Laplante via bitbake-devel (1):
  bb.utils.fileslocked: don't leak files if yield throws

Joshua Watt (1):
  runqueue: Batch scenequeue updates

Richard Purdie (16):
  hashserv: Add support for equivalent hash reporting
  runqueue/siggen: Allow handling of equivalent hashes
  runqueue: Add extra debugging when locked sigs mismatches occur
  knotty/uihelper: Switch from pids to tids for Task event management
  siggen: Avoid taskhash mismatch errors for nostamp tasks when
    dependencies rehash
  siggen: Ensure new unihash propagates through the system
  siggen: Fix performance issue in get_unihash
  runqueue: Rework process_possible_migrations() to improve performance
  runqueue: Fix task mismatch failures from incorrect logic
  siggen: Split get_tashhash for performance
  runqueue: Fix sstate task iteration performance
  runqueue: Optimise task migration code slightly
  runqueue: Optimise out pointless loop iteration
  runqueue: Optimise task filtering
  runqueue: Only call into the migrations function if migrations active
  lib/bb: Optimise out debug messages from cooker

 lib/bb/__init__.py     |   5 ++
 lib/bb/build.py        |  25 +++++-----
 lib/bb/runqueue.py     | 127 ++++++++++++++++++++++++++++---------------------
 lib/bb/siggen.py       |  74 ++++++++++++++++++++++------
 lib/bb/ui/knotty.py    |  12 ++---
 lib/bb/ui/uihelper.py  |  39 +++++++++------
 lib/bb/utils.py        |   9 ++--
 lib/hashserv/client.py |   8 ++++
 lib/hashserv/server.py |  36 ++++++++++++++
 9 files changed, 231 insertions(+), 104 deletions(-)

-- 
2.7.4


