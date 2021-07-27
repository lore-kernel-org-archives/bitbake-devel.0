Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
 by mx.groups.io with SMTP id smtpd.web11.6312.1627353492512930841
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 26 Jul 2021 19:38:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=fJGh1lB+;
 spf=pass (domain: konsulko.com, ip: 209.85.160.169, mailfrom: scott.murray@konsulko.com)
Received: by mail-qt1-f169.google.com with SMTP id a12so8586594qtb.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 26 Jul 2021 19:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IcvEMjVA6P8hf560iStmajaDqQocZnyiTE356RxYcuw=;
        b=fJGh1lB+Nr7Lao5FTjG0nABtMZLMaCqeRg3+m82UN2EU8Hb6MvP9soEwJf4kUlbq7R
         9pvOc22HBkrSSYXNpUJUBSW8ABPN/bF+23Ih7cTnvtHu7gIIPPYBcv0pyhOIZsoH/woo
         q/fl8KYrW8mjQJhHx3G061VmrVp+YEjR30698=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IcvEMjVA6P8hf560iStmajaDqQocZnyiTE356RxYcuw=;
        b=r8JS+Y/qPHSeY8P8Ubhnyu/tUcgowV+iex81HobU6qjcXhttCoNcVze7TNI83kASBY
         KFVItGVUdvYfVo3SxMN34v9Ln/Qu+wAiiF7mP0mB2F41sTNIV+9u01UYLAvB+t2hQuKI
         qPwc52D+/Vi9qvAmvfqEm4qm4pGx4azjaB81T3UoCW4L5PxPBoExKnSl3/RcCeD2sJJF
         vzH5m7XScTzbq6UBi4ykR2u0JHJNX61QDjMvY2Ar5evlxOUCCkzC+JqmwWUdXQPlSINa
         yxynsx+Qain0sAG3u9WN829Nnk/9tkAvsdB5aa/jkG3ZG3dTRQKKlJOX7hCIyCC/HIRK
         sTeA==
X-Gm-Message-State: AOAM530yPBqyVGhT9Gkg06Aa2+vWA/q0BMLeQVI3lcsCXt6BccALdUgm
	UeYLvQ1WDkMAdHGsj3SQIlC4/tywHolwSg==
X-Google-Smtp-Source: ABdhPJwC3p7Lunwy4WrL/nVUyReiP50f4Ou+ANU+7mETCOCp0ybwB4kIFkNAZhW32WNwUCwva8I49w==
X-Received: by 2002:ac8:5210:: with SMTP id r16mr10607428qtn.344.1627353491401;
        Mon, 26 Jul 2021 19:38:11 -0700 (PDT)
Return-Path: <scott.murray@konsulko.com>
Received: from ghidorah.spiteful.org (198-84-179-103.cpe.teksavvy.com. [198.84.179.103])
        by smtp.gmail.com with ESMTPSA id h10sm974887qka.83.2021.07.26.19.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 19:38:10 -0700 (PDT)
From: "Scott Murray" <scott.murray@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Subject: [PATCH v4 5/5] prserv: Add read-only mode
Date: Mon, 26 Jul 2021 22:37:56 -0400
Message-Id: <045f2df3b6499c4a45bd10e729c92b36b34024b9.1627352176.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627352176.git.scott.murray@konsulko.com>
References: <cover.1627352176.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Barker <pbarker@konsulko.com>

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 bin/bitbake-prserv |  4 ++-
 lib/prserv/db.py   | 65 ++++++++++++++++++++++++++++++++++++----------
 lib/prserv/serv.py | 49 ++++++++++++++++++++++------------
 3 files changed, 86 insertions(+), 32 deletions(-)

diff --git a/bin/bitbake-prserv b/bin/bitbake-prserv
index 1e9b6cbc..bef5ef68 100755
--- a/bin/bitbake-prserv
+++ b/bin/bitbake-prserv
@@ -36,12 +36,14 @@ def main():
                       dest="host", type="string", default=PRHOST_DEFAULT)
     parser.add_option("--port", help="port number(default: 8585)", action="store",
                       dest="port", type="int", default=PRPORT_DEFAULT)
+    parser.add_option("-r", "--read-only", help="open database in read-only mode",
+                      action="store_true")
 
     options, args = parser.parse_args(sys.argv)
     prserv.init_logger(os.path.abspath(options.logfile),options.loglevel)
 
     if options.start:
-        ret=prserv.serv.start_daemon(options.dbfile, options.host, options.port,os.path.abspath(options.logfile))
+        ret=prserv.serv.start_daemon(options.dbfile, options.host, options.port,os.path.abspath(options.logfile), options.read_only)
     elif options.stop:
         ret=prserv.serv.stop_daemon(options.host, options.port)
     else:
