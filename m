Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AABC4345F
	for <webhook@archiver.kernel.org>; Mon, 29 Apr 2024 20:34:51 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
 by mx.groups.io with SMTP id smtpd.web11.32701.1714422881159563057
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 29 Apr 2024 13:34:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=NB2qXwgN;
 spf=pass (domain: gmail.com, ip: 209.85.167.45, mailfrom: jpewhacker@gmail.com)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5176f217b7bso8585149e87.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 29 Apr 2024 13:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714422879; x=1715027679; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVVhusE+A/YdTIuqrDq8Pv06Q4op3uylMaI1nt1pgOk=;
        b=NB2qXwgNe5m69A4DeSWudwXAHF9joF6+9fgvKw24o7U+VK/OIwP7NhImxYmfR6vcjK
         SCLe0QiM4dzi2pYmrWcRHufS6xggjg06pqd/Y/ontWSEnXhtdRnx+PBkkSBnEzByrM9j
         SaFWhXpQJIqYJ0KjfVh85QVOry8n2SZClTXn57wjiUCAWVQWDPYqoVg/PMQu/NnZuteo
         30VrRRAorToBJM9RLrELn39nD5pibK3rrngTvxwqV4OcISqV4Uwhfglo3vmWmlu/aJlC
         Y4q5YxEbKLan9L3hEe+een1/wtfxu2lcyvg2JPuZGPqag/pZeq3MXZ8HzKLLR8g1j1EG
         /vWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714422879; x=1715027679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GVVhusE+A/YdTIuqrDq8Pv06Q4op3uylMaI1nt1pgOk=;
        b=uLlVgWAk3m7fUE3gKZFXZzYTOjKMZAY1FIU4Eetk6RVxi/CNFhX3A8QAeYqNvFBs6A
         NAlzzUAHHKYZde8tcWqsDh2pm5MVzCopucujIxZVz0+fHk77frk7KzeeTXu2K08DaK4m
         glU9bQLTRaayrcfm56Fu0qDhFO7NrMREnhctga33+uz70EthUOXZ81++oMrX2wVtgmeR
         DgDYxMcRWl0S5NZD0wHHSd25aQQKu1oLuhlvi16dDY7D/taS/tWd5gsaMxYz6a4uc0uX
         6BV7goeHLJwQFpSgCAfqKZCQyslDmo+QpEfwfiRFPqcafmqFsDNrPtmCzyGIynLMOPaj
         aHGQ==
X-Gm-Message-State: AOJu0Yx+DceE19+EHZjQuZXFYSh1Lvnt6+amjVpvYvu7ewQCnGf2XqEG
	ze+aPuuG2oXIIiTZdZr6bUVmYM0gqHBvn38xdqweEjsN7e+CbewxIXXT3vYlbgQ0AjCZcUCA2lP
	6IU0z7P3v9EZjKvEwHLS41qf9hDY=
X-Google-Smtp-Source: AGHT+IGd5xsFdp1Cg53u5j04tee4Vufh1fZRuobETd6eLr01BCW2+fvNGcqxhgVflqgIoGp7F5dFG6/9iyuEQKhipJ4=
X-Received: by 2002:ac2:4a70:0:b0:51b:250a:a8fb with SMTP id
 q16-20020ac24a70000000b0051b250aa8fbmr9705995lfp.48.1714422878794; Mon, 29
 Apr 2024 13:34:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240429201418.657042-1-michael.opdenacker@bootlin.com> <20240429201418.657042-5-michael.opdenacker@bootlin.com>
In-Reply-To: <20240429201418.657042-5-michael.opdenacker@bootlin.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Mon, 29 Apr 2024 14:34:26 -0600
Message-ID: <CAJdd5GbeJL=Z4-YHYm8eab0x3JD3yynoBE+S0LsuP_E3cCYQPA@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] prserv: enable database sharing
To: michael.opdenacker@bootlin.com
Cc: bitbake-devel@lists.openembedded.org, Tim Orling <ticotimo@gmail.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 29 Apr 2024 20:34:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16156

