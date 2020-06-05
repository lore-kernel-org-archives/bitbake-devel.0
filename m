Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
 by mx.groups.io with SMTP id smtpd.web11.2274.1591322011881703380
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Jun 2020 18:53:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=qMvOQl+Y;
 spf=pass (domain: gmail.com, ip: 209.85.216.66, mailfrom: jpewhacker@gmail.com)
Received: by mail-pj1-f66.google.com with SMTP id q24so2050868pjd.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 04 Jun 2020 18:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wpq6svs554bMWFDbbGIatGF0DHbIyxFQgQfjRXQ2fFw=;
        b=qMvOQl+Yr0yDPximyikkydfzopHWGra7qgKD/XKrXICpMFJs/TrPyq7HyEHmnGERTs
         /yye1YMvU71kgVYgB+Gbf8aLGYDoGpbYSYAztik4cqBwfP07d2h04yGen6EhgQMnDvuy
         EerJPVvKmCbkQF6p4sJO3h/In5suhinnRfnsFx2kckzhsZTqQFGV54NqYXPT/yNG0L2F
         +7Q9ucRIj13j3mzSkaQeCnsrsfCya9Y31BdHT6TMVdRiz+p/mP82QnNlzBgp+8izFwzq
         /l7nXlrndX8mC6LVvkIoM12kmFwq4xXgvNmzD20bLjzphndwH8fgtabD1B4sa0UkegLF
         ITAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wpq6svs554bMWFDbbGIatGF0DHbIyxFQgQfjRXQ2fFw=;
        b=qPo4d+U0BU8cNn6EkiQB9FPK6+bMROayleB6659geR1aqvQtESZgPiI2e4kPegC6P+
         yT9D50hIatkypZbAWmsh5Ymw573SZNC6fmx2o4UeR3QZL5PUhZJ/2qDqgO5MW8o9cc/Q
         eGdlNIQMmVGeZHRPaCX850UGM6jw7bmZDKqovGh3DXTygD7WfSmX12QXtxd/JxATSixv
         U8d23XLN6YEExiBThMBirFfo5gqzBCUvw8LREJ2s9agKBlkl3l8xTrZzyHvFb0QjJNT6
         deK7Rh5kWuJAGy1FowSjm3/S7ZkW7O1HCBebKtGHE7LFajP5DKh6T24kGG0I7h434CbH
         8Oxg==
X-Gm-Message-State: AOAM5331LF6ueWtA9oE5uRh47Z5ilKwx7zrXwbNriylNOJ25AVmB9AY4
	U/s2HiM3f5aQzAVCKiKfgBl1iKIufu8=
X-Google-Smtp-Source: ABdhPJzLPGTnqyOV2Uaz2qtPS6MGnAdgrrxB1VPcYIY1DPTQ6toE5rwNDqxrRbUNU1uFy44yczfpIg==
X-Received: by 2002:a17:90a:714c:: with SMTP id g12mr269773pjs.31.1591322011167;
        Thu, 04 Jun 2020 18:53:31 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:bdc6:d557:64ed:7ccf])
        by smtp.gmail.com with ESMTPSA id x12sm5673516pfo.72.2020.06.04.18.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 18:53:30 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v4 0/8] Add support for per-multiconfig BBMASK
Date: Thu,  4 Jun 2020 20:53:17 -0500
Message-Id: <20200605015325.35395-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200603025405.26885-1-JPEWhacker@gmail.com>
References: <20200603025405.26885-1-JPEWhacker@gmail.com>
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
 bitbake/lib/bb/command.py                     |  39 +--
 bitbake/lib/bb/cooker.py                      | 159 +++++++-----
 bitbake/lib/bb/runqueue.py                    |  17 +-
 .../bb/tests/runqueue-tests/conf/bitbake.conf |   3 +-
 .../runqueue-tests/conf/multiconfig/mc1.conf  |   1 +
 .../runqueue-tests/conf/multiconfig/mc2.conf  |   1 +
 .../recipes/fails-mc/fails-mc1.bb             |   5 +
 .../recipes/fails-mc/fails-mc2.bb             |   4 +
 bitbake/lib/bb/tests/runqueue.py              |  15 ++
 bitbake/lib/bb/tinfoil.py                     |  26 +-
 bitbake/lib/bblayers/query.py                 |   4 +-
 13 files changed, 380 insertions(+), 172 deletions(-)
 create mode 100644 bitbake/lib/bb/tests/runqueue-tests/recipes/fails-mc/fails-mc1.bb
 create mode 100644 bitbake/lib/bb/tests/runqueue-tests/recipes/fails-mc/fails-mc2.bb

-- 
2.26.2

