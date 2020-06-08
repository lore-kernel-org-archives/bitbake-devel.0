Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
 by mx.groups.io with SMTP id smtpd.web12.488.1591650201578120756
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Jun 2020 14:03:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=RSbHtoQC;
 spf=pass (domain: gmail.com, ip: 209.85.216.45, mailfrom: jpewhacker@gmail.com)
Received: by mail-pj1-f45.google.com with SMTP id m2so371780pjv.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 08 Jun 2020 14:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Fk9EIUCq/2CQ2F7vwXEzlyHHxGqdzGBVW9i+YRRUNg=;
        b=RSbHtoQCKU6qq3lunim+oh+bPZDXqI2/hr1vY8lU1fEyXubIRKEeGOAsFr4HiZG0se
         3xyogkjnM+Of1LP/FkvzyIByuLsOxnxMFHebdMUSDeXx8pDm9TXHDCTYvKdcOUU69bTL
         LhCcGZgwRezLmFdN8bXK5MfGKrFDiFdhO1JtlSqvbfgpnSln1ZQx9vekryN3pPidpFdc
         Op2zacFraIA3lvpL8R/BVJwcEWEvH/eVnnt9QG+Dq/H+sqQ3MhDEagUf3+/G8rTi454O
         WnmzF4nU2wioAwvhhjmqRaRUuzDZ6r/1icH7KkMR95JI5RerTLd++KTn8KUd++Ule0Gl
         OjWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Fk9EIUCq/2CQ2F7vwXEzlyHHxGqdzGBVW9i+YRRUNg=;
        b=A7Esk+OwHKOMCngCqhvepTm60+B+jg9ev2LCNOgWD8/foGvezp2VirYAHc634mvx9G
         Xl/bFCWfWcnc1bokg6OUIIGnrUjQTr6et2OOTUzqpzh0rpqGViGiQC03fkKtSAZWEX/y
         VvPHRnMn1UlpIPm65UN9+lDEQMZYi895Wzzr9VZNOOP83LqI8qCk5luUNsVizmLag05Y
         147vu0sygwlO16LKxUEdX/TsxkqN7PBgLFEo5qEy80NVRHAc59WelrWHpQLV7778sBZK
         lmdyEZX2FRDipQh4KXLCR7FoMQ2MIHf9DTmiQFJutfy8e7p/g3IsF+Liq1Os8+5gf0Jd
         ZYOw==
X-Gm-Message-State: AOAM531B+TZh7jCM9yjJ6YJsSr7YqKRI6RxOwk/jGkm7bxDIGp0dAWWN
	XW9sQkpjfkRYnIJ0IUyWfSmw/TsaJOk=
X-Google-Smtp-Source: ABdhPJzMCPEU6iUwTpTwic4DfI6U1oqg/T0JzD41vg+55YtN+12abhvUz9Hp/cBzPdzeb0hNLrJAeA==
X-Received: by 2002:a17:902:9889:: with SMTP id s9mr473585plp.299.1591650200423;
        Mon, 08 Jun 2020 14:03:20 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:90db:6d3d:5f9f:7f1d])
        by smtp.gmail.com with ESMTPSA id r9sm7799843pfq.31.2020.06.08.14.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 14:03:19 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: richard.purdie@linuxfoundation.org,
	Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] bitbake: cache: Fix error when cache is rebuilt
Date: Mon,  8 Jun 2020 16:03:10 -0500
Message-Id: <20200608210310.13756-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is expected that load_cachfile() returns an integer indicating how
many entries were loaded from the cache. In the event the cache needs to
be rebuilt, 0 must be returned to prevent python from attempting to add
an None and an integer together.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/cache.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index df78d5b701..be5ea6a8bd 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -464,14 +464,14 @@ class Cache(NoCache):
                     bitbake_ver = pickled.load()
                 except Exception:
                     self.logger.info('Invalid cache, rebuilding...')
-                    return
+                    return 0
 
                 if cache_ver != __cache_version__:
                     self.logger.info('Cache version mismatch, rebuilding...')
-                    return
+                    return 0
                 elif bitbake_ver != bb.__version__:
                     self.logger.info('Bitbake version mismatch, rebuilding...')
-                    return
+                    return 0
 
                 # Load the rest of the cache file
                 current_progress = 0
-- 
2.26.2

