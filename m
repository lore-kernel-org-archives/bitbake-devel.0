Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web09.774.1627446581964231030
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Jul 2021 21:29:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mvista-com.20150623.gappssmtp.com header.s=20150623 header.b=VRHVTVoI;
 spf=pass (domain: mvista.com, ip: 209.85.214.176, mailfrom: akuster@mvista.com)
Received: by mail-pl1-f176.google.com with SMTP id a20so1237705plm.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jul 2021 21:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=xMbdsRMPvaaHe7jq5SFrAUSyrVTz2B/EqOcX2jSKdyo=;
        b=VRHVTVoIb1MvjWH8lNcI0x352FwZw4mb6ZWjopHk5BupvA3fWKJeEGhAkoDKX5f3lF
         Uj4b6HeyjKuFI4WTPbunM7DpEy4RVnv96QGcKm3TtYTRyClJlh5jYAoBbcfPk3hGdIc2
         d/4FGbFw/a9Gc6fto8mIAA2Fy8t7QJVtOiKdXkmRz3uFuOh/ry4xmn0MnVUxhw50+nqP
         h2NdTdOoNt/YxPRVyAZJVsnSwOJzz6fBdfsnl3dwP3V+UzNlGYKjLI94XdsBvCFb2gcv
         eY5bSJz38qWA6g7wmrPVZhNcuAQKtMtcn6prf+ZgHnXepc3SbHL9+l5WNRMQw2znJinA
         3Gfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=xMbdsRMPvaaHe7jq5SFrAUSyrVTz2B/EqOcX2jSKdyo=;
        b=qEu3YxxVR0gyVsYMQfQ7GrWws7fnNNY2HFXakonxooPpCHZF7gLQvvymruxjUZsJfM
         uCZ5FYVMNMXHRydn0JJEMTkhkb7oMZ7XYFoygWK5Wv3dkVH+EvRtDiKHQf8F6Ljqn8Tw
         u7guUokiZjAzRK3mNOjwALWYtjqUZEPPKHSUm0/B/oKCkUQXeZPfA7hGC7Ijz35K8vEJ
         dvmk3fZjtHzOPqQx9s7Y99iiZGci8JN+LwsMQaWFXmjBt9FpugoJRdgSww5f3ZtsvHde
         Ly3a0XEMlEpUbr/NMYLP5xsF9t1Xj6B099gsw0Ht4rDScmwYjLDhkqCzq5ik67W8aWfo
         J4Ew==
X-Gm-Message-State: AOAM530WHtpWx3po8pZPuffAw1Uk5ungjcsD9kNjUFNPI8H15gcT7hFF
	7aDW2hvyocWS7Su/ogu6mUbefw==
X-Google-Smtp-Source: ABdhPJxBxl6syk5i9OosoNJ3IQUXJbHAUP4b83h8NJjfuxmIiMPIwcMAZeOBIw9SWqZFJORiVKrOog==
X-Received: by 2002:a17:90b:4acf:: with SMTP id mh15mr26057285pjb.196.1627446581389;
        Tue, 27 Jul 2021 21:29:41 -0700 (PDT)
Return-Path: <akuster@mvista.com>
Received: from ?IPv6:2601:202:4180:a5c0:cbf5:d7b8:4de2:e344? ([2601:202:4180:a5c0:cbf5:d7b8:4de2:e344])
        by smtp.gmail.com with ESMTPSA id c7sm5736756pgq.22.2021.07.27.21.29.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 21:29:40 -0700 (PDT)
Subject: Re: [bitbake-devel] [PATCH v5 5/5] prserv: Add read-only mode
To: Scott Murray <scott.murray@konsulko.com>,
 bitbake-devel@lists.openembedded.org,
 Richard Purdie <richard.purdie@linuxfoundation.org>,
 Joshua Watt <JPEWhacker@gmail.com>, Paul Barker <paul@pbarker.dev>
References: <cover.1627405824.git.scott.murray@konsulko.com>
 <a8a09447a24b2c8918dcfab10faf6f8fcd687d73.1627405824.git.scott.murray@konsulko.com>
