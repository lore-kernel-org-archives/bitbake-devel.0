Return-Path: <bruce.ashfield@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE276C4345F
	for <webhook@archiver.kernel.org>; Wed, 17 Apr 2024 15:19:53 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
 by mx.groups.io with SMTP id smtpd.web10.16103.1713367187813493807
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 17 Apr 2024 08:19:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=NPK4itPJ;
 spf=pass (domain: gmail.com, ip: 209.85.210.178, mailfrom: bruce.ashfield@gmail.com)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ecf1bb7f38so5236029b3a.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 17 Apr 2024 08:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713367187; x=1713971987; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O6ZA8MLZU0k5zoVTI5gnqeOGKcIqDrm28MMpmBTSpAM=;
        b=NPK4itPJIsLWPdtZpk+up0ewMoFVPSzTWxUmlWVb60d+OAcRZAo6UDjCqPSSuNBZff
         Yxmkss/+YUoC0HkVm9sXPadfOfOW06N5eK+2u7Mar/4opx/lddiX5otQxbWxVACAEJr7
         LBap1PvIPN/JYxc4ulBBFt2X+APf7K7ejDCVu1/qOBEFOYd/zcj663KlaSNsJDtdbqPK
         HerEFdZbV/9dUddcjSic/W5y1OvZ4aPl7NSXTdPyB0/AKiC1fB/fhVCebwV3TlVsNRx9
         xbfrxOOPu2VlKF9rtHgxZf1Gm+B168aTqlnGI2BMCxRPDslCTNIyi5/ef0juR2QZ1r+Y
         gSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713367187; x=1713971987;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O6ZA8MLZU0k5zoVTI5gnqeOGKcIqDrm28MMpmBTSpAM=;
        b=jngkHJtX/eGGiE2rVORlemrRcJ5ZVQjHNhC+TKb7mqyA9DjtPnu0Az3bEcZuA0BBNv
         JOMonzHjzCPekhvIWOU+I+A+x0+8BLT1HwxtsJSVPTr3N5jKWZyvHYo0wQvcxLYAqRua
         /d74M5Hk7sIUe5ShN/BbpctF7D+jq0tU+ha4yLcSwAm9mZdIG3LqJF0exhDTnP9P4549
         5i1t0zQ/tIifK2wB3DQdD8mafVwvwKTh8E32DJXIm5aoR8b2koc8kriBDKvrwdEgPZew
         28xEPZFR1OOX8c1khJXg59hVqeFZBr3xpRFLUnF2jbvlEgpM4jlXNwESRJesfvPgRnff
         C16Q==
X-Gm-Message-State: AOJu0YzqF1ZhCp8xXo9tU2jX7XM3bXUZHy8aKAOmT0U9+jgr5xN3lo1Z
	cXjZcezKbk+5IPTIdzRMlfm4+UKP489FaID0wBB+KXPshepNrl6dmfiBvwAJdeZNzWw1y6Wd/Ni
	J7bj8PZnBiR+T5Xdoq6hl7CLfDuM=
X-Google-Smtp-Source: AGHT+IHyAffGwHIgq4v5bqxz9UTENqJ9X8+ximHA8g4qtlWk030linqevicJsAeILRQL+hYckV/dPKDjSn1Ahsvkenw=
X-Received: by 2002:a17:90a:d0c5:b0:2a2:f06a:4fea with SMTP id
 y5-20020a17090ad0c500b002a2f06a4feamr13558358pjw.27.1713367186973; Wed, 17
 Apr 2024 08:19:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240412090234.4110915-1-michael.opdenacker@bootlin.com> <20240412090234.4110915-12-michael.opdenacker@bootlin.com>
In-Reply-To: <20240412090234.4110915-12-michael.opdenacker@bootlin.com>
From: Bruce Ashfield <bruce.ashfield@gmail.com>
Date: Wed, 17 Apr 2024 11:19:35 -0400
Message-ID: <CADkTA4Oxnc-bPUJyq-hzHR-Dfb84A_sn_ThGoN1qR7Wwy2zGig@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 11/12] prserv: add "upstream" server support
To: michael.opdenacker@bootlin.com
Cc: bitbake-devel@lists.openembedded.org, Joshua Watt <JPEWhacker@gmail.com>, 
	Tim Orling <ticotimo@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: multipart/alternative; boundary="0000000000008caa9c06164c620d"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 17 Apr 2024 15:19:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16106

--0000000000008caa9c06164c620d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 5:02=E2=80=AFAM Michael Opdenacker via
lists.openembedded.org <michael.opdenacker=3D
bootlin.com@lists.openembedded.org> wrote:

> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
>
> Introduce a PRSERVER_UPSTREAM variable that makes the
> local PR server connect to an "upstream" one.
>
>
I assume we'll eventually put something about the new variable
in template conf files (commented out), similar to the upstream
hasserv ones ?


