Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web09.30745.1618227718554871119
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Apr 2021 04:41:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=PMATXZAm;
 spf=pass (domain: konsulko.com, ip: 209.85.221.43, mailfrom: pbarker@konsulko.com)
Received: by mail-wr1-f43.google.com with SMTP id h4so3551038wrt.12
        for <bitbake-devel@lists.openembedded.org>; Mon, 12 Apr 2021 04:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7ie+F35O3us4dRAToKHTE25ydHf6h0eVaOB9UpY6xkY=;
        b=PMATXZAmx8xB4+cUffGY3Z7nE7UQYLb+c6JhStWNA108xG8PXTdEcofK4nDs2W3QwB
         6jq3pSdG46TnAd7Ck/zPk/+hy22zRlbHGnoe3Yj0ecSfkpOTLp3C07NecE8fqoYa8fzl
         KlU1rCMg/V3JcjF613jZ7K9q3KNR20O/YQTsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7ie+F35O3us4dRAToKHTE25ydHf6h0eVaOB9UpY6xkY=;
        b=cUJ3DhXMyZzJqllhuK36j/fy/SxNUhYAQ4fGHlYRtBMK+R4v4Z6MX7VXjWrRss0AAQ
         ZIbOUtoTiOJKZCPjl1QiupM2sbM5SlPEy6VXN7rnw1R1O2ZEZnh8gcHlRtmhARf+l9O7
         fXLV7L1bOda9mU9zUmIo1ryK8fYH+gCBWr+ZWcb0mKpGfzWvt6AbvnookQP6LRdCd9xQ
         Q/gFkcaxiTEHPTjsj0nDkDO2gEbAhLntCje73jMKhv7PA9BwGCRL+MDOXs5FT0SfPx6A
         i6XS3UW5m5hX8sGaU+QFzQCGP/B9V3M8FSjG9BflXQ5FFgxE5mBUIAT4EykscRbuxA/P
         fwjQ==
X-Gm-Message-State: AOAM532/hjvu7jSUDgVCZN2VyFed/h8Eu9VCbBI3f/uNX2Di1QNshuq0
	GZCP0drfH8n71XnhoPTbJcwBpzaHrujyAg==
X-Google-Smtp-Source: ABdhPJzUzxTRoT5jopbR5D1A3AbiSjt0BPHevDPY35Jqf4lrC+a3viDP1HgOLD7ZDzYz0Nfq9nsoUw==
X-Received: by 2002:a5d:58fa:: with SMTP id f26mr5520553wrd.177.1618227716787;
        Mon, 12 Apr 2021 04:41:56 -0700 (PDT)
Return-Path: <pbarker@konsulko.com>
Received: from alpha.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id 3sm17931294wma.45.2021.04.12.04.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:41:56 -0700 (PDT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [RFC PATCH 00/11] Modernise prserv
Date: Mon, 12 Apr 2021 12:41:38 +0100
Message-Id: <20210412114149.4750-1-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The prserv module is converted from the old XML RPC mechinism to the more
modern json + asyncio RPC system used by hashserv. The common code now
shared between hashserv and prserv is moved to a new asyncrpc module. The
startup and shutdown code within prserv is also refactored and modernised,
using the Python multiprocessing module where possible.

These changes are not expected to land in the upcoming 3.3 release, they're
currently submitted as an RFC to get some early review.

The following change is needed in oe-core when testing these patches, this
can be submitted separately once these changes are past the RFC stage:

    diff --git a/meta/lib/oe/prservice.py b/meta/lib/oe/prservice.py
    index fcdbe66c19..15ce060ff6 100644
    --- a/meta/lib/oe/prservice.py
    +++ b/meta/lib/oe/prservice.py
    @@ -7,7 +7,7 @@ def prserv_make_conn(d, check = False):
        host_params = list([_f for _f in (d.getVar("PRSERV_HOST") or '').split(':') if _f])
        try:
            conn = None
    -        conn = prserv.serv.PRServerConnection(host_params[0], int(host_params[1]))
    +        conn = prserv.serv.connect(host_params[0], int(host_params[1]))
            if check:
                if not conn.ping():
                    raise Exception('service not available')

I'm also currently working on a follow-up patch which will add a read-only
mode to prserv.

Let me know if there are any other questions :)

Paul Barker (11):
  hashserv: Use generic ConnectionError
  asyncrpc: Common implementation of RPC using json & asyncio
  hashserv: Refactor to use asyncrpc
  prserv: Drop obsolete python version check
  asyncrpc: Add ping method
  prserv: Use multiprocessing to auto start prserver
  prserv: Extract daemonization from PRServer class
  prserv: Handle requests in main thread
  prserv: Drop unused methods
  prserv: Replace XML RPC with modern asyncrpc implementation
  prserv: Add connect function

 lib/bb/asyncrpc/__init__.py |  31 ++
 lib/bb/asyncrpc/client.py   | 150 ++++++++++
 lib/bb/asyncrpc/serv.py     | 223 +++++++++++++++
 lib/bb/siggen.py            |   6 +-
 lib/hashserv/client.py      | 147 ++--------
 lib/hashserv/server.py      | 210 ++------------
 lib/hashserv/tests.py       |   3 +-
 lib/prserv/serv.py          | 550 ++++++++++++++----------------------
 8 files changed, 663 insertions(+), 657 deletions(-)
 create mode 100644 lib/bb/asyncrpc/__init__.py
 create mode 100644 lib/bb/asyncrpc/client.py
 create mode 100644 lib/bb/asyncrpc/serv.py

-- 
2.26.2

