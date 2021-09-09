Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web12.4937.1631219422349114714
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 09 Sep 2021 13:30:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=JKc8cqhQ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id d6so4312044wrc.11
        for <bitbake-devel@lists.openembedded.org>; Thu, 09 Sep 2021 13:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3HiiCaMMFS8ySpHFWSrQTgdZXT0FDYGRNAsF/KFlCMY=;
        b=JKc8cqhQvPj/DXpr9YZ4kO0KPg3GKa21Yuw1TwTtDOpbZGIdeAk9gl1tHdvE8jQATx
         hlNGokRt+7HnwyoeWtpPYa+8BTY60b7mlA3W2pe7v0Y1+fLS20WeUqvAqi3vldViceW9
         Qs57xpmipw+bZSuW93wKST0YVY13iTNp0dG40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3HiiCaMMFS8ySpHFWSrQTgdZXT0FDYGRNAsF/KFlCMY=;
        b=aB9DFA++fiGHSPI+z5vTkOwqrKoUtWXlQrDSxgT1JOXTdslbEiqqpiEUJ2gtj+lwFn
         KgdncgCOHKjNzgXBtiYudPuIKG16Foxp/bGXb//LR7kvwtvWl2bdk+lNN1QAJ2Ba3U8i
         I/oiewT2Cok6SvyrNbkxcUJod8cas2QLpvRUVCJ6+YQ/o5MYsDYbn+6fBHBnX7s9+upG
         My+HO0vMtKlV/34H7VKTFDpKTUGGsIxW0G8B5BnLKa6irFXbUzzdI+FaS51ytBnSQ5Yc
         EXUrUgrvVe3jLKCfNcGo/2zO+sym2BchdtU4BZoKVRiRPIopLqRqSzOQRliOEnWF4L8R
         Oh9g==
X-Gm-Message-State: AOAM533rUdxN0nQn0Lf9Fs9ratVjPNVD7S8TmEazGvTkUDL3LFTGKwFL
	4wg9ZyoF9iR5v5wUgmMXbZL67C1c3SpWR/Et
X-Google-Smtp-Source: ABdhPJynr1JTkPkghOWDlTiQnnztahZSfsft9U5/ICR+laFByu0tIeDe1k79nCtYfrdVFG3CtzHWJA==
X-Received: by 2002:a05:6000:1379:: with SMTP id q25mr5705417wrz.280.1631219420599;
        Thu, 09 Sep 2021 13:30:20 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:69c:dc1e:bcce:ea45])
        by smtp.gmail.com with ESMTPSA id t64sm2344002wma.48.2021.09.09.13.30.20
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 13:30:20 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/3] parse_py: Drop deprecated function reference
Date: Thu,  9 Sep 2021 21:30:18 +0100
Message-Id: <20210909203019.1231314-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210909203019.1231314-1-richard.purdie@linuxfoundation.org>
References: <20210909203019.1231314-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is now used from bb.parse everywhere so drop this long deprecated reference.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/parse/parse_py/BBHandler.py | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/bb/parse/parse_py/BBHandler.py b/lib/bb/parse/parse_py/BBHandler.py
index 152ef6ab72..ee9bd760ce 100644
--- a/lib/bb/parse/parse_py/BBHandler.py
+++ b/lib/bb/parse/parse_py/BBHandler.py
@@ -19,9 +19,6 @@ from . import ConfHandler
 from .. import resolve_file, ast, logger, ParseError
 from .ConfHandler import include, init
 
-# For compatibility
-bb.deprecate_import(__name__, "bb.parse", ["vars_from_file"])
-
 __func_start_regexp__    = re.compile(r"(((?P<py>python(?=(\s|\()))|(?P<fr>fakeroot(?=\s)))\s*)*(?P<func>[\w\.\-\+\{\}\$:]+)?\s*\(\s*\)\s*{$" )
 __inherit_regexp__       = re.compile(r"inherit\s+(.+)" )
 __export_func_regexp__   = re.compile(r"EXPORT_FUNCTIONS\s+(.+)" )
-- 
2.32.0