> This makes it possible to implement local fixes to an
> upstream package (revision "x", in a way that gives the local
> update priority (revision "x.y").
>
Update the calculation of the new revisions to support the
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
> -        ret=3Dprserv.serv.start_daemon(args.file, args.host, args.port,
> os.path.abspath(args.log), args.read_only)
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
d
> increase its last number
> +    This fails if the last number is not an integer"""
> +
> +    fields=3Dstr(ver).split('.')
> +    last =3D fields[-1]
> +
> +    try:
> +         val =3D int(last)
> +    except Exception as e:
> +         logger.critical("Unable to increase revision value %s: %s" %
> (ver, e))
> +
>

What's the chain of events that will happen after this log and the return ?
The log
message itself isn't going to tell us much, as the package name, etc,
aren't available
at this point.

Should we be raising another exception ? Something else ? Such that we can
get a better log message from calling code that has more context about what
package or what might have lead to the issue ?

Should processing stop and the build fail ? If we don't have a failure, we
risk
getting a package with the same version and changes being missed. This
could already be the case in other parts of the code, I'm only wondering it
while
reading this specific routine. (and I can never remember if
logger.cirtical()
aborts execution on it's own).



> +    return ".".join(fields[0:-1] + list(str(val + 1)))
> +
>  #
>  # "No History" mode - for a given query tuple (version, pkgarch,
> checksum),
>  # the returned value will be the largest among all the values of the sam=
e
> @@ -53,7 +67,7 @@ class PRTable(object):
>                          (version TEXT NOT NULL, \
>                          pkgarch TEXT NOT NULL,  \
>                          checksum TEXT NOT NULL, \
> -                        value INTEGER, \
> +                        value TEXT, \
>                          PRIMARY KEY (version, pkgarch, checksum));" %
> self.table)
>
>      def _execute(self, *query):
> @@ -119,84 +133,67 @@ class PRTable(object):
>          data =3D self._execute("SELECT max(value) FROM %s where version=
=3D?
> AND pkgarch=3D?;" % (self.table),
>                               (version, pkgarch))
>          row =3D data.fetchone()
> -        if row is not None:
> +        # With SELECT max() requests, you have an empty row when there
> are no values, therefore the test on row[0]
> +        if row is not None and row[0] is not None:
>              return row[0]
>          else:
>              return None
>
> -    def _get_value_hist(self, version, pkgarch, checksum):
> -        data=3Dself._execute("SELECT value FROM %s WHERE version=3D? AND
> pkgarch=3D? AND checksum=3D?;" % self.table,
> -                           (version, pkgarch, checksum))
> -        row=3Ddata.fetchone()
> -        if row is not None:
> -            return row[0]
> +    def find_new_subvalue(self, version, pkgarch, base):
> +        """Take and increase the greatest "<base>.y" value for (version,
> pkgarch), or return "<base>.1" if not found.
> +        This doesn't store a new value."""
> +
> +        data =3D self._execute("SELECT max(value) FROM %s where version=
=3D?
> AND pkgarch=3D? AND value LIKE '%s.%%';" % (self.table, base),
> +                             (version, pkgarch))
> +        row =3D data.fetchone()
> +        # With SELECT max() requests, you have an empty row when there
> are no values, therefore the test on row[0]
> +        if row is not None and row[0] is not None:
> +            return increase_revision(row[0])
>          else:
> -            #no value found, try to insert
> -            if self.read_only:
> -                data =3D self._execute("SELECT ifnull(max(value)+1, 0) F=
ROM
> %s where version=3D? AND pkgarch=3D?;" % (self.table),
> -                                   (version, pkgarch))
> -                row =3D data.fetchone()
> -                if row is not None:
> -                    return row[0]
> -                else:
> -                    return 0
> +            return base + ".0"
>
> -            try:
> -                self._execute("INSERT INTO %s VALUES (?, ?, ?, (select
> ifnull(max(value)+1, 0) from %s where version=3D? AND pkgarch=3D?));"
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
> +            self._execute("INSERT INTO %s VALUES (?, ?, ?, ?);"  %
> (self.table),
> +                       (version, pkgarch, checksum, value))
> +        except sqlite3.IntegrityError as exc:
> +            logger.error(str(exc))
>
> -            data=3Dself._execute("SELECT value FROM %s WHERE version=3D?=
 AND
> pkgarch=3D? AND checksum=3D?;" % self.table,
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
um=3D?
> AND \
> -                            value >=3D (select max(value) from %s where
> version=3D? AND pkgarch=3D?);"
> -                            % (self.table, self.table),
> -                            (version, pkgarch, checksum, version,
> pkgarch))
> -        row=3Ddata.fetchone()
> -        if row is not None:
> -            return row[0]
> -        else:
> -            #no value found, try to insert
> -            if self.read_only:
> -                data =3D self._execute("SELECT ifnull(max(value)+1, 0) F=
ROM
> %s where version=3D? AND pkgarch=3D?;" % (self.table),
> -                                   (version, pkgarch))
> -                return data.fetchone()[0]
> +    def _get_value(self, version, pkgarch, checksum):
>
> -            try:
> -                self._execute("INSERT OR REPLACE INTO %s VALUES (?, ?, ?=
,
> (select ifnull(max(value)+1, 0) from %s where version=3D? AND pkgarch=3D?=
));"
> -                               % (self.table, self.table),
> -                               (version, pkgarch, checksum, version,
> pkgarch))
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
 AND
