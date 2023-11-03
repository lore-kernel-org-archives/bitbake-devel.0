Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5142FC4708E
	for <webhook@archiver.kernel.org>; Fri,  3 Nov 2023 14:27:06 +0000 (UTC)
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
 by mx.groups.io with SMTP id smtpd.web11.52758.1699021620097002077
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Nov 2023 07:27:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=OFglxfhl;
 spf=pass (domain: gmail.com, ip: 209.85.161.46, mailfrom: jpewhacker@gmail.com)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5820299b99cso1521758eaf.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 03 Nov 2023 07:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699021619; x=1699626419; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LprVoJlqanLaEQ7T60BP3dzic8sVKHsjRF04ubqiA0Q=;
        b=OFglxfhlycss1iM+Tmwf/KoFUMPPsmHb8PLGBWrNziJn00ZFko18dP+SzJ0z1rEHF9
         A4WN0bBXlVT/EHnJ8pKTo0w6diTz0Z2z+TURR64FE62MT7MeoFWWDxEpGO3PETY941Ek
         Ag3MzquoNzJWQXPsbLFsA7n51MezEsUnco6cByQUza1RxBf3RZBAjSmtlyxS8qpmrC6C
         YAJocOyZ/Aj2fmiE36zj64xsZgBGNLtlcpucmKiTG59qkq2E/N+sBEtYpoh/lTrvV96i
         PHU7MNTsbGgPlqiUqDSS+6UxRgyaUsPNikU0i524dY1B/tJ4CpqefHHgRGo+chcxbLP2
         sLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699021619; x=1699626419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LprVoJlqanLaEQ7T60BP3dzic8sVKHsjRF04ubqiA0Q=;
        b=Nfn0uig7JRDOIAgxisGVfI3WKP0QgPHGTH/rVR9RZjeTg0OjPxYJbaWCoi34TQtfsh
         Mn+y4nEmUV3dWhokgwR4QR+Ep4ezBv9YcQvHvw23qDztZEARUS8N8Z4JiLmZKhhVTBS2
         41t+4r+QlBip8d0I8XIyf6LLRXzPFUsE3fNHGmtF33EYtOThSiwZsygUeHM8rZwD7RA7
         oZA/piqUAZWajrpO87i6IlYXbDmFj5/z0QftOgriocQAIZ+iBP3AjEhwPMj36K2xEMtg
         oz40ay23AjXH2QBteMt2ZS6SF3URspnnUbBm0C35VD5OMZ0BAQnPcqHEocLrdc8tzpwc
         JScA==
X-Gm-Message-State: AOJu0YzlJ8piI5NBUCMsjDOhjMTtnQvREklesu55i5fKvCkCbmdT4GzR
	BvoF3q/sAf3vXFi+7j+Y0JZCcBGg+4o=
X-Google-Smtp-Source: AGHT+IG71NGwP6s+hIZk1/S4VqFeDAoNjRh42q6Y/UFIms4hvUizQl9rPtUAZu5KeD8dT2HE4fFFLA==
X-Received: by 2002:a05:6870:ac1f:b0:1f0:3fd5:9d5a with SMTP id kw31-20020a056870ac1f00b001f03fd59d5amr1565087oab.16.1699021618758;
        Fri, 03 Nov 2023 07:26:58 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::2fe0])
        by smtp.gmail.com with ESMTPSA id bb29-20020a056871b21d00b001dcde628a6fsm308272oac.42.2023.11.03.07.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 07:26:57 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v6 06/22] bitbake-hashserv: Allow arguments from environment
Date: Fri,  3 Nov 2023 08:26:24 -0600
Message-Id: <20231103142640.1936827-7-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103142640.1936827-1-JPEWhacker@gmail.com>
References: <20231031172138.3577199-1-JPEWhacker@gmail.com>
 <20231103142640.1936827-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Nov 2023 14:27:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15427

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


