Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF50DC54787
	for <webhook@archiver.kernel.org>; Sun, 18 Feb 2024 23:00:15 +0000 (UTC)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
 by mx.groups.io with SMTP id smtpd.web11.29236.1708297215569659425
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 18 Feb 2024 15:00:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=j87b4voC;
 spf=pass (domain: gmail.com, ip: 209.85.166.174, mailfrom: jpewhacker@gmail.com)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-36519980c04so779085ab.3
        for <bitbake-devel@lists.openembedded.org>; Sun, 18 Feb 2024 15:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708297214; x=1708902014; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGm+CR07IVTaqD5fHQ5Z3Ej7Lcj09MmUmOV6eyrsNLo=;
        b=j87b4voCBzYCjfcyCaqMm/JzJfbhZuTT8dKYYn12SSfmh/3ozXtBQUklyq8c1Ik8aP
         aPeJDVsRHzX9rPVM+TUm9qQ1l54zHHgZLEZcc6gf19/YTJxn7C7VZtez1nJd3eJKqqBJ
         XNjfZ5AhPlfr8SSA7nsAIZe6w3hFivY6bzQmjSmDZg9piGUredtgy9WA5anMig/Kz6Kj
         ugM9KqIQy/Y11GOGTNMtebnpl8wjXiNvsIPOv3dS/zSTfSGCydiVbbb68qpDqqXmt7uh
         E3JtaKQEP7tUM++HceaSKT0d8BhoWTHVMmfXBsUryGg+JlZdMZBJ8LvA9k/vjkDygjNK
         u9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708297214; x=1708902014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IGm+CR07IVTaqD5fHQ5Z3Ej7Lcj09MmUmOV6eyrsNLo=;
        b=vJMMrXcbHB3bq7egHPXD5o3YtTVxwCavt5TN1slbUZCqgAfyaqXafKFEvFk00whX0w
         /Mr5vfD4y7bzX9OVoltiNU9U7jas556ooqA8GdcMdHHLUJlBXBBI1W5lsS6rVT0ac1fp
         BdwIZATC3XN+k0QoKYXfMdtknq4DGyE2Y/iPwBT/KGCctRhI8BhGig8sM7oif+Ry6gZN
         cP9w0olQzdwTzcewwNs1J2G89H/NjU8uBTuUzYxbOsFgggt9n/RbwELgdoVXWdieTHyM
         NfdhEh4lh5EOlG6ewwmS1LBAX6n4z4B04aJ5n6heqtsiVELwLHThKKKW/szrrBKXPm/4
         WzOw==
X-Gm-Message-State: AOJu0YzGv03QbgxcUgsN+0V+n6YTLEeZ2ToNnR3/1UFSRX2lZPVTGTUR
	MrR56mMiV/525zdpjYrZARtfexRotT7vBWd7/qxdFrxQfSXisY44QLloeT6c
X-Google-Smtp-Source: AGHT+IGIzzmU4pzcYUEfejWKrMSATXGTapUNKUuLhthjSay7j4qR2qWbxywV0SN/z6ZLgYiFVwWG/g==
X-Received: by 2002:a92:b748:0:b0:365:d80:e1b2 with SMTP id c8-20020a92b748000000b003650d80e1b2mr7291403ilm.17.1708297213615;
        Sun, 18 Feb 2024 15:00:13 -0800 (PST)
Received: from localhost.localdomain ([2601:282:4300:19e0::44fb])
        by smtp.gmail.com with ESMTPSA id n3-20020a02cc03000000b004712a778fb4sm1214848jap.28.2024.02.18.15.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 15:00:12 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v2 6/8] siggen: Add parallel query API
Date: Sun, 18 Feb 2024 15:59:51 -0700
Message-Id: <20240218225953.2997239-7-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240218225953.2997239-1-JPEWhacker@gmail.com>
References: <20240218200743.2982923-1-JPEWhacker@gmail.com>
 <20240218225953.2997239-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 18 Feb 2024 23:00:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15928

Implements a new API called get_unihashes() that allows for querying
multiple unihashes in parallel.

The API is also reworked to make it easier for derived classes to
interface with the new API in a consistent manner. Instead of overriding
get_unihash() to add custom handling for local hash calculating (e.g.
caches) derived classes should now override get_cached_unihash(), and
return the local unihash or None if there isn't one.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/siggen.py | 121 ++++++++++++++++++++++++++++-----------
 1 file changed, 87 insertions(+), 34 deletions(-)

diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 58854aee76c..e1a4fa2cdd1 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -102,9 +102,18 @@ class SignatureGenerator(object):
             if flag:
                 self.datacaches[mc].stamp_extrainfo[mcfn][t] = flag
 
+    def get_cached_unihash(self, tid):
+        return None
+
     def get_unihash(self, tid):
+        unihash = self.get_cached_unihash(tid)
+        if unihash:
+            return unihash
         return self.taskhash[tid]
 
+    def get_unihashes(self, tids):
+        return {tid: self.get_unihash(tid) for tid in tids}
+
     def prep_taskhash(self, tid, deps, dataCaches):
         return
 
@@ -524,28 +533,37 @@ class SignatureGeneratorUniHashMixIn(object):
         super().__init__(data)
 
     def get_taskdata(self):
-        return (self.server, self.method, self.extramethod) + super().get_taskdata()
+        return (self.server, self.method, self.extramethod, self.max_parallel) + super().get_taskdata()
 
     def set_taskdata(self, data):