> pkgarch=3D? AND checksum=3D?;" % self.table,
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
e
> from the maximum one
> +            return increase_revision(max_value)
>
> -    def get_value(self, version, pkgarch, checksum):
>          if self.nohist:
> -            return self._get_value_no_hist(version, pkgarch, checksum)
> +            # "no-history" mode: only return a value if that's the
> maximum one for
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
> @@ -76,14 +77,76 @@ class
> PRServerClient(bb.asyncrpc.AsyncServerConnection):
>          pkgarch =3D request["pkgarch"]
>          checksum =3D request["checksum"]
>
> -        response =3D None
> -        try:
> +        if self.upstream_client is None:
>              value =3D self.server.table.get_value(version, pkgarch,
> checksum)
> -            response =3D {"value": value}
> -        except prserv.NotFoundError:
> -            self.logger.error("failure storing value in database for (%s=
,
> %s)",version, checksum)
> +            return {"value": value}
>
> -        return response
> +        # We have an upstream server.
> +        # Check whether the local server already knows the requested
> configuration
> +        # Here we use find_value(), not get_value(), because we don't wa=
nt
> +        # to unconditionally add a new generated value to the database.
> If the configuration
> +        # is a new one, the generated value we will add will depend on
> what's on the upstream server.
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
on,
> pkgarch)
> +
>

Remind me .. what happens in the case of timeouts or other issues ? Is ther=
e
any way to detect it and provide a message ? Right now, it looks like it'll
just
fall through to local PR server functionality. Which I don't know is right
or wrong,
just that there's no way to really tell it happened.


> +        if not known_upstream:
> +
> +            # The package is not known upstream, must be a local-only
> package
> +            # Let's compute the PR number using the local-only method
> +
> +            value =3D self.server.table.get_value(version, pkgarch,
> checksum)
> +            return {"value": value}
> +
> +        # The package is known upstream, let's ask the upstream server
> +        # whether it knows our new output hash
> +
> +        value =3D await self.upstream_client.test_pr(version, pkgarch,
> checksum)
> +
> +        if value is not None:
> +
> +            # Upstream knows this output hash, let's store it and use it
> too.
> +
> +            if not self.server.read_only:
> +                self.server.table.store_value(version, pkgarch, checksum=
,
> value)
> +            # If the local server is read only, won't be able to store
> the new
> +            # value in the database and will have to keep asking the
> upstream server
>

I assume it is in the find_value() call above where we'll short circuit the
call
to the upstream server if the hash hasn't changed and we've stored it
locally.



> +
> +            return {"value": value}
> +
> +        # The output hash doesn't exist upstream, get the most recent
> number from upstream (x)
> +        # Then, we want to have a new PR value for the local server: x.y
> +
> +        upstream_max =3D await self.upstream_client.max_package_pr(versi=
on,
> pkgarch)
> +        # Here we know that the package is known upstream, so
> upstream_max can't be None
> +        subvalue =3D self.server.table.find_new_subvalue(version, pkgarc=
h,
> upstream_max)
> +
> +        if not self.server.read_only:
> +            self.server.table.store_value(version, pkgarch, checksum,
> subvalue)
> +
> +        return {"value": subvalue}
> +
> +    async def process_requests(self):
> +        if self.server.upstream is not None:
> +            self.upstream_client =3D await
> create_async_client(self.server.upstream)
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
> @@ -117,11 +180,12 @@ class
> PRServerClient(bb.asyncrpc.AsyncServerConnection):
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
>          self.logger.info("Started PRServer with DBfile: %s, Address: %s,
> PID: %s" %
>                       (self.dbfile, self.address, str(os.getpid())))
>
> +        if self.upstream is not None:
> +            self.logger.info("And upstream PRServer: %s " %
> (self.upstream))
> +
>

I noticed there were some direct call to the global logger above. Is the
mixing of logger and self.logger intentional (based on whether or not
the object has a logger .. I assume .. but I wanted to be sure).

Bruce



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
>          self.prserv.start_tcp_server(socket.gethostbyname(self.host),
> self.port)
>          self.process =3D
> self.prserv.serve_as_process(log_level=3Dlogging.WARNING)
>
> @@ -233,7 +301,7 @@ def run_as_daemon(func, pidfile, logfile):
>      os.remove(pidfile)
>      os._exit(0)
>
> -def start_daemon(dbfile, host, port, logfile, read_only=3DFalse):
> +def start_daemon(dbfile, host, port, logfile, read_only=3DFalse,
> upstream=3DNone):
>      ip =3D socket.gethostbyname(host)
>      pidfile =3D PIDPREFIX % (ip, port)
>      try:
> @@ -249,7 +317,7 @@ def start_daemon(dbfile, host, port, logfile,
> read_only=3DFalse):
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
> -            singleton =3D PRServSingleton(os.path.abspath(dbfile),
> os.path.abspath(logfile), host, port)
> +            singleton =3D PRServSingleton(os.path.abspath(dbfile),
> os.path.abspath(logfile), host, port, upstream)
>              singleton.start()
>      if singleton:
>          host =3D singleton.host
> --
> 2.34.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16086):
> https://lists.openembedded.org/g/bitbake-devel/message/16086
> Mute This Topic: https://lists.openembedded.org/mt/105479101/1050810
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> bruce.ashfield@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--=20
- Thou shalt not follow the NULL pointer, for chaos and madness await thee
at its end
- "Use the force Harry" - Gandalf, Star Trek II

--0000000000008caa9c06164c620d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Apr 12, 2024 at 5:02=E2=80=AFAM Michael Opd=
enacker via <a href=3D"http://lists.openembedded.org">lists.openembedded.or=
g</a> &lt;michael.opdenacker=3D<a href=3D"mailto:bootlin.com@lists.openembe=
dded.org">bootlin.com@lists.openembedded.org</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">From: Michael Opdenacker &lt;<a=
 href=3D"mailto:michael.opdenacker@bootlin.com" target=3D"_blank">michael.o=