diff --git a/lib/prserv/db.py b/lib/prserv/db.py
index cb2a2461..2710d4a2 100644
--- a/lib/prserv/db.py
+++ b/lib/prserv/db.py
@@ -30,21 +30,29 @@ if sqlversion[0] < 3 or (sqlversion[0] == 3 and sqlversion[1] < 3):
 #
 
 class PRTable(object):
-    def __init__(self, conn, table, nohist):
+    def __init__(self, conn, table, nohist, read_only):
         self.conn = conn
         self.nohist = nohist
+        self.read_only = read_only
         self.dirty = False
         if nohist:
             self.table = "%s_nohist" % table 
         else:
             self.table = "%s_hist" % table 
 
-        self._execute("CREATE TABLE IF NOT EXISTS %s \
-                    (version TEXT NOT NULL, \
-                    pkgarch TEXT NOT NULL,  \
-                    checksum TEXT NOT NULL, \
-                    value INTEGER, \
-                    PRIMARY KEY (version, pkgarch, checksum));" % self.table)
+        if self.read_only:
+            table_exists = self._execute(
+                        "SELECT count(*) FROM sqlite_master \
+                        WHERE type='table' AND name='%s'" % (self.table))
+            if not table_exists:
+                raise prserv.NotFoundError
+        else:
+            self._execute("CREATE TABLE IF NOT EXISTS %s \
+                        (version TEXT NOT NULL, \
+                        pkgarch TEXT NOT NULL,  \
+                        checksum TEXT NOT NULL, \
+                        value INTEGER, \
+                        PRIMARY KEY (version, pkgarch, checksum));" % self.table)
 
     def _execute(self, *query):
         """Execute a query, waiting to acquire a lock if necessary"""
@@ -59,8 +67,9 @@ class PRTable(object):
                 raise exc
 
     def sync(self):
-        self.conn.commit()
-        self._execute("BEGIN EXCLUSIVE TRANSACTION")
+        if not self.read_only:
+            self.conn.commit()
+            self._execute("BEGIN EXCLUSIVE TRANSACTION")
 
     def sync_if_dirty(self):
         if self.dirty:
@@ -75,6 +84,15 @@ class PRTable(object):
             return row[0]
         else:
             #no value found, try to insert
+            if self.read_only:
+                data = self._execute("SELECT ifnull(max(value)+1,0) FROM %s where version=? AND pkgarch=?;" % (self.table),
+                                   (version, pkgarch))
+                row = data.fetchone()
+                if row is not None:
+                    return row[0]
+                else:
+                    return 0
+
             try:
                 self._execute("INSERT INTO %s VALUES (?, ?, ?, (select ifnull(max(value)+1,0) from %s where version=? AND pkgarch=?));"
                            % (self.table,self.table),
@@ -103,6 +121,15 @@ class PRTable(object):
             return row[0]
         else:
             #no value found, try to insert
+            if self.read_only:
+                data = self._execute("SELECT ifnull(max(value)+1,0) FROM %s where version=? AND pkgarch=?;" % (self.table),
+                                   (version, pkgarch))
+                row = data.fetchone()
+                if row is not None:
+                    return row[0]
+                else:
+                    return 0
+
             try:
                 self._execute("INSERT OR REPLACE INTO %s VALUES (?, ?, ?, (select ifnull(max(value)+1,0) from %s where version=? AND pkgarch=?));"
                                % (self.table,self.table),
@@ -128,6 +155,9 @@ class PRTable(object):
             return self._getValueHist(version, pkgarch, checksum)
 
     def _importHist(self, version, pkgarch, checksum, value):
+        if self.read_only:
+            return None
+
         val = None 
         data = self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=?;" % self.table,
                            (version, pkgarch, checksum))
@@ -152,6 +182,9 @@ class PRTable(object):
         return val
 
     def _importNohist(self, version, pkgarch, checksum, value):
+        if self.read_only:
+            return None
+
         try:
             #try to insert
             self._execute("INSERT INTO %s VALUES (?, ?, ?, ?);"  % (self.table),
@@ -245,19 +278,23 @@ class PRTable(object):
 
 class PRData(object):
     """Object representing the PR database"""
-    def __init__(self, filename, nohist=True):
+    def __init__(self, filename, nohist=True, read_only=False):
         self.filename=os.path.abspath(filename)
         self.nohist=nohist
+        self.read_only = read_only
         #build directory hierarchy
         try:
             os.makedirs(os.path.dirname(self.filename))
         except OSError as e:
             if e.errno != errno.EEXIST:
                 raise e
-        self.connection=sqlite3.connect(self.filename, isolation_level="EXCLUSIVE", check_same_thread = False)
+        uri = "file:%s%s" % (self.filename, "?mode=ro" if self.read_only else "")
+        logger.debug("Opening PRServ database '%s'" % (uri))
+        self.connection=sqlite3.connect(uri, uri=True, isolation_level="EXCLUSIVE", check_same_thread = False)
         self.connection.row_factory=sqlite3.Row
-        self.connection.execute("pragma synchronous = off;")
-        self.connection.execute("PRAGMA journal_mode = MEMORY;")
+        if not self.read_only:
+            self.connection.execute("pragma synchronous = off;")
+            self.connection.execute("PRAGMA journal_mode = MEMORY;")
         self._tables={}
 
     def disconnect(self):
@@ -270,7 +307,7 @@ class PRData(object):
         if tblname in self._tables:
             return self._tables[tblname]
         else:
-            tableobj = self._tables[tblname] = PRTable(self.connection, tblname, self.nohist)
+            tableobj = self._tables[tblname] = PRTable(self.connection, tblname, self.nohist, self.read_only)
             return tableobj
 
     def __delitem__(self, tblname):
diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 2c572e0f..618bd452 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -18,14 +18,16 @@ PIDPREFIX = "/tmp/PRServer_%s_%s.pid"
 singleton = None
 
 class PRServerClient(bb.asyncrpc.AsyncServerConnection):
-    def __init__(self, reader, writer, table):
+    def __init__(self, reader, writer, table, read_only):
         super().__init__(reader, writer, 'PRSERVICE', logger)
         self.handlers.update({
             'get-pr': self.handle_get_pr,
             'import-one': self.handle_import_one,
             'export': self.handle_export,
+            'is-readonly': self.handle_is_readonly,
         })
         self.table = table
+        self.read_only = read_only
 
     def validate_proto_version(self):
         return (self.proto_version == (1, 0))
@@ -56,16 +58,17 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection):
         self.write_message(response)
 
     async def handle_import_one(self, request):
-        version = request['version']
-        pkgarch = request['pkgarch']
-        checksum = request['checksum']
-        value = request['value']
+        response = None
+        if not self.read_only:
+            version = request['version']
+            pkgarch = request['pkgarch']
+            checksum = request['checksum']
+            value = request['value']
+
+            value = self.table.importone(version, pkgarch, checksum, value)
+            if value is not None:
+                response = {'value': value}
 
-        value = self.table.importone(version, pkgarch, checksum, value)
-        if value is not None:
-            response = {'value': value}
-        else:
-            response = None
         self.write_message(response)
 
     async def handle_export(self, request):
@@ -83,20 +86,25 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection):
         response = {'metainfo': metainfo, 'datainfo': datainfo}
         self.write_message(response)
 
