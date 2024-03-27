Return-Path: <rustyhowell@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562A6C47DD9
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 06:43:44 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.web11.31299.1711521823899268532
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 26 Mar 2024 23:43:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=cLb202JD;
 spf=pass (domain: gmail.com, ip: 209.85.214.174, mailfrom: rustyhowell@gmail.com)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e00d1e13a2so40700405ad.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 26 Mar 2024 23:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711521823; x=1712126623; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fq+XEjQbdfWBCmjJQysgVIDAqaYffmlnUc5HIViOb1M=;
        b=cLb202JDzPqAYFQZhTb0t+KqM/P640cj+DYMvh2MhDkam/H3qVgzl74qZGtpspKb7K
         3uCBl68sJJfmKY6c6iobecqxCqVS6xwSl9Qi+pbdy6N8EK+A/A8y6wnMIU0eaS1IjjM1
         bAdGwVB3MpyNX8vaejfFQbr3TSpI/1DA6Py4XZY+62Ru/81Oy+St4oh3TKIiCe78kqFr
         +eNw16C+m5blQcgMrOH6nTiQrvVDP1FrjbJFBhu9jltMOnexsNJ5lLVUCxcC9agFp+HN
         DOZ3mxZKSQLIrgH7GLtghB6QbyxWuYvJEWLoxIQ0KoE+kK2NXo156yItiSTQIUIIyKSi
         AOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711521823; x=1712126623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fq+XEjQbdfWBCmjJQysgVIDAqaYffmlnUc5HIViOb1M=;
        b=JSRSONncXKKlU0qhPOuuPJhBY3dRTSQtUnNqmGfRZkpMW4G5kBOKKo/rJubfKvDvrc
         ch6RBYoekzAo01yFr2YJJOU+iqzLA0hB0soMYnL+OzqA3vZyruUN5S4Sc8PPK9DvLmeV
         g4DjzSRpZEtk0GzXsup4ZRyb/LZ40wfaaKbZI1nUPmAPfyQWrumdmaxGBy/KxbsmIe89
         hsRLhXmWgk2g5nNtmREWtuZJk1GXlFddIH7tTm4qAs94B7hXjo07D3xyg54uRGy8zAJs
         +5D7cdsiCskYlPVwT7FBntpTLa12sSWFVXw+f+GfglXguuSnBnJyr2IkYxksS786WuRH
         ZcWA==
X-Gm-Message-State: AOJu0YwYAzj6YVSgSyD/WGRvsCXmgP4M2uq4Po6sMoAj1NkLSWtQ/rsl
	qoBkxseIRILgBWef5n98G6LrdmhBDVF400tGiVwuThCDhrWK2Qkd1O7wjWaE
X-Google-Smtp-Source: AGHT+IEjZWVYHp8oksV2KH7m1X6FiSluVIH6P6bHlch8pkwwyWOc4JPrELEOyNzFLLl/nL21yvoweg==
X-Received: by 2002:a17:903:1d1:b0:1e0:e6b4:76ab with SMTP id e17-20020a17090301d100b001e0e6b476abmr2556271plh.0.1711521822963;
        Tue, 26 Mar 2024 23:43:42 -0700 (PDT)
Received: from sirius.wirepathsystems.local ([2605:a601:a937:b200:4692:7e25:dd73:b0b])
        by smtp.gmail.com with ESMTPSA id d15-20020a170902cecf00b001defd404efdsm5502747plg.13.2024.03.26.23.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 23:43:42 -0700 (PDT)
From: Rusty Howell <rustyhowell@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Rusty Howell <rustyhowell@gmail.com>
Subject: [PATCH] bitbake: bitbake-prserv: add nodaemon option
Date: Wed, 27 Mar 2024 00:43:32 -0600
Message-Id: <20240327064332.3381069-1-rustyhowell@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 27 Mar 2024 06:43:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16016

Add a --nodaemon option to the prserver so it stays in the foreground
and does not fork and exit.

There are several reasons why one would prefer to run the prserver in the
foreground and not as a daemon.  Systemd documentation indicates that non-forking
processes are preferred over forking/daemonized ones. Other use cases include
running the prserver in a docker container and put in a k8s cluster.

Signed-off-by: Rusty Howell <rustyhowell@gmail.com>
---
 bin/bitbake-prserv |  4 ++++
 lib/prserv/serv.py | 16 ++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/bin/bitbake-prserv b/bin/bitbake-prserv
index 5be42f3c..0d755fcb 100755
--- a/bin/bitbake-prserv
+++ b/bin/bitbake-prserv
@@ -32,6 +32,8 @@ def main():
                       dest="logfile", type="string", default="prserv.log")
     parser.add_option("--loglevel", help="logging level, i.e. CRITICAL, ERROR, WARNING, INFO, DEBUG",
                       action = "store", type="string", dest="loglevel", default = "INFO")
+    parser.add_option("--nodaemon", help="Run prserver in foreground",
+                      action="store_true", dest="nodaemon")
     parser.add_option("--start", help="start daemon",
                       action="store_true", dest="start")
     parser.add_option("--stop", help="stop daemon",
@@ -50,6 +52,8 @@ def main():
         ret=prserv.serv.start_daemon(options.dbfile, options.host, options.port,os.path.abspath(options.logfile), options.read_only)
     elif options.stop:
         ret=prserv.serv.stop_daemon(options.host, options.port)
+    elif options.nodaemon:
+        ret=prserv.serv.start_nodaemon(options.dbfile, options.host, options.port, options.read_only)
     else:
         ret=parser.print_help()
     return ret
diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 5fc8863f..111e6e9f 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -207,6 +207,22 @@ def run_as_daemon(func, pidfile, logfile):
     os.remove(pidfile)
     os._exit(0)
 
+
+def start_nodaemon(dbfile, host, port, read_only=False):
+    ip = socket.gethostbyname(host)
+    dbfile = os.path.abspath(dbfile)
+    # Ensure logging makes it to the logfile
+    streamhandler = logging.StreamHandler()
+    streamhandler.setLevel(logging.DEBUG)
+    formatter = bb.msg.BBLogFormatter("%(levelname)s: %(message)s")
+    streamhandler.setFormatter(formatter)
+    logger.addHandler(streamhandler)
+
+    server = PRServer(dbfile, read_only=read_only)
+    server.start_tcp_server(ip, port)
+    server.serve_forever()
+
+
 def start_daemon(dbfile, host, port, logfile, read_only=False):
     ip = socket.gethostbyname(host)
     pidfile = PIDPREFIX % (ip, port)
-- 
2.25.1