pdenacker@bootlin.com</a>&gt;<br>
<br>
Introduce a PRSERVER_UPSTREAM variable that makes the<br>
local PR server connect to an &quot;upstream&quot; one.<br>
<br></blockquote><div><br></div><div><div class=3D"gmail_default" style=3D"=
font-size:small">I assume we&#39;ll eventually put something about the new =
variable</div><div class=3D"gmail_default" style=3D"font-size:small">in tem=
plate conf files (commented out), similar to the upstream</div><div class=
=3D"gmail_default" style=3D"font-size:small">hasserv ones ?</div></div><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
This makes it possible to implement local fixes to an<br>
upstream package (revision &quot;x&quot;, in a way that gives the local<br>
update priority (revision &quot;x.y&quot;).<br></blockquote><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
Update the calculation of the new revisions to support the<br>
case when prior revisions are not integers, but have<br>
an &quot;x.y...&quot; format.&quot;<br>
<br>
Set the comments in the handle_get_pr() function in serv.py<br>
for details about the calculation of the local revision.<br>
<br>
Use the newly developed functions to simplify the implementation<br>
of the get_value() function by merging the code of the earlier<br>
_get_value_hist() and _get_value_nohist() functions, removing<br>
redundancy between both functions. This also makes the code easier<br>
to understand.<br>
<br>
Signed-off-by: Michael Opdenacker &lt;<a href=3D"mailto:michael.opdenacker@=
bootlin.com" target=3D"_blank">michael.opdenacker@bootlin.com</a>&gt;<br>
Cc: Joshua Watt &lt;<a href=3D"mailto:JPEWhacker@gmail.com" target=3D"_blan=
k">JPEWhacker@gmail.com</a>&gt;<br>
Cc: Tim Orling &lt;<a href=3D"mailto:ticotimo@gmail.com" target=3D"_blank">=
ticotimo@gmail.com</a>&gt;<br>
Cc: Thomas Petazzoni &lt;<a href=3D"mailto:thomas.petazzoni@bootlin.com" ta=
rget=3D"_blank">thomas.petazzoni@bootlin.com</a>&gt;<br>
---<br>
=C2=A0bin/bitbake-prserv=C2=A0 =C2=A0 =C2=A0|=C2=A0 15 ++++-<br>
=C2=A0lib/prserv/__init__.py |=C2=A0 15 +++++<br>
=C2=A0lib/prserv/client.py=C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0lib/prserv/db.py=C2=A0 =C2=A0 =C2=A0 =C2=A0| 125 ++++++++++++++++++++=
---------------------<br>
=C2=A0lib/prserv/serv.py=C2=A0 =C2=A0 =C2=A0|=C2=A0 95 ++++++++++++++++++++=
+++++++----<br>
=C2=A05 files changed, 174 insertions(+), 77 deletions(-)<br>
<br>
diff --git a/bin/bitbake-prserv b/bin/bitbake-prserv<br>
index ad0a069401..e39d0fba87 100755<br>
--- a/bin/bitbake-prserv<br>
+++ b/bin/bitbake-prserv<br>
@@ -70,12 +70,25 @@ def main():<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0action=3D&quot;store_true&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0help=3D&quot;open database in read-only m=
ode&quot;,<br>
=C2=A0 =C2=A0 =C2=A0)<br>
+=C2=A0 =C2=A0 parser.add_argument(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;-u&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;--upstream&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default=3Dos.environ.get(&quot;PRSERVER_UPSTRE=
AM&quot;, None),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 help=3D&quot;Upstream PR service (host:port)&q=
uot;,<br>
+=C2=A0 =C2=A0 )<br>
<br>
=C2=A0 =C2=A0 =C2=A0args =3D parser.parse_args()<br>
=C2=A0 =C2=A0 =C2=A0prserv.init_logger(os.path.abspath(args.log), args.logl=
evel)<br>
<br>
=C2=A0 =C2=A0 =C2=A0if args.start:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret=3Dprserv.serv.start_daemon(args.file, args=
.host, args.port, os.path.abspath(args.log), args.read_only)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret=3Dprserv.serv.start_daemon(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 args.file,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 args.host,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 args.port,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.path.abspath(args.log),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 args.read_only,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 args.upstream<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
=C2=A0 =C2=A0 =C2=A0elif args.stop:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret=3Dprserv.serv.stop_daemon(args.host, =
args.port)<br>
=C2=A0 =C2=A0 =C2=A0else:<br>
diff --git a/lib/prserv/__init__.py b/lib/prserv/__init__.py<br>
index 0e0aa34d0e..2ee6a28c04 100644<br>
--- a/lib/prserv/__init__.py<br>
+++ b/lib/prserv/__init__.py<br>
@@ -8,6 +8,7 @@ __version__ =3D &quot;1.0.0&quot;<br>
<br>
=C2=A0import os, time<br>
=C2=A0import sys, logging<br>
+from bb.asyncrpc.client import parse_address, ADDR_TYPE_UNIX, ADDR_TYPE_WS=
<br>
<br>
=C2=A0def init_logger(logfile, loglevel):<br>
=C2=A0 =C2=A0 =C2=A0numeric_level =3D getattr(logging, loglevel.upper(), No=
ne)<br>
@@ -18,3 +19,17 @@ def init_logger(logfile, loglevel):<br>
<br>
=C2=A0class NotFoundError(Exception):<br>
=C2=A0 =C2=A0 =C2=A0pass<br>
+<br>
+async def create_async_client(addr):<br>
+=C2=A0 =C2=A0 from . import client<br>
+<br>
+=C2=A0 =C2=A0 c =3D client.PRAsyncClient()<br>
+<br>
+=C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (typ, a) =3D parse_address(addr)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 await c.connect_tcp(*a)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return c<br>
+<br>
+=C2=A0 =C2=A0 except Exception as e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 await c.close()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise e<br>
diff --git a/lib/prserv/client.py b/lib/prserv/client.py<br>
index 8471ee3046..89760b6f74 100644<br>
--- a/lib/prserv/client.py<br>
+++ b/lib/prserv/client.py<br>
@@ -6,6 +6,7 @@<br>
<br>
=C2=A0import logging<br>
=C2=A0import bb.asyncrpc<br>
+from . import create_async_client<br>
<br>
=C2=A0logger =3D logging.getLogger(&quot;BitBake.PRserv&quot;)<br>
<br>
diff --git a/lib/prserv/db.py b/lib/prserv/db.py<br>
index eb41508198..8305238f7a 100644<br>
--- a/lib/prserv/db.py<br>
+++ b/lib/prserv/db.py<br>
@@ -21,6 +21,20 @@ sqlversion =3D sqlite3.sqlite_version_info<br>
=C2=A0if sqlversion[0] &lt; 3 or (sqlversion[0] =3D=3D 3 and sqlversion[1] =
&lt; 3):<br>
=C2=A0 =C2=A0 =C2=A0raise Exception(&quot;sqlite3 version 3.3.0 or later is=
 required.&quot;)<br>
<br>
+def increase_revision(ver):<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Take a revision string such as &quot;1&quo=
t; or &quot;1.2.3&quot; or even a number and increase its last number<br>
+=C2=A0 =C2=A0 This fails if the last number is not an integer&quot;&quot;&=
quot;<br>
+<br>
+=C2=A0 =C2=A0 fields=3Dstr(ver).split(&#39;.&#39;)<br>
+=C2=A0 =C2=A0 last =3D fields[-1]<br>
+<br>
+=C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D int(last)<br>
+=C2=A0 =C2=A0 except Exception as e:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0logger.critical(&quot;Unable to increase=
 revision value %s: %s&quot; % (ver, e))<span class=3D"gmail_default" style=
=3D"font-size:small"></span><br>
+<br></blockquote><div><br></div><div><div class=3D"gmail_default" style=3D=
"font-size:small">What&#39;s the chain of events that will happen after thi=
s log and the return ? The log</div><div class=3D"gmail_default" style=3D"f=
ont-size:small">message itself isn&#39;t going to tell us much, as the pack=
age name, etc, aren&#39;t available</div><div class=3D"gmail_default" style=
=3D"font-size:small">at this point.</div><div class=3D"gmail_default" style=
=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D"font-s=
ize:small">Should we be raising another exception ? Something else ? Such t=
hat we can</div><div class=3D"gmail_default" style=3D"font-size:small">get =
a better log message from calling code that has more context about what</di=
v><div class=3D"gmail_default" style=3D"font-size:small">package or what mi=
ght have lead to the issue ?</div><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:sma=
ll">Should processing stop and the build fail ? If we don&#39;t have a fail=
ure, we risk</div><div class=3D"gmail_default" style=3D"font-size:small">ge=
tting a package with the same version and changes being missed. This</div><=
div class=3D"gmail_default" style=3D"font-size:small">could already be the =
case in other parts of the code, I&#39;m only wondering it while</div><div =
class=3D"gmail_default" style=3D"font-size:small">reading this specific=C2=
=A0routine. (and I can never remember if logger.cirtical()</div><div class=
=3D"gmail_default" style=3D"font-size:small">aborts execution on it&#39;s o=
wn).</div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
+=C2=A0 =C2=A0 return &quot;.&quot;.join(fields[0:-1] + list(str(val + 1)))=
<br>
+<br>
=C2=A0#<br>
=C2=A0# &quot;No History&quot; mode - for a given query tuple (version, pkg=
arch, checksum),<br>
=C2=A0# the returned value will be the largest among all the values of the =
same<br>
@@ -53,7 +67,7 @@ class PRTable(object):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0(version TEXT NOT NULL, \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0pkgarch TEXT NOT NULL,=C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0checksum TEXT NOT NULL, \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 value INTEGER, \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 value TEXT, \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0PRIMARY KEY (version, pkgarch, checksum));&quot; % self.ta=
ble)<br>
<br>
=C2=A0 =C2=A0 =C2=A0def _execute(self, *query):<br>
@@ -119,84 +133,67 @@ class PRTable(object):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data =3D self._execute(&quot;SELECT max(v=
alue) FROM %s where version=3D? AND pkgarch=3D?;&quot; % (self.table),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (version, pkgarch))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0row =3D data.fetchone()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if row is not None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # With SELECT max() requests, you have an empt=
y row when there are no values, therefore the test on row[0]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if row is not None and row[0] is not None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return row[0]<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return None<br>
<br>
-=C2=A0 =C2=A0 def _get_value_hist(self, version, pkgarch, checksum):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 data=3Dself._execute(&quot;SELECT value FROM %=
s WHERE version=3D? AND pkgarch=3D? AND checksum=3D?;&quot; % self.table,<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0(version, pkgarch, checksum))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 row=3Ddata.fetchone()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if row is not None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return row[0]<br>
+=C2=A0 =C2=A0 def find_new_subvalue(self, version, pkgarch, base):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Take and increase the greate=
st &quot;&lt;base&gt;.y&quot; value for (version, pkgarch), or return &quot=
;&lt;base&gt;.1&quot; if not found.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 This doesn&#39;t store a new value.&quot;&quot=
;&quot;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D self._execute(&quot;SELECT max(value)=
 FROM %s where version=3D? AND pkgarch=3D? AND value LIKE &#39;%s.%%&#39;;&=
quot; % (self.table, base),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(version, pkgarch))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 row =3D data.fetchone()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # With SELECT max() requests, you have an empt=
y row when there are no values, therefore the test on row[0]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if row is not None and row[0] is not None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return increase_revision(row[0])=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 #no value found, try to insert<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.read_only:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D self._exe=
cute(&quot;SELECT ifnull(max(value)+1, 0) FROM %s where version=3D? AND pkg=
arch=3D?;&quot; % (self.table),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(version, pkgarch))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 row =3D data.fetch=
one()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if row is not None=
:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn row[0]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 retu=
rn 0<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return base + &quot;.0&quot;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._execute(&quo=
t;INSERT INTO %s VALUES (?, ?, ?, (select ifnull(max(value)+1, 0) from %s w=
here version=3D? AND pkgarch=3D?));&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0% (self.table, self.table),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0(version, pkgarch, checksum, version, pkgarch))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 except sqlite3.IntegrityError as=
 exc:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 logger.error(str(e=
xc))<br>
+=C2=A0 =C2=A0 def store_value(self, version, pkgarch, checksum, value):<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Store new value in the datab=
ase&quot;&quot;&quot;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.dirty =3D True<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._execute(&quot;INSERT INTO =
%s VALUES (?, ?, ?, ?);&quot;=C2=A0 % (self.table),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(version, pkgarch, checksum, value))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 except sqlite3.IntegrityError as exc:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 logger.error(str(exc))<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data=3Dself._execute(&quot;SELEC=
T value FROM %s WHERE version=3D? AND pkgarch=3D? AND checksum=3D?;&quot; %=
 self.table,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(version, pkgarch, checksum))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 row=3Ddata.fetchone()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if row is not None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return row[0]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise prserv.NotFo=
