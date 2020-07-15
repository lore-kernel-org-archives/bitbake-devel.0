Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web12.7833.1594823246707772895
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Jul 2020 07:27:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20150623.gappssmtp.com header.s=20150623 header.b=UZgIVTtr;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.171, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f171.google.com with SMTP id x8so2453233plm.10
        for <bitbake-devel@lists.openembedded.org>; Wed, 15 Jul 2020 07:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=GYKvDBVlLkdPkUdQdMARwiOBSDC1iXpi5huSw8+T7p0=;
        b=UZgIVTtrKUsrOrNLQ/f2VopqN1f31fuX/thvqJL1i038/1p+Jc1zmJ/X1HUwoCVx5g
         RgjKCozc9y4uk0baSVT8FQcGZ36LH4pr+IaLPXTB5Hs379HVJiSt2sY5mD3oYVXgSYG5
         qmhCZFrCBIDYG5iWR1IKcvDzM4BESdb7oXn5/58Tpj91vqyGw6nMnP8Ho5ALcO6OKm6m
         zFgngNTawaJy4zvDyh3f8tw9MvZndGjNxdPCDxAAUtPYyUAWhlXOss1g6S+/pJdYAWJC
         v+3Bd6Mw+QD5yw81mIGQDZVLuBiedY+EBRiAm4qsL6FDVxkTShrZfP7HKvsQViBwzyAz
         WPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=GYKvDBVlLkdPkUdQdMARwiOBSDC1iXpi5huSw8+T7p0=;
        b=K88iQ54jknhLDri5aPdZq5D8uI2BkcCK2+/51g9D9Gc6FIMkaG2/L4MwsPhhLP6x+j
         MAjasppfZtTDZ5BQ7WmGGqHV0U8jDkvzQB68S5+EWwE/pfF4E7+0Lrq/PGgSllSK0zMQ
         2wvb4AP7mv5dC5Ym7e+7lOcMGemQq+ixDShnIshwXzOilZyQOcMM6VGvqtZ6ZXqYKK+w
         zCVyaKrTiiMzIqJvghGM97ROKEgDX7mN+c0wS4F9/JIJmVZ5PnCEs7Y/AXAb+kXbP+4Q
         5lwUrBOZwSz+0S8qgjH41xQO6i+vXLMp/F6ws+v/blBS4JHiA1tXSSIJgIYqFV4/jkAY
         XzEQ==
X-Gm-Message-State: AOAM533mZopm5ZIOdtj0Iz2b1nB4FQWA/pYnZP2NZMbtlqHddy0q4V+m
	LK53M03V9/75IesDa8oNs5ysEzMJV8ps1g==
X-Google-Smtp-Source: ABdhPJxeahDFogZsYxRPuldR02AzTssy05QA+9LN3q/UQHStShZI40INMlVw25CCe5Q3YD2w7ewcaQ==
X-Received: by 2002:a17:902:8206:: with SMTP id x6mr8704926pln.328.1594823245833;
        Wed, 15 Jul 2020 07:27:25 -0700 (PDT)
Return-Path: <steve@sakoman.com>
Received: from octo.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com. [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id i125sm2423915pgd.21.2020.07.15.07.27.24
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 07:27:25 -0700 (PDT)
From: "Steve Sakoman" <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 2/8] lib/ui/taskexp: Fix missing Gtk import
Date: Wed, 15 Jul 2020 04:26:44 -1000
Message-Id: <44e24fffc568dfee054b5feff2d9b382b9ce4bb5.1594822992.git.steve@sakoman.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1594822992.git.steve@sakoman.com>
References: <cover.1594822992.git.steve@sakoman.com>

From: David Khouya <dakhouya@gmail.com>

Adding back gtk objects import.

Fix bug introduce when adding validation on gtk import.

Signed-off-by: David Khouya <dakhouya@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 765be5ef60668f8a1cfbcba248f4995725807196)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/ui/taskexp.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/ui/taskexp.py b/lib/bb/ui/taskexp.py
index 336d197d..05e32338 100644
--- a/lib/bb/ui/taskexp.py
+++ b/lib/bb/ui/taskexp.py
@@ -12,6 +12,7 @@ import sys
 try:
     import gi
     gi.require_version('Gtk', '3.0')
+    from gi.repository import Gtk, Gdk, GObject
 except ValueError:
     sys.exit("FATAL: Gtk version needs to be 3.0")
 except ImportError:
-- 
2.17.1

