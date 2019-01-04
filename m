Return-Path: <jpewhacker@gmail.com>
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com
	[209.85.166.46])
	by mail.openembedded.org (Postfix) with ESMTP id 7E2D47BB93;
	Fri,  4 Jan 2019 02:42:36 +0000 (UTC)
Received: by mail-io1-f46.google.com with SMTP id b23so7653050ios.10;
	Thu, 03 Jan 2019 18:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=ljtx72h6VZLkfMxLo+gE07m5bew/ZjmqseMUZplrQME=;
	b=Wo3zJlWmP1FvO5hMAYNLR7+1aQLV63Gmh6kOvyuApKDVVh8QQOftRzlOyWy+sjHfHY
	GZkmLulALZBuhOXEkGiAxNoKJzW+n/4BMu8MXEnAM1MjM+0djxKbLhAmCvVMdqKNd2TA
	X9RkPZV/muYRAUd3f1gxFp434kn9dTipaBjudhyOyV1qAoPSa6wRPer4YdKx08YzSO14
	25oZGKf25CKJHiwMY44ICrFhIqrPe/GdKXCgQgP6y0jZEwPwtc1p09FOjs6iZp8bHshM
	xcC4OtJrnBWL6k6Qa6Kqqzxuw3mll5xuOGyOiZNZiKRLvdVv7ZxCPSd0PMD3HkgUV6eI
	lnqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=ljtx72h6VZLkfMxLo+gE07m5bew/ZjmqseMUZplrQME=;
	b=Y/J7cvK+rBhy637LL6p1jZbhlPHpbk8ulSMImmvN/A4n4Y0R+1xNlIgnhO9IMpzqUv
	mAfMgBLyUaOEKrH5279BQb3W7ApXxbcneQ3PWKB+CZN4NmHLWhurx8NAoGdmjXPgFHrs
	5iC9esLuKEWR5V5XlxO6WsOC3z52aBHCdM24q6AtD6lzkphfTkFaSr4927Ff5OAzXlsO
	cBLMy4TRgtcJYWh3Aiurn58WjYRG3Rf/GWujXXkbPh1thEjhro5Lt4jXutcvh6ypM0of
	J5qVdFV41U5nB5hqRMlk7IKuZoUF9rDHwlUOtUbcGEKICaybrKjghbWmtRnwGr735CVL
	QNFA==
X-Gm-Message-State: AJcUukcpkr2YArcrHTWYxpxft1f4tW7kE4bZCK+cm1KVDAyyBUwZflso
	cGgwdw2Fl2MpZyPn/lm+mEuSIjqc
X-Google-Smtp-Source: ALg8bN4DhhsumUgGiM176s7wGSKwkVmJa73wwJtaBqmOn9Tym5Kt21SXr/TBkxqQ8BRehK8KquIxSQ==
X-Received: by 2002:a6b:d20f:: with SMTP id q15mr37029403iob.100.1546569757169;
	Thu, 03 Jan 2019 18:42:37 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id h2sm21864980itk.0.2019.01.03.18.42.36
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 03 Jan 2019 18:42:36 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Thu,  3 Jan 2019 20:42:14 -0600
Message-Id: <20190104024217.3316-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181218153101.9212-1-JPEWhacker@gmail.com>
References: <20181218153101.9212-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Subject: [OE-core][PATCH v6 0/3] Hash Equivalency Server
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
X-List-Received-Date: Fri, 04 Jan 2019 02:42:36 -0000
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

VERSION 6:

Fixed a bug that was introduced with the rename to unihash that prevent
unihashes from being recorded in persist_data.

Joshua Watt (3):
  classes/sstate: Handle unihash in hash check
  bitbake: hashserv: Add hash equivalence reference server
  sstate: Implement hash equivalence sstate

 bitbake/bin/bitbake-hashserv     |  67 +++++++++++++
 bitbake/bin/bitbake-selftest     |   2 +
 bitbake/lib/hashserv/__init__.py | 152 ++++++++++++++++++++++++++++
 bitbake/lib/hashserv/tests.py    | 141 ++++++++++++++++++++++++++
 meta/classes/sstate.bbclass      | 102 +++++++++++++++++--
 meta/conf/bitbake.conf           |   4 +-
 meta/lib/oe/sstatesig.py         | 167 +++++++++++++++++++++++++++++++
 7 files changed, 625 insertions(+), 10 deletions(-)
 create mode 100755 bitbake/bin/bitbake-hashserv
 create mode 100644 bitbake/lib/hashserv/__init__.py
 create mode 100644 bitbake/lib/hashserv/tests.py

-- 
2.20.1


