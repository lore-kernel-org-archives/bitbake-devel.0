Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web09.6541.1612524382952708788
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Feb 2021 03:26:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=avERFt2b;
 spf=pass (domain: konsulko.com, ip: 209.85.221.49, mailfrom: pbarker@konsulko.com)
Received: by mail-wr1-f49.google.com with SMTP id u14so7316015wri.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 05 Feb 2021 03:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1VqSPtjbeqfF4JpYG8hgAAZO1GvEWZLUre6XlG336zc=;
        b=avERFt2b0Y+iaLrOWQ3PN5IoAXOv/JTqYfOgwB2yqAU6qjuZhZcrGCBG/IqDdmtlgB
         yqpBPUxlPv2mCAOZKiN4HzJEMdip1jj9Rsca4Y8gCpQ8lVUCC3oTPNbMtAwmM4Ul1Z0P
         g78NQU4gFUpDxlRWKE7+olvXjGS4O72uQTw+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1VqSPtjbeqfF4JpYG8hgAAZO1GvEWZLUre6XlG336zc=;
        b=RorYWawjzn0vdz2mLnnlyu21d2rInpnPw5rfo0qbdZGzDAQAEXpjD7/LFnubeEdRuQ
         rXQ6HkC9D4Q+PiCuKI+52GgpKDlUab0VBvcqwJn/wUTup7cVbMwEsooe5XvgloC03mzP
         yggsDPDVwK66QkUfalK4ul6WZgIQHdW3dru+ypzfcjti6LXxHxs4FyvzHWKhMxAGD05o
         ZssQQ/WGLe9dTyxek1YbzxzqOAR5InArxFI9knbDxS7YVXbcznkMa+4Lr/Zntd5OZfIo
         NFCQHiXNEuc/cBpNubdfnFtPEcUorzZMt3yOunujmmhxsrCuO8Z9lSTjHilwyFII3kZP
         mVCQ==
X-Gm-Message-State: AOAM533ohjfPF7BKLjr5ffLsis3Id+sHKGgETSsU29LtfbYeqaz5ZBBh
	glOqEI2h2o+vtAOvQwtyj2RDWEc8XFskhch6
X-Google-Smtp-Source: ABdhPJxLirOtN6iEgEP8hXw6z4JUTFlAijO0Fzg1NhzdfBP+wQsKLG5Fb+ozq4I28XJr7LMDku92jQ==
X-Received: by 2002:a05:6000:12c8:: with SMTP id l8mr4415181wrx.81.1612524381357;
        Fri, 05 Feb 2021 03:26:21 -0800 (PST)
Return-Path: <pbarker@konsulko.com>
Received: from tortoise.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id y18sm11881716wrt.19.2021.02.05.03.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 03:26:20 -0800 (PST)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [PATCH v2 6/8] hashserv: Add short forms of remaining command line arguments
Date: Fri,  5 Feb 2021 11:26:09 +0000
Message-Id: <20210205112611.17167-7-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210205112611.17167-1-pbarker@konsulko.com>
References: <20210205112611.17167-1-pbarker@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Short form arguments are added for convenience.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 bin/bitbake-hashserv | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/bin/bitbake-hashserv b/bin/bitbake-hashserv
index ab71f4e6c..153f65a37 100755
--- a/bin/bitbake-hashserv
+++ b/bin/bitbake-hashserv
@@ -30,9 +30,9 @@ def main():
                                                "--bind [::1]:8686"'''
                                      )
 
-    parser.add_argument('--bind', default=DEFAULT_BIND, help='Bind address (default "%(default)s")')
-    parser.add_argument('--database', default='./hashserv.db', help='Database file (default "%(default)s")')
-    parser.add_argument('--log', default='WARNING', help='Set logging level')
+    parser.add_argument('-b', '--bind', default=DEFAULT_BIND, help='Bind address (default "%(default)s")')
+    parser.add_argument('-d', '--database', default='./hashserv.db', help='Database file (default "%(default)s")')
+    parser.add_argument('-l', '--log', default='WARNING', help='Set logging level')
     parser.add_argument('-u', '--upstream', help='Upstream hashserv to pull hashes from')
     parser.add_argument('-r', '--read-only', action='store_true', help='Disallow write operations from clients')
 
-- 
2.26.2

