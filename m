Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432D5E7AD58
	for <webhook@archiver.kernel.org>; Tue,  3 Oct 2023 14:53:12 +0000 (UTC)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
 by mx.groups.io with SMTP id smtpd.web10.110650.1696344783701301306
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 03 Oct 2023 07:53:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=KOvbOo/d;
 spf=pass (domain: gmail.com, ip: 209.85.210.44, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6c4e30a3604so648849a34.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 03 Oct 2023 07:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696344782; x=1696949582; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t42Q3LzyAB2+w1wzsjUwDz49h7zVohMK3DtJAqm5J14=;
        b=KOvbOo/d5qIUCUYorQv+Pn98xtUSIS/DX+Ohv9aLP4+7ocCB+RDNCj8SGtx/8Joqq8
         4T52fD85UNPKYDZ7p0qoi5jzEavh0Z+ozZhOrkN3dn7IRGQ1Mdq4hnlj6Ae1ZeRvrx0F
         2RqnSQ4GQ37nXTI3QfoOtoWWApy1E64h8eqX3Mkvsq+2m+YOYCZk14dO53Cqih1x2xFi
         rcCCC7dpE2ee/u8VkmXgIsvHnca7hcCmpTZlnDb7FDFXOh956d6XkjvIstriH1+xtrCn
         vF5UXsbWmojxz4fKL41A7JwpP6ANku7Z3B6MuD0SH4j0axCRd1EEfPpcnpJkhihj/Zow
         cOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696344782; x=1696949582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t42Q3LzyAB2+w1wzsjUwDz49h7zVohMK3DtJAqm5J14=;
        b=e9jq5g4/L1076h9PhmAZrSjJ4S+MmgLAceigPCs0nGfSFLUVoV/cWqpcYhdNj4Gvy9
         ITnuucLPFe2NVBrLoqiNJKRjAljoatKRZWqEc0XfGt3OkhOrzz2p/+MlQ8tIRAA0+Hni
         OZFtxTO/f38kltfcEfoXLt4qOBfAC31MGachzANt0NFXcN41vh5wVlHmiLt10Ci54T65
         EAeXqr71FIakjl60J3k4AA3wB38UmDgz05cKspb0Dj33XwONqSTReEyUaQxP2pe/VIfZ
         kyMEQhkM8duMcs7eDV+khFL2hKPPorKO9iFv6STPZhYX02K4XKCGmfOsBTEgr724zw4P
         /CwA==
X-Gm-Message-State: AOJu0YyJm+COk6P3qVbKRtPzvEMSsxWTLB/6m8ByPUisZakBN5s2InUi
	tjBs+OwG7voef8Lxve/CuKQnC7Yw5bA=
X-Google-Smtp-Source: AGHT+IG6Vqfce6NOCzfCdXQof0J6GFk41MULaanjjw0B82DuUHtJGmCqogXjUmzfDzB42TXilGffhg==
X-Received: by 2002:a05:6870:b293:b0:1cc:e169:96bf with SMTP id c19-20020a056870b29300b001cce16996bfmr17337583oao.39.1696344782396;
        Tue, 03 Oct 2023 07:53:02 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::589])
        by smtp.gmail.com with ESMTPSA id du28-20020a0568703a1c00b001dd2b869a26sm253477oab.17.2023.10.03.07.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 07:53:01 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][RFC v2 08/12] bitbake-hashserv: Allow arguments from environment
Date: Tue,  3 Oct 2023 08:52:45 -0600
Message-Id: <20231003145249.1166276-9-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003145249.1166276-1-JPEWhacker@gmail.com>
References: <20230928170551.4193224-1-JPEWhacker@gmail.com>
 <20231003145249.1166276-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 03 Oct 2023 14:53:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15169

Allows the arguments to the bitbake-hashserv command to be specified in
environment variables. This is a very common idiom when running services
in containers as it allows the arguments to be specified from different
sources as desired by the service administrator

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/bin/bitbake-hashserv | 75 ++++++++++++++++++++++++++----------
 1 file changed, 55 insertions(+), 20 deletions(-)

diff --git a/bitbake/bin/bitbake-hashserv b/bitbake/bin/bitbake-hashserv
index 00af76b2d11..b09458b60c4 100755
--- a/bitbake/bin/bitbake-hashserv
+++ b/bitbake/bin/bitbake-hashserv
@@ -11,56 +11,91 @@ import logging
 import argparse
 import sqlite3
 import warnings