From: "Armin Kuster" <akuster@mvista.com>
Message-ID: <de88fb4a-db8d-8227-f550-99877568e358@mvista.com>
Date: Tue, 27 Jul 2021 21:29:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <a8a09447a24b2c8918dcfab10faf6f8fcd687d73.1627405824.git.scott.murray@konsulko.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US

Paul or Scott,

On 7/27/21 10:21 AM, Scott Murray wrote:
> From: Paul Barker <pbarker@konsulko.com>
>
> Signed-off-by: Paul Barker <pbarker@konsulko.com>

Does this address  this open defect?
https://bugzilla.yoctoproject.org/show_bug.cgi?id=13659

- Armin
> ---
>  bin/bitbake-prserv |  4 ++-
>  lib/prserv/db.py   | 65 ++++++++++++++++++++++++++++++++++++----------
>  lib/prserv/serv.py | 49 ++++++++++++++++++++++------------
>  3 files changed, 86 insertions(+), 32 deletions(-)
>
> diff --git a/bin/bitbake-prserv b/bin/bitbake-prserv
> index 1e9b6cbc..bef5ef68 100755
> --- a/bin/bitbake-prserv
> +++ b/bin/bitbake-prserv
> @@ -36,12 +36,14 @@ def main():
>                        dest="host", type="string", default=PRHOST_DEFAULT)
>      parser.add_option("--port", help="port number(default: 8585)", action="store",
>                        dest="port", type="int", default=PRPORT_DEFAULT)
> +    parser.add_option("-r", "--read-only", help="open database in read-only mode",
> +                      action="store_true")
>  
>      options, args = parser.parse_args(sys.argv)
>      prserv.init_logger(os.path.abspath(options.logfile),options.loglevel)
>  
>      if options.start:
> -        ret=prserv.serv.start_daemon(options.dbfile, options.host, options.port,os.path.abspath(options.logfile))
> +        ret=prserv.serv.start_daemon(options.dbfile, options.host, options.port,os.path.abspath(options.logfile), options.read_only)
>      elif options.stop:
>          ret=prserv.serv.stop_daemon(options.host, options.port)
>      else:
> diff --git a/lib/prserv/db.py b/lib/prserv/db.py
> index cb2a2461..2710d4a2 100644
> --- a/lib/prserv/db.py
> +++ b/lib/prserv/db.py
> @@ -30,21 +30,29 @@ if sqlversion[0] < 3 or (sqlversion[0] == 3 and sqlversion[1] < 3):
>  #
>  
>  class PRTable(object):
> -    def __init__(self, conn, table, nohist):
> +    def __init__(self, conn, table, nohist, read_only):
>          self.conn = conn
>          self.nohist = nohist
> +        self.read_only = read_only
>          self.dirty = False
>          if nohist:
>              self.table = "%s_nohist" % table 
>          else:
>              self.table = "%s_hist" % table 
>  
> -        self._execute("CREATE TABLE IF NOT EXISTS %s \
> -                    (version TEXT NOT NULL, \
> -                    pkgarch TEXT NOT NULL,  \
> -                    checksum TEXT NOT NULL, \
> -                    value INTEGER, \
> -                    PRIMARY KEY (version, pkgarch, checksum));" % self.table)
> +        if self.read_only:
> +            table_exists = self._execute(
> +                        "SELECT count(*) FROM sqlite_master \
> +                        WHERE type='table' AND name='%s'" % (self.table))
> +            if not table_exists:
> +                raise prserv.NotFoundError
> +        else:
> +            self._execute("CREATE TABLE IF NOT EXISTS %s \
> +                        (version TEXT NOT NULL, \
> +                        pkgarch TEXT NOT NULL,  \
> +                        checksum TEXT NOT NULL, \
> +                        value INTEGER, \
> +                        PRIMARY KEY (version, pkgarch, checksum));" % self.table)
>  
>      def _execute(self, *query):
>          """Execute a query, waiting to acquire a lock if necessary"""
> @@ -59,8 +67,9 @@ class PRTable(object):
>                  raise exc
>  
>      def sync(self):
> -        self.conn.commit()
> -        self._execute("BEGIN EXCLUSIVE TRANSACTION")
> +        if not self.read_only:
> +            self.conn.commit()
> +            self._execute("BEGIN EXCLUSIVE TRANSACTION")
>  
>      def sync_if_dirty(self):
>          if self.dirty:
> @@ -75,6 +84,15 @@ class PRTable(object):
>              return row[0]
>          else:
>              #no value found, try to insert
> +            if self.read_only:
> +                data = self._execute("SELECT ifnull(max(value)+1,0) FROM %s where version=? AND pkgarch=?;" % (self.table),
> +                                   (version, pkgarch))
> +                row = data.fetchone()
> +                if row is not None:
> +                    return row[0]
> +                else:
> +                    return 0
> +
>              try:
>                  self._execute("INSERT INTO %s VALUES (?, ?, ?, (select ifnull(max(value)+1,0) from %s where version=? AND pkgarch=?));"
>                             % (self.table,self.table),
> @@ -103,6 +121,15 @@ class PRTable(object):
>              return row[0]
>          else:
>              #no value found, try to insert
> +            if self.read_only:
> +                data = self._execute("SELECT ifnull(max(value)+1,0) FROM %s where version=? AND pkgarch=?;" % (self.table),
> +                                   (version, pkgarch))
> +                row = data.fetchone()
> +                if row is not None:
> +                    return row[0]
> +                else:
> +                    return 0
> +
>              try:
>                  self._execute("INSERT OR REPLACE INTO %s VALUES (?, ?, ?, (select ifnull(max(value)+1,0) from %s where version=? AND pkgarch=?));"
>                                 % (self.table,self.table),
> @@ -128,6 +155,9 @@ class PRTable(object):
>              return self._getValueHist(version, pkgarch, checksum)
>  
>      def _importHist(self, version, pkgarch, checksum, value):
> +        if self.read_only:
> +            return None
> +
>          val = None 
>          data = self._execute("SELECT value FROM %s WHERE version=? AND pkgarch=? AND checksum=?;" % self.table,
>                             (version, pkgarch, checksum))
> @@ -152,6 +182,9 @@ class PRTable(object):
>          return val
>  
>      def _importNohist(self, version, pkgarch, checksum, value):
> +        if self.read_only:
> +            return None
> +
>          try:
>              #try to insert
>              self._execute("INSERT INTO %s VALUES (?, ?, ?, ?);"  % (self.table),
> @@ -245,19 +278,23 @@ class PRTable(object):
>  
>  class PRData(object):
>      """Object representing the PR database"""
> -    def __init__(self, filename, nohist=True):
> +    def __init__(self, filename, nohist=True, read_only=False):
>          self.filename=os.path.abspath(filename)
>          self.nohist=nohist
> +        self.read_only = read_only
>          #build directory hierarchy
>          try:
>              os.makedirs(os.path.dirname(self.filename))
>          except OSError as e:
>              if e.errno != errno.EEXIST:
>                  raise e
> -        self.connection=sqlite3.connect(self.filename, isolation_level="EXCLUSIVE", check_same_thread = False)
> +        uri = "file:%s%s" % (self.filename, "?mode=ro" if self.read_only else "")
> +        logger.debug("Opening PRServ database '%s'" % (uri))
> +        self.connection=sqlite3.connect(uri, uri=True, isolation_level="EXCLUSIVE", check_same_thread = False)
>          self.connection.row_factory=sqlite3.Row
> -        self.connection.execute("pragma synchronous = off;")
> -        self.connection.execute("PRAGMA journal_mode = MEMORY;")
> +        if not self.read_only:
> +            self.connection.execute("pragma synchronous = off;")
> +            self.connection.execute("PRAGMA journal_mode = MEMORY;")
>          self._tables={}
>  
>      def disconnect(self):
> @@ -270,7 +307,7 @@ class PRData(object):
>          if tblname in self._tables:
>              return self._tables[tblname]
>          else:
> -            tableobj = self._tables[tblname] = PRTable(self.connection, tblname, self.nohist)
> +            tableobj = self._tables[tblname] = PRTable(self.connection, tblname, self.nohist, self.read_only)
>              return tableobj
>  
>      def __delitem__(self, tblname):
> diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
> index 2c572e0f..618bd452 100644
> --- a/lib/prserv/serv.py
> +++ b/lib/prserv/serv.py
> @@ -18,14 +18,16 @@ PIDPREFIX = "/tmp/PRServer_%s_%s.pid"
>  singleton = None
>  
>  class PRServerClient(bb.asyncrpc.AsyncServerConnection):
> -    def __init__(self, reader, writer, table):
> +    def __init__(self, reader, writer, table, read_only):
>          super().__init__(reader, writer, 'PRSERVICE', logger)
>          self.handlers.update({
>              'get-pr': self.handle_get_pr,
>              'import-one': self.handle_import_one,
>              'export': self.handle_export,
> +            'is-readonly': self.handle_is_readonly,
>          })
>          self.table = table
> +        self.read_only = read_only
>  
>      def validate_proto_version(self):
>          return (self.proto_version == (1, 0))
> @@ -56,16 +58,17 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection):
>          self.write_message(response)
>  
>      async def handle_import_one(self, request):
> -        version = request['version']
> -        pkgarch = request['pkgarch']
> -        checksum = request['checksum']
> -        value = request['value']
> +        response = None
> +        if not self.read_only:
> +            version = request['version']
> +            pkgarch = request['pkgarch']
> +            checksum = request['checksum']
> +            value = request['value']
> +
> +            value = self.table.importone(version, pkgarch, checksum, value)
> +            if value is not None:
> +                response = {'value': value}
>  
> -        value = self.table.importone(version, pkgarch, checksum, value)
> -        if value is not None:
> -            response = {'value': value}
> -        else:
> -            response = None
>          self.write_message(response)
>  
>      async def handle_export(self, request):
> @@ -83,20 +86,25 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection):
>          response = {'metainfo': metainfo, 'datainfo': datainfo}
>          self.write_message(response)
>  
> +    async def handle_is_readonly(self, request):
> +        response = {'readonly': self.read_only}
> +        self.write_message(response)
> +
>  class PRServer(bb.asyncrpc.AsyncServer):
> -    def __init__(self, dbfile, loop=None):
> +    def __init__(self, dbfile, loop=None, read_only=False):
>          super().__init__(logger, loop)
>          self.dbfile = dbfile
>          self.table = None
> +        self.read_only = read_only
>  
>      def accept_client(self, reader, writer):
> -        return PRServerClient(reader, writer, self.table)
> +        return PRServerClient(reader, writer, self.table, self.read_only)
>  
>      def serve_forever(self):
> -        self.db = prserv.db.PRData(self.dbfile)
> +        self.db = prserv.db.PRData(self.dbfile, read_only=self.read_only)
>          self.table = self.db["PRMAIN"]
>  
> -        logger.debug("Started PRServer with DBfile: %s, Address: %s, PID: %s" %
> +        logger.info("Started PRServer with DBfile: %s, Address: %s, PID: %s" %
>                       (self.dbfile, self.address, str(os.getpid())))
>  
>          super().serve_forever()
> @@ -149,10 +157,17 @@ class PRAsyncClient(bb.asyncrpc.AsyncClient):
>          if response:
>              return (response['metainfo'], response['datainfo'])
>  
> +    async def is_readonly(self):
> +        response = await self.send_message(
> +            {'is-readonly': {}}
> +        )
> +        if response:
> +            return response['readonly']
> +
>  class PRClient(bb.asyncrpc.Client):
>      def __init__(self):
>          super().__init__()
> -        self._add_methods('getPR', 'importone', 'export')
> +        self._add_methods('getPR', 'importone', 'export', 'is_readonly')
>  
>      def _get_async_client(self):
>          return PRAsyncClient()
> @@ -227,7 +242,7 @@ def run_as_daemon(func, pidfile, logfile):
>      os.remove(pidfile)
>      os._exit(0)
>  
> -def start_daemon(dbfile, host, port, logfile):
> +def start_daemon(dbfile, host, port, logfile, read_only=False):
>      ip = socket.gethostbyname(host)
>      pidfile = PIDPREFIX % (ip, port)
>      try:
> @@ -243,7 +258,7 @@ def start_daemon(dbfile, host, port, logfile):
>  
>      dbfile = os.path.abspath(dbfile)
>      def daemon_main():
> -        server = PRServer(dbfile)
> +        server = PRServer(dbfile, read_only=read_only)
>          server.start_tcp_server(host, port)
>          server.serve_forever()
>  
>
> 
>

