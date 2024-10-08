Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7090BCEF170
	for <webhook@archiver.kernel.org>; Tue,  8 Oct 2024 12:36:41 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web10.8083.1728390993388096386
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 08 Oct 2024 05:36:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=UfsTrWKP;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d372c1942so151487f8f.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 08 Oct 2024 05:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728390991; x=1728995791; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TjO5f4fmaPp+N1T97Q4hzIlEU7bNUAlFufez8ShXk1I=;
        b=UfsTrWKPsghmM0WIVzVc+rNT5ceWeg+1s9yjLQQkg7LtVtLtYHUcWQ8+0KxKNbi95y
         9C3I4Cxdm2ynnUTWj+6015GJ8CipSEqh2IXxi+ep3Raqh04dSlgeRbGWLTFcjdEqN9HU
         FVTwe1Yj854+sIObIvhnv3SJdRtc+HwboqvqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728390991; x=1728995791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TjO5f4fmaPp+N1T97Q4hzIlEU7bNUAlFufez8ShXk1I=;
        b=K+cnK9AH74pUMqMZ9uwmFRPS3GITiYNPf2Fyd3Hu9YyCs7igpYKCn+C0WscK2QcHRm
         YWLFGoLjLtgRYK1MwxwL8UOjp9t82/eAjtmbgyKGD3n/X8Hije6bQ7nfoOqyntnUFlxh
         Rc4wcHqkyhMvoICOdakH70qtA558Mlq36E1CILrrGGgRXhXBTkk7wRpgps+hmFx8yc+6
         igTA+E0Icv747y9svBAnVS/zriTUudFcDDNZMWGhmA77V+UGpr0j9YX0Ru4JDQHY5qTt
         LcBVOtJ/DGExzhKxyj7dc+TIZd0KDzi7GFKnkyHAFKV9ZhUseXVHZ5KmAfwSXdNmfZDS
         +LXg==
X-Gm-Message-State: AOJu0YzfEXKlj6fZ6w4itAh7PEvyAROpa/k4Hk3VEunSKlJKFCFQ8rtB
	O6cv5LrgYipdgkgBXVO9NXEi0gKWb7phwXFff2LB9pYLLn8KE05eyBUctDc089zfPkotLL0k8jf
	l
X-Google-Smtp-Source: AGHT+IFi1rUkO1gJ93zqvkdzpuwQ8FsSlC0NRfV5Ukk8kHJbZU2ZT5mAn3XA/KUj8vzfOv+XDIT09A==
X-Received: by 2002:a5d:69ca:0:b0:37c:d02a:7e41 with SMTP id ffacd0b85a97d-37d0e738969mr8562036f8f.15.1728390991243;
        Tue, 08 Oct 2024 05:36:31 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:3f9a:5ae5:8636:3d57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1691a47esm8019492f8f.28.2024.10.08.05.36.30
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 05:36:30 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 4/8] persist_data: Remove it
Date: Tue,  8 Oct 2024 13:36:23 +0100
Message-ID: <20241008123627.252307-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241008123627.252307-1-richard.purdie@linuxfoundation.org>
References: <20241008123627.252307-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 08 Oct 2024 12:36:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16657

It was never a great solution to persisting data and there are much better
ones now. The last user has been replaced so drop the code and tests.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-selftest         |   1 -
 lib/bb/persist_data.py       | 271 -----------------------------------
 lib/bb/tests/persist_data.py | 129 -----------------
 3 files changed, 401 deletions(-)
 delete mode 100644 lib/bb/persist_data.py
 delete mode 100644 lib/bb/tests/persist_data.py