undError<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.dirty =3D True<br>
<br>
-=C2=A0 =C2=A0 def _get_value_no_hist(self, version, pkgarch, checksum):<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 data=3Dself._execute(&quot;SELECT value FROM %=
s \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 WHERE version=3D? AND pkgarch=3D? AND checksum=3D?=
 AND \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 value &gt;=3D (select max(value) from %s where ver=
sion=3D? AND pkgarch=3D?);&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 % (self.table, self.table),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 (version, pkgarch, checksum, version, pkgarch))<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 row=3Ddata.fetchone()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if row is not None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return row[0]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 #no value found, try to insert<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.read_only:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D self._exe=
cute(&quot;SELECT ifnull(max(value)+1, 0) FROM %s where version=3D? AND pkg=
arch=3D?;&quot; % (self.table),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(version, pkgarch))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return data.fetcho=
ne()[0]<br>
+=C2=A0 =C2=A0 def _get_value(self, version, pkgarch, checksum):<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._execute(&quo=
t;INSERT OR REPLACE INTO %s VALUES (?, ?, ?, (select ifnull(max(value)+1, 0=
) from %s where version=3D? AND pkgarch=3D?));&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0% (self.table, self.table),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(version, pkgarch, checksum, version,=
 pkgarch))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 except sqlite3.IntegrityError as=
 exc:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 logger.error(str(e=
xc))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.conn.rollback=
()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 max_value =3D self.find_max_value(version, pkg=
arch)<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.dirty =3D True<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if max_value is None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # version, pkgarch completely un=
known. Return initial value.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;0&quot;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data=3Dself._execute(&quot;SELEC=
T value FROM %s WHERE version=3D? AND pkgarch=3D? AND checksum=3D?;&quot; %=
 self.table,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(version, pkgarch, checksum))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 row=3Ddata.fetchone()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if row is not None:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return row[0]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise prserv.NotFo=
