Return-Path: <akuster808@gmail.com>
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
	[209.85.214.173])
	by mail.openembedded.org (Postfix) with ESMTP id C51247F978
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  4 Jan 2020 02:23:13 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id p9so19661166plk.9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 03 Jan 2020 18:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=POtfboDHqIN7hhObkoHZaYCkUfl3fGXmLddHnyRSBDo=;
	b=P3n7PRrCF/96JQ/Dj/LEE7ulcYdzdcCDDLWg0qb5xx2Pwk/D3IXfKNazBC94nWue84
	5hHrGn0uIU1xjXmpKFtiWVY3xJBGlR44QQ9UjuW8zvc+WTz3XmgExZs8Pphe2FUEzRbS
	a8+qMMWUFuAmk9lZgzFhcPKW203pJC9ECcLJBtH6E5hXnULQjyq5Detv+Y1IjIeKRlKk
	rtiztI6OdbZyeglZlYLfYYqTjp01rP29LT5dkVUaDAA55wb11GCfmOVpD4l5g7eA7oPb
	iwHthcBQJKoGNMjmvxCTncNCwnWhIloY31JiCYfIhHpCxKSDdK+6CN6Iz5cBtAuu0Muz
	9zYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=POtfboDHqIN7hhObkoHZaYCkUfl3fGXmLddHnyRSBDo=;
	b=Cu7D4QGTo27WsUYAN/QBFU99/ZxqwC4kW+gnlmXrBNZow8A8YAJ+atcy0sAdqLk7Fm
	WTHgbR31lwD1ZW2pY4KT2tgn1LSN4vNsYTTXm3NgyGsYWt6heAnvyVHb9dWxQ+dzyUdm
	MFkFro0XsqmOfvMxm7KhmE4f19O4gTw57vWSzsNmXSiOlKz2BH6bdS2WJTFNsA5KHd+e
	A1NzbKfyz0CjV5Oc+SFhR/UYfjy1msy61d3WamvuM75rk/gnuS9UmY3pcbOrG9CNvSaD
	pTXPphJSmxkaVUEuwNYMCQ3aatrRh4RhxiPSeaTBGh7WMdUKS5kVO3nJTgYKFzXdIcul
	8Ysw==
X-Gm-Message-State: APjAAAWzY5OS+pjrGmU8MNLtwmNxsD8rhrqmWwn/s4IoEnR+qQ1P56Nz
	vToxCjvAmpuUHVHaDY5+oGcrgrKPkBg=
X-Google-Smtp-Source: APXvYqz2MulXk63DI5UfKR9bvrd5MJgKwUn1R4TF+2nSJYhN1SIQMLtxlVMYGuYHcP8EnbrWHd9iFw==
X-Received: by 2002:a17:902:b18e:: with SMTP id
	s14mr97750329plr.261.1578104594771; 
	Fri, 03 Jan 2020 18:23:14 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:e812:6764:3882:fa62])
	by smtp.gmail.com with ESMTPSA id
	s11sm58830590pfd.157.2020.01.03.18.23.13
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 03 Jan 2020 18:23:14 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  3 Jan 2020 18:22:45 -0800
Message-Id: <cover.1578104305.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Subject: [PATCH 00/25] 1.44 Patch review
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
X-List-Received-Date: Sat, 04 Jan 2020 02:23:15 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is a consolidate set which includes last weeks series. 

Passes on AB. Please have comment back by Monday.

The following changes since commit cfa307aabf710d79c404a8571b4158b864a94727:

  runqueue.py: not show warning for deferred multiconfig task (2019-11-29 11:26:07 +0000)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.44-nut
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.44-nut

Aníbal Limón (1):
  lib/bb: Add BB_SIGNATURE_LOCAL_DIRS_EXCLUDE to speed-up taskhash on
    directories

Chris Laplante via bitbake-devel (1):
  bb.utils.fileslocked: don't leak files if yield throws

Joshua Watt (1):
  runqueue: Batch scenequeue updates

Ola x Nilsson (1):
  prserv/serv: Use with while reading pidfile

Richard Purdie (21):
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
  runqueue: Fix equiv hash handling build failures
  runqueue: Ensure task dependencies are run correctly
  runqueue: Fix task dependency corner case in sanity test
  siggen: Test extra cross/native hashserv method
  cache: Lower debug level for wold build messages

 lib/bb/__init__.py        |   5 ++
 lib/bb/build.py           |  25 +++----
 lib/bb/cache.py           |   6 +-
 lib/bb/checksum.py        |   5 +-
 lib/bb/fetch2/__init__.py |   4 +-
 lib/bb/runqueue.py        | 137 +++++++++++++++++++++++---------------
 lib/bb/siggen.py          | 104 +++++++++++++++++++++++------
 lib/bb/ui/knotty.py       |  12 ++--
 lib/bb/ui/uihelper.py     |  39 ++++++-----
 lib/bb/utils.py           |   9 +--
 lib/hashserv/client.py    |   8 +++
 lib/hashserv/server.py    |  36 ++++++++++
 lib/prserv/serv.py        |  12 ++--
 13 files changed, 277 insertions(+), 125 deletions(-)

-- 
2.17.1


