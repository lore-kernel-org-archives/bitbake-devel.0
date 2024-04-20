Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7E8C4345F
	for <webhook@archiver.kernel.org>; Sat, 20 Apr 2024 20:56:00 +0000 (UTC)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
 by mx.groups.io with SMTP id smtpd.web10.20459.1713646554548276843
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 20 Apr 2024 13:55:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=jm6045yD;
 spf=pass (domain: gmail.com, ip: 209.85.167.49, mailfrom: jpewhacker@gmail.com)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51967f75763so3737599e87.2
        for <bitbake-devel@lists.openembedded.org>; Sat, 20 Apr 2024 13:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713646552; x=1714251352; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubAL6w/xdA+LYWabcATtyrfQDPE1r6Oks1NZ4n+8s8c=;
        b=jm6045yDz3JLH8aimRianflPHucCxFZS1e34HKltczU1Y/pvFVmL+JWoVUQRXkVaMm
         n5KXBvbOUxcdnkBakatBXoKGHAonsGdpiT86i4wUR6o/a8jg5sTjojBXPq3WkW6Ig6kN
         Pf44KesN2o/cprhbamdJLJbBaZALkCaHW5aynftSaEo1pELzOsR78LxEeFUFBdc40mW/
         3UQ/jgW2LcSqni72syw1R0Mqo+weZr+Ac+Q2HCebKIRxfyUMLhKE+Jp63301wf8PndTx
         NraOVoV5H/Tpj9cW+xGVK/2WC24dT09mhP1/NTN/H+xxbztWpY8S4ecHBSTW5FvYVpQt
         RrIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713646552; x=1714251352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ubAL6w/xdA+LYWabcATtyrfQDPE1r6Oks1NZ4n+8s8c=;
        b=Q6YT2z5cMuanMxvccF9KJOIOC46QC54C3+iWkk/7JwqEeTGNELU2OgZ740L+BS/ifV
         KeSVE7rKHtnTzjMs6kM6mbvbO1ykt8rSo/tlojf81FMTPUAilbfc+Ah4gXkMSDvT3cV7
         W4JVvvLhbblB/JjKNxYgDNCJU+gWy47Ns6POqlIaaNp112o8R7gwFfkQt9LoslF6h8py
         a4iLA+mkt5PdmSmUMVU1l9u+6T2uT4iVK9q/atHBxmyDq43a7eBbCSji48867f/gsquv
         LqVL04Sx5qalGIzRQWffXUsv6wplZgWMFMBeGwNKKRa7PKl9EPwuRW0ONRsKPAx4MPRc
         zaTA==
X-Gm-Message-State: AOJu0Yz1ehtykLsZKAeABkiRCcW1XBHzbRmpLJXcVzCHDvqesSBTndg3
	PUE2QEwLM+9wHsUHp9GZ7iFXIlnRniDSMWUofj2QnREp0RMFlovGEiHkyPKch6gZaviFTK9FqL5
	WE8Eud0AXwTzigjHLDQzjbHonPqw=
X-Google-Smtp-Source: AGHT+IHDfTATE0lRxvMQbf/QZSHF0Y2QBmD7LcOlKG66Z6bjZecj7/HvCMgEtly/s7Yc02yH9r7Ny9m2/kjBY/yvhzY=
X-Received: by 2002:ac2:5d44:0:b0:518:baa1:381b with SMTP id
 w4-20020ac25d44000000b00518baa1381bmr3283169lfd.50.1713646552270; Sat, 20 Apr
 2024 13:55:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240412090234.4110915-1-michael.opdenacker@bootlin.com> <20240412090234.4110915-12-michael.opdenacker@bootlin.com>
In-Reply-To: <20240412090234.4110915-12-michael.opdenacker@bootlin.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Sat, 20 Apr 2024 15:55:40 -0500
Message-ID: <CAJdd5GaDUEjAh2-gH83jyQK+eFw9E1=R4G8UYrhE3AYTFNjp1A@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 11/12] prserv: add "upstream" server support
To: michael.opdenacker@bootlin.com
Cc: bitbake-devel@lists.openembedded.org, Tim Orling <ticotimo@gmail.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 20 Apr 2024 20:56:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16118

