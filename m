Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EF3C0018A
	for <webhook@archiver.kernel.org>; Wed,  1 Nov 2023 15:42:37 +0000 (UTC)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
 by mx.groups.io with SMTP id smtpd.web10.10801.1698853351468416342
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Nov 2023 08:42:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=h62H6w6z;
 spf=pass (domain: gmail.com, ip: 209.85.167.174, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3b566ee5f1dso1108046b6e.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 01 Nov 2023 08:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698853349; x=1699458149; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LprVoJlqanLaEQ7T60BP3dzic8sVKHsjRF04ubqiA0Q=;
        b=h62H6w6zO3d6X+VKVrinzepcWPHp0H2kB4oWCLMxjX9bUfcu1utNPmWXApzCvdQFLG
         z6zo5dwN97p+pN7fWN1UUv4suTugijiB2oUJsrIQH6nD7hoExhALhAp48BeKyNpvRnNN
         loAEbyZJdTggZYzGtTyBxRGJs4vyPnBL8HHGzvCv/q0hYI6iQ4GoNdAkRRW7oC5rSzZW
         xEbYzVVRZfY8ue+RKQrtcT+8on7kLp4q5VGrYmIJsHUBAQ1YNak6udroM1SjtJdW3PLi
         cVby/NthIAUTtWqclDp4i65PX7oGzT5CKfm/BHobwGyHcxWjDkapV80eK4WAc+GWSxzW
         AM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698853349; x=1699458149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LprVoJlqanLaEQ7T60BP3dzic8sVKHsjRF04ubqiA0Q=;
        b=w/0z9BD3CSLgjySQyTrPJu4nvHKzuQefiX/5m9PqX8NKo8Z8oAK6LB0HvtuNOAhVHT
         Cv2uL1weMN+uZLaDde7FjODxxtOJNXefME1bqR7yKoxq0COCEUJ3jM2qvlbZGhaXRxPj
         h39U0Jq5Kf4qECcZrJRaQ4+wnlqofbXadqAO9jKFzfoi0gWHVtgDXOH+exe7Suvu8NBJ
         3PK932UJ1hFzjfCIKOrHxQQG37HuVpXp/fmR0uX4pQ389O/jcGEypiVpg/Zu8/drMrGt
         CFwUXGnlzZFq2UhcmrW2KeqJNB/FIgXYTFDIOMp0aJthE/kgoUAeJJSk0kBnvUEfpO5r
         htbw==
X-Gm-Message-State: AOJu0Yz1hbvLDgfVWM5RMG36Z6ydRC5z5kI+7+UCmA60IRAAsNN5fAH4
	ElyFvafoyy4iIdRW+tkp7Ie2MOw2d9c=
X-Google-Smtp-Source: AGHT+IEb6FRQdGr8Ni58j1vM6lIIjeBOf/YrbtYJrWEEx+qGyMdyfdnaQT/Y5PYR1hMPQhewaZ8hgw==
X-Received: by 2002:a05:6808:1290:b0:3a8:43d5:878b with SMTP id a16-20020a056808129000b003a843d5878bmr19364567oiw.2.1698853349656;
        Wed, 01 Nov 2023 08:42:29 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id l9-20020aca1909000000b003ae36d664a9sm249651oii.39.2023.11.01.08.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 08:42:28 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v5 06/22] bitbake-hashserv: Allow arguments from environment
Date: Wed,  1 Nov 2023 09:42:00 -0600
Message-Id: <20231101154216.2758185-7-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101154216.2758185-1-JPEWhacker@gmail.com>
References: <20231031172138.3577199-1-JPEWhacker@gmail.com>
 <20231101154216.2758185-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Nov 2023 15:42:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15388

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


