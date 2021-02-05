Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web11.6847.1612524377292209802
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Feb 2021 03:26:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=s67OVYBg;
 spf=pass (domain: konsulko.com, ip: 209.85.221.43, mailfrom: pbarker@konsulko.com)
Received: by mail-wr1-f43.google.com with SMTP id g10so7321231wrx.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 05 Feb 2021 03:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qXcsdgC/N/mumSWL6wP/kQvR3/mdr4rOrHKs90qyl48=;
        b=s67OVYBgddLC8PHSwFw/rEpB0bs8D2K9yE2zhfod2ygG5o9Aal41C3y/BoozpLkj0C
         ip6BOAuOAMhi6IsDrjbqgisjqwf/gZRopP0yHX647xy1/tJ9efvWJL+HzZ9BnaOB5S9e
         ONn9s6YEmKUk2yOUTxGGNm3ULBfyZkXtv4z8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qXcsdgC/N/mumSWL6wP/kQvR3/mdr4rOrHKs90qyl48=;
        b=btNKP5Fv5OfpFfTwBHBo/yEKBLcu2sYULBOFctH56V/t4dCILZ5TqMeax+AyaUiSyE
         vXh6g/L36e1oIlgnML+MR0GH/7BivVOmotV/M/eLFyxkDoHi7m0x6fDVEB2wi0kefwoq
         34PGCrn49i+IUPOSWjru5lZVYgs2QMdVwbM0Wu2Zo+yA77Ysi71Iv+AVYKYX2R9IqeHv
         SOloLF5QkqL1wSnXsUb/X+239qqv7dfqceXcyVrb60wb0UAnbCLk2x6KfniRY7561NDf
         alhc+ARBQTPaTf8DQWZdeHZ8VC3H1cGUrV1SgphAV7gYQdWgXHhksUmFpXh6ppxMYrW5
         BGZQ==
X-Gm-Message-State: AOAM531IE3KImoan3naMx/yLJYG/kAMa/xVe4gJsmj1QvzUorlf6j12n
	VGn7s11GnG6e50NoQ/pOMPAt1o/0m6PYZvh0
X-Google-Smtp-Source: ABdhPJwN9ON8wrgP9GamGtf9NtoaRFtkS7wY1hhLN7VEW3eTRWLi77OWaSjkVMad7r0rSzA0fF1FHA==
X-Received: by 2002:adf:df84:: with SMTP id z4mr4424055wrl.339.1612524375459;
        Fri, 05 Feb 2021 03:26:15 -0800 (PST)
Return-Path: <pbarker@konsulko.com>
Received: from tortoise.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id y18sm11881716wrt.19.2021.02.05.03.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 03:26:14 -0800 (PST)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [PATCH v2 0/8] hashserv read-only mode & upstream fixes
Date: Fri,  5 Feb 2021 11:26:03 +0000
Message-Id: <20210205112611.17167-1-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

* Implement a read-only mode for the hash equivalence server. This mode is
  useful when you wish to populate a hash equivalence database from CI or other
  internal builds (via a read-write server instance) and also allow external
  clients to query this database (via a read-only server instance). External
  clients can therefore be prevented from adding hash equivalences to the
  server which correspond to sstate artifacts which would be missing in a
  primary sstate cache. This mode is enabled using the -r/--read-only
  argument to bitbake-hashserv.

* Expose the existing upstream server support via a -u/--upstream argument to
  bitbake-hashserv.

* Support querying an upstream server using the new `get-outhash` message when
  the server handles a `report` message from a client and a match is not found
  in the server's own database. This is important as the `report` message is
  used by bitbake when a task finishes executing to check if the task outhash
  matches the outhash for any previous execution. With this support such
  matches can now be found in a local (read-write) hash equivalence db as
  well as in an upstream (potentially read-only and/or remote) db.

* Other minor hashserv fixes.

These changes have been tested locally using the following setup:

1) Build core-image-base with BB_HASHSERVE = "auto". Additional logging was
   also enabled following the instructions in 
   https://docs.yoctoproject.org/bitbake/bitbake-user-manual/bitbake-user-manual-execution.html#logging.

2) Move the hashserv.db file into a new 'upstream-hashserv' directory. Start
   the upstream server in read-only mode using the following command in that
   directory:

    bitbake-hashserv -r -l DEBUG

3) Create an empty 'downstream-hashserv' directory. Start the downstream
   (local) server with an empty db using the following command in that
   directory:

    bitbake-hashserv -u "unix://../upstream-hashserv/hashserve.sock" -l DEBUG

4) Modify local.conf to set 
   BB_HASHSERVE = "unix://${TOPDIR}/downstream-hashserv/hashserve.sock".

5) Add an 'echo hello' command to do_configure for glibc to force a rebuild
   which should result in a matching hash equivalence.

6) Build core-image-base again, confirm that glibc is rebuilt but then a hash
   equivalence is found (copied from the upstream server into the downstream
   server) and dependent tasks are pulled from the sstate cache instead of
   being rebuilt.

Changes from RFC series:

  * Fixed issues identified by JPEW.

  * Added selftest cases.

These changes can also be pulled from:

  https://gitlab.com/pbarker.dev/staging/bitbake.git
  tag: hashserv_v2_2021-02-05

Paul Barker (8):
  bitbake-hashclient: Remove obsolete call to client.connect
  hashserv: client: Fix handling of null responses
  hashserv: server: Fix logger.debug calls
  hashserv: Support read-only server
  hashserv: Support upstream command line argument
  hashserv: Add short forms of remaining command line arguments
  hashserv: Add get-outhash message
  hashserv: server: Support searching upstream for outhash

 bin/bitbake-hashclient   |   3 --
 bin/bitbake-hashserv     |  10 ++--
 lib/hashserv/__init__.py |   4 +-
 lib/hashserv/client.py   |   8 ++-
 lib/hashserv/server.py   | 103 +++++++++++++++++++++++++++++----------
 lib/hashserv/tests.py    |  45 ++++++++++++++++-
 6 files changed, 134 insertions(+), 39 deletions(-)

-- 
2.26.2