undError<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D self.find_value(version, pkgarch, ch=
ecksum)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if value is None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # version, pkgarch found but not=
 checksum. Create a new value from the maximum one<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return increase_revision(max_val=
ue)<br>
<br>
-=C2=A0 =C2=A0 def get_value(self, version, pkgarch, checksum):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.nohist:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return self._get_value_no_hist(v=
ersion, pkgarch, checksum)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # &quot;no-history&quot; mode: o=
nly return a value if that&#39;s the maximum one for<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # the version and architecture, =
otherwise create a new one.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # This means that the value cann=
ot decrement.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if value =3D=3D max_value:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return value<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return increase_re=
vision(max_value)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return self._get_value_hist(vers=
ion, pkgarch, checksum)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # &quot;hist&quot; mode: we foun=
d an existing value. We can return it<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # whether it&#39;s the maximum o=
ne or not.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return value<br>
+<br>
+=C2=A0 =C2=A0 def get_value(self, version, pkgarch, checksum):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D self._get_value(version, pkgarch, ch=
ecksum)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.store_value(version, pkgarch, checksum, v=
alue)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return value<br>
<br>
=C2=A0 =C2=A0 =C2=A0def _import_hist(self, version, pkgarch, checksum, valu=
e):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.read_only:<br>
diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py<br>
index dc4be5b620..9e07a34445 100644<br>
--- a/lib/prserv/serv.py<br>
+++ b/lib/prserv/serv.py<br>
@@ -12,6 +12,7 @@ import sqlite3<br>
=C2=A0import prserv<br>
=C2=A0import prserv.db<br>
=C2=A0import errno<br>
+from . import create_async_client<br>
=C2=A0import bb.asyncrpc<br>
<br>
=C2=A0logger =3D logging.getLogger(&quot;BitBake.PRserv&quot;)<br>
@@ -76,14 +77,76 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection)=
:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pkgarch =3D request[&quot;pkgarch&quot;]<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0checksum =3D request[&quot;checksum&quot;=
]<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 response =3D None<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.upstream_client is None:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0value =3D self.server.table=
.get_value(version, pkgarch, checksum)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 response =3D {&quot;value&quot;:=
 value}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 except prserv.NotFoundError:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.logger.error(&quot;failure =
storing value in database for (%s, %s)&quot;,version, checksum)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return {&quot;value&quot;: value=
}<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return response<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # We have an upstream server.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Check whether the local server already knows=
 the requested configuration<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Here we use find_value(), not get_value(), b=
