Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AFFC4345F
	for <webhook@archiver.kernel.org>; Tue, 23 Apr 2024 18:26:35 +0000 (UTC)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
 by mx.groups.io with SMTP id smtpd.web11.2698.1713896794177568037
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 23 Apr 2024 11:26:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=PrfPiJFs;
 spf=pass (domain: gmail.com, ip: 209.85.166.45, mailfrom: jpewhacker@gmail.com)
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7dbc33bdf08so86472739f.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 23 Apr 2024 11:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713896792; x=1714501592; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8mYT6QWGf2kT8s4qmQlgbMX1tI2xSVATc9VFNZU8PFA=;
        b=PrfPiJFsXYnhpyexQzhVOFFUvn+l1VOvKLpEWzp7QPvLl5YHx4gW4BZgq110VNC3Hy
         i5zQBVncEhHQ7dn/YmcRRmdOfPjQeaBbMwsVQDzXPeAYFBLBX56u/l8vq4ovQDkO9m39
         NwM9/GkXmXKjUKcDTplz1+dysKItl0oQW3xtQzzPqgOty0UiFU+OwCTundqviHSoCwMi
         8sR2f05NXAOEwiHSd5b14DM4JlJIk0ETDCkPS8/wp8is9v6JFelcfWOcYtmLQd2Shezz
         LNSr5fr4xk51XCZaovqmxrL4oX+LWipqVUKsgEzoMAO0JwdOQZhr7CAtNgwE9uICheOO
         wCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713896792; x=1714501592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8mYT6QWGf2kT8s4qmQlgbMX1tI2xSVATc9VFNZU8PFA=;
        b=h7k3JAioPFnteMKBNBkJZxquiZg4IxVWzFZ5OIFM61xK3KWVx6mPqLJ4ORqvwq1GOk
         1U30LW5oHbs7Ag/ZJVCuUV06y8naBQHIUUzvWkWgWDI6PSuByrKYJ+ZdmnaPaJnKpp3z
         56ib5ddSeifP33P1KpPrFuj4RpD0pO2/mPgCct4sG2W4kp5UdTM9jRgMfZWoIrbFqQSK
         CDV5aMgagBYat6QhcGs4o5SwEQvvsc/V5RkdRyEru2Ea2KMbxZ3oh4hcLvoAa9wK8kKh
         I+eaD87UvHDzeiTT0YNMn2QSMLANZKprFjz3ycbmQ4d+/yOGGT1BoFObUaaRoZjkdQSJ
         cX0w==
X-Gm-Message-State: AOJu0YwAYdOF1y6vhfm8I/VEICQal2edA5mUf4QAmK7vaXf7P5NkfC7M
	tTBTATfyqgEPQdeMFhYAopRESdZuW0BsK+unD43FUnGTqbyQYFL+w+DkIQ==
X-Google-Smtp-Source: AGHT+IEgWybTZvnTF0IFfpZ3FFaSbDa4T9QbwRZgzoagazUInJ9ZSc7gtuq9R/bC9CY+ys6qYWwNLA==
X-Received: by 2002:a05:6602:450:b0:7d9:6351:4ef3 with SMTP id e16-20020a056602045000b007d963514ef3mr293683iov.5.1713896792341;
        Tue, 23 Apr 2024 11:26:32 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::d802])
        by smtp.gmail.com with ESMTPSA id ja12-20020a056638888c00b0048569383229sm866097jab.121.2024.04.23.11.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 11:26:31 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: michael.opdenacker@bootlin.com,
	Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][RFC] prserv: Enable database sharing
Date: Tue, 23 Apr 2024 12:25:43 -0600
Message-Id: <20240423182543.226113-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 23 Apr 2024 18:26:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16135

sqlite3 can allow multiple processes to access the database
simultaneously, but it must be opened correctly. The key change is that
the database is no longer opened in "exclusive" mode (defaulting to
shared mode). In addition, the journal is set to "WAL" mode, as this is
the most efficient for dealing with simultaneous access between
different processes. In order to keep the database performance,
synchronous mode is set to "off". The WAL journal will protect against
incomplete transactions in any given client, however the database will
not be protected against unexpected power loss from the OS (which is a
fine trade off for performance, and also the same as the previous
implementation).

Finally, the _execute() API now uses a database cursor. The cursor
automatically makes sure that the query happens in an atomic transaction
and commits when finished.

NOTE: THIS MAY BE INCOMPLETE; All APIs need to be evaluated to see if
the transaction (cursor) needs to cover mode than one "execute"
statement.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/prserv/db.py | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/prserv/db.py b/bitbake/lib/prserv/db.py
index b4bda7078cd..e7a2d27e950 100644
--- a/bitbake/lib/prserv/db.py
+++ b/bitbake/lib/prserv/db.py
@@ -292,11 +292,10 @@ class PRData(object):
                 raise e
         uri = "file:%s%s" % (self.filename, "?mode=ro" if self.read_only else "")
         logger.debug("Opening PRServ database '%s'" % (uri))
-        self.connection=sqlite3.connect(uri, uri=True, isolation_level="EXCLUSIVE", check_same_thread = False)
+        self.connection=sqlite3.connect(uri, uri=True)
         self.connection.row_factory=sqlite3.Row
-        if not self.read_only:
-            self.connection.execute("pragma synchronous = off;")
-            self.connection.execute("PRAGMA journal_mode = MEMORY;")
+        self.connection.execute("pragma synchronous = off;")
+        self.connection.execute("PRAGMA journal_mode = WAL;")
         self._tables={}
 
     def disconnect(self):
-- 
2.34.1