+
 warnings.simplefilter("default")
 
-sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(__file__)), 'lib'))
+sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(__file__)), "lib"))
 
 import hashserv
 
 VERSION = "1.0.0"
 
-DEFAULT_BIND = 'unix://./hashserve.sock'
+DEFAULT_BIND = "unix://./hashserve.sock"
 
 
 def main():
-    parser = argparse.ArgumentParser(description='Hash Equivalence Reference Server. Version=%s' % VERSION,
-                                     epilog='''The bind address is the path to a unix domain socket if it is
-                                               prefixed with "unix://". Otherwise, it is an IP address
-                                               and port in form ADDRESS:PORT. To bind to all addresses, leave
-                                               the ADDRESS empty, e.g. "--bind :8686". To bind to a specific
-                                               IPv6 address, enclose the address in "[]", e.g.
-                                               "--bind [::1]:8686"'''
-                                     )
-
-    parser.add_argument('-b', '--bind', default=DEFAULT_BIND, help='Bind address (default "%(default)s")')
-    parser.add_argument('-d', '--database', default='./hashserv.db', help='Database file (default "%(default)s")')
-    parser.add_argument('-l', '--log', default='WARNING', help='Set logging level')
-    parser.add_argument('-u', '--upstream', help='Upstream hashserv to pull hashes from')
-    parser.add_argument('-r', '--read-only', action='store_true', help='Disallow write operations from clients')
+    parser = argparse.ArgumentParser(
+        description="Hash Equivalence Reference Server. Version=%s" % VERSION,
+        epilog='''The bind address is the path to a unix domain socket if it is
+                  prefixed with "unix://". Otherwise, it is an IP address
+                  and port in form ADDRESS:PORT. To bind to all addresses, leave
+                  the ADDRESS empty, e.g. "--bind :8686". To bind to a specific
+                  IPv6 address, enclose the address in "[]", e.g.
+                  "--bind [::1]:8686"''',
+    )
+
+    parser.add_argument(
+        "-b",
+        "--bind",
+        default=os.environ.get("HASHSERVER_BIND", DEFAULT_BIND),
+        help='Bind address (default $HASHSERVER_BIND, "%(default)s")',
+    )
+    parser.add_argument(
+        "-d",
+        "--database",
+        default=os.environ.get("HASHSERVER_DB", "./hashserv.db"),
+        help='Database file (default $HASHSERVER_DB, "%(default)s")',
+    )
+    parser.add_argument(
+        "-l",
+        "--log",
+        default=os.environ.get("HASHSERVER_LOG_LEVEL", "WARNING"),
+        help='Set logging level (default $HASHSERVER_LOG_LEVEL, "%(default)s")',
+    )
+    parser.add_argument(
+        "-u",
+        "--upstream",
+        default=os.environ.get("HASHSERVER_UPSTREAM", None),
+        help="Upstream hashserv to pull hashes from ($HASHSERVER_UPSTREAM)",
+    )
+    parser.add_argument(
+        "-r",
+        "--read-only",
+        action="store_true",
+        help="Disallow write operations from clients ($HASHSERVER_READ_ONLY)",
+    )
 
     args = parser.parse_args()
 
-    logger = logging.getLogger('hashserv')
+    logger = logging.getLogger("hashserv")
 
     level = getattr(logging, args.log.upper(), None)
     if not isinstance(level, int):
-        raise ValueError('Invalid log level: %s' % args.log)
+        raise ValueError("Invalid log level: %s" % args.log)
 
     logger.setLevel(level)
     console = logging.StreamHandler()
     console.setLevel(level)
     logger.addHandler(console)
 
-    server = hashserv.create_server(args.bind, args.database, upstream=args.upstream, read_only=args.read_only)
+    read_only = (os.environ.get("HASHSERVER_READ_ONLY", "0") == "1") or args.read_only
+
+    server = hashserv.create_server(
+        args.bind,
+        args.database,
+        upstream=args.upstream,
+        read_only=read_only,
+    )
     server.serve_forever()
     return 0
 
 
-if __name__ == '__main__':
+if __name__ == "__main__":
     try:
         ret = main()
     except Exception:
         ret = 1
         import traceback
+
         traceback.print_exc()
     sys.exit(ret)
-- 
2.34.1