ecause we don&#39;t want<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # to unconditionally add a new generated value=
 to the database. If the configuration<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # is a new one, the generated value we will ad=
d will depend on what&#39;s on the upstream server.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D self.server.table.find_value(version=
, pkgarch, checksum)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if value is not None:<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # The configuration is already k=
nown locally. Let&#39;s use it.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return {&quot;value&quot;: value=
}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # The configuration is a new one for the local=
 server<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Let&#39;s ask the upstream server whether it=
 knows it<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 known_upstream =3D await self.upstream_client.=
test_package(version, pkgarch)<br>
+<br></blockquote><div><br></div><div><div class=3D"gmail_default" style=3D=
"font-size:small">Remind me .. what happens in the case of timeouts or othe=
r issues ? Is there</div><div class=3D"gmail_default" style=3D"font-size:sm=
all">any way to detect it and provide a message ? Right now, it looks like =
it&#39;ll just</div><div class=3D"gmail_default" style=3D"font-size:small">=
fall through to local PR server functionality. Which I don&#39;t know is ri=
ght or wrong,</div><div class=3D"gmail_default" style=3D"font-size:small">j=
ust that there&#39;s no way to really tell it happened.</div></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not known_upstream:<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # The package is not known upstr=
eam, must be a local-only package<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Let&#39;s compute the PR numbe=
r using the local-only method<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D self.server.table.get_=
value(version, pkgarch, checksum)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return {&quot;value&quot;: value=
}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # The package is known upstream, let&#39;s ask=
 the upstream server<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # whether it knows our new output hash<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D await self.upstream_client.test_pr(v=
ersion, pkgarch, checksum)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if value is not None:<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Upstream knows this output has=
h, let&#39;s store it and use it too.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not self.server.read_only:<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.server.table.=
store_value(version, pkgarch, checksum, value)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # If the local server is read on=
ly, won&#39;t be able to store the new<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # value in the database and will=
 have to keep asking the upstream server<br></blockquote><div><br></div><di=
v><div class=3D"gmail_default" style=3D"font-size:small">I assume it is in =
the find_value() call above where we&#39;ll short circuit the call</div><di=
v class=3D"gmail_default" style=3D"font-size:small">to the upstream server =
if the hash hasn&#39;t changed and we&#39;ve stored it locally.</div><br></=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return {&quot;value&quot;: value=
}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # The output hash doesn&#39;t exist upstream, =
get the most recent number from upstream (x)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Then, we want to have a new PR value for the=
 local server: x.y<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 upstream_max =3D await self.upstream_client.ma=
