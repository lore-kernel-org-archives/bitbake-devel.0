Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web12.1930.1602699656620685290
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 14 Oct 2020 11:20:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=IxoNl6XU;
 spf=pass (domain: gmail.com, ip: 209.85.214.182, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f182.google.com with SMTP id w21so148533plq.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 14 Oct 2020 11:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ke3FoJekGFJ6Ztoo4BuJAdxKGzG+I05fsTq39fpUOf4=;
        b=IxoNl6XUlDm46A7Os93iyUlRP8OMMI463wOTooacdFTZDjK2BOtIHU0KPwo9tAvRg4
         lC4aBo1V9DQK8aKDEhSMjP+C3OGYOQBmWh6Xea3RiyJjBQjkIHRnD83vtclymC/1qNNX
         Tod8hPsCsLhty12eeDiwZCKv2ZYzmX8/mRlY6ZFTu0zDD/yGrv5PMulkzMj5PYr2qdA/
         O5U1LKCCMB6Cf8BWEgUCvrEnfuttFf2uYAbsOkxn1sqQA/0StRop9e1sjFy1yHK0776O
         gpkNnKHycutkxE436xIYYXWMJpslhLp84YhQMCSPJf3t2ju/MDipLxSv+pZ1VoiSSwBM
         DSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ke3FoJekGFJ6Ztoo4BuJAdxKGzG+I05fsTq39fpUOf4=;
        b=IiiRwWojyqIC2A7xAEaqv4iL/wEYt1qNPVYqn6fN7RKztJauQJ9Fqau6xT0A1dyQpM
         jcyec3BpR0Wg73DKAdkJGsDKfrFaQDu6PX7nd9ohIXfuatV4vodvEyc0Sb7m1M2xbWL7
         +93hCLcslWcUlcUigdP25S6X6TF4QSr/m2DKt/9W6XbwGd+IqYCse0iVkvVcbWeLOw1Y
         fhbYNwxcU8h/FikY5ybJOT8wosLeu5Y4wWoBp830+v6OvQa5ZIRsEif32Lm7YJIrHzk1
         nbP4Dmp8FtDkHH7jk3FELXtEJrpJixQnXEU8QNDnpgIANDYUUCd1FkctQ0x2qU394r88
         Vcxw==
X-Gm-Message-State: AOAM533FUvbygO8vS1rxAStiq2Lv33gB5rsKYa3TfFP2kf2mLe9VJJFU
	EzzAYJtCRY2BR/cVZGk1089CKrzMkKaz7g==
X-Google-Smtp-Source: ABdhPJyfEwL4QJDNvjSmuGPkkdbUs9eU8bpXYAsGWWc8jpDTOffzRiQRo/+M2itbxeLDvIfEHpzymQ==
X-Received: by 2002:a17:902:6b45:b029:d3:df34:3222 with SMTP id g5-20020a1709026b45b02900d3df343222mr352300plt.68.1602699655679;
        Wed, 14 Oct 2020 11:20:55 -0700 (PDT)
Return-Path: <ticotimo@gmail.com>
Received: from thetis.hsd1.or.comcast.net ([2601:1c0:6000:9640:59d8:4931:5c26:e5c7])
        by smtp.gmail.com with ESMTPSA id fa12sm198188pjb.25.2020.10.14.11.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 11:20:55 -0700 (PDT)
From: "Tim Orling" <ticotimo@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Tim Orling <timothy.t.orling@linux.intel.com>
Subject: [PATCH] lib/bb/ui/knotty: fix typo in parseprogress
Date: Wed, 14 Oct 2020 11:20:52 -0700
Message-Id: <20201014182052.36766-1-ticotimo@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tim Orling <timothy.t.orling@linux.intel.com>

After parseprogress.finish() it was intended to
set parseprogress to None, but a typo means this
is not happening.

Signed-off-by: Tim Orling <timothy.t.orling@linux.intel.com>
---
 lib/bb/ui/knotty.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index a91e4fd1..0efa614d 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -692,7 +692,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 if not parseprogress:
                     continue
                 parseprogress.finish()
-                pasreprogress = None
+                parseprogress = None
                 if params.options.quiet == 0:
                     print(("Parsing of %d .bb files complete (%d cached, %d parsed). %d targets, %d skipped, %d masked, %d errors."
                         % ( event.total, event.cached, event.parsed, event.virtuals, event.skipped, event.masked, event.errors)))
-- 
2.25.0