-        self.server, self.method, self.extramethod = data[:3]
-        super().set_taskdata(data[3:])
+        self.server, self.method, self.extramethod, self.max_parallel = data[:4]
+        super().set_taskdata(data[4:])
 
     def client(self):
         if getattr(self, '_client', None) is None:
             self._client = hashserv.create_client(self.server)
         return self._client
 
+    def client_pool(self):
+        if getattr(self, '_client_pool', None) is None:
+            self._client_pool = hashserv.client.ClientPool(self.server, self.max_parallel)
+        return self._client_pool
+
     def reset(self, data):
-        if getattr(self, '_client', None) is not None:
-            self._client.close()
-            self._client = None 
+        self.__close_clients()
         return super().reset(data)
 
     def exit(self):
+        self.__close_clients()
+        return super().exit()
+
+    def __close_clients(self):
         if getattr(self, '_client', None) is not None:
             self._client.close()
             self._client = None
-        return super().exit()
+        if getattr(self, '_client_pool', None) is not None:
+            self._client_pool.close()
+            self._client_pool = None
 
     def get_stampfile_hash(self, tid):
         if tid in self.taskhash:
@@ -578,7 +596,7 @@ class SignatureGeneratorUniHashMixIn(object):
             return None
         return unihash
 
-    def get_unihash(self, tid):
+    def get_cached_unihash(self, tid):
         taskhash = self.taskhash[tid]
 
         # If its not a setscene task we can return
@@ -593,40 +611,74 @@ class SignatureGeneratorUniHashMixIn(object):
             self.unihash[tid] = unihash
             return unihash
 
-        # In the absence of being able to discover a unique hash from the
-        # server, make it be equivalent to the taskhash. The unique "hash" only
-        # really needs to be a unique string (not even necessarily a hash), but
-        # making it match the taskhash has a few advantages:
-        #
-        # 1) All of the sstate code that assumes hashes can be the same
-        # 2) It provides maximal compatibility with builders that don't use
-        #    an equivalency server
-        # 3) The value is easy for multiple independent builders to derive the
-        #    same unique hash from the same input. This means that if the
-        #    independent builders find the same taskhash, but it isn't reported
-        #    to the server, there is a better chance that they will agree on
-        #    the unique hash.
-        unihash = taskhash
+        return None
 
-        try:
-            method = self.method
-            if tid in self.extramethod:
-                method = method + self.extramethod[tid]
-            data = self.client().get_unihash(method, self.taskhash[tid])
-            if data:
-                unihash = data
+    def _get_method(self, tid):
+        method = self.method
+        if tid in self.extramethod:
+            method = method + self.extramethod[tid]
+
+        return method
+
+    def get_unihash(self, tid):
+        return self.get_unihashes([tid])[tid]
+
+    def get_unihashes(self, tids):
+        """
+        For a iterable of tids, returns a dictionary that maps each tid to a
+        unihash
+        """
+        result = {}
+        queries = {}
+        query_result = {}
+
+        for tid in tids:
+            unihash = self.get_cached_unihash(tid)
+            if unihash:
+                result[tid] = unihash
+            else:
+                queries[tid] = (self._get_method(tid), self.taskhash[tid])
+
+        if len(queries) == 0:
+            return result
+
+        if self.max_parallel <= 1 or len(queries) <= 1:
+            # No parallelism required. Make the query serially with the single client
+            for tid, args in queries.items():
+                query_result[tid] = self.client().get_unihash(*args)
+        else:
+            query_result = self.client_pool().get_unihashes(queries)
+
+        for tid, unihash in query_result.items():
+            # In the absence of being able to discover a unique hash from the
+            # server, make it be equivalent to the taskhash. The unique "hash" only
+            # really needs to be a unique string (not even necessarily a hash), but
+            # making it match the taskhash has a few advantages:
+            #
+            # 1) All of the sstate code that assumes hashes can be the same
+            # 2) It provides maximal compatibility with builders that don't use
+            #    an equivalency server
+            # 3) The value is easy for multiple independent builders to derive the
+            #    same unique hash from the same input. This means that if the
+            #    independent builders find the same taskhash, but it isn't reported
+            #    to the server, there is a better chance that they will agree on
+            #    the unique hash.
+            taskhash = self.taskhash[tid]
+            if unihash:
                 # A unique hash equal to the taskhash is not very interesting,
                 # so it is reported it at debug level 2. If they differ, that
                 # is much more interesting, so it is reported at debug level 1
                 hashequiv_logger.bbdebug((1, 2)[unihash == taskhash], 'Found unihash %s in place of %s for %s from %s' % (unihash, taskhash, tid, self.server))
             else:
                 hashequiv_logger.debug2('No reported unihash for %s:%s from %s' % (tid, taskhash, self.server))
-        except ConnectionError as e:
-            bb.warn('Error contacting Hash Equivalence Server %s: %s' % (self.server, str(e)))
+                unihash = taskhash
 
-        self.set_unihash(tid, unihash)
-        self.unihash[tid] = unihash
-        return unihash
+
+            self.set_unihash(tid, unihash)
+            self.unihash[tid] = unihash
+            result[tid] = unihash
+
+        return result
 
     def report_unihash(self, path, task, d):
         import importlib
@@ -754,6 +806,7 @@ class SignatureGeneratorTestEquivHash(SignatureGeneratorUniHashMixIn, SignatureG
         super().init_rundepcheck(data)
         self.server = data.getVar('BB_HASHSERVE')
         self.method = "sstate_output_hash"
+        self.max_parallel = 1
 
 def clean_checksum_file_path(file_checksum_tuple):
     f, cs = file_checksum_tuple
-- 
2.34.1


