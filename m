Return-Path: <jpewhacker@gmail.com>
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com
	[209.85.166.52])
	by mail.openembedded.org (Postfix) with ESMTP id 795E26BD11;
	Tue,  4 Dec 2018 03:46:20 +0000 (UTC)
Received: by mail-io1-f52.google.com with SMTP id t24so12441157ioi.0;
	Mon, 03 Dec 2018 19:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=y1ymACRYrZg6jhjKb4rz06iKP24lAxY1SThR/tqUDwU=;
	b=oc5k6Q00omJvVc2RAGqmIw8oiwg+b3LGdowasSkM1BBAdKFUwqJyr3rOLtb9HvBe3v
	hjYeoU/T78zCA2hkne7JlrNkaXNfTho0iI6J+mpUwC1U1DJ47ioNTRKFeGksc1cNBmzj
	MWvVLoh7cboD7S8Q4VWjbRf66vCZCvPBfOHUPj3oX6YUQl8juKqZwJXoqP8iDzKJuD+6
	+QhLIuAMejZOuZGp7xri644HgQhiVux1JcPZenFzLjuABCqCYHWYylJQSF9dZGYFSTuJ
	HnqKYHQoUhZAorquZ/2KN6RTG2oolmlqHPT5YVyN1VkVqE8VznsBrFwCBr2eZHWhvhch
	irRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=y1ymACRYrZg6jhjKb4rz06iKP24lAxY1SThR/tqUDwU=;
	b=mONHD3FH9MRQyOymqNg3ncL5ltO4DK4SgEmmcA45IKkM8A2q+H/mdoIVxlQtp6qU5g
	4DyfLpjNSi4JuTUSJ7YXYGGWbLI0rLnqxhNCwPNUrfU6hgbxM1ePlbHTLWYdE4Z1BR2J
	/9z6bs+9ejb/bzIjFt/QPU6GQ22d4BNx+jl1LPKHd4fT6ioL7AS6Sq3IWaEK958Tw4g4
	XiwpaF9gxALfMDnIVfmp5Q1c6TV7o2slNupjn+O3sdrUIYqEGr2FGf2Xks+9rRvmVlif
	/MPn41wEBKo+3Yj0vpnMkkAYm6FwF5zGKtEsf0ENZyw8z6hBmho/2WPtNXJSjRkQtFsd
	0dcQ==
X-Gm-Message-State: AA+aEWZceYyUV8AOPhcIOLggCr2plkFK87ZxLYb1iw+CizlwagDFUuyX
	V55E6l6wZrRzfwqDsiqBPjotMX4N6Q8=
X-Google-Smtp-Source: AFSGD/UJVyEZe3kiCNFk2lbi8KbiXRatxLMzQBNpB6t0QnfQYP0QmByrNyIcVS5w6eCXmVc6pOebAg==
X-Received: by 2002:a5d:9257:: with SMTP id e23mr18078955iol.112.1543895181130;
	Mon, 03 Dec 2018 19:46:21 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	q23sm6216824ioi.66.2018.12.03.19.46.19
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 03 Dec 2018 19:46:20 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Mon,  3 Dec 2018 21:42:28 -0600
Message-Id: <20181204034245.25461-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20180809220840.26697-1-JPEWhacker@gmail.com>
References: <20180809220840.26697-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Subject: [OE-core][PATCH v3 00/17] Hash Equivalency Server
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
X-List-Received-Date: Tue, 04 Dec 2018 03:46:20 -0000
Content-Transfer-Encoding: 8bit

These patches are a first pass at implementing a hash equivalence server
in bitbake & OE.

Apologies for cross-posting this to both the bitbake-devel and
openembedded-devel; this work necessarily intertwines both places, and
it is really necessary to look at both parts to get an idea of what is
going on. For convenience, the bitbake patches are listed first,
followed by the oe-core patches.

The basic premise is that any given task no longer hashes a dependent
task's taskhash to determine it's own taskhash, but instead hashes the
dependent task's "dependency ID" (which doesn't strictly need to be a
hash, but is for consistency. We can have the discussion as to whether
this should be called a "dependency hash" if anyone wants). This allows
multiple taskhashes to map to the same dependency ID, meaning that
trivial changes to a recipe that would change the taskhash don't
necessarily need to change the dependency ID, and thus don't need to
cause downstream tasks to be rebuilt (with caveats, see below).

