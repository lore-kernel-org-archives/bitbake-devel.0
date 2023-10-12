Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BFACDB482
	for <webhook@archiver.kernel.org>; Thu, 12 Oct 2023 22:17:15 +0000 (UTC)
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
 by mx.groups.io with SMTP id smtpd.web11.25717.1697149033265816852
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Oct 2023 15:17:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=m+2NXLsj;
 spf=pass (domain: gmail.com, ip: 209.85.160.51, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1e993765c1bso847743fac.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 12 Oct 2023 15:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697149032; x=1697753832; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LprVoJlqanLaEQ7T60BP3dzic8sVKHsjRF04ubqiA0Q=;
        b=m+2NXLsjZjre19avM723bIATobWtypqZUibo/jCT1TmAc7F3k8SX+P71Ld7Q9I93i2
         rcs5IrL+0DWiSBcgDUlULo2PW3AwsvcIJqnAHKA7GgMwjk7pz4PC2283Y0ayIEz3z5eQ
         JVHnmBMMa7pv3jqKhCagPzLzeFovuN5nDSEaWryACwhJLyPN6z+hndwgr/wmMqACWbK6
         yIk0VtWz3uiO+a5QMALnf3Af+HfYOu541klfMes8j+gN5+gLz85l/o5i3h02uv9wKzGa
         mLzb73Nih+C8WsQ+/1J7Cqf4yXE5d0xQnYbK2J5OTbuMCTVejTIaZkgOF5+0GPu9Sop0
         FOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697149032; x=1697753832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LprVoJlqanLaEQ7T60BP3dzic8sVKHsjRF04ubqiA0Q=;
        b=ZBARRmAPupbi+JOSp2Vr76rDYbalF7cIgbkq8NYT8/XpZDK5bauIyZZxA8mwFrnjmt
         +iNLVrqjSTT86MxOt8FjWRFc4GtoyImI77uT02Z/iSy4Nonh2jG+BDQVEzWgNBUJi2cn
         yUwzeI36z0xSx5piVnCYJoWSkjKv2p1vR9BZbhmUxeVl3ksvRSxAwe1vzls7IvNRBZpn
         BTl1kEkDQTe8aChHrPlYz0x3j+qRjHNo/Fr/RuvxU4nDcAbyOuib2hrZOdAZbqoN8qKI
         UJIrMfKVuV75pY0U7/6AkhA7Rlfsw9hCnQuGE6s6P5Jrq4a8f8X3eTJ7GFCug+EfcedF
         a6Aw==
X-Gm-Message-State: AOJu0YyfdzpJYcTeHs+7um5ZVSBQUBGMEfi/w3Pt+No/7ZPah5fMKfkH
	FnRw9cwkl19cerHHEuIi3nM5d2dAt0g=
X-Google-Smtp-Source: AGHT+IEuS3PPwZflD0L1tENXFDjn8JSYWwIMNMrTMJJm1Q1dAzVqFRM/5hItVVu4HNwVwf8nfTeIxA==
X-Received: by 2002:a05:6870:c6a4:b0:1b0:3637:2bbe with SMTP id cv36-20020a056870c6a400b001b036372bbemr31000717oab.54.1697149030374;
        Thu, 12 Oct 2023 15:17:10 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::8282])
        by smtp.gmail.com with ESMTPSA id d22-20020a056870719600b001e195682b2esm524039oah.58.2023.10.12.15.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 15:17:09 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][RFC v2 06/18] bitbake-hashserv: Allow arguments from environment
Date: Thu, 12 Oct 2023 16:16:43 -0600
Message-Id: <20231012221655.632637-7-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012221655.632637-1-JPEWhacker@gmail.com>
References: <20231003145249.1166276-1-JPEWhacker@gmail.com>
 <20231012221655.632637-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Oct 2023 22:17:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15224

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


