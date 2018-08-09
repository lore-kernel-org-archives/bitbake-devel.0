Return-Path: <jpewhacker@gmail.com>
Received: from mail-io0-f171.google.com (mail-io0-f171.google.com
	[209.85.223.171])
	by mail.openembedded.org (Postfix) with ESMTP id 09FFE78C13;
	Thu,  9 Aug 2018 22:10:43 +0000 (UTC)
Received: by mail-io0-f171.google.com with SMTP id q4-v6so6076717iob.8;
	Thu, 09 Aug 2018 15:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=XvwW1eVger3vC1tM9nHMp00nDn84/gHv1C5AfIovrR4=;
	b=WaQG6hBy5jFXqNM0zUHG0/LTyLgcyDmyGrrRqaIYKcVVy2edmeOoqZ7f8SCAGgu2hy
	W3wMqIY5ibq6dNG0e470eszn7tc50x3ayIFGOKWVZC24vdhwyFrGPfX//fsCjD6nRt2d
	KXVjIeweczZ3asZhXeF0qX+8Ml9k3YSS2F27qk/3zdh5EpiGapcctnl0td7mVHvCl04B
	nzPoqwcEGTDrR8ErBjCRmqRVnTagQ2p2NeYqaFMHu2yCbCC5VSKKuLZBpkFr2N5DhRPL
	lWE/FNWuR2IVs3SLbVRXor/sU+Ap4Zj3YRYeIxVDKbczkxvtRWomQAPK+/BargqZNNCJ
	wM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=XvwW1eVger3vC1tM9nHMp00nDn84/gHv1C5AfIovrR4=;
	b=NCYcpYSgg364h34RAStdNrS507u7+fAUs8G19gceUyBhYxE2LB3XARycFoSld8G3y9
	eQqozqjSM55WmHOu+nlxb2NVdV23JVpn9/zGYPdWToR1gUsEgfgYDXnGsiA5XHb/rv98
	XB6PBgVBj0tgcZ7E+h7+if62vVoxqMo6EXETt8bp7yjb0GczBLRn+zxGm8nzEjA0Yage
	LVbE01pgf/kJUsnLufTO84oJCwKa+Fp0CDXlYzq+iha5/3JQedbvkbsh9YCoQh+7EPJI
	L2I8/2vupGQcJ/T+v8bMj3AE2rkTdt1geYOb9PDp1qE/xwt8y23RbKxMYWdrh5BS5HOz
	QSoQ==
X-Gm-Message-State: AOUpUlFrZYssxMht98w43Q6k/si/N/SGzlJ1kOOURxQJwBjiQYMOKzsE
	7G4/zVDW//VboLWng+safyHwB2GD
X-Google-Smtp-Source: AA+uWPwlAzv9lqi6+F4FAeG2/JIJaSh8+mcpXgsa4bu1N0VjcBoPZOcG4fy+VQcjMlii/ACo6uiW6w==
X-Received: by 2002:a5e:9b14:: with SMTP id
	j20-v6mr3472721iok.193.1533852644612; 
	Thu, 09 Aug 2018 15:10:44 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	z3-v6sm4404573ioz.85.2018.08.09.15.10.43
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 09 Aug 2018 15:10:44 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Date: Thu,  9 Aug 2018 17:08:24 -0500
Message-Id: <20180809220840.26697-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180716203728.23078-1-JPEWhacker@gmail.com>
References: <20180716203728.23078-1-JPEWhacker@gmail.com>
Subject: [RFC v2 00/16] Hash Equivalency Server
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
X-List-Received-Date: Thu, 09 Aug 2018 22:10:44 -0000

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
 2) There is a major rework of persist_data in bitbake. I think these
    patches could be submitted independently, but I doubt anyone is
    clamoring for them. The general gist of them is that there were a
    lot of strange edge cases that I found when using persist_data as an
    IPC mechanism between the main bitbake process and the
    bitbake-worker processes. I went ahead and added extensive unit
    tests for this as well.

Joshua Watt (16):
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

 bitbake/bin/bitbake-hashserv         |  67 ++++++++
 bitbake/bin/bitbake-selftest         |   3 +
 bitbake/bin/bitbake-worker           |  11 +-
 bitbake/lib/bb/fork.py               |  71 ++++++++
 bitbake/lib/bb/persist_data.py       | 239 ++++++++++++++++++++-------
 bitbake/lib/bb/runqueue.py           |  56 ++++---
 bitbake/lib/bb/siggen.py             |  20 ++-
 bitbake/lib/bb/tests/persist_data.py | 188 +++++++++++++++++++++
 bitbake/lib/hashserv/__init__.py     | 152 +++++++++++++++++
 bitbake/lib/hashserv/tests.py        | 141 ++++++++++++++++
 meta/classes/sstate.bbclass          | 102 +++++++++++-
 meta/conf/bitbake.conf               |   4 +-
 meta/lib/oe/sstatesig.py             | 166 +++++++++++++++++++
 13 files changed, 1117 insertions(+), 103 deletions(-)
 create mode 100755 bitbake/bin/bitbake-hashserv
 create mode 100644 bitbake/lib/bb/fork.py
 create mode 100644 bitbake/lib/bb/tests/persist_data.py
 create mode 100644 bitbake/lib/hashserv/__init__.py
 create mode 100644 bitbake/lib/hashserv/tests.py

-- 
2.17.1


