Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.32767.1612180415994815587
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Feb 2021 03:53:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=LCfvSALQ;
 spf=pass (domain: konsulko.com, ip: 209.85.128.54, mailfrom: pbarker@konsulko.com)
Received: by mail-wm1-f54.google.com with SMTP id o5so2745891wmq.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Feb 2021 03:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XY6ndNHZmY1KJ9CN/gECLwUnzFCdlMN7jzMFC0c5hFg=;
        b=LCfvSALQTnpQDuasUhW+1f38fFK56YTETblX4QVaX7kWCuft7z/J4xAP1CcPXgkT+c
         /xwGh64mtoq0GWX5gIB1zuUHWvPjKMMlsEjOSrnYBzdSyfHKva5vIxZP9/17ys3AGS+A
         xbsHNslUdvLtk2CqzG6SX9Wt+LTP2W5TQNDrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XY6ndNHZmY1KJ9CN/gECLwUnzFCdlMN7jzMFC0c5hFg=;
        b=M8uSMNQSVxX3FkoKWsUcexaOccdN4Jo57yNze3dLa+Iygah60oTjeyLmotGnaTrGLM
         G1scIOhhhoeg+nhtZdtScqkkYIinJaLIvVeS02kPkcebleVk+hxq+q5+6F/A9aU7tCx2
         VUg99c9H2b36dMdFP3yIaR4xC/GxcKrTASiUSDoJGemdOv1XO3PAhmdEhOqyVfVe8xs2
         Gg6FTE7EC2TBB+CzTs6gLffIIGAZZbULLOAg7t5EYC9tpkidWPp7Fox02722R+7pUl4T
         DT2/iBIntLqJBz+b7tWAPaWSOoMqpLzamej0W3yXjHGsMIrxLqYHq/rpCr4UCm3pgZ8/
         pogQ==
X-Gm-Message-State: AOAM5339pUDIi+SJYZJ90dXyhdYzrUCrTWEENASzTxbuJM+t6mpOoVca
	IrkVKuJNnih80EAJJPtJ/YwuaOZRKAyV4rUm
X-Google-Smtp-Source: ABdhPJxYTWb3eaE79iFDk8vI6YEnJYGo1XLOUeAD9Cm7DBMW4xJ3+KuzaVseprlzCpG6g+wxIeYY8Q==
X-Received: by 2002:a1c:32c4:: with SMTP id y187mr3518076wmy.120.1612180414097;
        Mon, 01 Feb 2021 03:53:34 -0800 (PST)
Return-Path: <pbarker@konsulko.com>
Received: from tortoise.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id u6sm28120514wro.75.2021.02.01.03.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 03:53:33 -0800 (PST)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [RFC PATCH 0/8] hashserv read-only mode & upstream fixes
Date: Mon,  1 Feb 2021 11:53:23 +0000
Message-Id: <20210201115331.13510-1-pbarker@konsulko.com>
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

This is an RFC series as it still needs documentation to be written and
selftest cases to be added. However it'd be great to get some feedback at
this stage before moving on to that work.

These changes can also be pulled from:

  https://gitlab.com/pbarker.dev/staging/bitbake.git
  tag: hashserv_2020-02-01

Let me know if you have any questions/feedback :)

Paul Barker (8):
  bitbake-hashclient: Remove obsolete call to client.connect
  hashserv: client: Fix handling of null responses
  hashserv: server: Fix logger.debug calls
  hashserv: Support read-only server
  hashserv: Support upstream command line argument
  hashserv: Add short forms of remaining command line arguments
  hashserv: Add get-outhash message
  hashserv: server: Support searching upstream for outhash

 bin/bitbake-hashclient   |  3 --
 bin/bitbake-hashserv     | 10 +++--
 lib/hashserv/__init__.py |  4 +-
 lib/hashserv/client.py   |  8 +++-
 lib/hashserv/server.py   | 85 ++++++++++++++++++++++++++++++++++------
 5 files changed, 88 insertions(+), 22 deletions(-)

-- 
2.26.2