On Mon, Apr 29, 2024 at 2:14=E2=80=AFPM <michael.opdenacker@bootlin.com> wr=
ote:
>
> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
>
> sqlite3 can allow multiple processes to access the database
> simultaneously, but it must be opened correctly. The key change is that
> the database is no longer opened in "exclusive" mode (defaulting to
> shared mode). In addition, the journal is set to "WAL" mode, as this is
> the most efficient for dealing with simultaneous access between
> different processes. In order to keep the database performance,
> synchronous mode is set to "off". The WAL journal will protect against
> incomplete transactions in any given client, however the database will
> not be protected against unexpected power loss from the OS (which is a
> fine trade off for performance, and also the same as the previous
> implementation).
>
> The use of a database cursor enabled to remove the _execute() wrapper.
> The cursor automatically makes sure that the query happens in an atomic
> transaction and commits when finished.
>
> This also removes the need for a "dirty" flag for the database and
> for explicit database syncing, which simplifies the code.
>
> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> Cc: Tim Orling <ticotimo@gmail.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> ---
>  lib/prserv/db.py   | 322 +++++++++++++++++++++------------------------
>  lib/prserv/serv.py |   8 --
>  2 files changed, 151 insertions(+), 179 deletions(-)
>
> diff --git a/lib/prserv/db.py b/lib/prserv/db.py
> index b2520f3158..f430586d73 100644
> --- a/lib/prserv/db.py
> +++ b/lib/prserv/db.py
> @@ -8,21 +8,13 @@ import logging
>  import os.path
>  import errno
>  import prserv
> -import time
> +import sqlite3
>
> +from contextlib import closing
>  from . import increase_revision, revision_greater, revision_smaller
>
> -try:
> -    import sqlite3
> -except ImportError:
> -    from pysqlite2 import dbapi2 as sqlite3
> -
>  logger =3D logging.getLogger("BitBake.PRserv")
>
> -sqlversion =3D sqlite3.sqlite_version_info
> -if sqlversion[0] < 3 or (sqlversion[0] =3D=3D 3 and sqlversion[1] < 3):
> -    raise Exception("sqlite3 version 3.3.0 or later is required.")
> -
>  #
>  # "No History" mode - for a given query tuple (version, pkgarch, checksu=
m),
>  # the returned value will be the largest among all the values of the sam=
e
> @@ -31,40 +23,28 @@ if sqlversion[0] < 3 or (sqlversion[0] =3D=3D 3 and s=
qlversion[1] < 3):
>  # "History" mode - Return a new higher value for previously unseen query
>  # tuple (version, pkgarch, checksum), otherwise return historical value.
>  # Value can decrement if returning to a previous build.
> -#
>
>  class PRTable(object):
>      def __init__(self, conn, table, read_only):
>          self.conn =3D conn
>          self.read_only =3D read_only
> -        self.dirty =3D False
>          self.table =3D table
>
> -        if self.read_only:
> -            table_exists =3D self._execute(
> -                        "SELECT count(*) FROM sqlite_master \
> -                        WHERE type=3D'table' AND name=3D'%s'" % (self.ta=
ble))
> -            if not table_exists:
> -                raise prserv.NotFoundError
> -        else:
> -            self._execute("CREATE TABLE IF NOT EXISTS %s \
> -                        (version TEXT NOT NULL, \
> -                        pkgarch TEXT NOT NULL,  \
> -                        checksum TEXT NOT NULL, \
> -                        value TEXT, \
> -                        PRIMARY KEY (version, pkgarch, checksum, value))=
;" % self.table)
> -
> -    def _execute(self, *query):
> -        """Execute a query, waiting to acquire a lock if necessary"""
> -        start =3D time.time()
> -        end =3D start + 20
> -        while True:
> -            try:
> -                return self.conn.execute(*query)
> -            except sqlite3.OperationalError as exc:
> -                if "is locked" in str(exc) and end > time.time():
> -                    continue
> -                raise exc
> +        with closing(self.conn.cursor()) as cursor:
> +            if self.read_only:
> +                table_exists =3D cursor.execute(
> +                            "SELECT count(*) FROM sqlite_master \
> +                            WHERE type=3D'table' AND name=3D'%s'" % (sel=
f.table))
> +                if not table_exists:
> +                    raise prserv.NotFoundError

This is a race if you run the read-only server first, which seems like
a bad user experience. I'd probably create the table even if the
server is read-only (I'm pretty sure hash server works this way also)

> +            else:
> +                cursor.execute("CREATE TABLE IF NOT EXISTS %s \
> +                            (version TEXT NOT NULL, \
> +                            pkgarch TEXT NOT NULL,  \
> +                            checksum TEXT NOT NULL, \
> +                            value TEXT, \
> +                            PRIMARY KEY (version, pkgarch, checksum, val=
ue));" % self.table)
> +                self.conn.commit()
>
>      def _extremum_value(self, rows, is_max):
>          value =3D None
> @@ -88,49 +68,42 @@ class PRTable(object):
>      def _min_value(self, rows):
>          return self._extremum_value(rows, False)
>
> -    def sync(self):
> -        if not self.read_only:
> -            self.conn.commit()
> -            self._execute("BEGIN EXCLUSIVE TRANSACTION")
> -
> -    def sync_if_dirty(self):
> -        if self.dirty:
> -            self.sync()
> -            self.dirty =3D False
> -
>      def test_package(self, version, pkgarch):
>          """Returns whether the specified package version is found in the=
 database for the specified architecture"""
>
>          # Just returns the value if found or None otherwise
> -        data=3Dself._execute("SELECT value FROM %s WHERE version=3D? AND=
 pkgarch=3D?;" % self.table,
> -                           (version, pkgarch))
> -        row=3Ddata.fetchone()
> -        if row is not None:
> -            return True
> -        else:
> -            return False
> +        with closing(self.conn.cursor()) as cursor:
> +            data=3Dcursor.execute("SELECT value FROM %s WHERE version=3D=
? AND pkgarch=3D?;" % self.table,
> +                               (version, pkgarch))
> +            row=3Ddata.fetchone()
> +            if row is not None:
> +                return True
> +            else:
> +                return False
>
>      def test_value(self, version, pkgarch, value):
>          """Returns whether the specified value is found in the database =
for the specified package and architecture"""
>
>          # Just returns the value if found or None otherwise
> -        data=3Dself._execute("SELECT value FROM %s WHERE version=3D? AND=
 pkgarch=3D? and value=3D?;" % self.table,
> -                           (version, pkgarch, value))
> -        row=3Ddata.fetchone()
> -        if row is not None:
> -            return True
> -        else:
> -            return False
> +        with closing(self.conn.cursor()) as cursor:
> +            data=3Dcursor.execute("SELECT value FROM %s WHERE version=3D=
? AND pkgarch=3D? and value=3D?;" % self.table,
> +                               (version, pkgarch, value))
> +            row=3Ddata.fetchone()
> +            if row is not None:
> +                return True
> +            else:
> +                return False
>
>
>      def find_package_max_value(self, version, pkgarch):
>          """Returns the greatest value for (version, pkgarch), or None if=
 not found. Doesn't create a new value"""
>
> -        data =3D self._execute("SELECT value FROM %s where version=3D? A=
ND pkgarch=3D?;" % (self.table),
> -                             (version, pkgarch))
> -        rows =3D data.fetchall()
> -        value =3D self._max_value(rows)
> -        return value
> +        with closing(self.conn.cursor()) as cursor:
> +            data =3D cursor.execute("SELECT value FROM %s where version=
=3D? AND pkgarch=3D?;" % (self.table),
> +                                 (version, pkgarch))
> +            rows =3D data.fetchall()
> +            value =3D self._max_value(rows)
> +            return value
>
>      def find_value(self, version, pkgarch, checksum, history=3DFalse):
>          """Returns the value for the specified checksum if found or None=
 otherwise."""
> @@ -145,10 +118,11 @@ class PRTable(object):
>          """Returns the maximum (if is_max is True) or minimum (if is_max=
 is False) value
>             for (version, pkgarch, checksum), or None if not found. Doesn=
't create a new value"""
>
> -        data =3D self._execute("SELECT value FROM %s where version=3D? A=
ND pkgarch=3D? AND checksum=3D?;" % (self.table),
> -                             (version, pkgarch, checksum))
> -        rows =3D data.fetchall()
> -        return self._extremum_value(rows, is_max)
> +        with closing(self.conn.cursor()) as cursor:
> +            data =3D cursor.execute("SELECT value FROM %s where version=
=3D? AND pkgarch=3D? AND checksum=3D?;" % (self.table),
> +                                 (version, pkgarch, checksum))
> +            rows =3D data.fetchall()
> +            return self._extremum_value(rows, is_max)
>
>      def find_max_value(self, version, pkgarch, checksum):
>          return self._find_extremum_value(version, pkgarch, checksum, Tru=
e)
> @@ -160,26 +134,27 @@ class PRTable(object):
>          """Take and increase the greatest "<base>.y" value for (version,=
 pkgarch), or return "<base>.0" if not found.
>          This doesn't store a new value."""
>
> -        data =3D self._execute("SELECT value FROM %s where version=3D? A=
ND pkgarch=3D? AND value LIKE '%s.%%';" % (self.table, base),
> -                             (version, pkgarch))
> -        rows =3D data.fetchall()
> -        value =3D self._max_value(rows)
> +        with closing(self.conn.cursor()) as cursor:
> +            data =3D cursor.execute("SELECT value FROM %s where version=
=3D? AND pkgarch=3D? AND value LIKE '%s.%%';" % (self.table, base),
> +                                 (version, pkgarch))
> +            rows =3D data.fetchall()
> +            value =3D self._max_value(rows)
>
> -        if value is not None:
> -            return increase_revision(value)
> -        else:
> -            return base + ".0"
> +            if value is not None:
> +                return increase_revision(value)
> +            else:
> +                return base + ".0"
>
>      def store_value(self, version, pkgarch, checksum, value):
>          """Store new value in the database"""
>
> -        try:
> -            self._execute("INSERT INTO %s VALUES (?, ?, ?, ?);"  % (self=
.table),
> -                       (version, pkgarch, checksum, value))
> -        except sqlite3.IntegrityError as exc:
> -            logger.error(str(exc))
> -
> -        self.dirty =3D True
> +        with closing(self.conn.cursor()) as cursor:
> +            try:
> +                cursor.execute("INSERT INTO %s VALUES (?, ?, ?, ?);"  % =
(self.table),
> +                           (version, pkgarch, checksum, value))
> +            except sqlite3.IntegrityError as exc:
> +                logger.error(str(exc))
> +            self.conn.commit()
>
>      def _get_value(self, version, pkgarch, checksum, history):
>
> @@ -215,54 +190,56 @@ class PRTable(object):
>              return None
>
>          val =3D None
> -        data =3D self._execute("SELECT value FROM %s WHERE version=3D? A=
ND pkgarch=3D? AND checksum=3D?;" % self.table,
> +        with closing(self.conn.cursor()) as cursor:
> +            data =3D cursor.execute("SELECT value FROM %s WHERE version=
=3D? AND pkgarch=3D? AND checksum=3D?;" % self.table,
>                             (version, pkgarch, checksum))
> -        row =3D data.fetchone()
> -        if row is not None:
> -            val=3Drow[0]
> -        else:
> -            #no value found, try to insert
> -            try:
> -                self._execute("INSERT INTO %s VALUES (?, ?, ?, ?);"  % (=
self.table),
> -                           (version, pkgarch, checksum, value))
> -            except sqlite3.IntegrityError as exc:
> -                logger.error(str(exc))
> +            row =3D data.fetchone()
> +            if row is not None:
> +                val=3Drow[0]
> +            else:
> +                #no value found, try to insert
> +                try:
> +                    cursor.execute("INSERT INTO %s VALUES (?, ?, ?, ?);"=
  % (self.table),
> +                               (version, pkgarch, checksum, value))
> +                except sqlite3.IntegrityError as exc:
> +                    logger.error(str(exc))

You probably want to make this whole SELECT / INSERT block a loop, and
instead of repeating the SELECT below, retry the loop on an integrity
error. The only reason you should be getting an integrity error is if
you have a race between multiple servers accessing the database at
once. In that case, looping back and trying to fall out in the
previous SELECT is better.

This is especially important if you delete entries in the database, as
in pathological cases you might have to loop several times before you
fall out of the loop (although typically, you would only need to retry
once).

I'd recommend this paradigm any other places you do SELECT / INSERT
where the INSERT depends on the SELECT.

>
> -            self.dirty =3D True
> +                self.conn.commit()
>
> -            data =3D self._execute("SELECT value FROM %s WHERE version=
=3D? AND pkgarch=3D? AND checksum=3D?;" % self.table,
> +                data =3D cursor.execute("SELECT value FROM %s WHERE vers=
ion=3D? AND pkgarch=3D? AND checksum=3D?;" % self.table,
>                             (version, pkgarch, checksum))
> -            row =3D data.fetchone()
> -            if row is not None:
> -                val =3D row[0]
> +                row =3D data.fetchone()
> +                if row is not None:
> +                    val =3D row[0]
>          return val
>
>      def _import_no_hist(self, version, pkgarch, checksum, value):
>          if self.read_only:
>              return None
>
> -        try:
> -            #try to insert
> -            self._execute("INSERT INTO %s VALUES (?, ?, ?, ?);"  % (self=
.table),
> -                           (version, pkgarch, checksum, value))
> -        except sqlite3.IntegrityError as exc:
> -            #already have the record, try to update
> +        with closing(self.conn.cursor()) as cursor:
>              try:
> -                self._execute("UPDATE %s SET value=3D? WHERE version=3D?=
 AND pkgarch=3D? AND checksum=3D? AND value<?"
> -                              % (self.table),
> -                               (value, version, pkgarch, checksum, value=
))
> +                #try to insert
> +                cursor.execute("INSERT INTO %s VALUES (?, ?, ?, ?);"  % =
(self.table),
> +                               (version, pkgarch, checksum, value))
>              except sqlite3.IntegrityError as exc:
> -                logger.error(str(exc))
> +                #already have the record, try to update
> +                try:
> +                    cursor.execute("UPDATE %s SET value=3D? WHERE versio=
n=3D? AND pkgarch=3D? AND checksum=3D? AND value<?"
> +                                  % (self.table),
> +                                   (value, version, pkgarch, checksum, v=
alue))
> +                except sqlite3.IntegrityError as exc:
> +                    logger.error(str(exc))

Looping is suggested here also.

>
> -        self.dirty =3D True
> +                self.conn.commit()
>
> -        data =3D self._execute("SELECT value FROM %s WHERE version=3D? A=
ND pkgarch=3D? AND checksum=3D? AND value>=3D?;" % self.table,
> +            data =3D cursor.execute("SELECT value FROM %s WHERE version=
=3D? AND pkgarch=3D? AND checksum=3D? AND value>=3D?;" % self.table,
>                              (version, pkgarch, checksum, value))

You already have all the data for everything you inserted.... I'd
probably just return based on what you already know instead of another
SELECT, otherwise this could race (with a deletion) and fail.
Alternatively, I think sqlite can return the data for the
just-inserted-row, but I forget how off the top of my head.

> -        row=3Ddata.fetchone()
> -        if row is not None:
> -            return row[0]
> -        else:
> -            return None
> +            row=3Ddata.fetchone()
> +            if row is not None:
> +                return row[0]
> +            else:
> +                return None
>
>      def importone(self, version, pkgarch, checksum, value, history=3DFal=
se):
>          if history:
> @@ -272,56 +249,57 @@ class PRTable(object):
>
>      def export(self, version, pkgarch, checksum, colinfo, history=3DFals=
e):
>          metainfo =3D {}
> -        #column info
> -        if colinfo:
> -            metainfo["tbl_name"] =3D self.table
> -            metainfo["core_ver"] =3D prserv.__version__
> -            metainfo["col_info"] =3D []
> -            data =3D self._execute("PRAGMA table_info(%s);" % self.table=
)
> +        with closing(self.conn.cursor()) as cursor:
> +            #column info
> +            if colinfo:
> +                metainfo["tbl_name"] =3D self.table
> +                metainfo["core_ver"] =3D prserv.__version__
> +                metainfo["col_info"] =3D []
> +                data =3D cursor.execute("PRAGMA table_info(%s);" % self.=
table)
> +                for row in data:
> +                    col =3D {}
> +                    col["name"] =3D row["name"]
> +                    col["type"] =3D row["type"]
> +                    col["notnull"] =3D row["notnull"]
> +                    col["dflt_value"] =3D row["dflt_value"]
> +                    col["pk"] =3D row["pk"]
> +                    metainfo["col_info"].append(col)
> +
> +            #data info
> +            datainfo =3D []
> +
> +            if history:
> +                sqlstmt =3D "SELECT * FROM %s as T1 WHERE 1=3D1 " % self=
.table
> +            else:
> +                sqlstmt =3D "SELECT T1.version, T1.pkgarch, T1.checksum,=
 T1.value FROM %s as T1, \
> +                        (SELECT version, pkgarch, max(value) as maxvalue=
 FROM %s GROUP BY version, pkgarch) as T2 \
> +                        WHERE T1.version=3DT2.version AND T1.pkgarch=3DT=
2.pkgarch AND T1.value=3DT2.maxvalue " % (self.table, self.table)
> +            sqlarg =3D []
> +            where =3D ""
> +            if version:
> +                where +=3D "AND T1.version=3D? "
> +                sqlarg.append(str(version))
> +            if pkgarch:
> +                where +=3D "AND T1.pkgarch=3D? "
> +                sqlarg.append(str(pkgarch))
> +            if checksum:
> +                where +=3D "AND T1.checksum=3D? "
> +                sqlarg.append(str(checksum))
> +
> +            sqlstmt +=3D where + ";"
> +
> +            if len(sqlarg):
> +                data =3D cursor.execute(sqlstmt, tuple(sqlarg))
> +            else:
> +                data =3D cursor.execute(sqlstmt)
>              for row in data:
> -                col =3D {}
> -                col["name"] =3D row["name"]
> -                col["type"] =3D row["type"]
> -                col["notnull"] =3D row["notnull"]
> -                col["dflt_value"] =3D row["dflt_value"]
> -                col["pk"] =3D row["pk"]
> -                metainfo["col_info"].append(col)
> -
> -        #data info
> -        datainfo =3D []
> -
> -        if history:
> -            sqlstmt =3D "SELECT * FROM %s as T1 WHERE 1=3D1 " % self.tab=
le
> -        else:
> -            sqlstmt =3D "SELECT T1.version, T1.pkgarch, T1.checksum, T1.=
value FROM %s as T1, \
> -                    (SELECT version, pkgarch, max(value) as maxvalue FRO=
M %s GROUP BY version, pkgarch) as T2 \
> -                    WHERE T1.version=3DT2.version AND T1.pkgarch=3DT2.pk=
garch AND T1.value=3DT2.maxvalue " % (self.table, self.table)
> -        sqlarg =3D []
> -        where =3D ""
> -        if version:
> -            where +=3D "AND T1.version=3D? "
> -            sqlarg.append(str(version))
> -        if pkgarch:
> -            where +=3D "AND T1.pkgarch=3D? "
> -            sqlarg.append(str(pkgarch))
> -        if checksum:
> -            where +=3D "AND T1.checksum=3D? "
> -            sqlarg.append(str(checksum))
> -
> -        sqlstmt +=3D where + ";"
> -
> -        if len(sqlarg):
> -            data =3D self._execute(sqlstmt, tuple(sqlarg))
> -        else:
> -            data =3D self._execute(sqlstmt)
> -        for row in data:
> -            if row["version"]:
> -                col =3D {}
> -                col["version"] =3D row["version"]
> -                col["pkgarch"] =3D row["pkgarch"]
> -                col["checksum"] =3D row["checksum"]
> -                col["value"] =3D row["value"]
> -                datainfo.append(col)
> +                if row["version"]:
> +                    col =3D {}
> +                    col["version"] =3D row["version"]
> +                    col["pkgarch"] =3D row["pkgarch"]
> +                    col["checksum"] =3D row["checksum"]
> +                    col["value"] =3D row["value"]
> +                    datainfo.append(col)
>          return (metainfo, datainfo)
>
>      def dump_db(self, fd):
> @@ -345,14 +323,15 @@ class PRData(object):
>                  raise e
>          uri =3D "file:%s%s" % (self.filename, "?mode=3Dro" if self.read_=
only else "")
>          logger.debug("Opening PRServ database '%s'" % (uri))
> -        self.connection=3Dsqlite3.connect(uri, uri=3DTrue, isolation_lev=
el=3D"EXCLUSIVE", check_same_thread =3D False)
> +        self.connection=3Dsqlite3.connect(uri, uri=3DTrue)
>          self.connection.row_factory=3Dsqlite3.Row
> -        if not self.read_only:
> -            self.connection.execute("pragma synchronous =3D off;")
> -            self.connection.execute("PRAGMA journal_mode =3D MEMORY;")
> +        self.connection.execute("PRAGMA synchronous =3D OFF;")
> +        self.connection.execute("PRAGMA journal_mode =3D WAL;")
> +        self.connection.commit()
>          self._tables=3D{}
>
>      def disconnect(self):
> +        self.connection.commit()
>          self.connection.close()
>
>      def __getitem__(self, tblname):
> @@ -370,3 +349,4 @@ class PRData(object):
>              del self._tables[tblname]
>          logger.info("drop table %s" % (tblname))
>          self.connection.execute("DROP TABLE IF EXISTS %s;" % tblname)
> +        self.connection.commit()
> diff --git a/lib/prserv/serv.py b/lib/prserv/serv.py
> index 05573d06cc..fd673b1851 100644
> --- a/lib/prserv/serv.py
> +++ b/lib/prserv/serv.py
> @@ -44,8 +44,6 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection)=
:
>          except:
>              self.server.table.sync()
>              raise
> -        else:
> -            self.server.table.sync_if_dirty()
>
>      async def handle_test_pr(self, request):
>          '''Finds the PR value corresponding to the request. If not found=
, returns None and doesn't insert a new value'''
> @@ -233,15 +231,9 @@ class PRServer(bb.asyncrpc.AsyncServer):
>          return tasks
>
>      async def stop(self):
> -        self.table.sync_if_dirty()
>          self.db.disconnect()
>          await super().stop()
>
> -    def signal_handler(self):
> -        super().signal_handler()
> -        if self.table:
> -            self.table.sync()
> -
>  class PRServSingleton(object):
>      def __init__(self, dbfile, logfile, host, port, upstream):
>          self.dbfile =3D dbfile
> --
> 2.34.1
>

