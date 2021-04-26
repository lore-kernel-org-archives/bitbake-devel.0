Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web12.4060.1619425006146630740
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 26 Apr 2021 01:16:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Sq4G5UPS;
 spf=pass (domain: konsulko.com, ip: 209.85.128.43, mailfrom: pbarker@konsulko.com)
Received: by mail-wm1-f43.google.com with SMTP id l189-20020a1cbbc60000b0290140319ad207so2247938wmf.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 26 Apr 2021 01:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8PXAGyvVdn8wjPzZi3xflav1selr8igX0jcNnmiGVu8=;
        b=Sq4G5UPS3KhECv3aEI/N73SO9TB6jTS27C7CRJrnIvynjjenfA1ID93vOkTfVGi7f0
         2NTurUodAE6RdJ5ZpixZ2h6x+yP6EsuUYxAPuNJ4HgukXS6zMAq78ScqLWwk4ugtWI9d
         Zi3v9qHFy16I76sT06vhGw2fzWOkLBM8pftJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8PXAGyvVdn8wjPzZi3xflav1selr8igX0jcNnmiGVu8=;
        b=Q0kKR3ZwXs68QgzvikfPxi7UvER7cXihyYGSsgKyG1rMtc6pa0Za5A7T+eHRb9u0FT
         2MwoJ1wU6VrqVI3j5uiHl6g8dEUV+mWNmTLVUA53Yj9GTYmD4Gtxd2Mx5lCHf35owAjL
         XsL7g1HJr5uXSw1IQikrUKlb19jdNvziONno0aN8+jncIdN3IOaC1kYqToqp/fcnij0J
         ytj/A1TvlHq847Y1mqjtC5Y268y5V0AqAw/hgS07GySggrFPoi23YNBh0jzBt66c0FwW
         enhzzUEgJg7rHhyt96iIcMvHjnV/bINhbkQxLelOGMu5mPk2Twn4vFNKxvi0L8E1THDI
         C17w==
X-Gm-Message-State: AOAM532i4PZy74FPMEQZkh32H5WwFPkzgjuOqCYxXNAbURrveAID6a8G
	PeSsgHe3RjQNfOv19LNWNJQBPkRNTm3E7Q==
X-Google-Smtp-Source: ABdhPJw+hhXYycSkUavYZI0jNDxZahWdc3q5DlOZuPsbXDaQq8FjtaJ7IPiQm4MXm/y6kbugTamsMg==
X-Received: by 2002:a05:600c:3548:: with SMTP id i8mr20072240wmq.110.1619425003991;
        Mon, 26 Apr 2021 01:16:43 -0700 (PDT)
Return-Path: <pbarker@konsulko.com>
Received: from alpha.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id a9sm4631320wrw.26.2021.04.26.01.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 01:16:43 -0700 (PDT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [PATCH 0/6] Preparation for prserv upgrade to json-based asyncrpc
Date: Mon, 26 Apr 2021 09:16:27 +0100
Message-Id: <20210426081633.5020-1-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches put the groundwork in place for the planned upgrades of the
prservice (which will include moving to the new json-based asyncrpc system
used by hashserv and using the Python multiprocessing module where possible
in the service startup/shutdown code).

The common code which will be shared by both hashserv and prserv is moved to
a new asyncrpc module.

Obsolete and unused code in prserv is dropped.

A new connect() method is added to the prserv module to abstract away the
details of how the connection is started. This can then be used by the
prservice module in oe-core.  As this patch series doesn't yet remove the
PRServerConnection class the change in oe-core doesn't have to be made
immediately. I'll submit the required patch for oe-core after this series is
merged to bitbake.

These changes have been tested by running a few local builds with and without
hashserv enabled, running the full bitbake-selftest and oe-selftest suites.
A couple of failures were seen in oe-selftest but these are related to my
host system configuration (socat not installed, firewall blocking ports, etc)
so I'm fairly confident they aren't caused by this patch series.

Paul Barker (6):
  hashserv: Use generic ConnectionError
  asyncrpc: Common implementation of RPC using json & asyncio
  hashserv: Refactor to use asyncrpc
  prserv: Drop obsolete python version check
  prserv: Drop unused dump_db method
  prserv: Add connect function

 lib/bb/asyncrpc/__init__.py |  31 +++++
 lib/bb/asyncrpc/client.py   | 145 ++++++++++++++++++++++++
 lib/bb/asyncrpc/serv.py     | 218 ++++++++++++++++++++++++++++++++++++
 lib/bb/siggen.py            |   6 +-
 lib/hashserv/client.py      | 147 ++++--------------------
 lib/hashserv/server.py      | 210 +++++-----------------------------
 lib/hashserv/tests.py       |   3 +-
 lib/prserv/serv.py          |  31 +----
 8 files changed, 445 insertions(+), 346 deletions(-)
 create mode 100644 lib/bb/asyncrpc/__init__.py
 create mode 100644 lib/bb/asyncrpc/client.py
 create mode 100644 lib/bb/asyncrpc/serv.py

-- 
2.26.2

