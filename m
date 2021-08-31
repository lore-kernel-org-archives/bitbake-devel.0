Received: from mail5.wrs.com (mail5.wrs.com [192.103.53.11])
 by mx.groups.io with SMTP id smtpd.web08.2487.1630396318672176303
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Aug 2021 00:51:59 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: windriver.com, ip: 192.103.53.11, mailfrom: mingli.yu@windriver.com)
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com [147.11.82.252])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 17V7prT2013322
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 31 Aug 2021 00:51:54 -0700
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 31 Aug 2021 00:51:53 -0700
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 31 Aug 2021 00:51:53 -0700
Received: from pek-lpg-core2.corp.ad.wrs.com (128.224.153.41) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2242.12 via Frontend Transport; Tue, 31 Aug 2021 00:51:52 -0700
From: "Yu, Mingli" <mingli.yu@windriver.com>
To: <bitbake-devel@lists.openembedded.org>, <Martin.Jansa@gmail.com>,
        <scott.murray@konsulko.com>
Subject: [PATCH] prserv: make localhost work
Date: Tue, 31 Aug 2021 15:48:07 +0800
Message-ID: <20210831074807.5972-1-mingli.yu@windriver.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <16A04D855643B3E7.30479@lists.openembedded.org>
References: <16A04D855643B3E7.30479@lists.openembedded.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Mingli Yu <mingli.yu@windriver.com>

After [1] introduced, the PR server doesn't work in docker when use
below setting like before.
PRSERV_HOST = "localhost:0"

And it's because the localhost is resolved to an ipv6 address ::1 as
the below bitbake-prserv shows.
 bitbake$ bitbake-prserv --start --host=localhost --port=42005
 bitbake$ cat prserv.log
    Traceback (most recent call last):
      File "/OE/nodistro/honister/bitbake/bin/bitbake-prserv", line 55, in <module>
        ret = main()
      File "/OE/nodistro/honister/bitbake/bin/bitbake-prserv", line 46, in main
        ret=prserv.serv.start_daemon(options.dbfile, options.host, options.port,os.path.abspath(options.logfile), options.read_only)
      File "/OE/nodistro/honister/bitbake/lib/prserv/serv.py", line 226, in start_daemon
        run_as_daemon(daemon_main, pidfile, os.path.abspath(logfile))
      File "/OE/nodistro/honister/bitbake/lib/prserv/serv.py", line 202, in run_as_daemon
        func()
      File "/OE/nodistro/honister/bitbake/lib/prserv/serv.py", line 224, in daemon_main
        server.serve_forever()
      File "/OE/nodistro/honister/bitbake/lib/bb/asyncrpc/serv.py", line 233, in serve_forever
        self.start()
      File "/OE/nodistro/honister/bitbake/lib/bb/asyncrpc/serv.py", line 144, in start_tcp
        self.server = self.loop.run_until_complete(server_coro)
      File "/usr/lib/python3.8/asyncio/base_events.py", line 616, in run_until_complete
        return future.result()
      File "/usr/lib/python3.8/asyncio/streams.py", line 94, in start_server
        return await loop.create_server(factory, host, port, **kwds)
      File "/usr/lib/python3.8/asyncio/base_events.py", line 1463, in create_server
        raise OSError(err.errno, 'error while attempting '
    OSError: [Errno 99] error while attempting to bind on address ('::1', 42005, 0, 0): cannot assign requested address

So add the extra logic to make the localhost resolved as expected to
make the PR service work especially in docker.

[1] 6a2b23e2 prserv: Replace XML RPC with modern asyncrpc implementation

Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
---
 lib/prserv/serv.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
index 68db3d3e..0a20b927 100644
--- a/lib/prserv/serv.py
+++ b/lib/prserv/serv.py
@@ -126,7 +126,7 @@ class PRServSingleton(object):
 
     def start(self):
         self.prserv = PRServer(self.dbfile)
-        self.prserv.start_tcp_server(self.host, self.port)
+        self.prserv.start_tcp_server(socket.gethostbyname(self.host), self.port)
         self.process = self.prserv.serve_as_process()
 
         if not self.prserv.address:
@@ -221,7 +221,7 @@ def start_daemon(dbfile, host, port, logfile, read_only=False):
     dbfile = os.path.abspath(dbfile)
     def daemon_main():
         server = PRServer(dbfile, read_only=read_only)
-        server.start_tcp_server(host, port)
+        server.start_tcp_server(ip, port)
         server.serve_forever()
 
     run_as_daemon(daemon_main, pidfile, os.path.abspath(logfile))
-- 
2.17.1