On Fri, Apr 12, 2024 at 4:02=E2=80=AFAM Michael Opdenacker via
lists.openembedded.org
<michael.opdenacker=3Dbootlin.com@lists.openembedded.org> wrote:
>
> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
>
> Introduce a PRSERVER_UPSTREAM variable that makes the
> local PR server connect to an "upstream" one.
>
> This makes it possible to implement local fixes to an
> upstream package (revision "x", in a way that gives the local
> update priority (revision "x.y").
>
> Update the calculation of the new revisions to support the
> case when prior revisions are not integers, but have
> an "x.y..." format."
>
> Set the comments in the handle_get_pr() function in serv.py
> for details about the calculation of the local revision.
>
> Use the newly developed functions to simplify the implementation
> of the get_value() function by merging the code of the earlier
> _get_value_hist() and _get_value_nohist() functions, removing
> redundancy between both functions. This also makes the code easier
> to understand.
>
> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> Cc: Joshua Watt <JPEWhacker@gmail.com>
> Cc: Tim Orling <ticotimo@gmail.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> ---
>  bin/bitbake-prserv     |  15 ++++-
>  lib/prserv/__init__.py |  15 +++++
>  lib/prserv/client.py   |   1 +
>  lib/prserv/db.py       | 125 ++++++++++++++++++++---------------------
>  lib/prserv/serv.py     |  95 +++++++++++++++++++++++++++----
>  5 files changed, 174 insertions(+), 77 deletions(-)
>
> diff --git a/bin/bitbake-prserv b/bin/bitbake-prserv
> index ad0a069401..e39d0fba87 100755
> --- a/bin/bitbake-prserv
> +++ b/bin/bitbake-prserv
> @@ -70,12 +70,25 @@ def main():
>          action=3D"store_true",
>          help=3D"open database in read-only mode",
>      )
> +    parser.add_argument(
> +        "-u",
> +        "--upstream",
> +        default=3Dos.environ.get("PRSERVER_UPSTREAM", None),
> +        help=3D"Upstream PR service (host:port)",
> +    )
>
>      args =3D parser.parse_args()
>      prserv.init_logger(os.path.abspath(args.log), args.loglevel)
>
>      if args.start:
> -        ret=3Dprserv.serv.start_daemon(args.file, args.host, args.port, =
os.path.abspath(args.log), args.read_only)
> +        ret=3Dprserv.serv.start_daemon(
> +            args.file,
> +            args.host,
> +            args.port,
> +            os.path.abspath(args.log),
> +            args.read_only,
> +            args.upstream
> +        )
>      elif args.stop:
>          ret=3Dprserv.serv.stop_daemon(args.host, args.port)
>      else:
> diff --git a/lib/prserv/__init__.py b/lib/prserv/__init__.py
> index 0e0aa34d0e..2ee6a28c04 100644
> --- a/lib/prserv/__init__.py
> +++ b/lib/prserv/__init__.py
> @@ -8,6 +8,7 @@ __version__ =3D "1.0.0"
>
>  import os, time
>  import sys, logging
> +from bb.asyncrpc.client import parse_address, ADDR_TYPE_UNIX, ADDR_TYPE_=
WS
>
>  def init_logger(logfile, loglevel):
>      numeric_level =3D getattr(logging, loglevel.upper(), None)
> @@ -18,3 +19,17 @@ def init_logger(logfile, loglevel):
>
>  class NotFoundError(Exception):
>      pass
> +
> +async def create_async_client(addr):
> +    from . import client
> +
> +    c =3D client.PRAsyncClient()
> +
> +    try:
> +        (typ, a) =3D parse_address(addr)
> +        await c.connect_tcp(*a)
> +        return c
> +
> +    except Exception as e:
> +        await c.close()
> +        raise e
> diff --git a/lib/prserv/client.py b/lib/prserv/client.py
> index 8471ee3046..89760b6f74 100644
> --- a/lib/prserv/client.py
> +++ b/lib/prserv/client.py
> @@ -6,6 +6,7 @@
>
>  import logging
>  import bb.asyncrpc
> +from . import create_async_client
>
>  logger =3D logging.getLogger("BitBake.PRserv")
>
> diff --git a/lib/prserv/db.py b/lib/prserv/db.py
> index eb41508198..8305238f7a 100644
> --- a/lib/prserv/db.py
> +++ b/lib/prserv/db.py
> @@ -21,6 +21,20 @@ sqlversion =3D sqlite3.sqlite_version_info
>  if sqlversion[0] < 3 or (sqlversion[0] =3D=3D 3 and sqlversion[1] < 3):
>      raise Exception("sqlite3 version 3.3.0 or later is required.")
>
> +def increase_revision(ver):
> +    """Take a revision string such as "1" or "1.2.3" or even a number an=
d increase its last number
> +    This fails if the last number is not an integer"""
> +
> +    fields=3Dstr(ver).split('.')
> +    last =3D fields[-1]
> +
> +    try:
> +         val =3D int(last)
> +    except Exception as e:
> +         logger.critical("Unable to increase revision value %s: %s" % (v=
er, e))
> +
> +    return ".".join(fields[0:-1] + list(str(val + 1)))
> +
>  #
>  # "No History" mode - for a given query tuple (version, pkgarch, checksu=
m),
>  # the returned value will be the largest among all the values of the sam=
e
> @@ -53,7 +67,7 @@ class PRTable(object):
>                          (version TEXT NOT NULL, \
>                          pkgarch TEXT NOT NULL,  \
>                          checksum TEXT NOT NULL, \
> -                        value INTEGER, \
> +                        value TEXT, \
>                          PRIMARY KEY (version, pkgarch, checksum));" % se=
lf.table)
>
>      def _execute(self, *query):
> @@ -119,84 +133,67 @@ class PRTable(object):
>          data =3D self._execute("SELECT max(value) FROM %s where version=
=3D? AND pkgarch=3D?;" % (self.table),
>                               (version, pkgarch))
>          row =3D data.fetchone()
> -        if row is not None:
> +        # With SELECT max() requests, you have an empty row when there a=
re no values, therefore the test on row[0]
> +        if row is not None and row[0] is not None:
>              return row[0]
>          else:
>              return None
>
> -    def _get_value_hist(self, version, pkgarch, checksum):
> -        data=3Dself._execute("SELECT value FROM %s WHERE version=3D? AND=
 pkgarch=3D? AND checksum=3D?;" % self.table,
> -                           (version, pkgarch, checksum))
> -        row=3Ddata.fetchone()
> -        if row is not None:
> -            return row[0]
> +    def find_new_subvalue(self, version, pkgarch, base):
> +        """Take and increase the greatest "<base>.y" value for (version,=
 pkgarch), or return "<base>.1" if not found.
> +        This doesn't store a new value."""
> +
> +        data =3D self._execute("SELECT max(value) FROM %s where version=
=3D? AND pkgarch=3D? AND value LIKE '%s.%%';" % (self.table, base),
> +                             (version, pkgarch))
> +        row =3D data.fetchone()
> +        # With SELECT max() requests, you have an empty row when there a=
re no values, therefore the test on row[0]
> +        if row is not None and row[0] is not None:
> +            return increase_revision(row[0])
>          else:
> -            #no value found, try to insert
> -            if self.read_only:
> -                data =3D self._execute("SELECT ifnull(max(value)+1, 0) F=
ROM %s where version=3D? AND pkgarch=3D?;" % (self.table),
> -                                   (version, pkgarch))
> -                row =3D data.fetchone()
> -                if row is not None:
> -                    return row[0]
> -                else:
> -                    return 0
> +            return base + ".0"
>
> -            try:
> -                self._execute("INSERT INTO %s VALUES (?, ?, ?, (select i=
fnull(max(value)+1, 0) from %s where version=3D? AND pkgarch=3D?));"
> -                           % (self.table, self.table),
> -                           (version, pkgarch, checksum, version, pkgarch=
))
> -            except sqlite3.IntegrityError as exc:
> -                logger.error(str(exc))
> +    def store_value(self, version, pkgarch, checksum, value):
> +        """Store new value in the database"""
>
> -            self.dirty =3D True
> +        try:
> +            self._execute("INSERT INTO %s VALUES (?, ?, ?, ?);"  % (self=
.table),
> +                       (version, pkgarch, checksum, value))
> +        except sqlite3.IntegrityError as exc:
> +            logger.error(str(exc))
>
> -            data=3Dself._execute("SELECT value FROM %s WHERE version=3D?=
 AND pkgarch=3D? AND checksum=3D?;" % self.table,
> -                               (version, pkgarch, checksum))
> -            row=3Ddata.fetchone()
> -            if row is not None:
> -                return row[0]
> -            else:
> -                raise prserv.NotFoundError
> +        self.dirty =3D True
>
> -    def _get_value_no_hist(self, version, pkgarch, checksum):
> -        data=3Dself._execute("SELECT value FROM %s \
> -                            WHERE version=3D? AND pkgarch=3D? AND checks=
um=3D? AND \
> -                            value >=3D (select max(value) from %s where =
version=3D? AND pkgarch=3D?);"
> -                            % (self.table, self.table),
> -                            (version, pkgarch, checksum, version, pkgarc=
h))
> -        row=3Ddata.fetchone()
> -        if row is not None:
> -            return row[0]
> -        else:
> -            #no value found, try to insert
> -            if self.read_only:
> -                data =3D self._execute("SELECT ifnull(max(value)+1, 0) F=
ROM %s where version=3D? AND pkgarch=3D?;" % (self.table),
> -                                   (version, pkgarch))
> -                return data.fetchone()[0]
> +    def _get_value(self, version, pkgarch, checksum):
>
> -            try:
> -                self._execute("INSERT OR REPLACE INTO %s VALUES (?, ?, ?=
, (select ifnull(max(value)+1, 0) from %s where version=3D? AND pkgarch=3D?=
));"
> -                               % (self.table, self.table),
> -                               (version, pkgarch, checksum, version, pkg=
arch))
> -            except sqlite3.IntegrityError as exc:
> -                logger.error(str(exc))
> -                self.conn.rollback()
> +        max_value =3D self.find_max_value(version, pkgarch)
>
> -            self.dirty =3D True
> +        if max_value is None:
> +            # version, pkgarch completely unknown. Return initial value.
> +            return "0"
>
> -            data=3Dself._execute("SELECT value FROM %s WHERE version=3D?=
 AND pkgarch=3D? AND checksum=3D?;" % self.table,
> -                               (version, pkgarch, checksum))
> -            row=3Ddata.fetchone()
> -            if row is not None:
> -                return row[0]
> -            else:
> -                raise prserv.NotFoundError
> +        value =3D self.find_value(version, pkgarch, checksum)
> +
> +        if value is None:
> +            # version, pkgarch found but not checksum. Create a new valu=
e from the maximum one
> +            return increase_revision(max_value)
>
> -    def get_value(self, version, pkgarch, checksum):
>          if self.nohist:
> -            return self._get_value_no_hist(version, pkgarch, checksum)
> +            # "no-history" mode: only return a value if that's the maxim=
um one for
> +            # the version and architecture, otherwise create a new one.
> +            # This means that the value cannot decrement.
> +            if value =3D=3D max_value:
> +                return value
> +            else:
> +                return increase_revision(max_value)
>          else:
> -            return self._get_value_hist(version, pkgarch, checksum)
> +            # "hist" mode: we found an existing value. We can return it
> +            # whether it's the maximum one or not.
> +            return value
> +
> +    def get_value(self, version, pkgarch, checksum):
> +        value =3D self._get_value(version, pkgarch, checksum)
> +        self.store_value(version, pkgarch, checksum, value)
> +        return value
>
>      def _import_hist(self, version, pkgarch, checksum, value):
>          if self.read_only:
> diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
> index dc4be5b620..9e07a34445 100644
> --- a/lib/prserv/serv.py
> +++ b/lib/prserv/serv.py
> @@ -12,6 +12,7 @@ import sqlite3
>  import prserv
>  import prserv.db
>  import errno
> +from . import create_async_client
>  import bb.asyncrpc
>
>  logger =3D logging.getLogger("BitBake.PRserv")
> @@ -76,14 +77,76 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnectio=
n):
>          pkgarch =3D request["pkgarch"]
>          checksum =3D request["checksum"]
>
> -        response =3D None
> -        try:
> +        if self.upstream_client is None:
>              value =3D self.server.table.get_value(version, pkgarch, chec=
ksum)
> -            response =3D {"value": value}
> -        except prserv.NotFoundError:
> -            self.logger.error("failure storing value in database for (%s=
, %s)",version, checksum)
> +            return {"value": value}
>
> -        return response
> +        # We have an upstream server.
> +        # Check whether the local server already knows the requested con=
figuration
> +        # Here we use find_value(), not get_value(), because we don't wa=
nt
> +        # to unconditionally add a new generated value to the database. =
If the configuration
> +        # is a new one, the generated value we will add will depend on w=
hat's on the upstream server.
> +
> +        value =3D self.server.table.find_value(version, pkgarch, checksu=
m)
> +
> +        if value is not None:
> +
> +            # The configuration is already known locally. Let's use it.
> +
> +            return {"value": value}
> +
> +        # The configuration is a new one for the local server
> +        # Let's ask the upstream server whether it knows it
> +
> +        known_upstream =3D await self.upstream_client.test_package(versi=
on, pkgarch)
> +
> +        if not known_upstream:
> +
> +            # The package is not known upstream, must be a local-only pa=
ckage
> +            # Let's compute the PR number using the local-only method
> +
> +            value =3D self.server.table.get_value(version, pkgarch, chec=
ksum)
> +            return {"value": value}
> +
> +        # The package is known upstream, let's ask the upstream server
> +        # whether it knows our new output hash
> +
> +        value =3D await self.upstream_client.test_pr(version, pkgarch, c=
hecksum)
> +
> +        if value is not None:
> +
> +            # Upstream knows this output hash, let's store it and use it=
 too.
