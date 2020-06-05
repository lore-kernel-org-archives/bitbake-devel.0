Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web11.1053.1591381079639730096
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Jun 2020 11:17:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=AnJ4dNGn;
 spf=pass (domain: gmail.com, ip: 209.85.216.47, mailfrom: jpewhacker@gmail.com)
Received: by mail-pj1-f47.google.com with SMTP id m2so3181181pjv.2;
        Fri, 05 Jun 2020 11:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZoIOhb8TLtEFocF7Dlw6eB/6SjpIEYLbyl5Xz8BvbyI=;
        b=AnJ4dNGn/RTQCdJUondgR+UpggIgGKPhSW3X7d5VD5SKjAVDNslhTc00q60fPzwWog
         LIRttH98HhN6o1gMMmf7De/AxZpz6CTIMa1rQYzcWYbJYp6voBHdGVaV6X2GNonhcyj8
         sZOoriv0cB3xtSv6s9d864i9Y3Of8tI/+X9Yc7o6CGMHSI9c4/NP1pQQVPOMOcElH42u
         cE1rX6SmR7bC7tO+myIlJTuNKYwH/HEPbCzXn+H4zIZO2KoO8UAZBC8dDsATAAvb0tBf
         BJhaxRGJHpw6X/SiiFCFh44tQTicu6PAlqbObqFI6+PUSiuOODRIazFIBf3Gqcg1RSsa
         vE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZoIOhb8TLtEFocF7Dlw6eB/6SjpIEYLbyl5Xz8BvbyI=;
        b=L3VBeq+xx7sut3cBuRGwn9zP0mYBAeYUvt+Y1lzE0AyCXYcRADAv2BHpME4rK8FO3O
         xtnokOcnFNUR6z5ifz4N52cgnsZrjAMRRqEj9/8MR84yO2SUc0Ba5qcKop+DeuDQSkBF
         w+uwuT2P0GlNpgW4LNuFbv6yvDBeM5sguR7GiSz4F7WTsFS/xxZ+GW2okOsZpk9Iio+l
         ph9GIPVQDe+ISAN7bDOnmUoYWSVy9LYgm0VCpq4ULwJJIBNWy5DaQz0/wsaDd/45Ln/T
         yn0l1nSGqQo48DFsXuiQAcqpo20hRo7TsJydOrqsQeMOu3ZCzFBbq/cwgGCJVFX4BQXH
         +UyA==
X-Gm-Message-State: AOAM530yJFQHTXT1FbG0yR2R+yRu9UCcoGM/bGwBaxppwg5YqHnawx2Y
	LFjfLeWu/B18Gkz4CSqKYi7BqbBAFTM=
X-Google-Smtp-Source: ABdhPJzjSalTGQFz3J4HOC2MXcDHVxIfc8ExDI30p3p+F/t1923EZCTs416EyXdQnYWhEA6IMIAguw==
X-Received: by 2002:a17:90a:240c:: with SMTP id h12mr4503899pje.42.1591381078874;
        Fri, 05 Jun 2020 11:17:58 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:28:333f:5748:fb55])
        by smtp.gmail.com with ESMTPSA id g21sm246096pfh.134.2020.06.05.11.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 11:17:58 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [RFC PATCH 0/3] Include mcdepends in signature generation
Date: Fri,  5 Jun 2020 13:17:51 -0500
Message-Id: <20200605181754.32883-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Updates signature generation so that mcdepends are included. Previously,
they were not which meant that if recipe A mcdepends on recipe B, and
recipe B changed, it would not automatically cause recipe A to also
rebuild.

In order for signature generation classes to correctly handle mcdepends,
they need access to all the data caches, so all are passed instead of
just the one for the recipe in question.

This breaks the bitbake siggen API and makes it incompatible with
previous signature generators, hence the cross-posting between bitbake
and oe-core.

Joshua Watt (3):
  bitbake: siggen: Pass all data caches to hash functions
  bitbake: tests: Add mcdepends test
  sstatesig: Account for all dataCaches being passed

 bitbake/lib/bb/runqueue.py                    |  6 +-
 bitbake/lib/bb/siggen.py                      | 32 ++++----
 .../lib/bb/tests/runqueue-tests/recipes/f1.bb |  1 +
 bitbake/lib/bb/tests/runqueue.py              | 30 ++++++++
 meta/lib/oe/sstatesig.py                      | 77 ++++++++++---------
 5 files changed, 89 insertions(+), 57 deletions(-)
 create mode 100644 bitbake/lib/bb/tests/runqueue-tests/recipes/f1.bb

-- 
2.26.2

