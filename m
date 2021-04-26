Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web11.4159.1619425010598401842
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 26 Apr 2021 01:16:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=qToZBcGg;
 spf=pass (domain: konsulko.com, ip: 209.85.221.43, mailfrom: pbarker@konsulko.com)
Received: by mail-wr1-f43.google.com with SMTP id h15so2560037wre.11
        for <bitbake-devel@lists.openembedded.org>; Mon, 26 Apr 2021 01:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yTR0+VX/BR3jSdHRwvOdL/qmiDuAApFTdijafvHV4zw=;
        b=qToZBcGg7vYSku8QUExPwns8eDrAS70SsVrv9Etp874u/xSGQ5CCLJVrGzFjcuZWey
         m93wJoE8KD4416VrL0zCOQEc199u3pADNz5XFWaJtyQctzX+Lcfxt3MAo3eR2zAyDpnG
         jn/mIpdFZ5r8QfV+7Y13PERYZ5UymI1SjO6Jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yTR0+VX/BR3jSdHRwvOdL/qmiDuAApFTdijafvHV4zw=;
        b=dn/bjJzsaLfp50tabLdsfvcdjfILCj1rc1E8/UH7EAQZygP5byk3v+GDHB7nAPvX82
         mKX6/6nlIsTOUHTotdRixTa0He+y0N/zR3VuSTrn8EoNVKvjmguHcNXu5CgeDLp7qhxN
         Ms92HEvDy5yclJC1nrIYFBj3a6I3qljd7RbChfLahFBpyhKskxOcwQvf63J/V4XsrR7E
         blyY9A/ZJIaWsEqJewQABZB8HhTesAUKhzPp7FS7gke38lhgqjTKG77I2GF5v9Gu+eC7
         2lIq6m2svhf8ksmGGo/HJy6hapky6V2Q3oDrmxutrxz8WlPhFnx8NIk6QHn7nLWXtb26
         X86Q==
X-Gm-Message-State: AOAM532WJI+Bl9xVqFgJGvh7TjK8K93eQIncuqMjgUqdZG89anRua5Bf
	OrV1Y/9kY98Y2I8ZHy9pIb/qtgo3WmRgAQ==
X-Google-Smtp-Source: ABdhPJwMHUb08R3GmtaOir2TzroRNvFiEaD5lS3HpfLIo9oIcx3877n1rRoiwXy3xpL2u61ON1aZfA==
X-Received: by 2002:adf:f3c1:: with SMTP id g1mr21750451wrp.344.1619425008943;
        Mon, 26 Apr 2021 01:16:48 -0700 (PDT)
Return-Path: <pbarker@konsulko.com>
Received: from alpha.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id a9sm4631320wrw.26.2021.04.26.01.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 01:16:48 -0700 (PDT)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [PATCH 5/6] prserv: Drop unused dump_db method
Date: Mon, 26 Apr 2021 09:16:32 +0100
Message-Id: <20210426081633.5020-6-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210426081633.5020-1-pbarker@konsulko.com>
References: <20210426081633.5020-1-pbarker@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 lib/prserv/serv.py | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 1cfbba864..6ccc7ee9e 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -56,7 +56,6 @@ class PRServer(SimpleXMLRPCServer):
         self.register_function(self.quit, "quit")
         self.register_function(self.ping, "ping")
         self.register_function(self.export, "export")
-        self.register_function(self.dump_db, "dump_db")
         self.register_function(self.importone, "importone")
         self.register_introspection_functions()
 
@@ -118,26 +117,6 @@ class PRServer(SimpleXMLRPCServer):
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
 
@@ -335,9 +314,6 @@ class PRServerConnection(object):
     def export(self,version=None, pkgarch=None, checksum=None, colinfo=True):
         return self.connection.export(version, pkgarch, checksum, colinfo)
 
-    def dump_db(self):
-        return self.connection.dump_db()
-
     def importone(self, version, pkgarch, checksum, value):
         return self.connection.importone(version, pkgarch, checksum, value)
 
-- 
2.26.2