diff --git a/bin/bitbake-selftest b/bin/bitbake-selftest
index ce901232fe..1b7a783fdc 100755
--- a/bin/bitbake-selftest
+++ b/bin/bitbake-selftest
@@ -28,7 +28,6 @@ tests = ["bb.tests.codeparser",
          "bb.tests.event",
          "bb.tests.fetch",
          "bb.tests.parse",
-         "bb.tests.persist_data",
          "bb.tests.runqueue",
          "bb.tests.siggen",
          "bb.tests.utils",
diff --git a/lib/bb/persist_data.py b/lib/bb/persist_data.py
deleted file mode 100644
index bcca791edf..0000000000
--- a/lib/bb/persist_data.py
+++ /dev/null
@@ -1,271 +0,0 @@
-"""BitBake Persistent Data Store
-
-Used to store data in a central location such that other threads/tasks can
-access them at some future date.  Acts as a convenience wrapper around sqlite,
-currently, providing a key/value store accessed by 'domain'.
-"""
-
-# Copyright (C) 2007        Richard Purdie
-# Copyright (C) 2010        Chris Larson <chris_larson@mentor.com>
-#
-# SPDX-License-Identifier: GPL-2.0-only
-#
-
-import collections
-import collections.abc
-import contextlib
-import functools
-import logging
-import os.path
-import sqlite3
-import sys
-from collections.abc import Mapping
-
-sqlversion = sqlite3.sqlite_version_info
-if sqlversion[0] < 3 or (sqlversion[0] == 3 and sqlversion[1] < 3):
-    raise Exception("sqlite3 version 3.3.0 or later is required.")
-
-
-logger = logging.getLogger("BitBake.PersistData")
-
-@functools.total_ordering
-class SQLTable(collections.abc.MutableMapping):
-    class _Decorators(object):
-        @staticmethod
-        def retry(*, reconnect=True):
-            """
-            Decorator that restarts a function if a database locked sqlite
-            exception occurs. If reconnect is True, the database connection
-            will be closed and reopened each time a failure occurs
-            """
-            def retry_wrapper(f):
-                def wrap_func(self, *args, **kwargs):
-                    # Reconnect if necessary
-                    if self.connection is None and reconnect:
-                        self.reconnect()
-
-                    count = 0
-                    while True:
-                        try:
-                            return f(self, *args, **kwargs)
-                        except sqlite3.OperationalError as exc:
-                            if count < 500 and ('is locked' in str(exc) or 'locking protocol' in str(exc)):
-                                count = count + 1
-                                if reconnect:
-                                    self.reconnect()
-                                continue
-                            raise
-                return wrap_func
-            return retry_wrapper
-
-        @staticmethod
-        def transaction(f):
-            """
-            Decorator that starts a database transaction and creates a database
-            cursor for performing queries. If no exception is thrown, the
-            database results are committed. If an exception occurs, the database
-            is rolled back. In all cases, the cursor is closed after the
-            function ends.
-
-            Note that the cursor is passed as an extra argument to the function
-            after `self` and before any of the normal arguments
-            """
-            def wrap_func(self, *args, **kwargs):
-                # Context manager will COMMIT the database on success,
-                # or ROLLBACK on an exception
-                with self.connection:
-                    # Automatically close the cursor when done
-                    with contextlib.closing(self.connection.cursor()) as cursor:
-                        return f(self, cursor, *args, **kwargs)
-            return wrap_func
-
-    """Object representing a table/domain in the database"""
-    def __init__(self, cachefile, table):
-        self.cachefile = cachefile
-        self.table = table
-
-        self.connection = None
-        self._execute_single("CREATE TABLE IF NOT EXISTS %s(key TEXT PRIMARY KEY NOT NULL, value TEXT);" % table)
-
-    @_Decorators.retry(reconnect=False)
-    @_Decorators.transaction
-    def _setup_database(self, cursor):
-        cursor.execute("pragma synchronous = off;")
-        # Enable WAL and keep the autocheckpoint length small (the default is
-        # usually 1000). Persistent caches are usually read-mostly, so keeping
-        # this short will keep readers running quickly
-        cursor.execute("pragma journal_mode = WAL;")
-        cursor.execute("pragma wal_autocheckpoint = 100;")
-
-    def reconnect(self):
-        if self.connection is not None:
-            self.connection.close()
-        self.connection = sqlite3.connect(self.cachefile, timeout=5)
-        self.connection.text_factory = str
-        self._setup_database()
-
-    @_Decorators.retry()
-    @_Decorators.transaction
-    def _execute_single(self, cursor, *query):
-        """
-        Executes a single query and discards the results. This correctly closes
-        the database cursor when finished
-        """
-        cursor.execute(*query)
-
-    @_Decorators.retry()
-    def _row_iter(self, f, *query):
-        """
-        Helper function that returns a row iterator. Each time __next__ is
-        called on the iterator, the provided function is evaluated to determine
-        the return value
-        """
-        class CursorIter(object):
-            def __init__(self, cursor):
-                self.cursor = cursor
-
-            def __iter__(self):
-                return self
-
-            def __next__(self):
-                row = self.cursor.fetchone()
-                if row is None:
-                    self.cursor.close()
-                    raise StopIteration
-                return f(row)
-
-            def __enter__(self):
-                return self
-
-            def __exit__(self, typ, value, traceback):
-                self.cursor.close()
-                return False
-
-        cursor = self.connection.cursor()
-        try:
-            cursor.execute(*query)
-            return CursorIter(cursor)
-        except:
-            cursor.close()
-
-    def __enter__(self):
-        self.connection.__enter__()
-        return self
-
-    def __exit__(self, *excinfo):
-        self.connection.__exit__(*excinfo)
-
-    @_Decorators.retry()
-    @_Decorators.transaction
-    def __getitem__(self, cursor, key):
-        cursor.execute("SELECT * from %s where key=?;" % self.table, [key])
-        row = cursor.fetchone()
-        if row is not None:
-            return row[1]
-        raise KeyError(key)
-
-    @_Decorators.retry()
-    @_Decorators.transaction
-    def __delitem__(self, cursor, key):
-        if key not in self:
-            raise KeyError(key)
-        cursor.execute("DELETE from %s where key=?;" % self.table, [key])
-
-    @_Decorators.retry()
-    @_Decorators.transaction
-    def __setitem__(self, cursor, key, value):
-        if not isinstance(key, str):
-            raise TypeError('Only string keys are supported')
-        elif not isinstance(value, str):
-            raise TypeError('Only string values are supported')
-
-        # Ensure the entire transaction (including SELECT) executes under write lock
-        cursor.execute("BEGIN EXCLUSIVE")
-
-        cursor.execute("SELECT * from %s where key=?;" % self.table, [key])
-        row = cursor.fetchone()
-        if row is not None:
-            cursor.execute("UPDATE %s SET value=? WHERE key=?;" % self.table, [value, key])
-        else:
-            cursor.execute("INSERT into %s(key, value) values (?, ?);" % self.table, [key, value])
-
-    @_Decorators.retry()
-    @_Decorators.transaction
-    def __contains__(self, cursor, key):
-        cursor.execute('SELECT * from %s where key=?;' % self.table, [key])
-        return cursor.fetchone() is not None
-
-    @_Decorators.retry()
-    @_Decorators.transaction
-    def __len__(self, cursor):
-        cursor.execute("SELECT COUNT(key) FROM %s;" % self.table)
-        row = cursor.fetchone()
-        if row is not None:
-            return row[0]
-
-    def __iter__(self):
-        return self._row_iter(lambda row: row[0], "SELECT key from %s;" % self.table)
-
-    def __lt__(self, other):
-        if not isinstance(other, Mapping):
-            raise NotImplementedError()
-
-        return len(self) < len(other)
-
-    def get_by_pattern(self, pattern):
-        return self._row_iter(lambda row: row[1], "SELECT * FROM %s WHERE key LIKE ?;" %
-                              self.table, [pattern])
-
-    def values(self):
-        return list(self.itervalues())
-
-    def itervalues(self):
-        return self._row_iter(lambda row: row[0], "SELECT value FROM %s;" %
-                              self.table)
-
-    def items(self):
-        return list(self.iteritems())
-
-    def iteritems(self):
-        return self._row_iter(lambda row: (row[0], row[1]), "SELECT * FROM %s;" %
-                              self.table)
-
-    @_Decorators.retry()
-    @_Decorators.transaction
-    def clear(self, cursor):
-        cursor.execute("DELETE FROM %s;" % self.table)
-
-    def has_key(self, key):
-        return key in self
-
-def persist(domain, d):
-    """Convenience factory for SQLTable objects based upon metadata"""
-    import bb.utils
-    cachedir = (d.getVar("PERSISTENT_DIR") or
-                d.getVar("CACHE"))
-    if not cachedir:
-        logger.critical("Please set the 'PERSISTENT_DIR' or 'CACHE' variable")
-        sys.exit(1)
-
-    bb.utils.mkdirhier(cachedir)
-    cachefile = os.path.join(cachedir, "bb_persist_data.sqlite3")
-
-    try:
-        return SQLTable(cachefile, domain)
-    except sqlite3.OperationalError:
-        # Sqlite fails to open database when its path is too long.
-        # After testing, 504 is the biggest path length that can be opened by
-        # sqlite.
-        # Note: This code is called before sanity.bbclass and its path length
-        # check
-        max_len = 504
-        if len(cachefile) > max_len:
-            logger.critical("The path of the cache file is too long "
-                    "({0} chars > {1}) to be opened by sqlite! "
-                    "Your cache file is \"{2}\"".format(
-                        len(cachefile),
-                        max_len,
-                        cachefile))
-            sys.exit(1)
-        else:
-            raise
diff --git a/lib/bb/tests/persist_data.py b/lib/bb/tests/persist_data.py
deleted file mode 100644
index f641b5acbc..0000000000
--- a/lib/bb/tests/persist_data.py
+++ /dev/null
@@ -1,129 +0,0 @@
-#
-# BitBake Test for lib/bb/persist_data/
-#
-# Copyright (C) 2018 Garmin Ltd.
-#
-# SPDX-License-Identifier: GPL-2.0-only
-#
-
-import unittest
-import bb.data
-import bb.persist_data
-import tempfile
-import threading
-
-class PersistDataTest(unittest.TestCase):
-    def _create_data(self):
-        return bb.persist_data.persist('TEST_PERSIST_DATA', self.d)
-
-    def setUp(self):
-        self.d = bb.data.init()
-        self.tempdir = tempfile.TemporaryDirectory()
-        self.d['PERSISTENT_DIR'] = self.tempdir.name
-        self.data = self._create_data()
-        self.items = {
-                'A1': '1',
-                'B1': '2',
-                'C2': '3'
-                }
-        self.stress_count = 10000
-        self.thread_count = 5
-
-        for k,v in self.items.items():
-            self.data[k] = v
-
-    def tearDown(self):
-        self.tempdir.cleanup()
-
-    def _iter_helper(self, seen, iterator):
-        with iter(iterator):
-            for v in iterator:
-                self.assertTrue(v in seen)
-                seen.remove(v)
-        self.assertEqual(len(seen), 0, '%s not seen' % seen)
-
-    def test_get(self):
-        for k, v in self.items.items():
-            self.assertEqual(self.data[k], v)
-
-        self.assertIsNone(self.data.get('D'))
-        with self.assertRaises(KeyError):
-            self.data['D']
-
-    def test_set(self):
-        for k, v in self.items.items():
-            self.data[k] += '-foo'
-
-        for k, v in self.items.items():
-            self.assertEqual(self.data[k], v + '-foo')
-
-    def test_delete(self):
-        self.data['D'] = '4'
-        self.assertEqual(self.data['D'], '4')
-        del self.data['D']
-        self.assertIsNone(self.data.get('D'))
-        with self.assertRaises(KeyError):
-            self.data['D']
-
-    def test_contains(self):
-        for k in self.items:
-            self.assertTrue(k in self.data)
-            self.assertTrue(self.data.has_key(k))
-        self.assertFalse('NotFound' in self.data)
-        self.assertFalse(self.data.has_key('NotFound'))
-
-    def test_len(self):
-        self.assertEqual(len(self.data), len(self.items))
-
-    def test_iter(self):
-        self._iter_helper(set(self.items.keys()), self.data)
-
-    def test_itervalues(self):
-        self._iter_helper(set(self.items.values()), self.data.itervalues())
-
-    def test_iteritems(self):
-        self._iter_helper(set(self.items.items()), self.data.iteritems())
-
-    def test_get_by_pattern(self):
-        self._iter_helper({'1', '2'}, self.data.get_by_pattern('_1'))
-
-    def _stress_read(self, data):
-        for i in range(self.stress_count):
-            for k in self.items:
-                data[k]
-
-    def _stress_write(self, data):
-        for i in range(self.stress_count):
-            for k, v in self.items.items():
-                data[k] = v + str(i)
-
-    def _validate_stress(self):
-        for k, v in self.items.items():
-            self.assertEqual(self.data[k], v + str(self.stress_count - 1))
-
-    def test_stress(self):
-        self._stress_read(self.data)
-        self._stress_write(self.data)
-        self._validate_stress()
-
-    def test_stress_threads(self):
-        def read_thread():
-            data = self._create_data()
-            self._stress_read(data)
-
-        def write_thread():
-            data = self._create_data()
-            self._stress_write(data)
-
-        threads = []
-        for i in range(self.thread_count):
-            threads.append(threading.Thread(target=read_thread))
-            threads.append(threading.Thread(target=write_thread))
-
-        for t in threads:
-            t.start()
-        self._stress_read(self.data)
-        for t in threads:
-            t.join()
-        self._validate_stress()
-