+    async def handle_is_readonly(self, request):
+        response = {'readonly': self.read_only}
+        self.write_message(response)
+
 class PRServer(bb.asyncrpc.AsyncServer):
-    def __init__(self, dbfile, loop=None):
+    def __init__(self, dbfile, loop=None, read_only=False):
         super().__init__(logger, loop)
         self.dbfile = dbfile
         self.table = None
+        self.read_only = read_only
 
     def accept_client(self, reader, writer):
-        return PRServerClient(reader, writer, self.table)
+        return PRServerClient(reader, writer, self.table, self.read_only)
 
     def serve_forever(self):
-        self.db = prserv.db.PRData(self.dbfile)
+        self.db = prserv.db.PRData(self.dbfile, read_only=self.read_only)
         self.table = self.db["PRMAIN"]
 
-        logger.debug("Started PRServer with DBfile: %s, Address: %s, PID: %s" %
+        logger.info("Started PRServer with DBfile: %s, Address: %s, PID: %s" %
                      (self.dbfile, self.address, str(os.getpid())))
 
         super().serve_forever()
@@ -149,10 +157,17 @@ class PRAsyncClient(bb.asyncrpc.AsyncClient):
         if response:
             return (response['metainfo'], response['datainfo'])
 
+    async def is_readonly(self):
+        response = await self.send_message(
+            {'is-readonly': {}}
+        )
+        if response:
+            return response['readonly']
+
 class PRClient(bb.asyncrpc.Client):
     def __init__(self):
         super().__init__()
-        self._add_methods('getPR', 'importone', 'export')
+        self._add_methods('getPR', 'importone', 'export', 'is_readonly')
 
     def _get_async_client(self):
         return PRAsyncClient()
@@ -227,7 +242,7 @@ def run_as_daemon(func, pidfile, logfile):
     os.remove(pidfile)
     os._exit(0)
 
-def start_daemon(dbfile, host, port, logfile):
+def start_daemon(dbfile, host, port, logfile, read_only=False):
     ip = socket.gethostbyname(host)
     pidfile = PIDPREFIX % (ip, port)
     try:
@@ -243,7 +258,7 @@ def start_daemon(dbfile, host, port, logfile):
 
     dbfile = os.path.abspath(dbfile)
     def daemon_main():
-        server = PRServer(dbfile)
+        server = PRServer(dbfile, read_only=read_only)
         server.start_tcp_server(host, port)
         server.serve_forever()
 
-- 
2.31.1

