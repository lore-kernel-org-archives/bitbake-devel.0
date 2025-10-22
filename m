Return-Path: <adam.blank.g@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88A5CCD1BC
	for <webhook@archiver.kernel.org>; Wed, 22 Oct 2025 18:00:05 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
 by mx.groups.io with SMTP id smtpd.web11.1338.1761155997617168932
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Oct 2025 10:59:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=WwzQY6lo;
 spf=pass (domain: gmail.com, ip: 209.85.218.51, mailfrom: adam.blank.g@gmail.com)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so1403667066b.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 22 Oct 2025 10:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761155996; x=1761760796; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6EoIf7Kwo7Mrypca/mCbpauwjIQ46+OyRrue6xNLWC4=;
        b=WwzQY6loNks0QXW1WyMDfQw7HQcZQM4Xogjn/Vou4ACoVFmzXTyjQ41XbE3GtgFa2a
         11bz4PtjF1S89cg1CUVOUabyJo0LgpX1/zZ9ZI8pqC3rpiam15pyAP6oQUxkAmN69RYO
         j7hGmxiZL9UEzUDovtQaNtOE+pbt5oHzinIZgBPUYzlv/CQHuLxzbUb43oK5mVw05Ndx
         eiEZS7u5vM8qzdBgT6WJUi5PPBoGUhn5FYzcYD9B7ytx1kPNqCVqgeREW27IDxPU8ECr
         DIbrqlfnhqBxIQ3vZkrl9cH+BZbkOZMgvH25jykYxp8qTqBkuKV29NfBhdXRvz3nVRXj
         J24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761155996; x=1761760796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6EoIf7Kwo7Mrypca/mCbpauwjIQ46+OyRrue6xNLWC4=;
        b=qpreo0iBBkHec80/xLrpmaQUmUFeKPcOk0x84XT1Taom+De/zbIFToix3aSTFwlw1l
         /lfSAcaiWEa16WRk6MnV/nVUXJAsTsWNdfKZRcK4bsT0gvRl9EibuKeELD/ixQUu0YVn
         axHlr5T21TWpIKYj7YhDJ2ZVqn4cmMAmSgFqZQqE7s0XCRiIqEjngqBBSvh4SJZgfLI4
         0rHx/RteMc99Rhv1q1XyqADTSuZSzywdqb1285YyN29nYaGXKOAgeLOmBcTpv3Qgcnaq
         awz586oCaiKRUjimx6+X1stoB+TzL4p9dZ9Lxz5G1MRAm7Bhib/YNhiWrAVcjTCmcUrv
         6GNg==
X-Gm-Message-State: AOJu0YzYHw7ukoht0e/aMfhB3h+cZy6f3DzR01dMI7FPThYpF3PVkhuP
	6nFa0elvgC618M9ZnROMeFujTctHpP3ttyoaEpSALwPTjRxTiCaIiIL4lomz5A==
X-Gm-Gg: ASbGncvaPDd2XhFqoIqFzZI/NalLCTFqHsLdbcEVXW8e00rqD4oJ60TV017cae2br9n
	1mWKE+ZVqJnlIg2gb2CLDp7GxbmkBO6PH2JKya48HcxGFxuNKivXNosnqQg1A3GWtJb1rV+TJQN
	WQSlcCgUmyA54FmCJYzYB4o1cd07+PtpetTMlpv7LMht1K6qMW+pLA7mJyBsurIY5zi27WPF7fN
	ZvoaVWFiOWkAm0oetdLkmkNI7g+sXNsO88AbMgActe0p7ZDUffXQpdBHyG8cXY4qZJWb5iNvq2V
	dShAeexO7bdSxeDWL7d7Xngf+/4xtogQJXi/vvZiAg8dYg0zSELkZ4znbKWgU1gxo8ivEY/KEGg
	qC4N0ML+U8RWE+XTMCkHUr21yK8jc7MtriJzDHgGuHqmdudM3FTuD7NuAsz65ur7MioI7R69Ydw
	yAZiSZz23GdoJVibH8QohP
X-Google-Smtp-Source: AGHT+IHrU8Uluo2YxLqgEfNzHHB8fy9yrB9G+AaaB/6V3QKInZY04MwhOV03d+FiquHM/Z1VQcORsw==
X-Received: by 2002:a17:907:bb49:b0:b4b:4f7:7a51 with SMTP id a640c23a62f3a-b6475706fc2mr2659929366b.62.1761155995822;
        Wed, 22 Oct 2025 10:59:55 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a312:c8a8:7a00:d881:1b43:b51e:659b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e8391523sm1386121166b.18.2025.10.22.10.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 10:59:55 -0700 (PDT)
From: Adam Blank <adam.blank.g@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Adam Blank <adam.blank.g@gmail.com>
Subject: [PATCH v2 0/2] Describe AUTOREV and SRCREV_FORMAT roles in fetching
Date: Wed, 22 Oct 2025 19:59:11 +0200
Message-ID: <20251022175913.13007-1-adam.blank.g@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 Oct 2025 18:00:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18210

Fix encountered style issues, add missing variable
descriptions and references.
---
Changes in v2:
- abandoned the commit for the UNPACKDIR
- reworded and fixed typos

---
Adam Blank (2):
  doc: bitbake-user-manual: AUTOREV and SRCREV_FORMAT roles in fetching
  doc: bitbake-user-manual: style and completeness corrections

 .../bitbake-user-manual-fetching.rst          | 112 ++++++++++++------
 .../bitbake-user-manual-ref-variables.rst     |  18 ++-
 2 files changed, 91 insertions(+), 39 deletions(-)

