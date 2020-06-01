Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
 by mx.groups.io with SMTP id smtpd.web11.48806.1591048189271119478
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Jun 2020 14:49:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=bqXdTD7N;
 spf=pass (domain: gmail.com, ip: 209.85.210.196, mailfrom: jpewhacker@gmail.com)
Received: by mail-pf1-f196.google.com with SMTP id v2so4062476pfv.7
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Jun 2020 14:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LsvWJcRhhu26+SMrhwylKecdrL0SXT3ubOYBLvEXSbk=;
        b=bqXdTD7NfPVEaj3rCaHjJuMyvy2ryPEDZhemoWIr6qRr0JG8OYpTLs0Z39a1fXo2ad
         xWMXaRcuvdkZaorcs8IuQHfb4FOMH2/YDJLNPYY1/lR9cUS1lO2PyCf1U9nKXmjXci6m
         Xpn0l5opVfMiQkqhjAXPyaXYTFahDt1SmC0fT9O87Ts7ynZNdh4DC5Wb4q9y9ZLHt9WJ
         ZT/tlcSlznn+KMw4JVujAEx2FkoSJN7+Rd/w7p1dFSl47oCCGRbJF9yJ1FL+8DnK6z8c
         QVgnsx1Iel/j7mGexp7w09AkQCxLbxwhl29fdZ7Fj25tn1dD5wyfxgwnjYJBp4lSE9Mg
         UzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LsvWJcRhhu26+SMrhwylKecdrL0SXT3ubOYBLvEXSbk=;
        b=izsKJ+sVsZarksTvRL0+TSWC/9G3POOqQ88zoB5obJiJ6DuEVDS8+BHr9hMfaEePnp
         JHL8CdAtYukJcohdClb9YWl/9DphHaVEHVRuPvi0PFcTeX7EzMMTwxI0GiB4lncKFb2y
         A0oUORHOtX9egKmPjjw++xVfFOkKpQ8nyNclQKF5tg5UKBHkbzxo2CI5XK/DFM7A6gQ6
         LpgfUf7K8GQIsSS1sdtOVqcSQyA8/QZTIxuMz4s+vZmABo/X1GYYL3CSR8Bp/49trlj4
         yhIfab6qW+sVVyS7cYhiaag79s17EQZqh1jaFcurfDCoDe2k7oJfcP1uTrG2K8JoE/8/
         Rgnw==
X-Gm-Message-State: AOAM530d+KbOtQbRQ1DCiQ/Cxb45+0tGMu0L9GI8aQY3V0GBBa5VRiDn
	tHfIRhiNZRn35O5ayoJCmGjSXc6CyT4=
X-Google-Smtp-Source: ABdhPJwouknSy+ZJViqN47ccvw9jJofHDFnRm+fkZM3c6ASu0l2kAV0ssUmsJwCyXZZYdAr48k1UJA==
X-Received: by 2002:aa7:9f97:: with SMTP id z23mr14576017pfr.140.1591048188439;
        Mon, 01 Jun 2020 14:49:48 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:ec76:791a:e792:c8c8])
        by smtp.gmail.com with ESMTPSA id o18sm385458pjp.4.2020.06.01.14.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 14:49:47 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v2 0/8] Add support for per-multiconfig BBMASK
Date: Mon,  1 Jun 2020 16:49:37 -0500
Message-Id: <20200601214945.32481-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601202807.26357-1-JPEWhacker@gmail.com>
References: <20200601202807.26357-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Splits apart the bitbake configuration data and caches so that each
defined multiconfig can specify as separate BBMASK independently of the
other multiconfigs. This can take multiple forms, such as a `BBMASK` in
a multiconfig .conf file, or BBMASK assignment based on an override (see
linked bugzilla for an example).

The most noticeable change is that bitbake now keeps a parsing cache
file for each multiconfig instead of a single parsing cache file that
caches all multiconfigs.

V2: Fixes some syntax errors in tinfoil

Joshua Watt (8):
  bitbake: cooker: Split file collections per multiconfig
  bitbake: cache: Use multiconfig aware caches
  bitbake: lib: Add support for Logging Adapters
  bitbake: lib: Add PrefixLoggerAdapter helper
  bitbake: cache: Improve logging
  bitbake: cache: Cache size optimization
  bitbake: tests: Add tests for BBMASK in multiconfig
  bitbake: command: Move split_mc_pn to runqueue

 bitbake/lib/bb/__init__.py                    |  30 ++-
 bitbake/lib/bb/cache.py                       | 219 ++++++++++++------
 bitbake/lib/bb/command.py                     |  39 ++--
 bitbake/lib/bb/cooker.py                      | 165 +++++++------
 bitbake/lib/bb/runqueue.py                    |  17 +-
 .../bb/tests/runqueue-tests/conf/bitbake.conf |   3 +-
 .../runqueue-tests/conf/multiconfig/mc1.conf  |   1 +
 .../runqueue-tests/conf/multiconfig/mc2.conf  |   1 +
 .../recipes/fails-mc/fails-mc1.bb             |   5 +
 .../recipes/fails-mc/fails-mc2.bb             |   4 +
 bitbake/lib/bb/tests/runqueue.py              |  15 ++
 bitbake/lib/bb/tinfoil.py                     |  26 ++-
 bitbake/lib/bblayers/query.py                 |   4 +-
 13 files changed, 356 insertions(+), 173 deletions(-)
 create mode 100644 bitbake/lib/bb/tests/runqueue-tests/recipes/fails-mc/fails-mc1.bb
 create mode 100644 bitbake/lib/bb/tests/runqueue-tests/recipes/fails-mc/fails-mc2.bb

-- 
2.26.2

