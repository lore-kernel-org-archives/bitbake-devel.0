Return-Path: <dl9pf@gmx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089E1C4345F
	for <webhook@archiver.kernel.org>; Tue, 30 Apr 2024 20:29:53 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by mx.groups.io with SMTP id smtpd.web11.26283.1714508987119889094
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 30 Apr 2024 13:29:47 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: signature did not verify: crypto/rsa: verification error" header.i=dl9pf@gmx.de header.s=s31663417 header.b=n6GyOIFk;
 spf=pass (domain: gmx.de, ip: 212.227.17.22, mailfrom: dl9pf@gmx.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1714508985; x=1715113785; i=dl9pf@gmx.de;
	bh=UzMC4z2WEeViqJPPxGfiBscDmRY7ZA7YTYOutu3ueUc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=n6GyOIFkyWPAg5VEP34gN1pqCQ/wpiji4AvTjVu0R1YduKnRFPyVEwFv6Kg4zPj2
	 QH14dIrPtroD8B6HXt9jSIBl6IkxMW/k0h3sE0bc/C5IqYmvz6P47Ubr6ierwv8Wd
	 NAAMKHXsbp8gbXPZOjCpmMFHexxgfX7F07S8mi7RPAPZ994+i5BZJtAkU7pmRVMya
	 FAzVmdT4OJXYiWLpQamv/shRAl9/Q0RYXq4nyln18HJ3eneKv5QP67mqV+/dinIHs
	 MKkUY8idvw4M+uy5pivgnuKE83sOcjlxkT2sQrAryRc/va47niviwLYirDgCZzYWt
	 VctT29XJ0ZgNRtde9w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from monster.localnet ([77.23.168.18]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MG9g4-1rs1fI39Xo-00G1jB; Tue, 30
 Apr 2024 22:29:44 +0200
From: Jan-Simon Moeller <dl9pf@gmx.de>
To: michael.opdenacker@bootlin.com
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH v6 4/8] prserv: enable database sharing
Date: Tue, 30 Apr 2024 22:29:44 +0200
Message-ID: <2746564.mvXUDI8C0e@monster>
In-Reply-To: <20240430171512.936371-5-michael.opdenacker@bootlin.com>
References: 
 <20240430171512.936371-1-michael.opdenacker@bootlin.com>
 <20240430171512.936371-5-michael.opdenacker@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Provags-ID: V03:K1:sEXEvVA42nwYNBQm4e/UUQhff3lDlQxZAh4RlDsI1apMu3nVD50
 DALD2JtYmmJhF8dKQB36qN283ZYKfF79PYJEn0/Pfg+0VWORLFMlN8uQro2a1j+4k8DPNgD
 O6H+5DzMgfcsDoDx+y1fL/spiPgLiLCSGnip8D4xY3Gm+us39BunCu0NtmGI0tvJIUQVllS
 5M6WxkuMBG7AUUgT+XmVQ==
UI-OutboundReport: notjunk:1;M01:P0:ewIgfk7xU8o=;dTUyWZQjHvqDhIV6nHBp+lyJkic
 iZQHzxelymNL9B07lDxtFwokOiIP8W9es5Ahy0t2vwv28vYEpWejyw0Bng1WXw4GLdY3er5qQ
 ni1fDBoiCkrdd9zdOnPdLexudCWO5NwnExzUc7+Gp4RWZcgLoz8vPG+ENH+guq8StCKmBZT72
 3v+7QYbrEynsZiNlOn8CcJVJIoG6F4IvYu3O4hN4py5JvxrJInZvrBE5yYwHRB4gjsLP2w0Zt
 ctQp5gP+WhafRq1aW6oX/o457kag3ZaFaKkebTvGv7cAHepi3OTAWuz8eigPxLK+emf5GEmni
 3mha5SeVAMWUXymWHrBDpsmdcGY963VVvIQ8QmxfkzfyMuj4n7NC+AnNVgBv2ayWRH/B9Xl17
 Z9x5PSal7JNzf/d9FD7ZHnC3pmdfNCWKBEf9EPyD76eXAU5Awpxacc6UittnW18TT5geXLqdi
 ZD5ZwjfzILGzdAFAtN1rguPcthXT9QiQaYOER1cbilQxKTuVBFUmMh5tQ8ZhtdpD2cruEGISI
 JjZgzpmfK6q22rItwV+53QHfGiHryGXLWmH7dbq00zYLsacMXKPVysChi3dZMmnoljx6E0o0Y
 eWna5J6jLlWKyWJVmxXhVqJw/VfMNYBAmbXJZkPLtTLEUaqJzMol+bJhpVhFDypNbGGni7bYs
 VRLbqDpeDLFBXi3oW+TOm8AGUKjEUpvp9cQyQugsXoAFdcTT+RxEaCI12d28KqFdBy6CKaugt
 50siu5i7hkJM3gSY8soVijRO0lpG9xc2/ewh5GwCf+O/ZQEdpyCtGV93w8TID1Z9I1tgnpSmd
 CcodUoIL0mGIOM6u/WhVsKdVHlyKjAd/GDOFGxNkU5kV8=
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 30 Apr 2024 20:29:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16174

Reviewed-by: Jan-Siumon M=F6ller <dl9pf@gmx.de>

Am Dienstag, 30. April 2024, 19:15:08 CEST schrieb Michael Opdenacker via=20
lists.openembedded.org:
> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
>=20
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
>=20
> The use of a database cursor enabled to remove the _execute() wrapper.
> The cursor automatically makes sure that the query happens in an atomic
> transaction and commits when finished.
>=20
> This also removes the need for a "dirty" flag for the database and
> for explicit database syncing, which simplifies the code.
>=20
> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> Cc: Tim Orling <ticotimo@gmail.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> ---
>  lib/prserv/db.py   | 322 +++++++++++++++++++++------------------------
>  lib/prserv/serv.py |   8 --
>  2 files changed, 151 insertions(+), 179 deletions(-)
>=20
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
>=20
> +from contextlib import closing
>  from . import increase_revision, revision_greater, revision_smaller
>=20
> -try:
> -    import sqlite3
> -except ImportError:
> -    from pysqlite2 import dbapi2 as sqlite3
> -
>  logger =3D logging.getLogger("BitBake.PRserv")
>=20
> -sqlversion =3D sqlite3.sqlite_version_info
> -if sqlversion[0] < 3 or (sqlversion[0] =3D=3D 3 and sqlversion[1] < 3):
> -    raise Exception("sqlite3 version 3.3.0 or later is required.")
> -
>  #
>  # "No History" mode - for a given query tuple (version, pkgarch, checksu=
m),
> # the returned value will be the largest among all the values of the same
> @@ -31,40 +23,28 @@ if sqlversion[0] < 3 or (sqlversion[0] =3D=3D 3 and
> sqlversion[1] < 3): # "History" mode - Return a new higher value for
> previously unseen query # tuple (version, pkgarch, checksum), otherwise
> return historical value. # Value can decrement if returning to a previous
> build.
> -#
>=20
>  class PRTable(object):
>      def __init__(self, conn, table, read_only):
>          self.conn =3D conn
>          self.read_only =3D read_only
> -        self.dirty =3D False
>          self.table =3D table
>=20
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
;"
> % self.table) -
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
> +                            WHERE type=3D'table' AND name=3D'%s'" %
> (self.table)) +                if not table_exists:
> +                    raise prserv.NotFoundError
> +            else:
> +                cursor.execute("CREATE TABLE IF NOT EXISTS %s \
> +                            (version TEXT NOT NULL, \
> +                            pkgarch TEXT NOT NULL,  \
> +                            checksum TEXT NOT NULL, \
> +                            value TEXT, \
> +                            PRIMARY KEY (version, pkgarch, checksum,
> value));" % self.table) +                self.conn.commit()
>=20
>      def _extremum_value(self, rows, is_max):
>          value =3D None
> @@ -88,49 +68,42 @@ class PRTable(object):
>      def _min_value(self, rows):
>          return self._extremum_value(rows, False)
>=20
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
>          """Returns whether the specified package version is found in the
> database for the specified architecture"""
>=20
>          # Just returns the value if found or None otherwise
> -        data=3Dself._execute("SELECT value FROM %s WHERE version=3D? AND
> pkgarch=3D?;" % self.table, -                           (version, pkgarch=
))
> -        row=3Ddata.fetchone()
> -        if row is not None:
> -            return True
> -        else:
> -            return False
> +        with closing(self.conn.cursor()) as cursor:
> +            data=3Dcursor.execute("SELECT value FROM %s WHERE version=3D=
? AND
> pkgarch=3D?;" % self.table, +                               (version,
> pkgarch))
> +            row=3Ddata.fetchone()
> +            if row is not None:
> +                return True
> +            else:
> +                return False
>=20
>      def test_value(self, version, pkgarch, value):
>          """Returns whether the specified value is found in the database =
for
> the specified package and architecture"""
>=20
>          # Just returns the value if found or None otherwise
> -        data=3Dself._execute("SELECT value FROM %s WHERE version=3D? AND
> pkgarch=3D? and value=3D?;" % self.table, -                           (ve=
rsion,
> pkgarch, value))
> -        row=3Ddata.fetchone()
> -        if row is not None:
> -            return True
> -        else:
> -            return False
> +        with closing(self.conn.cursor()) as cursor:
> +            data=3Dcursor.execute("SELECT value FROM %s WHERE version=3D=
? AND
> pkgarch=3D? and value=3D?;" % self.table, +                             =
=20
> (version, pkgarch, value))
> +            row=3Ddata.fetchone()
> +            if row is not None:
> +                return True
> +            else:
> +                return False
>=20
>=20
>      def find_package_max_value(self, version, pkgarch):
>          """Returns the greatest value for (version, pkgarch), or None if
> not found. Doesn't create a new value"""
>=20
> -        data =3D self._execute("SELECT value FROM %s where version=3D? A=
ND
> pkgarch=3D?;" % (self.table), -                             (version,
> pkgarch))
> -        rows =3D data.fetchall()
> -        value =3D self._max_value(rows)
> -        return value
> +        with closing(self.conn.cursor()) as cursor:
> +            data =3D cursor.execute("SELECT value FROM %s where version=
=3D? AND
> pkgarch=3D?;" % (self.table), +                                 (version,
> pkgarch))
> +            rows =3D data.fetchall()
> +            value =3D self._max_value(rows)
> +            return value
>=20
>      def find_value(self, version, pkgarch, checksum, history=3DFalse):
>          """Returns the value for the specified checksum if found or None
> otherwise.""" @@ -145,10 +118,11 @@ class PRTable(object):
>          """Returns the maximum (if is_max is True) or minimum (if is_max=
 is
> False) value for (version, pkgarch, checksum), or None if not found.
> Doesn't create a new value"""
>=20
> -        data =3D self._execute("SELECT value FROM %s where version=3D? A=
ND
> pkgarch=3D? AND checksum=3D?;" % (self.table), -                         =
  =20
> (version, pkgarch, checksum))
> -        rows =3D data.fetchall()
> -        return self._extremum_value(rows, is_max)
> +        with closing(self.conn.cursor()) as cursor:
> +            data =3D cursor.execute("SELECT value FROM %s where version=
=3D? AND
> pkgarch=3D? AND checksum=3D?;" % (self.table), +                         =
     =20
>  (version, pkgarch, checksum))
> +            rows =3D data.fetchall()
> +            return self._extremum_value(rows, is_max)
>=20
>      def find_max_value(self, version, pkgarch, checksum):
>          return self._find_extremum_value(version, pkgarch, checksum, Tru=
e)
> @@ -160,26 +134,27 @@ class PRTable(object):
>          """Take and increase the greatest "<base>.y" value for (version,
> pkgarch), or return "<base>.0" if not found. This doesn't store a new
> value."""
>=20
> -        data =3D self._execute("SELECT value FROM %s where version=3D? A=
ND
> pkgarch=3D? AND value LIKE '%s.%%';" % (self.table, base), -             =
   =20
>            (version, pkgarch))
> -        rows =3D data.fetchall()
> -        value =3D self._max_value(rows)
> +        with closing(self.conn.cursor()) as cursor:
> +            data =3D cursor.execute("SELECT value FROM %s where version=
=3D? AND
> pkgarch=3D? AND value LIKE '%s.%%';" % (self.table, base), +             =
   =20
>                (version, pkgarch))
> +            rows =3D data.fetchall()
> +            value =3D self._max_value(rows)
>=20
> -        if value is not None:
> -            return increase_revision(value)
> -        else:
> -            return base + ".0"
> +            if value is not None:
> +                return increase_revision(value)
> +            else:
> +                return base + ".0"
>=20
>      def store_value(self, version, pkgarch, checksum, value):
>          """Store new value in the database"""
>=20
> -        try:
> -            self._execute("INSERT INTO %s VALUES (?, ?, ?, ?);"  %
> (self.table), -                       (version, pkgarch, checksum, value))
> -        except sqlite3.IntegrityError as exc:
> -            logger.error(str(exc))
> -
> -        self.dirty =3D True
> +        with closing(self.conn.cursor()) as cursor:
> +            try:
> +                cursor.execute("INSERT INTO %s VALUES (?, ?, ?, ?);"  %
> (self.table), +                           (version, pkgarch, checksum,
> value))
> +            except sqlite3.IntegrityError as exc:
> +                logger.error(str(exc))
> +            self.conn.commit()
>=20
>      def _get_value(self, version, pkgarch, checksum, history):
>=20
> @@ -215,54 +190,56 @@ class PRTable(object):
>              return None
>=20
>          val =3D None
> -        data =3D self._execute("SELECT value FROM %s WHERE version=3D? A=
ND
> pkgarch=3D? AND checksum=3D?;" % self.table, +        with
> closing(self.conn.cursor()) as cursor:
> +            data =3D cursor.execute("SELECT value FROM %s WHERE version=
=3D? AND
> pkgarch=3D? AND checksum=3D?;" % self.table, (version, pkgarch, checksum))
> -        row =3D data.fetchone()
> -        if row is not None:
> -            val=3Drow[0]
> -        else:
> -            #no value found, try to insert
> -            try:
> -                self._execute("INSERT INTO %s VALUES (?, ?, ?, ?);"  %
> (self.table), -                           (version, pkgarch, checksum,
> value))
> -            except sqlite3.IntegrityError as exc:
> -                logger.error(str(exc))
> +            row =3D data.fetchone()
> +            if row is not None:
> +                val=3Drow[0]
> +            else:
> +                #no value found, try to insert
> +                try:
> +                    cursor.execute("INSERT INTO %s VALUES (?, ?, ?, ?);"=
  %
> (self.table), +                               (version, pkgarch, checksum,
> value)) +                except sqlite3.IntegrityError as exc:
> +                    logger.error(str(exc))
>=20
> -            self.dirty =3D True
> +                self.conn.commit()
>=20
> -            data =3D self._execute("SELECT value FROM %s WHERE version=
=3D? AND
> pkgarch=3D? AND checksum=3D?;" % self.table, +                data =3D
> cursor.execute("SELECT value FROM %s WHERE version=3D? AND pkgarch=3D? AND
> checksum=3D?;" % self.table, (version, pkgarch, checksum))
> -            row =3D data.fetchone()
> -            if row is not None:
> -                val =3D row[0]
> +                row =3D data.fetchone()
> +                if row is not None:
> +                    val =3D row[0]
>          return val
>=20
>      def _import_no_hist(self, version, pkgarch, checksum, value):
>          if self.read_only:
>              return None
>=20
> -        try:
> -            #try to insert
> -            self._execute("INSERT INTO %s VALUES (?, ?, ?, ?);"  %
> (self.table), -                           (version, pkgarch, checksum,
> value))
> -        except sqlite3.IntegrityError as exc:
> -            #already have the record, try to update
> +        with closing(self.conn.cursor()) as cursor:
>              try:
> -                self._execute("UPDATE %s SET value=3D? WHERE version=3D?=
 AND
> pkgarch=3D? AND checksum=3D? AND value<?" -                              %
> (self.table),
> -                               (value, version, pkgarch, checksum, value=
))
> +                #try to insert
> +                cursor.execute("INSERT INTO %s VALUES (?, ?, ?, ?);"  %
> (self.table), +                               (version, pkgarch, checksum,
> value)) except sqlite3.IntegrityError as exc:
> -                logger.error(str(exc))
> +                #already have the record, try to update
> +                try:
> +                    cursor.execute("UPDATE %s SET value=3D? WHERE versio=
n=3D?
> AND pkgarch=3D? AND checksum=3D? AND value<?" +                          =
     =20
>  % (self.table),
> +                                   (value, version, pkgarch, checksum,
> value)) +                except sqlite3.IntegrityError as exc:
> +                    logger.error(str(exc))
>=20
> -        self.dirty =3D True
> +                self.conn.commit()
>=20
> -        data =3D self._execute("SELECT value FROM %s WHERE version=3D? A=
ND
> pkgarch=3D? AND checksum=3D? AND value>=3D?;" % self.table, +            =
data =3D
> cursor.execute("SELECT value FROM %s WHERE version=3D? AND pkgarch=3D? AND
> checksum=3D? AND value>=3D?;" % self.table, (version, pkgarch, checksum,
> value))
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
>=20
>      def importone(self, version, pkgarch, checksum, value, history=3DFal=
se):
>          if history:
> @@ -272,56 +249,57 @@ class PRTable(object):
>=20
>      def export(self, version, pkgarch, checksum, colinfo, history=3DFals=
e):
>          metainfo =3D {}
> -        #column info
> -        if colinfo:
> -            metainfo["tbl_name"] =3D self.table
> -            metainfo["core_ver"] =3D prserv.__version__
> -            metainfo["col_info"] =3D []
> -            data =3D self._execute("PRAGMA table_info(%s);" % self.table)
> +        with closing(self.conn.cursor()) as cursor:
> +            #column info
> +            if colinfo:
> +                metainfo["tbl_name"] =3D self.table
> +                metainfo["core_ver"] =3D prserv.__version__
> +                metainfo["col_info"] =3D []
> +                data =3D cursor.execute("PRAGMA table_info(%s);" %
> self.table) +                for row in data:
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
=2Etable
> +            else:
> +                sqlstmt =3D "SELECT T1.version, T1.pkgarch, T1.checksum,
> T1.value FROM %s as T1, \ +                        (SELECT version,
> pkgarch, max(value) as maxvalue FROM %s GROUP BY version, pkgarch) as T2 \
> +                        WHERE T1.version=3DT2.version AND
> T1.pkgarch=3DT2.pkgarch AND T1.value=3DT2.maxvalue " % (self.table, self.=
table)
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
value
> FROM %s as T1, \ -                    (SELECT version, pkgarch, max(value)
> as maxvalue FROM %s GROUP BY version, pkgarch) as T2 \ -                 =
 =20
> WHERE T1.version=3DT2.version AND T1.pkgarch=3DT2.pkgarch AND
> T1.value=3DT2.maxvalue " % (self.table, self.table) -        sqlarg =3D []
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
>=20
>      def dump_db(self, fd):
> @@ -345,14 +323,15 @@ class PRData(object):
>                  raise e
>          uri =3D "file:%s%s" % (self.filename, "?mode=3Dro" if self.read_=
only
> else "") logger.debug("Opening PRServ database '%s'" % (uri))
> -        self.connection=3Dsqlite3.connect(uri, uri=3DTrue,
> isolation_level=3D"EXCLUSIVE", check_same_thread =3D False) +      =20
> self.connection=3Dsqlite3.connect(uri, uri=3DTrue)
>          self.connection.row_factory=3Dsqlite3.Row
> -        if not self.read_only:
> -            self.connection.execute("pragma synchronous =3D off;")
> -            self.connection.execute("PRAGMA journal_mode =3D MEMORY;")
> +        self.connection.execute("PRAGMA synchronous =3D OFF;")
> +        self.connection.execute("PRAGMA journal_mode =3D WAL;")
> +        self.connection.commit()
>          self._tables=3D{}
>=20
>      def disconnect(self):
> +        self.connection.commit()
>          self.connection.close()
>=20
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
> @@ -44,8 +44,6 @@ class PRServerClient(bb.asyncrpc.AsyncServerConnection):
>          except:
>              self.server.table.sync()
>              raise
> -        else:
> -            self.server.table.sync_if_dirty()
>=20
>      async def handle_test_pr(self, request):
>          '''Finds the PR value corresponding to the request. If not found,
> returns None and doesn't insert a new value''' @@ -233,15 +231,9 @@ class
> PRServer(bb.asyncrpc.AsyncServer):
>          return tasks
>=20
>      async def stop(self):
> -        self.table.sync_if_dirty()
>          self.db.disconnect()
>          await super().stop()
>=20
> -    def signal_handler(self):
> -        super().signal_handler()
> -        if self.table:
> -            self.table.sync()
> -
>  class PRServSingleton(object):
>      def __init__(self, dbfile, logfile, host, port, upstream):
>          self.dbfile =3D dbfile