x_package_pr(version, pkgarch)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Here we know that the package is known upstr=
eam, so upstream_max can&#39;t be None<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 subvalue =3D self.server.table.find_new_subval=
ue(version, pkgarch, upstream_max)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not self.server.read_only:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.server.table.store_value(ve=
rsion, pkgarch, checksum, subvalue)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return {&quot;value&quot;: subvalue}<br>
+<br>
+=C2=A0 =C2=A0 async def process_requests(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.server.upstream is not None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.upstream_client =3D await c=
reate_async_client(self.server.upstream)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.upstream_client =3D None<br=
>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 await super().process_requests()=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 finally:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.upstream_client is not N=
one:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 await self.upstrea=
m_client.close()<br>
<br>
=C2=A0 =C2=A0 =C2=A0async def handle_import_one(self, request):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0response =3D None<br>
@@ -117,11 +180,12 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnectio=
n):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return {&quot;readonly&quot;: self.server=
.read_only}<br>
<br>
=C2=A0class PRServer(bb.asyncrpc.AsyncServer):<br>
-=C2=A0 =C2=A0 def __init__(self, dbfile, read_only=3DFalse):<br>
+=C2=A0 =C2=A0 def __init__(self, dbfile, read_only=3DFalse, upstream=3DNon=
e):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0super().__init__(logger)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.dbfile =3D dbfile<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.table =3D None<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.read_only =3D read_only<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.upstream =3D upstream<br>
<br>
=C2=A0 =C2=A0 =C2=A0def accept_client(self, socket):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PRServerClient(socket, self)<br>
@@ -134,6 +198,9 @@ class PRServer(bb.asyncrpc.AsyncServer):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"http://self.logger.info" rel=
=3D"noreferrer" target=3D"_blank">self.logger.info</a>(&quot;Started PRServ=
er with DBfile: %s, Address: %s, PID: %s&quot; %<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (self.dbfile, self.address, str(os.getpid())))<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.upstream is not None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://self.logger.in=
fo" rel=3D"noreferrer" target=3D"_blank">self.logger.info</a>(&quot;And ups=
tream PRServer: %s &quot; % (self.upstream))<br>
+<br></blockquote><div><br></div><div><div class=3D"gmail_default" style=3D=
"font-size:small">I noticed there were some direct call to the global logge=
r above. Is the</div><div class=3D"gmail_default" style=3D"font-size:small"=
>mixing of logger and self.logger intentional (based on whether or not</div=
><div class=3D"gmail_default" style=3D"font-size:small">the object has a lo=
gger .. I assume .. but I wanted to be sure).</div><div class=3D"gmail_defa=
ult" style=3D"font-size:small"><br></div><div class=3D"gmail_default" style=
=3D"font-size:small">Bruce</div><br></div><div>=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return tasks<br>
<br>
=C2=A0 =C2=A0 =C2=A0async def stop(self):<br>
@@ -147,14 +214,15 @@ class PRServer(bb.asyncrpc.AsyncServer):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.table.sync()<br>
<br>
=C2=A0class PRServSingleton(object):<br>
-=C2=A0 =C2=A0 def __init__(self, dbfile, logfile, host, port):<br>
+=C2=A0 =C2=A0 def __init__(self, dbfile, logfile, host, port, upstream):<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.dbfile =3D dbfile<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.logfile =3D logfile<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.host =3D host<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.port =3D port<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.upstream =3D upstream<br>
<br>
=C2=A0 =C2=A0 =C2=A0def start(self):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.prserv =3D PRServer(self.dbfile)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.prserv =3D PRServer(self.dbfile, upstream=
=3Dself.upstream)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.prserv.start_tcp_server(socket.getho=
stbyname(self.host), self.port)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.process =3D self.prserv.serve_as_pro=
cess(log_level=3Dlogging.WARNING)<br>
<br>
@@ -233,7 +301,7 @@ def run_as_daemon(func, pidfile, logfile):<br>
=C2=A0 =C2=A0 =C2=A0os.remove(pidfile)<br>
=C2=A0 =C2=A0 =C2=A0os._exit(0)<br>
<br>
-def start_daemon(dbfile, host, port, logfile, read_only=3DFalse):<br>
+def start_daemon(dbfile, host, port, logfile, read_only=3DFalse, upstream=
=3DNone):<br>
=C2=A0 =C2=A0 =C2=A0ip =3D socket.gethostbyname(host)<br>
=C2=A0 =C2=A0 =C2=A0pidfile =3D PIDPREFIX % (ip, port)<br>
=C2=A0 =C2=A0 =C2=A0try:<br>
@@ -249,7 +317,7 @@ def start_daemon(dbfile, host, port, logfile, read_only=
=3DFalse):<br>
<br>
=C2=A0 =C2=A0 =C2=A0dbfile =3D os.path.abspath(dbfile)<br>
=C2=A0 =C2=A0 =C2=A0def daemon_main():<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 server =3D PRServer(dbfile, read_only=3Dread_o=
nly)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 server =3D PRServer(dbfile, read_only=3Dread_o=
nly, upstream=3Dupstream)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0server.start_tcp_server(ip, port)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0server.serve_forever()<br>
<br>
@@ -336,6 +404,9 @@ def auto_start(d):<br>
<br>
=C2=A0 =C2=A0 =C2=A0host =3D host_params[0].strip().lower()<br>
=C2=A0 =C2=A0 =C2=A0port =3D int(host_params[1])<br>
+<br>
+=C2=A0 =C2=A0 upstream =3D d.getVar(&quot;PRSERV_UPSTREAM&quot;) or None<b=
r>
+<br>
=C2=A0 =C2=A0 =C2=A0if is_local_special(host, port):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0import bb.utils<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cachedir =3D (d.getVar(&quot;PERSISTENT_D=
IR&quot;) or d.getVar(&quot;CACHE&quot;))<br>
@@ -350,7 +421,7 @@ def auto_start(d):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 auto_shutdown()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not singleton:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.utils.mkdirhier(cachedir=
)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 singleton =3D PRServSingleton(os=
.path.abspath(dbfile), os.path.abspath(logfile), host, port)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 singleton =3D PRServSingleton(os=
.path.abspath(dbfile), os.path.abspath(logfile), host, port, upstream)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0singleton.start()<br>
=C2=A0 =C2=A0 =C2=A0if singleton:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host =3D singleton.host<br>
-- <br>
2.34.1<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#16086): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/16086" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/16086</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/105479101/105=
0810" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/105479101/1050810</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:bruce.ashfield@gmail.com" target=
=3D"_blank">bruce.ashfield@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">- =
Thou shalt not follow the NULL pointer, for chaos and madness await thee at=
 its end<br>- &quot;Use the force Harry&quot; - Gandalf, Star Trek II<br><b=
r></div></div>

--0000000000008caa9c06164c620d--

