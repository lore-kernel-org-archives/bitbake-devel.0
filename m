Received: from mail-io1-f66.google.com (mail-io1-f66.google.com [209.85.166.66])
 by mx.groups.io with SMTP id smtpd.web11.46953.1591043293481035190
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Jun 2020 13:28:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=F3qS9VVu;
 spf=pass (domain: gmail.com, ip: 209.85.166.66, mailfrom: jpewhacker@gmail.com)
Received: by mail-io1-f66.google.com with SMTP id d7so8415363ioq.5
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Jun 2020 13:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yzGC8FcDzxSISeCLF9kY19B5leLWAkIn3g4SMAKnTgw=;
        b=F3qS9VVuw7YYPIAptt1CZS9k840NNzyOgahzrYnc8YA4y+zVFnBLSNdHUjAyxVD275
         l6cN3HeI0acord0Kdx5m0OIOHePAylYnTzW6PD4Z9nXKAFGcPmlA8w+rQ8mIwemAebDr
         kO3uMbSIpcKz9b7YF5zM8CR2sT6HCBYNxXW52f1fJiVl+VRFdRgM2EIifzGNtmXpWewk
         SDDsYiL8VG3vc/wnoC+z0T2/uhbclKSwa0NZLsYrE3GGeEWIn23q3F6bkcJkQcznIpVz
         v+g9wY5yuK2UPW1/3UZuSAT/tGdpcQePpyYxexYX4ogLlhpee+TcpuQb99RmExp721Wa
         xnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yzGC8FcDzxSISeCLF9kY19B5leLWAkIn3g4SMAKnTgw=;
        b=WC8MPpygORICUUvhkiEQTdoiQ+5deg5rdfnW//+jOILljz0qy7qKZ4Yw4CNOvFZzOK
         HGCczZrfXLDj32F5fbo3GRsQx4pPnn2uRSWXkaao4d0YEl/o5nLXBF5Tj6IUn53W22Qr
         L70pVZkZY6tN7BE36vMR6fJkN0OtYJzGDH5/TsI/6mjiciIoHSDq1jocyheG+e/oAQsU
         Hv7k6RHsRRwKuIbijLuGoq7m2lgbORiLNfybpkosbbHAQt7TnVl+ppXpRS0iqasjCnRw
         yxuIR5AaMfZwS7+x2ie38BtPfG51jVFq8aSAtKcRwm7Pvk+c2Pz3JEwpfbgjy8X3E7f0
         yrfg==
X-Gm-Message-State: AOAM5315rvakcwFxIQqweQ48/qCkktW4N43oEyL2be32jXPH1Y0MqOOj
	4sL0EP4ItQc5n8jYkR+ykNaPjuCGlLY=
X-Google-Smtp-Source: ABdhPJycHT//hr62OTUf+ej48zynP0MB0KVfJWHk/vaeLAfIEqu3LlJnXJzgpBkXw+3F/C+pfYdE8Q==
X-Received: by 2002:a02:2406:: with SMTP id f6mr23226936jaa.59.1591043292634;
        Mon, 01 Jun 2020 13:28:12 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:ec76:791a:e792:c8c8])
        by smtp.gmail.com with ESMTPSA id v16sm300705ilo.47.2020.06.01.13.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 13:28:12 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH 0/8] Add support for per-multiconfig BBMASK
Date: Mon,  1 Jun 2020 15:27:59 -0500
Message-Id: <20200601202807.26357-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1

Splits apart the bitbake configuration data and caches so that each
defined multiconfig can specify as separate BBMASK independently of the
other multiconfigs. This can take multiple forms, such as a `BBMASK` in
a multiconfig .conf file, or BBMASK assignment based on an override (see
linked bugzilla for an example).

The most noticeable change is that bitbake now keeps a parsing cache
file for each multiconfig instead of a single parsing cache file that
caches all multiconfigs.

[YOCTO #13721]

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
2.17.1

