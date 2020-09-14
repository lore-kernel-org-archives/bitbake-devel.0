Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
 by mx.groups.io with SMTP id smtpd.web11.71973.1600118260001657225
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Sep 2020 14:17:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=lJGY2Wc3;
 spf=pass (domain: gmail.com, ip: 209.85.167.174, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f174.google.com with SMTP id n2so1444525oij.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 14 Sep 2020 14:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AqQdk9sddcjLShMZHnrdsFs7D5P26M+CRM/+4zFOl5c=;
        b=lJGY2Wc3E5tUWfmWKvHHqgiLboXxTYB1ng1SOuPqLLCPVY1KFgCbFsncm2UlslsuLX
         UzL6VDjJ3HjTjaVnganHTYZyfpl0sUzwK4AfGXpqGmn+Tv2UPwvXOW7bZ67e9GPKUYkA
         LEu7YsofR0pgh45iR6od4o9HY5tmSfxlNOBQTKtdrSBff6fC+m0dEBfLTtTRTY8VIZPu
         /Ux/crwcJ4uVVRdZ2cq5SUCHkaFSMgCTORz5fONfzhVjhuI/TpBiuc7zfspe4LY1GqiT
         ct8YW7KI0ybuYYX6ar3wcECQ+LRO82UH0XBp7tLWuywpn7U+P+j4cCckBRwKGq1fDax+
         8oMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AqQdk9sddcjLShMZHnrdsFs7D5P26M+CRM/+4zFOl5c=;
        b=mbQhvn/xfUgG5M2no+Jm7IXn8Met6b9l0IXUHIS7h+hFgJHCa/lOu3VXsK4wnsiILh
         SLNjldnkR4mKL1NgGUs/UJb6qx+D+x/iRscuNxPz7/XYnssnIqBFbgGJ+tFFr6F2IuzQ
         GLf/1sIyDcVZELvJal+QoRUSlCVj0a5UepkspoTc91a2hAsEtIbLagc17GHFNOld5K+Q
         f7XxUUWB4k5eMZZsZBJIE3F1MWJ14xnVGWR0cVNN/riPzYF6RhZ5zWIY9B/kSxfgl21f
         ueQJKxVJCD3ZaI1de3RAcagHU8GCUu8zvYuY3gCHZHLoLUkB1bC0B6g49S7CEh5//HNw
         PTxQ==
X-Gm-Message-State: AOAM531v2pun3YAmmitxe+dHxjZh9VQvLiOyB+3Ndu5vIyzCSGsL35m0
	a911VpEjc/0Al7z9YUzbz1FIBgfq8pI=
X-Google-Smtp-Source: ABdhPJyd1i2gctnSwQfA5W2PLsItkIdK8JZ2UXVr+a+aoR8h1K4RRlHrOVJCkIM7AcypADyz7BwCOw==
X-Received: by 2002:aca:f545:: with SMTP id t66mr894937oih.112.1600118258994;
        Mon, 14 Sep 2020 14:17:38 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:7282:816:6ef9:8e8c])
        by smtp.gmail.com with ESMTPSA id z16sm3986235oth.43.2020.09.14.14.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 14:17:38 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] bitbake: cooker: Block SIGINT in worker processes
Date: Mon, 14 Sep 2020 16:17:35 -0500
Message-Id: <20200914211735.10512-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Blocks SIGINT in the worker processes to prevent them from running the
parent process signal handler, which causes them to deadlock under
certain circumstances.

[YOCTO #14034]

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/cooker.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 58c223c1ca..5442f7d225 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -2093,6 +2093,7 @@ class CookerParser(object):
             def init():
                 signal.signal(signal.SIGTERM, signal.SIG_DFL)
                 signal.signal(signal.SIGHUP, signal.SIG_DFL)
+                signal.signal(signal.SIGINT, signal.SIG_IGN)
                 bb.utils.set_process_name(multiprocessing.current_process().name)
                 multiprocessing.util.Finalize(None, bb.codeparser.parser_cache_save, exitpriority=1)
                 multiprocessing.util.Finalize(None, bb.fetch.fetcher_parse_save, exitpriority=1)
-- 
2.28.0

