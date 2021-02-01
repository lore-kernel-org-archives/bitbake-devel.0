Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web08.32676.1612180420937401573
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Feb 2021 03:53:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=D+1AAHuM;
 spf=pass (domain: konsulko.com, ip: 209.85.221.50, mailfrom: pbarker@konsulko.com)
Received: by mail-wr1-f50.google.com with SMTP id c12so16251537wrc.7
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Feb 2021 03:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/bXkZLyGgfPSgzn2FsLb/tqMbALwLdKdChy+GGNi7AA=;
        b=D+1AAHuM8QmRGSe6bhXBJZ6n5JlJWEOE0fvdKXKVGM9zzkvnVq+y5YoTIQOpvw5Cnq
         HaWrVKh7mexlDjo5nip23kw2FD3UDvAJBHOibCW9HAidlSKB9HGcIqejfAzu4/CIkz5O
         AbxXlbdCtGR9AsE7Jn3ILWfnOsQtUEKj+gj/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/bXkZLyGgfPSgzn2FsLb/tqMbALwLdKdChy+GGNi7AA=;
        b=Z90iHUsjd2Qy0k2UoY/yRCzH+WVlC3WKJo/t7Z5P9Ntpgz0mEm+YztVjySK2LAgCyz
         9I1j5chR92oYRiuKmfTC8LYY7tZMwEbnM3cCzqOimFin2tJS86Q4b4RNiEGiet/L2swZ
         u05fyIQx9bNZmRMsryScuA5G6DIz8DpWDqGJaecHUkMDrUZq2sU9IiZdeNKQ2Uu8Cv3m
         TJ9bjnGg7fZBSE1QzLwNX0hRavf6HZXKtMtmJ3DtfWk9/nelyLMEQUOTD4biYNMs7CPD
         1KKlU2Zt4bjGLylZ8IEVNKhSlUtE19fth9yABz8AUtdvLSwXYbeJZo/SVnlPWZldYWzX
         wIkg==
X-Gm-Message-State: AOAM531d/WBpURofwC4ZfOUzoPcbapi22AXdaPc/haDlXYCgE6BnsSfy
	zli4n3Iq90FygGfTlvRMcIh0FtTD2Dry1BDW
X-Google-Smtp-Source: ABdhPJyHTpRaqzKqUShEkKpdTCgVC6YpbmEwiJZEMZdHw+3hRQFIxtqmUhDG74f9X30gpH0Acx3+2g==
X-Received: by 2002:a5d:6986:: with SMTP id g6mr17618863wru.263.1612180419352;
        Mon, 01 Feb 2021 03:53:39 -0800 (PST)
Return-Path: <pbarker@konsulko.com>
Received: from tortoise.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id u6sm28120514wro.75.2021.02.01.03.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 03:53:38 -0800 (PST)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [RFC PATCH 5/8] hashserv: Support upstream command line argument
Date: Mon,  1 Feb 2021 11:53:28 +0000
Message-Id: <20210201115331.13510-6-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210201115331.13510-1-pbarker@konsulko.com>
References: <20210201115331.13510-1-pbarker@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hashserv server already implements support for pulling hash data
from another "upstream" server. Add the -u/--upstream argument to the
bitbake-hashserv app to expose this functionality to users.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 bin/bitbake-hashserv | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-hashserv b/bin/bitbake-hashserv
index 2669bbd13..ab71f4e6c 100755
--- a/bin/bitbake-hashserv
+++ b/bin/bitbake-hashserv
@@ -33,6 +33,7 @@ def main():
     parser.add_argument('--bind', default=DEFAULT_BIND, help='Bind address (default "%(default)s")')
     parser.add_argument('--database', default='./hashserv.db', help='Database file (default "%(default)s")')
     parser.add_argument('--log', default='WARNING', help='Set logging level')
+    parser.add_argument('-u', '--upstream', help='Upstream hashserv to pull hashes from')
     parser.add_argument('-r', '--read-only', action='store_true', help='Disallow write operations from clients')
 
     args = parser.parse_args()
@@ -48,7 +49,7 @@ def main():
     console.setLevel(level)
     logger.addHandler(console)
 
-    server = hashserv.create_server(args.bind, args.database, read_only=args.read_only)
+    server = hashserv.create_server(args.bind, args.database, upstream=args.upstream, read_only=args.read_only)
     server.serve_forever()
     return 0
 
-- 
2.26.2

