Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web08.17235.1618227725301915181
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Apr 2021 04:42:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=RGKM1/yc;
 spf=pass (domain: konsulko.com, ip: 209.85.221.52, mailfrom: pbarker@konsulko.com)
Received: by mail-wr1-f52.google.com with SMTP id 12so12594091wrz.7
        for <bitbake-devel@lists.openembedded.org>; Mon, 12 Apr 2021 04:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4tPslViiZp19gBnQ2nFRKf0Vz8Q0v9DpuVj/+XJSnuo=;
        b=RGKM1/ycjZikZ2bvDAbCYWWEp92+ifHCLhnjkvB/vm/SFfnnxGU3RQvyJKPXbsvDcd
         l0LdQHmJjKhSTgi3mQgRuOi+Jx/P0VDnuGi9xY9UWS5XfHSj9sLopmNxnnI9Mup/tcsK
         lqkjw3V0nIYjM0ZHZmFScJmz4XNu1sAEnoZzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4tPslViiZp19gBnQ2nFRKf0Vz8Q0v9DpuVj/+XJSnuo=;
        b=PyiQaN5d70dY+2nrsboyFtDEreK/uCTE7u34hneltxbmpkcg7zmZFsZKEViZQ9As8r
         JUz0JCqo9L0WCCSbq9G1aH7ul9qm2X6nIfocxJNtMgQS3kXqxfUUy5xA1ndEbXV+AThJ
         wWdsWBOkmIOLi1EGi5fnCFX4BzPGBWnTZTkAFTqWT0AMVm/wGSUpvEXcuP2RkE1xWjki
         /ZXIJ/2mCy48pQArqsH/YIYKl0udgmm6G6trpLzUwOVsBTpmpatDrE9wjR0IxTuIqVbu
         QQXBBa0uAkpFoZs4X+jEl7bxPob5Wwa3k7UcyjznNY43OD7nQUM70uKEkHangrSW2Mb/
         t83A==
X-Gm-Message-State: AOAM531/D1ODPBufbS0ABECdwU0/qgjcq95+Wic8n9zllwVzXsBZzSlk
	bNPF7yXF0VjITisNawPapQcfyQhje2kyOQ==
X-Google-Smtp-Source: ABdhPJxtRUAdJr1NPps7YcPgRjmeLE33Su8f/9XVSMt1IRr1imjIpnmFKs0trynUxEAWb7VJTWRXcw==
X-Received: by 2002:a5d:58e4:: with SMTP id f4mr29072529wrd.130.1618227723690;
        Mon, 12 Apr 2021 04:42:03 -0700 (PDT)
Return-Path: <pbarker@konsulko.com>
Received: from alpha.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id 3sm17931294wma.45.2021.04.12.04.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:42:03 -0700 (PDT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [RFC PATCH 09/11] prserv: Drop unused methods
Date: Mon, 12 Apr 2021 12:41:47 +0100
Message-Id: <20210412114149.4750-10-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210412114149.4750-1-pbarker@konsulko.com>
References: <20210412114149.4750-1-pbarker@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

* The dump_db method is not used anywhere in the current bitbake or
  openembedded-core code.

* The getinfo request is handled entirely on the client side so the
  server side method isn't needed.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 lib/prserv/serv.py | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 0c61c6bf7..30f30e355 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -50,7 +50,6 @@ class PRServer(SimpleXMLRPCServer):
         self.register_function(self.getPR, "getPR")
         self.register_function(self.ping, "ping")
         self.register_function(self.export, "export")
-        self.register_function(self.dump_db, "dump_db")
         self.register_function(self.importone, "importone")
         self.register_introspection_functions()
 
@@ -97,35 +96,12 @@ class PRServer(SimpleXMLRPCServer):
             logger.error(str(exc))
             return None
 
-    def dump_db(self):
-        """
-        Returns a script (string) that reconstructs the state of the
-        entire database at the time this function is called. The script
-        language is defined by the backing database engine, which is a
-        function of server configuration.
-        Returns None if the database engine does not support dumping to
-        script or if some other error is encountered in processing.
-        """
-        buff = io.StringIO()
-        try:
-            self.table.sync()
-            self.table.dump_db(buff)
-            return buff.getvalue()
-        except Exception as exc:
-            logger.error(str(exc))
-            return None
-        finally:
-            buff.close()
-
     def importone(self, version, pkgarch, checksum, value):
         return self.table.importone(version, pkgarch, checksum, value)
 
     def ping(self):
         return True
 
-    def getinfo(self):
-        return (self.host, self.port)
-
     def getPR(self, version, pkgarch, checksum):
         try:
             return self.table.getValue(version, pkgarch, checksum)
@@ -171,9 +147,6 @@ class PRServerConnection(object):
     def export(self,version=None, pkgarch=None, checksum=None, colinfo=True):
         return self.connection.export(version, pkgarch, checksum, colinfo)
 
-    def dump_db(self):
-        return self.connection.dump_db()
-
     def importone(self, version, pkgarch, checksum, value):
         return self.connection.importone(version, pkgarch, checksum, value)
 
-- 
2.26.2

