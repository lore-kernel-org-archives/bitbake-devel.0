Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web10.6926.1624853643193350924
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 27 Jun 2021 21:14:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=E03RuXvx;
 spf=pass (domain: konsulko.com, ip: 209.85.221.43, mailfrom: pbarker@konsulko.com)
Received: by mail-wr1-f43.google.com with SMTP id p8so3265058wrr.1
        for <bitbake-devel@lists.openembedded.org>; Sun, 27 Jun 2021 21:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ddix05IC6iti5Xu+3jDNLmCvbpsBVyXMtY2nn9JySTA=;
        b=E03RuXvx1hy1KqyKKQR2ZH7qKQqb6FodGhsYKJMyFyt2LOTf88Z8JnTIRsq0W64WkI
         FS2i64YcygI480iRvPSRJMaUFj7hDyN1fnEwGhUFf2HXuPHIErS5TINrJjOX8WbR6Byy
         nGQ+9QPmB/htb2/nT79Wz7gk0V9VD76DSKmRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ddix05IC6iti5Xu+3jDNLmCvbpsBVyXMtY2nn9JySTA=;
        b=nW4y1vEqwOVSCiCKergdgdERpaAZ/KnJPlA42VjqmSI/zzRy0/qCq2JdlFfuLEptxm
         1Rf7sqmoker3y6PkxLpw7HLJO8folv3KlWGldh6pPph+mMPOXOBr2zz/JQwPedm+J1jY
         2DZ/yI/NGP/3b19FwkS6V9jkjSsBVCxT0sr/QMEga7PYgmjVpUTXYxhhxv0bmr5o1dDi
         NECuLd/VDg/RHqF50/1E4buLOdFydvuywv7qdv7K9eqjAPsPdtdq77gkRiHqNH4zzu1k
         YQ469k9T6CnS0U/A6zLFQEIdzFLV71Idc8fvFia5k2v38upKWjQCC18k6cCDMNFsmGcn
         labw==
X-Gm-Message-State: AOAM532piv1pzAD31Kxyp6xc8u4/SNvbs8GoUfYJS0OJhz6PjJSQ5Fm0
	Lw7QXIkX7RWgbsXaeepi9l9kp5E54XCQxA==
X-Google-Smtp-Source: ABdhPJwjK/BPSmjBVE1Ib+IWqR443ltzZ6MkpRbhnjW5gMsf/W+QSeBJf8uEpJH18Z6cGCwGsu7HNQ==
X-Received: by 2002:a5d:6591:: with SMTP id q17mr398559wru.212.1624853641316;
        Sun, 27 Jun 2021 21:14:01 -0700 (PDT)
Return-Path: <pbarker@konsulko.com>
Received: from owl.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id b187sm2874590wmh.32.2021.06.27.21.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 21:14:00 -0700 (PDT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [PATCH v3 0/4] Re-implement prserv on top of asyncrpc
Date: Mon, 28 Jun 2021 05:13:52 +0100
Message-Id: <20210628041356.2676-1-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These changes replace the old XML-based RPC system in prserv with the
new asyncrpc implementation originally used by hashserv.

Changes from v2:
  * Dropped patches which are currently applied to master-next, this
    series should be applied on top of the current master-next branch.

  * Improved asyncio usage based on a trawl through the docs and various
    other online resources. The asyncio tutorials from Lynn Root on
    graceful shutdowns [1] and exception handling [2] were excellent and
    should probably be required reading for anyone using asyncio in
    anger.

    As can be seen in the first patch, Python 3.7+ is required for us to
    guarantee good behaviour from asyncio stream readers & writers.
    However, these changes have been written to support Python 3.5+ in
    line with bitbake's supported Python versions and I've tested this
    on Python 3.6 (OpenSUSE 15.3).

    Hopefully this should resolve the hangs we've seen on the
    autobuilder or at least bring to light any exceptions which may have
    been occuring in asyncrpc/prserv.

    [1]: https://www.roguelynn.com/words/asyncio-graceful-shutdowns/

    [2]: https://www.roguelynn.com/words/asyncio-exception-handling/

Changes from v1:
  * Drop obsolete getPR function in PRServer, this was replaced by
    handle_get_pr()

  * Add timeouts to catch bitbake hangs seen on the autobuilder. This should
    turn these hangs into errors which can be more reasonably investigated.

  * Add a minor error message fix I spotted.

Paul Barker (4):
  asyncrpc: Wait on writers to close with Python 3.7+
  asyncrpc: Ensure that asyncio shutdown is clean
  asyncrpc: Handle exceptions
  prserv: Replace XML RPC with modern asyncrpc implementation

 lib/bb/asyncrpc/client.py |   3 +
 lib/bb/asyncrpc/serv.py   |  41 ++++--
 lib/prserv/serv.py        | 263 ++++++++++++++++++++------------------
 3 files changed, 169 insertions(+), 138 deletions(-)

-- 
2.26.2

