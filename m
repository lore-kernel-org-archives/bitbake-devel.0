Return-Path: <jpewhacker@gmail.com>
Received: from mail-it1-f172.google.com (mail-it1-f172.google.com
	[209.85.166.172])
	by mail.openembedded.org (Postfix) with ESMTP id 5DF217BDA6;
	Wed, 19 Dec 2018 03:10:37 +0000 (UTC)
Received: by mail-it1-f172.google.com with SMTP id m8so9838723itk.0;
	Tue, 18 Dec 2018 19:10:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=biIFaBAKa4O/sqAJrJ0C/SpTBpke68D4PDdXNKPePrs=;
	b=QW2PJJrJF/ylgqpRC5myDIVgqBFPPVg4ARrrz6WLTcbp6B1bPZYJp6FYwBCrtaxRo1
	yE5sv4fothOGV2XUWdaS1YUcr6aWlVXh0cfZMtQD01f8xrPBXkeQrETscuF3IioHxBi0
	u2uw/c0+Dt5kk6tVJrGUXhxTaJxVln7b+BIOYBZrEVujb0LvSHXcwzXAVAORwEyIY5XU
	Hz8+3M3zsxteiDCVpkBgUZoAD5JRXQfkzEfyQ7NuA7PfG/DI35qxa6tcIdGQ1SJuvf6c
	0apf9mnImOV1hyhuea8+bPbS07Oj9KFqfGbt/8kf0cwhYCFSMJCRH9jJq49jA2ZeLNFa
	HwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=biIFaBAKa4O/sqAJrJ0C/SpTBpke68D4PDdXNKPePrs=;
	b=R5M+A1INEriomhQWdOvKZfcL2KqQDtzW2D6B4xLm3ew9kNGfrcemvnLFvG4DpusUIN
	iAAeQ5RQ3vc+Nag/UGvprft/rOrdS3PLJ/iZnxvWsn/LlST1U+2SjyoKR9OOWhraGWg8
	pAu4Vt1MbdE+zm+p6q8OQKpkqh4DYtggdNWwfTaLtxa/kc+xO+VOgVL8p+dk8Qu5qsTi
	91Ydp+V0MRAUN/LNX3u1TJXxs2OXznVHaHjfOHUTagV+526UWK9w8t0XbUhwywuW14NK
	w+2t0WdFtJZCOuU0WxtXZJZbQbsW1SZj/6FOVH8guYuH4k2xIgA52sEqpSZ4xKbnC06Z
	B/ug==
X-Gm-Message-State: AA+aEWYEdVeEILzbyALByxBWim6EqGgN9pYrpxRRTll64ROaqKtJKWsp
	sjilHWzxyWusMPNi3Wy51b81RRBv
X-Google-Smtp-Source: AFSGD/UUrdUyvbmMWH/LUp96lo16Q1IuwoUgqt0Vzj4eiSRzRFoBPiFuC/b7QxqEmyyk/rDFEqNERg==
X-Received: by 2002:a24:d081:: with SMTP id m123mr5166090itg.119.1545189037987;
	Tue, 18 Dec 2018 19:10:37 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id r63sm2795992ita.2.2018.12.18.19.10.37
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 18 Dec 2018 19:10:37 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Tue, 18 Dec 2018 21:10:25 -0600
Message-Id: <20181219031033.28045-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218153101.9212-1-JPEWhacker@gmail.com>
References: <20181218153101.9212-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Subject: [OE-core][PATCH v5 0/8] Hash Equivalency Server
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
X-List-Received-Date: Wed, 19 Dec 2018 03:10:37 -0000
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

VERSION 5:

Removed os.fork() handlers for persist_data. They can be added back if
actually necessary.

Reworked hash validation slightly based on feedback.

Joshua Watt (8):
  bitbake: tests/persist_data: Add tests
  bitbake: siggen: Split out task unique hash
  bitbake: runqueue: Track task unique hash
  bitbake: runqueue: Pass unique hash to task
  bitbake: runqueue: Pass unique hash to hash validate
  classes/sstate: Handle unihash in hash check
  bitbake: hashserv: Add hash equivalence reference server
  sstate: Implement hash equivalence sstate

 bitbake/bin/bitbake-hashserv         |  67 +++++++++++
 bitbake/bin/bitbake-selftest         |   3 +
 bitbake/bin/bitbake-worker           |   7 +-
 bitbake/lib/bb/runqueue.py           |  76 ++++++++----
 bitbake/lib/bb/siggen.py             |   7 +-
 bitbake/lib/bb/tests/persist_data.py | 142 +++++++++++++++++++++++
 bitbake/lib/hashserv/__init__.py     | 152 ++++++++++++++++++++++++
 bitbake/lib/hashserv/tests.py        | 141 ++++++++++++++++++++++
 meta/classes/sstate.bbclass          | 102 ++++++++++++++--
 meta/conf/bitbake.conf               |   4 +-
 meta/lib/oe/sstatesig.py             | 167 +++++++++++++++++++++++++++
 11 files changed, 830 insertions(+), 38 deletions(-)
 create mode 100755 bitbake/bin/bitbake-hashserv
 create mode 100644 bitbake/lib/bb/tests/persist_data.py
 create mode 100644 bitbake/lib/hashserv/__init__.py
 create mode 100644 bitbake/lib/hashserv/tests.py

-- 
2.19.2


