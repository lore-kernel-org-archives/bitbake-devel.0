Return-Path: <jpewhacker@gmail.com>
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com
	[209.85.166.41])
	by mail.openembedded.org (Postfix) with ESMTP id 1ED126E47A;
	Tue, 18 Dec 2018 15:31:05 +0000 (UTC)
Received: by mail-io1-f41.google.com with SMTP id l14so13064169ioj.5;
	Tue, 18 Dec 2018 07:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=1QB7FdaEp5dUDTDcoAvk9cNoCGLcguI/p8FOugPSkrU=;
	b=kHYQMtp7NG+LbrlsM0b2/xOIge+xQrXJ+8HV/y7J5EWQ83Q+BGNmz+Und5tPAi9aNN
	WXpA5SLu9C/mMro3i6asfDz47n2MHaWJI9ZFhs+nXgUU+9Ha/CRlH5roxQ+ttohqlCd+
	xojDF5tVVPUANjIuDR6+3CwtSslU7Oi9/55gjWSnGggVWHpnfAE0s9CShWNkeiduG32O
	xGayXGSagNrprNFIvS9wLTmBdRM/NWz2fo6/XzQCp71udvc+1xOQnF9T1xYetOdZh273
	rEHzpTaMy1zV+dgOTJMwa+6DHnjxIorsRGX2hPDJ7VcRRXU/5VQhPM2wfehVYUWbOXuC
	I9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=1QB7FdaEp5dUDTDcoAvk9cNoCGLcguI/p8FOugPSkrU=;
	b=TgSMhcvkwYkhYhjlC8dEXCSDFecN/6X1GsGos5tmkjkxlJ5AfgimnA2QfwtdLwVBu0
	ZiFmybMRfbTmnA9hjl0NMI+wv0G1dqzBx7Nnzy41sq5oqV2vSDkRNCAcfeWdPCc9W+qK
	l3I/3ug1/zC60koeECIx9LwuIKyoEZqcqf+DjW3QiXugRybvp29HiHp7WLj182L4rRsw
	T9Aa5F6L3lLSZiX6HJDhQ9+Y5qPJEsWm379JydEzTeML5k88UFSMyUlB8kJ8mB/94eKb
	KqmYETPmmkE8ria+qCbjLvP33hn2vw4ew3OwVC9UEGgZuw1dQeu/2R7bMmCWTSGS7E52
	bGBw==
X-Gm-Message-State: AA+aEWaQovbz00aPyPk0RNgubEAIgcx+qf6t1ox63WHWUalPCOmln2Mb
	dKujgzgv+Lc6JBlfKBAUR5lPlzNw
X-Google-Smtp-Source: AFSGD/XZ0PlTqRlnvd3xwI9dCwEjlK4nZEt6RFhCB6LEzpH3tEiDhFNtdjAo193OLnmnuKiMLpx37A==
X-Received: by 2002:a5d:8d04:: with SMTP id p4mr4459807ioj.70.1545147066480;
	Tue, 18 Dec 2018 07:31:06 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id 18sm1652072itk.28.2018.12.18.07.31.04
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 18 Dec 2018 07:31:04 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Tue, 18 Dec 2018 09:30:51 -0600
Message-Id: <20181218153101.9212-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204034245.25461-1-JPEWhacker@gmail.com>
References: <20181204034245.25461-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Subject: [OE-core][PATCH v4 00/10] Hash Equivalency Server
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
X-List-Received-Date: Tue, 18 Dec 2018 15:31:06 -0000
Content-Transfer-Encoding: 8bit

Apologies for cross-posting this to both the bitbake-devel and
openembedded-devel; this work necessarily intertwines both places, and
it is really necessary to look at both parts to get an idea of what is
going on. For convenience, the bitbake patches are listed first,
followed by the oe-core patches.

The basic premise is that any given task no longer hashes a dependent
task's taskhash to determine it's own taskhash, but instead hashes the
dependent task's "unique hash" (which doesn't strictly need to be a
hash, but is for consistency.  This allows multiple taskhashes to map to
the same unique hash, meaning that trivial changes to a recipe that
would change the taskhash don't necessarily need to change the unique
hash, and thus don't need to cause downstream tasks to be rebuilt (with
caveats, see below).

In the absence of any interaction by the user, the unique hash for a
task is just that task's taskhash, which effectively maintains the
current behavior. However, if the user enables the "OEEquivHash"
signature generator, they can direct it to look at a hash equivalency
server (of which a reference implementation is provided). The sstate
code will provide the server with an output hash that it calculates, and
the server will record all tasks with the same output hash as
"equivalent" and report the same unique hash for them when requested.
When initializing tasks, bitbake can ask the server about the unique
hash for new tasks it has never seen before and potentially skip
rebuilding, or restore the task from an equivalent sstate file. To
facilitate restoring tasks from sstate, sstate objects are now named
based on the tasks unique hash instead of the taskhash (which, again has
no effect if the server is in use).

This patchset doesn't make any attempt to dynamically update task unique
hash after bitbake initializes the tasks, and as such there are some
cases where this isn't accelerating the build as much as it possibly
could. I think it will be possible to add support for this, but this
preliminary support needs to come first.

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

VERSION 4:

Based on discussion, the term "dependency ID" was dropped in favor of
"unique hash" (unihash).

The hash validation checks were updated to properly fallback to the old
function signatures (that don't pass the unihashes) for compatibility
with older implementations.

Joshua Watt (10):
  bitbake: fork: Add os.fork() wrappers
  bitbake: persist_data: Close databases across fork
  bitbake: tests/persist_data: Add tests
  bitbake: siggen: Split out task unique hash
  bitbake: runqueue: Track task unique hash
  bitbake: runqueue: Pass unique hash to task
  bitbake: runqueue: Pass unique hash to hash validate
  classes/sstate: Handle unihash in hash check
  bitbake: hashserv: Add hash equivalence reference server
  sstate: Implement hash equivalence sstate

 bitbake/bin/bitbake-hashserv         |  67 ++++++++++
 bitbake/bin/bitbake-selftest         |   3 +
 bitbake/bin/bitbake-worker           |   9 +-
 bitbake/lib/bb/fork.py               |  73 +++++++++++
 bitbake/lib/bb/persist_data.py       |  32 ++++-
 bitbake/lib/bb/runqueue.py           |  73 +++++++----
 bitbake/lib/bb/siggen.py             |   7 +-
 bitbake/lib/bb/tests/persist_data.py | 188 +++++++++++++++++++++++++++
 bitbake/lib/hashserv/__init__.py     | 152 ++++++++++++++++++++++
 bitbake/lib/hashserv/tests.py        | 141 ++++++++++++++++++++
 meta/classes/sstate.bbclass          | 102 +++++++++++++--
 meta/conf/bitbake.conf               |   4 +-
 meta/lib/oe/sstatesig.py             | 167 ++++++++++++++++++++++++
 13 files changed, 978 insertions(+), 40 deletions(-)
 create mode 100755 bitbake/bin/bitbake-hashserv
 create mode 100644 bitbake/lib/bb/fork.py
 create mode 100644 bitbake/lib/bb/tests/persist_data.py
 create mode 100644 bitbake/lib/hashserv/__init__.py
 create mode 100644 bitbake/lib/hashserv/tests.py

-- 
2.19.2


