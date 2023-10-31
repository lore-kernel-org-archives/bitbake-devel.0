Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BCEC00142
	for <webhook@archiver.kernel.org>; Tue, 31 Oct 2023 17:22:02 +0000 (UTC)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
 by mx.groups.io with SMTP id smtpd.web10.1612.1698772919474724350
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Oct 2023 10:21:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=iWDCWpeS;
 spf=pass (domain: gmail.com, ip: 209.85.210.44, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6ce353df504so3756647a34.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 10:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698772918; x=1699377718; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LprVoJlqanLaEQ7T60BP3dzic8sVKHsjRF04ubqiA0Q=;
        b=iWDCWpeScdfhGo2/Qh4qpQc3dfWuqHFPK9z/IoFoKEaLU1aCngxIrNSOmgExqnjPvp
         4rg4CAvkB0J69oVpBT0ke7ufKTQ7KNI4nfeR0soyhTsV6xDqdZR5ZBxhjKBErpLHGzg1
         MM1bVbMywshDti9V25sNaKIKxvkzLUgpf2/V/v04APCNVflwv1opIlyV3z5LzY5sriZm
         cxL0g+Jw4+3+zzeF8JIiR2iObTIt13HeYwzdtETpAuFZka5PcFwAAqUgoOHYjNvzICv4
         3jpqe89wLzILrKsqXBIRDRrnHOVaCFVlYlWF5nnHDSi65eIIdlmmMN+n28lglApeJfh/
         d/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698772918; x=1699377718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LprVoJlqanLaEQ7T60BP3dzic8sVKHsjRF04ubqiA0Q=;
        b=C/5Tgyl85JTXIIsNro4oZQU/rnblvZOH8gMRRxBvuYmDCA3EN9qxf9C5/LQHbIL/pG
         e857eQHMfeZBeaaGZU1DPaq7wPpDISSngpdfjqgLn3DCsbAQnZeUXaX2mcLmW/tJooXH
         4YUdvjhEDtLRM6UImqqr0DMnwdwBo91OqAi4mWorxYjQTo228L//eSg4/LjwDYtL/DlF
         u432qk3eCRgbjuNF589FLD6KTdo1ngmehq/U/1v9CvGo5wfwba85ogBZxv5fW1Oi4V5/
         0RID0vXunQbZrutT0eudZcnqg3/Y4rNdY6S8KN9C7z6C7DbdkKbP+HZBZFddw2qm/199
         VsLA==
X-Gm-Message-State: AOJu0YwoVDNgd+lmWtpX5VLeslZocutvKGvzdyDMuupexRSMW0rmPaD9
	pnqZcQrG1p+Rw7oFblsKHXvgJv4310g=
X-Google-Smtp-Source: AGHT+IEvURFaBbCx+6F85ODd1Y+GtRsckngXePB4OPVe4PXSaSoxCmM4pocvufmqMkjWU4W1HXAWVA==
X-Received: by 2002:a05:6830:411d:b0:6bc:a68b:ca44 with SMTP id w29-20020a056830411d00b006bca68bca44mr15359164ott.6.1698772917741;
        Tue, 31 Oct 2023 10:21:57 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id k6-20020a056830150600b006ce2e464a45sm282503otp.29.2023.10.31.10.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:21:56 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v4 06/22] bitbake-hashserv: Allow arguments from environment
Date: Tue, 31 Oct 2023 11:21:22 -0600
Message-Id: <20231031172138.3577199-7-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031172138.3577199-1-JPEWhacker@gmail.com>
References: <20231030191728.1276805-1-JPEWhacker@gmail.com>
 <20231031172138.3577199-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 17:22:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15356

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