> +
> +            if not self.server.read_only:
> +                self.server.table.store_value(version, pkgarch, checksum=
, value)
> +            # If the local server is read only, won't be able to store t=
he new
> +            # value in the database and will have to keep asking the ups=
tream server
> +
> +            return {"value": value}
> +
> +        # The output hash doesn't exist upstream, get the most recent nu=
mber from upstream (x)
> +        # Then, we want to have a new PR value for the local server: x.y
> +
> +        upstream_max =3D await self.upstream_client.max_package_pr(versi=
on, pkgarch)
> +        # Here we know that the package is known upstream, so upstream_m=
ax can't be None
> +        subvalue =3D self.server.table.find_new_subvalue(version, pkgarc=
h, upstream_max)
> +
> +        if not self.server.read_only:
> +            self.server.table.store_value(version, pkgarch, checksum, su=
bvalue)
> +
> +        return {"value": subvalue}

Keep in mind that this code is effectively multithreaded. I can't tell
if you'll be having race problems here due to simultaneous accesses,
but and sort of workflows where you read something, then update the
database based on the read value can have weird race conditions,
especially when dealing with many clients at once

> +
> +    async def process_requests(self):
> +        if self.server.upstream is not None:
> +            self.upstream_client =3D await create_async_client(self.serv=
er.upstream)
> +        else:
> +            self.upstream_client =3D None
> +
> +        try:
> +            await super().process_requests()
> +        finally:
> +            if self.upstream_client is not None:
> +                await self.upstream_client.close()
>
>      async def handle_import_one(self, request):
>          response =3D None
> @@ -117,11 +180,12 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnect=
ion):
>          return {"readonly": self.server.read_only}
>
>  class PRServer(bb.asyncrpc.AsyncServer):
> -    def __init__(self, dbfile, read_only=3DFalse):
> +    def __init__(self, dbfile, read_only=3DFalse, upstream=3DNone):
>          super().__init__(logger)
>          self.dbfile =3D dbfile
>          self.table =3D None
>          self.read_only =3D read_only
> +        self.upstream =3D upstream
>
>      def accept_client(self, socket):
>          return PRServerClient(socket, self)
> @@ -134,6 +198,9 @@ class PRServer(bb.asyncrpc.AsyncServer):
>          self.logger.info("Started PRServer with DBfile: %s, Address: %s,=
 PID: %s" %
>                       (self.dbfile, self.address, str(os.getpid())))
>
> +        if self.upstream is not None:
> +            self.logger.info("And upstream PRServer: %s " % (self.upstre=
am))
> +
>          return tasks
>
>      async def stop(self):
> @@ -147,14 +214,15 @@ class PRServer(bb.asyncrpc.AsyncServer):
>              self.table.sync()
>
>  class PRServSingleton(object):
> -    def __init__(self, dbfile, logfile, host, port):
> +    def __init__(self, dbfile, logfile, host, port, upstream):
>          self.dbfile =3D dbfile
>          self.logfile =3D logfile
>          self.host =3D host
>          self.port =3D port
> +        self.upstream =3D upstream
>
>      def start(self):
> -        self.prserv =3D PRServer(self.dbfile)
> +        self.prserv =3D PRServer(self.dbfile, upstream=3Dself.upstream)
>          self.prserv.start_tcp_server(socket.gethostbyname(self.host), se=
lf.port)
>          self.process =3D self.prserv.serve_as_process(log_level=3Dloggin=
g.WARNING)
>
> @@ -233,7 +301,7 @@ def run_as_daemon(func, pidfile, logfile):
>      os.remove(pidfile)
>      os._exit(0)
>
> -def start_daemon(dbfile, host, port, logfile, read_only=3DFalse):
> +def start_daemon(dbfile, host, port, logfile, read_only=3DFalse, upstrea=
m=3DNone):
>      ip =3D socket.gethostbyname(host)
>      pidfile =3D PIDPREFIX % (ip, port)
>      try:
> @@ -249,7 +317,7 @@ def start_daemon(dbfile, host, port, logfile, read_on=
ly=3DFalse):
>
>      dbfile =3D os.path.abspath(dbfile)
>      def daemon_main():
> -        server =3D PRServer(dbfile, read_only=3Dread_only)
> +        server =3D PRServer(dbfile, read_only=3Dread_only, upstream=3Dup=
stream)
>          server.start_tcp_server(ip, port)
>          server.serve_forever()
>
> @@ -336,6 +404,9 @@ def auto_start(d):
>
>      host =3D host_params[0].strip().lower()
>      port =3D int(host_params[1])
> +
> +    upstream =3D d.getVar("PRSERV_UPSTREAM") or None
> +
>      if is_local_special(host, port):
>          import bb.utils
>          cachedir =3D (d.getVar("PERSISTENT_DIR") or d.getVar("CACHE"))
> @@ -350,7 +421,7 @@ def auto_start(d):
>                 auto_shutdown()
>          if not singleton:
>              bb.utils.mkdirhier(cachedir)
> -            singleton =3D PRServSingleton(os.path.abspath(dbfile), os.pa=
th.abspath(logfile), host, port)
> +            singleton =3D PRServSingleton(os.path.abspath(dbfile), os.pa=
th.abspath(logfile), host, port, upstream)
>              singleton.start()
>      if singleton:
>          host =3D singleton.host
> --
> 2.34.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16086): https://lists.openembedded.org/g/bitbake-deve=
l/message/16086
> Mute This Topic: https://lists.openembedded.org/mt/105479101/3616693
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [JPEWha=
cker@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

