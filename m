Received: from mail-il1-f193.google.com (mail-il1-f193.google.com [209.85.166.193])
 by mx.groups.io with SMTP id smtpd.web11.3630.1591413349591731550
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Jun 2020 20:15:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=jqJV/4Xb;
 spf=pass (domain: gmail.com, ip: 209.85.166.193, mailfrom: jpewhacker@gmail.com)
Received: by mail-il1-f193.google.com with SMTP id 9so11528066ilg.12
        for <bitbake-devel@lists.openembedded.org>; Fri, 05 Jun 2020 20:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vUqTR+evusmewWzoLa4wEodYxiSuUYI6dm2gQ+bf0es=;
        b=jqJV/4XbCwb3Rw7WBYrQw5vvmdiPaTFbmqlFA/56nPWz6cdllFtlx26Jr3vVKiSNzc
         2GYRz3bQZ/RvSQ3Mxpagbbu29H/BWWFeeruVlhSbeUmG0GHNcqso3hcoDiZ56pp3/iPD
         W+yIFwXrk3cqrxW5o0azvKbjHyPFTMAzWGlK1rqtfxOiNbmrxTE11N8r/WraBRFtjuWH
         ky4nRZmkaWU5Td/vYQvcDMScjePWZmDavP1G2XHefa8t8TqO8ZVmBZ6y60Z7mj+p7s55
         189WbFNna91r44gGl9AE+BoX9bH4B1pMclSvkU40rVjiznOXiw5w0LUKSUzbTjDt2DWz
         lLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vUqTR+evusmewWzoLa4wEodYxiSuUYI6dm2gQ+bf0es=;
        b=CZipv1sQsauWer/DTmW0C1E9/NmZ90agTljlYx/iKXRepq1f/e/5DH0xo1wg3N+c4Q
         Qcqd2eo0RWnKcBfxZ6aczBP/1oZLxnSJ4499uMBN+DiKzg9F7BBWMyf5Vt23Q5iING7H
         CwPDpWXP3ypB9iHE9eJCXHcjuvWSq+h6jXGZvRpol2IkSunVAlkWCwYD+ugkWcbr0ueH
         3bPD3bjdw17FoADrdM8OKjXbPRq0amEWOA0rLlOFDKeK+IxorPxu9ud+YRHgZsunxC2V
         rKyBcMpAiyjwtGh1UJqZ4bcO9BE4whdxrrFq0QFaUsH7bkxblyGae1Hh27rJDibbqtVp
         JwHQ==
X-Gm-Message-State: AOAM531xq/83qYD2os4CxQMYEFtLNdOhqyzoc+KH327Gw0Rva+2FFWLA
	za1dtLrhX2U6576fdeIOGuLr1sFvliQ=
X-Google-Smtp-Source: ABdhPJxOyrci5/logxdIS31EWnDD4fF3/pIB+5AXYg7gFYM84rOQk1oG4iKL1et8ERsdr+Dbm9Fyjg==
X-Received: by 2002:a05:6e02:1286:: with SMTP id y6mr11977261ilq.0.1591413348761;
        Fri, 05 Jun 2020 20:15:48 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:28:333f:5748:fb55])
        by smtp.gmail.com with ESMTPSA id p9sm2885221ile.87.2020.06.05.20.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 20:15:48 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v5 0/8] Add support for per-multiconfig BBMASK
Date: Fri,  5 Jun 2020 22:15:28 -0500
Message-Id: <20200606031536.15956-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605015325.35395-1-JPEWhacker@gmail.com>
References: <20200605015325.35395-1-JPEWhacker@gmail.com>
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

[YOCTO #13721]

V2: Fixes some syntax errors in tinfoil

V3: Optimizes caches so that each one only caches the files for it's own
multiconfig

V4: Fixes compatability with Python < 3.6
    Renames split_pn -> split_mc

V5: Fixes oe-selftest errors

Joshua Watt (8):
  bitbake: cooker: Split file collections per multiconfig
  bitbake: cache: Use multiconfig aware caches
  bitbake: lib: Add support for Logging Adapters
  bitbake: lib: Add PrefixLoggerAdapter helper
  bitbake: cache: Improve logging
  bitbake: cache: Cache size optimization
  bitbake: tests: Add tests for BBMASK in multiconfig
  bitbake: command: Move split_mc_pn to runqueue

 bitbake/lib/bb/__init__.py                    |  50 +++-
 bitbake/lib/bb/cache.py                       | 228 ++++++++++++------
 bitbake/lib/bb/command.py                     |  45 ++--
 bitbake/lib/bb/cooker.py                      | 159 +++++++-----
 bitbake/lib/bb/runqueue.py                    |  17 +-
 .../bb/tests/runqueue-tests/conf/bitbake.conf |   3 +-
 .../runqueue-tests/conf/multiconfig/mc1.conf  |   1 +
 .../runqueue-tests/conf/multiconfig/mc2.conf  |   1 +
 .../recipes/fails-mc/fails-mc1.bb             |   5 +
 .../recipes/fails-mc/fails-mc2.bb             |   4 +
 bitbake/lib/bb/tests/runqueue.py              |  15 ++
 bitbake/lib/bb/tinfoil.py                     |  24 +-
 bitbake/lib/bblayers/action.py                |  22 +-
 bitbake/lib/bblayers/query.py                 |   4 +-
 14 files changed, 399 insertions(+), 179 deletions(-)
 create mode 100644 bitbake/lib/bb/tests/runqueue-tests/recipes/fails-mc/fails-mc1.bb
 create mode 100644 bitbake/lib/bb/tests/runqueue-tests/recipes/fails-mc/fails-mc2.bb

-- 
2.26.2