In the absence of any interaction by the user, the dependency ID for a
task is just that task's taskhash, which effectively maintains the
current behavior. However, if the user enables the "OEEquivHash"
signature generator, they can direct it to look at a hash equivalency
server (of which a reference implementation is provided). The sstate
code will provide the server with an output hash that it calculates, and
the server will record all tasks with the same output hash as
"equivalent" and report the same dependency ID for them when requested.
When initializing tasks, bitbake can ask the server about the dependency
ID for new tasks it has never seen before and potentially skip
rebuilding, or restore the task from an equivalent sstate file. To
facilitate restoring tasks from sstate, sstate objects are now named
based on the tasks dependency ID instead of the taskhash (which, again
has no effect if the server is in use).

This patchset doesn't make any attempt to dynamically update task
dependency IDs after bitbake initializes the tasks, and as such there
are some cases where this isn't accelerating the build as much as it
possibly could. I think it will be possible to add support for this, but
this preliminary support needs to come first.

Some patches have additional NOTEs that indicate places where I wasn't
sure what to do.

You can also see these patches (and my first attempts at dynamic task
re-hashing) on the "jpew/hash-equivalence" branch in poky-contrib.

As always, thanks for your feedback and time

VERSION 2:

At the core, this patch does the same thing as V1 with some very minor
tweaks. The main things that have changed are:
 1) Per request, the Hash Equivalence Server reference implementation is
    now based entirely on built in Python modules and requires no
    external libraries. It also has a wrapper script to launch it
    (bitbake-hashserv) and unittests.
 2) There is a major rework of persist_data in bitbake. I
    think these patches could be submitted independently, but I doubt
    anyone is clamoring for them. The general gist of them is that there
    were a lot of strange edge cases that I found when using
    persist_data as an IPC mechanism between the main bitbake process
    and the bitbake-worker processes. I went ahead and added extensive
    unit tests for this as well.

VERSION 3:

Minor tweak to version 2 that should fix timeout errors seen on the
autobuilder

Joshua Watt (17):
  bitbake: fork: Add os.fork() wrappers
  bitbake: persist_data: Fix leaking cursors causing deadlock
  bitbake: persist_data: Add key constraints
  bitbake: persist_data: Enable Write Ahead Log
  bitbake: persist_data: Disable enable_shared_cache
  bitbake: persist_data: Close databases across fork
  bitbake: tests/persist_data: Add tests
  bitbake: bitbake-worker: Pass taskhash as runtask parameter
  bitbake: siggen: Split out stampfile hash fetch
  bitbake: siggen: Split out task depend ID
  bitbake: runqueue: Track task dependency ID
  bitbake: runqueue: Pass dependency ID to task
  bitbake: runqueue: Pass dependency ID to hash validate
  classes/sstate: Handle depid in hash check
  bitbake: hashserv: Add hash equivalence reference server
  sstate: Implement hash equivalence sstate
  classes/image-buildinfo: Remove unused argument

 bitbake/bin/bitbake-hashserv         |  67 ++++++++
 bitbake/bin/bitbake-selftest         |   3 +
 bitbake/bin/bitbake-worker           |  11 +-
 bitbake/lib/bb/fork.py               |  73 +++++++++
 bitbake/lib/bb/persist_data.py       | 237 ++++++++++++++++++++-------
 bitbake/lib/bb/runqueue.py           |  56 ++++---
 bitbake/lib/bb/siggen.py             |  20 ++-
 bitbake/lib/bb/tests/persist_data.py | 188 +++++++++++++++++++++
 bitbake/lib/hashserv/__init__.py     | 152 +++++++++++++++++
 bitbake/lib/hashserv/tests.py        | 141 ++++++++++++++++
 meta/classes/image-buildinfo.bbclass |   6 +-
 meta/classes/sstate.bbclass          | 102 +++++++++++-
 meta/conf/bitbake.conf               |   4 +-
 meta/lib/oe/sstatesig.py             | 166 +++++++++++++++++++
 14 files changed, 1120 insertions(+), 106 deletions(-)
 create mode 100755 bitbake/bin/bitbake-hashserv
 create mode 100644 bitbake/lib/bb/fork.py
 create mode 100644 bitbake/lib/bb/tests/persist_data.py
 create mode 100644 bitbake/lib/hashserv/__init__.py
 create mode 100644 bitbake/lib/hashserv/tests.py

-- 
2.19.1


