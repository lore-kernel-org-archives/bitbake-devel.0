Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web09.6540.1612524382013814872
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Feb 2021 03:26:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=h4Lq0zDj;
 spf=pass (domain: konsulko.com, ip: 209.85.221.48, mailfrom: pbarker@konsulko.com)
Received: by mail-wr1-f48.google.com with SMTP id g10so7321505wrx.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 05 Feb 2021 03:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/bXkZLyGgfPSgzn2FsLb/tqMbALwLdKdChy+GGNi7AA=;
        b=h4Lq0zDj3A+Jyb49Um5/U60kARJN6wRM+AttdZ0JZISH5AYO/lrsTKvQhX5Elz1lvK
         IkJ5Can7s3ybBDJtnp6QrY8c9douYaJH8iexHjLIJ3O9rRGVmtm3jNESZueJwcwcAhqu
         v7rHicOoigty7ISuRq/aIenwOe1RyN7sagWsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/bXkZLyGgfPSgzn2FsLb/tqMbALwLdKdChy+GGNi7AA=;
        b=fi5Lvb/qY5zVY452wqskizHj55HNBfrlBVx5u1NSoACyB/8zEouPGEdzVS7jZI6LWU
         Intbtwl7FY6kryPSZo4vpKRlrjUBhofUCuQ311avhrEeP5muj6Dd6gZpVZ9BZlN+TWQy
         KyFp5YB/7mj5inpBax5qxo79FxtGZvJgQYFTUTonSmLJSjzIYbg6EdA+EucY4IVxrhW5
         TXJvsqht2gfZEwGp/ObLlzgJpmoTyQyzD7TuEvaH6OUdxfNzVDLurIa0eTFI2PlUTSGK
         Tos2e1XLUGbNegXhYT+jpTSK9g5liEJuWgJ4JGD/CR3iUVmlLZhceCITL7+qsZq/kCE0
         lHkQ==
X-Gm-Message-State: AOAM532lQ4d+NRc9BrmkXVBMmw2vzJ1+MYC+2tuAhM8iIkaYsoUUa7RD
	DblXnYRX0exg8RP061PSG60m0aAYsRAn05Ms
X-Google-Smtp-Source: ABdhPJyqsNEeWtBqBoNOx4z3dyJC9KjO6JDffDVUiADiuoRYXk1rKDF2DaytNF2QOHj6rmbFa0Ko1Q==
X-Received: by 2002:adf:dd92:: with SMTP id x18mr4623924wrl.4.1612524380457;
        Fri, 05 Feb 2021 03:26:20 -0800 (PST)
Return-Path: <pbarker@konsulko.com>
Received: from tortoise.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id y18sm11881716wrt.19.2021.02.05.03.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 03:26:19 -0800 (PST)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [PATCH v2 5/8] hashserv: Support upstream command line argument
Date: Fri,  5 Feb 2021 11:26:08 +0000
Message-Id: <20210205112611.17167-6-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210205112611.17167-1-pbarker@konsulko.com>
References: <20210205112611.17167-1-pbarker@konsulko.com>
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

