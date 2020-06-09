Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
 by mx.groups.io with SMTP id smtpd.web10.5489.1591727659318536129
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Jun 2020 11:34:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=rlKx3gxr;
 spf=pass (domain: gmail.com, ip: 209.85.166.49, mailfrom: jpewhacker@gmail.com)
Received: by mail-io1-f49.google.com with SMTP id m81so23950771ioa.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 09 Jun 2020 11:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MITuHKp08iBYW+2r1TZPJjzFVALbZ/wbCQH633w2YdE=;
        b=rlKx3gxrwtWY6lIN1D0zDjQEIk17N3NZn8cW9wI6m/hbo+P5lhY4iEuTratd3Pu4+D
         2pcM48MTj6kYWN64nNkwe6nrJtGkjPj874JwhkbQpAECpuOEzRrNgnBYMuuRlZVj3NmR
         ++581IGPgMMnkK27CDNh2DstnTKRCnAjkDZRotkIbiwOhQ+MCfsH0Jzorz2NynqHxSKl
         4imqsb+La5MnG5am7/2XMdxzmycrwYCHQvUCi7y+J2cH/sxTIbhkWoIvhWBOy0a6q82i
         q29GIjRNBbqVxbGuCxEjqr6Cgh21B8IYajDuQ4I8vSTHeyu+M8gPmvjM0fblNglscuUT
         3Dmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MITuHKp08iBYW+2r1TZPJjzFVALbZ/wbCQH633w2YdE=;
        b=RS+25TY6IVM4Xg2hetuL53aKEK6vgRfScaqNtrpw9Yxv5uPfdgkstEJkpkWs6k+vhU
         yPbJQW+OI5iKUtEWlfL5XPDKHYO4ch2AxC3WQWyhnGr1LYlpBBcVrm3I/Zm4YfVYq0pl
         Qd4yVXTQbdz+M/jdoYdx2yr590TN12HMPkScAo2rg5hrTk+OC5xAlMK8dAuGkT4Ey7T2
         wPjYU6i3opkrSJH09hs62zcmyIqUOwmXuF5Ns09gXSQlwZxO9kMHc50spfy361FZNeDz
         Kl/5ycK9/rNCFJRNATkgEhlmKU0qfNaIDEwtKdIU7XRXMTAHvhGNEEBWXWQmXqCArs9C
         X03g==
X-Gm-Message-State: AOAM532uII/8S7jUQuG1VlCPjXV+Me/cl1Ic3rpHIWW2k1hfBeeGGH4k
	JRoJF8pdLfHL6BbxQfnsBPl/1egF
X-Google-Smtp-Source: ABdhPJzl4qI7sg3Uu3ol7Ot7Z9p4I4wjysof70oHwm6LKv5jiJc9YbMqEHwabs5+ZaNj3AtlrR5jug==
X-Received: by 2002:a05:6602:2f0a:: with SMTP id q10mr27868636iow.134.1591727658381;
        Tue, 09 Jun 2020 11:34:18 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:6cec:510:bc9:611])
        by smtp.gmail.com with ESMTPSA id p5sm9342260ilg.88.2020.06.09.11.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 11:34:17 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v2 0/2] Include mcdepends in signature generation
Date: Tue,  9 Jun 2020 13:34:13 -0500
Message-Id: <20200609183415.21914-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605181754.32883-1-JPEWhacker@gmail.com>
References: <20200605181754.32883-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Updates signature generation so that mcdepends are included. Previously,
they were not which meant that if recipe A mcdepends on recipe B, and
recipe B changed, it would not automatically cause recipe A to also
rebuild.

In order for signature generation classes to correctly handle mcdepends,
they need access to all the data caches, so all are passed instead of
just the one for the recipe in question.

V2: Add flag to maintain backward compatibility with older derived
signature generators

Joshua Watt (2):
  bitbake: siggen: Pass all data caches to hash functions
  bitbake: tests: Add mcdepends test

 bitbake/lib/bb/runqueue.py                    |  8 +-
 bitbake/lib/bb/siggen.py                      | 78 +++++++++++++++----
 .../lib/bb/tests/runqueue-tests/recipes/f1.bb |  1 +
 bitbake/lib/bb/tests/runqueue.py              | 30 +++++++
 4 files changed, 98 insertions(+), 19 deletions(-)
 create mode 100644 bitbake/lib/bb/tests/runqueue-tests/recipes/f1.bb

-- 
2.26.2

