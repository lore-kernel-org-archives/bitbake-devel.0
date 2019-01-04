Return-Path: <jpewhacker@gmail.com>
Received: from mail-it1-f193.google.com (mail-it1-f193.google.com
	[209.85.166.193])
	by mail.openembedded.org (Postfix) with ESMTP id BE8CA6BC88;
	Fri,  4 Jan 2019 16:20:25 +0000 (UTC)
Received: by mail-it1-f193.google.com with SMTP id b5so2153966iti.2;
	Fri, 04 Jan 2019 08:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=bdLypA6H3t8134KIJOUPxQgQe0Z+z81F2QB/ZB2ARTI=;
	b=VC1IDDRvH21q+P5Vgnv0Ln//DyaMxvQR0jzSZRcGZuKU5pZFvg1tvkuy0j6EbL57GZ
	OiXr1Mmm6P6XZ/V3Z3IC2w8KrE+NRyQJhqnWgDXVAVXbbZ6BBKRo33Uls8POUgrywy4a
	BbkujWVc4r4B5mLHP9vljDixccvEZmzJ1SS6PP89BKTW9VDurLuUw8NOwrCXtEyxmPaX
	4A55p/xWkxeBL9atcbebBhxav+YztXj//GfhTyRNNMVB1H82jUBh3JSkQMwXzPxCeO35
	5VUwdO+kIDlg4s+YDU2hRE7sbL2Ta4DawuG88jxGlybISksvr6lcgXUaPaNPfGOUPxWZ
	HBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=bdLypA6H3t8134KIJOUPxQgQe0Z+z81F2QB/ZB2ARTI=;
	b=fiPnD1tOMsvBHRSMDLF0cw/yUi33Eh5fw/Gp1tQ7IDJy9TaRU1P/bwIzbh1jFyS6M2
	V+iT0UXDdp6HhnxtatodpTJURzXBDk2G1a4iiNEa0GLSdXIZW4zkgogPG863cixFmw8Q
	ImuTifNmyPvhfJKdYkxVooiNZmmK0/oU/P1mz19hAAEGITbOWUNNdC1RhGCR8QdOwhkc
	hD63WjEitLNyPSSNNckamDIyTCMQIpI+6zf6MtHOAxvLurJRgct3BdPhoNKRtnyk5Ihk
	DinTBgBC2f7OHHp+vJMnhfg25P4uoXopledNVWXukgk7onxF0LW94bkPCstBovpnOIhU
	zxJQ==
X-Gm-Message-State: AA+aEWa0mKrmM7kYVqYsUfV2OS5xdQb8QOGHwj1UFmFUTNqbWd96JtOC
	eGxPu0NtzEsSXFnpmxWu+nzRh3ma
X-Google-Smtp-Source: AFSGD/VsEgtfveTnRA5lIAaN7LUOTd5FgKQC86RSyyof6IXUZLkthXvUCaKepVJdiytX2NCzV3iSoQ==
X-Received: by 2002:a02:4d99:: with SMTP id t25mr36375543jad.58.1546618826329; 
	Fri, 04 Jan 2019 08:20:26 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id j8sm736702itb.30.2019.01.04.08.20.25
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 04 Jan 2019 08:20:25 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Fri,  4 Jan 2019 10:20:12 -0600
Message-Id: <20190104162015.456-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104024217.3316-1-JPEWhacker@gmail.com>
References: <20190104024217.3316-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Subject: [OE-core][PATCH v7 0/3] Hash Equivalency Server
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
X-List-Received-Date: Fri, 04 Jan 2019 16:20:26 -0000
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

VERSION 7:

Updated sstate hash check function so that it is backward compatible
with older versions of bitbake (that don't pass unihashes)

Joshua Watt (3):
  classes/sstate: Handle unihash in hash check
  bitbake: hashserv: Add hash equivalence reference server
  sstate: Implement hash equivalence sstate

 bitbake/bin/bitbake-hashserv     |  67 +++++++++++++
 bitbake/bin/bitbake-selftest     |   2 +
 bitbake/lib/hashserv/__init__.py | 152 ++++++++++++++++++++++++++++
 bitbake/lib/hashserv/tests.py    | 141 ++++++++++++++++++++++++++
 meta/classes/sstate.bbclass      | 107 ++++++++++++++++++--
 meta/conf/bitbake.conf           |   4 +-
 meta/lib/oe/sstatesig.py         | 167 +++++++++++++++++++++++++++++++
 7 files changed, 630 insertions(+), 10 deletions(-)
 create mode 100755 bitbake/bin/bitbake-hashserv
 create mode 100644 bitbake/lib/hashserv/__init__.py
 create mode 100644 bitbake/lib/hashserv/tests.py

-- 
2.20.1


