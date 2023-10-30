Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6D0C4332F
	for <webhook@archiver.kernel.org>; Mon, 30 Oct 2023 19:18:03 +0000 (UTC)
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
 by mx.groups.io with SMTP id smtpd.web11.158492.1698693482277984525
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Oct 2023 12:18:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=NkQQ1GNZ;
 spf=pass (domain: gmail.com, ip: 209.85.160.43, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1eb39505ba4so3226671fac.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 12:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698693481; x=1699298281; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LprVoJlqanLaEQ7T60BP3dzic8sVKHsjRF04ubqiA0Q=;
        b=NkQQ1GNZ3af2j9TMqfD5ps/cqn02RjPd2N8/uhktSYoQy3GsB2cGoiu9RurxVwiyEm
         kwR/9v8+0oFs8mLDrLTY9Hdf/ovEiWoatuSS4tacjq2I2IfG9f2vYrXPZJNx/ka18iJu
         eXXL1HNUbdxRf2Gr3kWVYkGjqPCwP87rxzCU12tE5n+ZycG3X5xBqlU2i7fqsdtzg1Bk
         4yin8FJae55KikTBcrncO5qerb2/P2ZdF/M1x9znx78DPj3hUeaBDvjU6CacvD8FoefS
         elmyFsJS2N2ivCNQqtEgTp+gC7oEr6JhWJIT65tG2SykB0zhM5kAlnkQ/fuhVIpSEX1u
         TdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698693481; x=1699298281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LprVoJlqanLaEQ7T60BP3dzic8sVKHsjRF04ubqiA0Q=;
        b=emy0lD1U2cOtYRu+f0BfidXYLtzF75HLETT09mEWDWEvjGBmzbLcyHq4+BDSFla67h
         I6RDvaueDdYwKfHZJA7yHrZLuW5vIxh/Jvf+BEbPOIIoPaa9BiqR05rVGxXmaO/H/fBa
         K/TkcLgZjgfKtyS66aCUHnPZOapoYc2UXoHKw8sWQ2plfcEn+IFLeM61pF5FIjwnOScy
         cHOledlsOckdhoHwGJD5jipRApD33DYu5foDGy/TXJoeCH+CKOEwuEeePAeKs+tMu6xc
         yxJt/27qiBNAgVTxUiFjy5q0FdXwqG1Bk1ICD15pP+zwstSs1kj1CJSel9SXpD5TIFFI
         AHCw==
X-Gm-Message-State: AOJu0YyVy6+uTP6G6faQ/T+MD8redmSils9omsOIS9hJCUmly/9CJCwD
	sUR+zqlm0wuSqZijrwWijWU9qQ2dOXA=
X-Google-Smtp-Source: AGHT+IE/6zczTwjcdiOUvK8O0OD5ihj0n5tpS4dEYXHwPvM/tx85TEMYmZ7T4K8gsKiEBbFVDJRm4w==
X-Received: by 2002:a05:6871:800c:b0:1d6:439d:d04e with SMTP id sk12-20020a056871800c00b001d6439dd04emr11661334oab.53.1698693480946;
        Mon, 30 Oct 2023 12:18:00 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id l38-20020a0568302b2600b006cd099bb052sm1510500otv.1.2023.10.30.12.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 12:18:00 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v3 06/22] bitbake-hashserv: Allow arguments from environment
Date: Mon, 30 Oct 2023 13:17:12 -0600
Message-Id: <20231030191728.1276805-7-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030191728.1276805-1-JPEWhacker@gmail.com>
References: <20231012221655.632637-1-JPEWhacker@gmail.com>
 <20231030191728.1276805-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 19:18:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15308

Allows the arguments to the bitbake-hashserv command to be specified in
environment variables. This is a very common idiom when running services
in containers as it allows the arguments to be specified from different
sources as desired by the service administrator

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bin/bitbake-hashserv | 80 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 60 insertions(+), 20 deletions(-)

diff --git a/bin/bitbake-hashserv b/bin/bitbake-hashserv
index 00af76b2..a916a90c 100755
--- a/bin/bitbake-hashserv
+++ b/bin/bitbake-hashserv
@@ -11,56 +11,96 @@ import logging
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
+        formatter_class=argparse.RawTextHelpFormatter,
+        epilog="""
+The bind address may take one of the following formats:
+    unix://PATH         - Bind to unix domain socket at PATH
+    ws://ADDRESS:PORT   - Bind to websocket on ADDRESS:PORT
+    ADDRESS:PORT        - Bind to raw TCP socket on ADDRESS:PORT
+
+To bind to all addresses, leave the ADDRESS empty, e.g. "--bind :8686" or
+"--bind ws://:8686". To bind to a specific IPv6 address, enclose the address in
+"[]", e.g. "--bind [::1]:8686" or "--bind ws://[::1]:8686"
+        """,
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


