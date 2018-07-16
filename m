Return-Path: <jpewhacker@gmail.com>
Received: from mail-it0-f45.google.com (mail-it0-f45.google.com
	[209.85.214.45])
	by mail.openembedded.org (Postfix) with ESMTP id 1DF917600F;
	Mon, 16 Jul 2018 20:38:03 +0000 (UTC)
Received: by mail-it0-f45.google.com with SMTP id 198-v6so15202125ite.4;
	Mon, 16 Jul 2018 13:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=KBhsoImbASZLBaswHjmZKKX2WhOvraxThU+uHCJajYU=;
	b=BmTpkA6kGZHsJ0jyLn3ZN5YOTduUR9hsXa+fesJ6EIW8I8dI7OGi/hEYMRMizmGe/A
	tKCSFt7xxR1HpoHwsc1H6GfBu8aZRTQ98mrx4OcS+SNT//7fXOFL+udnqFkGpYjQ7KTT
	lrmrWu9MilDLdwNUXU4uthcG4rdNj2O7mMvfiHSAh0yadZrI8FjBUtOXiJewgC6g8j4+
	gg7TO4hHA+NVoGtmiZgcW2k8tqlINY8Dgl8WBd8XkrkGw6IeFIfB34B7rLfB5XV1mYEC
	iJpgZkvcD27/kvFY+gBhL0xdhP7fqd77PmE4HQ0eYNwMIyvOSYjy3FE8xe4PqkVw4oIe
	dVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=KBhsoImbASZLBaswHjmZKKX2WhOvraxThU+uHCJajYU=;
	b=Cn3SJgu6Wrlnipz3szYgDJtAguX6ZYSxNKxAgJv0nO9fCs5nDaPyAK8APqTCEV3d/j
	NM9HxX63H8+mNrCRz/bYoEJDgEkK7N9t5Ybhas8Bgo8Eln0Uc9zcJ8RiIkQgUDIHjUAG
	OgXclcVguWF7T3YRnoRHPoFnWurx0k7wgjMxcH2X/1+8HeWTQ+UY33A370XTKzBIcM2A
	AKYd1Dat758zE5h8IEyEcsG65B4Qn6oFLChIMfTqZ1iM62JwGXrgP+C1nY2XOasq3RHs
	NMhzQk04g4DLbUgqlNK0PcZxPQwOqvigwtA5fF5JcRa0TGTqk99MHn22qWwARMl9pqpf
	iU7w==
X-Gm-Message-State: AOUpUlE5saS8iG2MPXXpda51b6O85p6c8jWXu1+Ii22FlSdNYAyDGR10
	8v/vAxJQPWCCcyv43mLbxc2szOuH
X-Google-Smtp-Source: AAOMgpfwB5OZCULC7gjhSHbGbx07CWFEpB06KFp4eejQ+XkFouoNpGB2ksyEYWKFgSxObbzxsL5Y6Q==
X-Received: by 2002:a24:2745:: with SMTP id
	g66-v6mr13846576ita.77.1531773484780; 
	Mon, 16 Jul 2018 13:38:04 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	r199-v6sm8988222itb.8.2018.07.16.13.38.04
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 16 Jul 2018 13:38:04 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Date: Mon, 16 Jul 2018 15:37:19 -0500
Message-Id: <20180716203728.23078-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
Subject: [RFC 0/9] Hash Equivalency Server
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
X-List-Received-Date: Mon, 16 Jul 2018 20:38:04 -0000

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

Joshua Watt (9):
  bitbake-worker: Pass taskhash as runtask parameter
  siggen: Split out stampfile hash fetch
  siggen: Split out task depend ID
  runqueue: Track task dependency ID
  runqueue: Pass dependency ID to task
  runqueue: Pass dependency ID to hash validate
  classes/sstate: Handle depid in hash check
  hashserver: Add initial reference server
  sstate: Implement hash equivalence sstate

 bitbake/bin/bitbake-worker            |   9 +-
 bitbake/contrib/hashserver/.gitignore |   2 +
 bitbake/contrib/hashserver/Pipfile    |  15 ++
 bitbake/contrib/hashserver/app.py     | 212 ++++++++++++++++++++++++++
 bitbake/lib/bb/runqueue.py            |  56 ++++---
 bitbake/lib/bb/siggen.py              |  20 ++-
 meta/classes/sstate.bbclass           | 102 +++++++++++--
 meta/conf/bitbake.conf                |   4 +-
 meta/lib/oe/sstatesig.py              | 166 ++++++++++++++++++++
 9 files changed, 544 insertions(+), 42 deletions(-)
 create mode 100644 bitbake/contrib/hashserver/.gitignore
 create mode 100644 bitbake/contrib/hashserver/Pipfile
 create mode 100755 bitbake/contrib/hashserver/app.py

--
2.17.1


