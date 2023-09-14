Return-Path: <quaresma.jose@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5708CEDE990
	for <webhook@archiver.kernel.org>; Thu, 14 Sep 2023 08:51:36 +0000 (UTC)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
 by mx.groups.io with SMTP id smtpd.web11.7274.1694681487762522094
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Sep 2023 01:51:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20221208 header.b=hXfaNVU8;
 spf=pass (domain: gmail.com, ip: 209.85.222.43, mailfrom: quaresma.jose@gmail.com)
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7a76ffc063bso259902241.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 14 Sep 2023 01:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694681487; x=1695286287; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m+BqgRoKTm/hVIGzeKvfMrDOUH2q1jhQhN8Apu0/YzI=;
        b=hXfaNVU8w4reymoTfC6D7QAfcT5I+YR3TatI3DNyJq2eW6C/nymu2whF8keZUFY8Vf
         /ZAjuQwfaDxLWq1mABXmC11eALIAlcoAttUeX1xkvydSz5caUyYRoKyQONTsJShV86VI
         tRqk++Ly5s5w+VgzEuEiVm1Wq7tpbQI+5oH/lklHwMhc7sM9+wv5wLH7vnk3AhzzMixQ
         /7C93PbSpEC95XOKM0rxojaXwR0o+2jPysQazbqx0mr984qRYo2rsFJX+Jn867oYv8xZ
         QZmH1d2S0xgkr/3b0RSFTUijfU39wTIBP2Neip8pj9yvp9E14NxeV13XHq0n696ysTh7
         E2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694681487; x=1695286287;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m+BqgRoKTm/hVIGzeKvfMrDOUH2q1jhQhN8Apu0/YzI=;
        b=RP2xRxOQ38CRK5GOaHw/4S6d4ks0pqpeh30cljegxW9kpre/aaLWRZH8VzEON2JIFc
         t2nVfsBhX3KUK6EH3UJqNTFxhWao+g0zmr0sIogWRFJIjgm4iBhxRTJ1wjOGosvrRMTh
         UvBbMMQ85VcZAHZfYomTODtXehx2OXT8a8K98wQV+qGynAHpLZbWUrskRof9Gm8VlEoW
         2H9286xmHTNnD9NXu1Q5jN8Eqojqa2PaksvRO01Y8M+R2tMHda/bGwujeTMYvTsC/bp4
         JuAzPUzBuK3HdPjlId9yYmE2PmDLduspkNW0M0IBRVxOHlImAoJT6ZSIK/JK7L0i5pmJ
         FJrQ==
X-Gm-Message-State: AOJu0YwrNlV2MPp2BrieyBa8HjcL5F8UArDNg77ETRIS5CDSPetbdx4s
	zykJkdLy3u43sLlCyn/yIc1hxHDHqrM7Xqc3pQM=
X-Google-Smtp-Source: AGHT+IFJpk/jeb+TbPjqpDsak+cJ8Fj9ogVvnHi/ZNyxR6xRsRtnL/OSdbDfMqvGZNWSoVyVymMOmzN8ByDIEJM+sH0=
X-Received: by 2002:a1f:6d82:0:b0:493:7df9:bcc4 with SMTP id
 i124-20020a1f6d82000000b004937df9bcc4mr3538148vkc.4.1694681486596; Thu, 14
 Sep 2023 01:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230913050824.13599-1-rustyhowell@gmail.com>
In-Reply-To: <20230913050824.13599-1-rustyhowell@gmail.com>
From: Jose Quaresma <quaresma.jose@gmail.com>
Date: Thu, 14 Sep 2023 09:51:15 +0100
Message-ID: <CANPvuRnb4XRK4A=YDXdS5cXjsNxPj_k1S4acfzFYHsKtUSs-Lw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] prserver: add self-tests
To: Rusty Howell <rustyhowell@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: multipart/alternative; boundary="00000000000004210f06054dc87d"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 Sep 2023 08:51:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15060

--00000000000004210f06054dc87d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Rusty Howell <rustyhowell@gmail.com> escreveu no dia quarta, 13/09/2023
=C3=A0(s) 06:09:

> Add some self tests for the prserver. As changes are made to the prserver=
,
> the tests will
> help ensure that any behavioral changes are known, or that changes do not
> affect behavior.
>
> Signed-off-by: Rusty Howell <rustyhowell@gmail.com>
> ---
>  .gitignore                           |   1 +
>  bitbake/bin/bitbake-selftest         |   5 +-
>  bitbake/lib/prserv/db.py             |   2 +-
>  bitbake/lib/prserv/tests/.gitignore  |   2 +
>  bitbake/lib/prserv/tests/__init__.py |   0
>  bitbake/lib/prserv/tests/prserver.py | 213 +++++++++++++++++++++++++++
>  6 files changed, 221 insertions(+), 2 deletions(-)
>  create mode 100644 bitbake/lib/prserv/tests/.gitignore
>  create mode 100644 bitbake/lib/prserv/tests/__init__.py
>  create mode 100644 bitbake/lib/prserv/tests/prserver.py
>
> diff --git a/.gitignore b/.gitignore
> index 8f48d452da..c227363e3c 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -36,3 +36,4 @@ _toaster_clones/
>  downloads/
>  sstate-cache/
>  toaster.sqlite
> +.idea
> diff --git a/bitbake/bin/bitbake-selftest b/bitbake/bin/bitbake-selftest
> index f25f23b1ae..8b601aa2b8 100755
> --- a/bitbake/bin/bitbake-selftest
> +++ b/bitbake/bin/bitbake-selftest
> @@ -16,6 +16,7 @@ try:
>      import bb
>      import hashserv
>      import layerindexlib
> +    import prserv
>  except RuntimeError as exc:
>      sys.exit(str(exc))
>
> @@ -35,7 +36,9 @@ tests =3D ["bb.tests.codeparser",
>           "hashserv.tests",
>           "layerindexlib.tests.layerindexobj",
>           "layerindexlib.tests.restapi",
> -         "layerindexlib.tests.cooker"]
> +         "layerindexlib.tests.cooker",
> +         "prserv.tests.prserver",
> +        ]
>
>  for t in tests:
>      t =3D '.'.join(t.split('.')[:3])
> diff --git a/bitbake/lib/prserv/db.py b/bitbake/lib/prserv/db.py
> index b4bda7078c..8cefb28f16 100644
> --- a/bitbake/lib/prserv/db.py
> +++ b/bitbake/lib/prserv/db.py
> @@ -71,7 +71,7 @@ class PRTable(object):
>      def sync(self):
>          if not self.read_only:
>              self.conn.commit()
> -            self._execute("BEGIN EXCLUSIVE TRANSACTION")
> +            #self._execute("BEGIN EXCLUSIVE TRANSACTION")
>

Is this change intentional? imo they should be on another commit since it
doesn't seem related.

Jose


>
>      def sync_if_dirty(self):
>          if self.dirty:
> diff --git a/bitbake/lib/prserv/tests/.gitignore
> b/bitbake/lib/prserv/tests/.gitignore
> new file mode 100644
> index 0000000000..8609a37b69
> --- /dev/null
> +++ b/bitbake/lib/prserv/tests/.gitignore
> @@ -0,0 +1,2 @@
> +*.log
> +*.db
> diff --git a/bitbake/lib/prserv/tests/__init__.py
> b/bitbake/lib/prserv/tests/__init__.py
> new file mode 100644
> index 0000000000..e69de29bb2
> diff --git a/bitbake/lib/prserv/tests/prserver.py
> b/bitbake/lib/prserv/tests/prserver.py
> new file mode 100644
> index 0000000000..52972bcf49
> --- /dev/null
> +++ b/bitbake/lib/prserv/tests/prserver.py
> @@ -0,0 +1,213 @@
> +import os
> +import sys
> +import json
> +import socket
> +import logging
> +import itertools
> +import random
> +import unittest
> +
> +import sqlite3
> +import time
> +import bb
> +
> +
> +this_dir =3D os.path.abspath(os.path.dirname(__file__))
> +bitbake_dir =3D os.path.abspath(os.path.dirname(os.path.dirname(__file__=
)))
> +sys.path.insert(0, os.path.join(bitbake_dir, 'lib'))
> +import prserv
> +import prserv.serv
> +
> +HOST =3D "localhost"
> +PORT =3D 18585
> +
> +logger =3D logging.getLogger("prserv_unittest")
> +logger.setLevel(logging.DEBUG)
> +logger.addHandler(logging.FileHandler(os.path.join(this_dir,
> 'prserv_unittests.log'), mode=3D'w'))
> +
> +logger.debug("-----------")
> +logger.debug("global setup")
> +logger.debug("bitbake_dir =3D %s", bitbake_dir)
> +logger.debug("this_dir =3D %s", this_dir)
> +
> +sock =3D None
> +conn =3D None
> +def setUpModule():
> +    global sock, conn
> +    logger.debug("setUpModule")
> +    dbfile =3D os.path.join(this_dir, 'pr_test.db')
> +    if os.path.exists(dbfile):
> +        os.remove(dbfile)
> +
> +    logfile =3D os.path.join(this_dir, 'prserv_daemon.log')
> +    logging.getLogger("BitBake.PRserv").setLevel(logging.DEBUG)
> +
> +    if os.path.exists(logfile):
> +        os.remove(logfile)
> +
> +    prserv.init_logger(os.path.abspath(logfile), "DEBUG")
> +    prserv.serv.start_daemon(dbfile, HOST, PORT, logfile)
> +    time.sleep(1)
> +
> +    conn =3D sqlite3.connect(dbfile, isolation_level=3D"EXCLUSIVE",
> check_same_thread=3DFalse)
> +
> +    sock =3D socket.socket(socket.AF_INET, socket.SOCK_STREAM)
> +    sock.connect(('localhost', PORT))
> +    msg =3D b'PRSERVICE 1.0\n\n'
> +    sock.send(msg)
> +
> +
> +def tearDownModule():
> +    logger.debug("tearDownModule")
> +    sock.close()
> +    prserv.serv.stop_daemon(HOST, PORT)
> +
> +
> +class PRServerTest(unittest.TestCase):
> +    def setUp(self):
> +        logger.info("inst setUp()")
> +
> +    def tearDown(self):
> +        logger.info("inst tearDown()")
> +
> +    def ping(self):
> +        return True
> +
> +    def getPR(self, version: str, arch: str, checksum: str) -> int:
> +        bb.logger.info("getting PRAUTO")
> +
> +        p =3D {'get-pr': {'version': version, 'pkgarch': arch, 'checksum=
':
> checksum}}
> +        data =3D "%s\n" % json.dumps(p)
> +        sock.send(data.encode('utf-8'))
> +
> +        data =3D sock.recv(128)
> +        data =3D json.loads(data.decode('utf-8'))
> +        # Returns {'value': 1}
> +        return data['value']
> +
> +    def test_first_query(self):
> +        v =3D self.getPR("aaa", "bbb", "c")
> +        assert v =3D=3D 0, 'v =3D %s' % v
> +
> +        v =3D self.getPR("aaa", "bbb", "c")
> +        assert v =3D=3D 0
> +
> +        v =3D self.getPR("xyz", "y", "z")
> +        assert v =3D=3D 0
> +
> +        v =3D self.getPR("xyz", "y", "z")
> +        assert v =3D=3D 0
> +
> +    def test_bad_queries(self):
> +        assert self.ping()
> +        try:
> +            self.getPR("aaa", "bbb", "c")
> +            self.getPR("aaa", "bbb", "c")
> +            self.getPR("aaa", "bbb", "c")
> +            assert False, 'Should have gotten an error'
> +        except Exception:
> +            pass
> +
> +    def test_checksum_changes(self):
> +        assert self.ping()
> +
> +        v1 =3D self.getPR("pkg-a", "arm64", "hash-a")
> +        assert v1 =3D=3D 0
> +
> +        v2 =3D self.getPR("pkg-a", "arm64", "hash-b")
> +        assert v2 =3D=3D 1
> +
> +        v3 =3D self.getPR("pkg-a", "arm64", "hash-c")
> +        assert v3 =3D=3D 2
> +
> +        v4 =3D self.getPR("pkg-a", "arm64", "hash-d")
> +        assert v4 =3D=3D 3
> +
> +        v5 =3D self.getPR("pkg-a", "arm64", "hash-b")
> +        assert v5 =3D=3D 4
> +
> +        v5 =3D self.getPR("pkg-a", "arm64", "hash-b")
> +        assert v5 =3D=3D 4
> +
> +    def test_arch_changes(self):
> +        assert self.ping()
> +        v =3D self.getPR("pkg-b", "arm64", "hash-a")
> +        assert v =3D=3D 0
> +        v =3D self.getPR("pkg-b", "imx8mm", "hash-a")
> +        assert v =3D=3D 0
> +        v =3D self.getPR("pkg-b", "aarch64", "hash-a")
> +        assert v =3D=3D 0
> +        v =3D self.getPR("pkg-b", "8086", "hash-a")
> +        assert v =3D=3D 0
> +
> +    def test_autoinc(self):
> +        assert self.ping()
> +
> +        sha1 =3D "12345"
> +        sha2 =3D "23456"
> +        sha3 =3D "34567"
> +        v =3D self.getPR("AUTOINC-daemon-1.2.3+", "aarch64", "AUTOINC+%s=
" %
> sha1)
> +        self.assertEqual(v, 0)
> +
> +        v =3D self.getPR("AUTOINC-daemon-1.2.3+", "aarch64", "AUTOINC+%s=
" %
> sha2)
> +        self.assertEqual(v, 1)
> +
> +        v =3D self.getPR("AUTOINC-daemon-1.2.4+", "aarch64", "AUTOINC+%s=
" %
> sha1)
> +        self.assertEqual(v, 0)
> +
> +        v =3D self.getPR("AUTOINC-daemon-1.2.3+", "x86_64", "AUTOINC+%s"=
 %
> sha1)
> +        self.assertEqual(v, 0)
> +
> +        v =3D self.getPR("AUTOINC-daemon-1.2.3+", "aarch64", "AUTOINC+%s=
" %
> sha3)
> +        self.assertEqual(v, 2)
> +
> +
> +    def test_full(self):
> +
> +        pkgs =3D ['pkg-x', 'pkg-y', 'pkg-z']
> +        arches =3D ['arm64', 'x86_64']
> +        hashes =3D ['hash-%d' % i for i in range(10)]
> +
> +        rand =3D random.Random(0)
> +
> +        # Populate database with basic stuff
> +        for pkg, arch in itertools.product(pkgs, arches):
> +            v =3D self.getPR(pkg, arch, "0")
> +            assert v is not None
> +
> +        # Populate database with random-ish stuff
> +        for _ in range(100):
> +            pkg =3D rand.choice(pkgs)
> +            arch =3D rand.choice(arches)
> +            hash_ =3D rand.choice(hashes)
> +            v =3D self.getPR(pkg, arch, hash_)
> +            assert v is not None
> +
> +        table =3D 'PRMAIN_nohist'
> +        old_versions =3D {}
> +        old_versions_2 =3D {}
> +
> +        for pkg, arch, hash_ in itertools.product(pkgs, arches, hashes):
> +            # verify that all OSv2 versions are less than the OSv1 versi=
on
> +            query =3D 'select ifnull(max(value),0) from %s where version=
=3D?
> AND pkgarch=3D?;' % table
> +            args =3D (pkg, arch)
> +            data =3D conn.execute(query, args)
> +
> +            row =3D data.fetchone()
> +            assert row is not None
> +            value =3D row[0]
> +
> +            k =3D '%s-%s' % (pkg, arch)
> +            old_v =3D old_versions.get(k, -1)
> +            assert value >=3D old_v, "%s %s: old_v=3D%s, new_v=3D%s" % (=
pkg,
> arch, old_v, value)
> +
> +            old_versions[k] =3D value
> +
> +            k2 =3D '%s-%s' % (pkg, arch)
> +            old_versions_2[k2] =3D value
> +
> +        print('\n')
> +
> +        for k in sorted(old_versions_2.keys()):
> +            v =3D old_versions_2[k]
> +            print("Max for %s is %s" % (k, v))
> --
> 2.25.1
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15040):
> https://lists.openembedded.org/g/bitbake-devel/message/15040
> Mute This Topic: https://lists.openembedded.org/mt/101331395/5052612
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> quaresma.jose@gmail.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>

--=20
Best regards,

Jos=C3=A9 Quaresma

--00000000000004210f06054dc87d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Rusty Howell &lt;<a href=3D"mailto:ru=
styhowell@gmail.com">rustyhowell@gmail.com</a>&gt; escreveu no dia quarta, =
13/09/2023 =C3=A0(s) 06:09:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">Add some self tests for the prserver. As changes are made to th=
e prserver, the tests will<br>
help ensure that any behavioral changes are known, or that changes do not a=
ffect behavior.<br>
<br>
Signed-off-by: Rusty Howell &lt;<a href=3D"mailto:rustyhowell@gmail.com" ta=
rget=3D"_blank">rustyhowell@gmail.com</a>&gt;<br>
---<br>
=C2=A0.gitignore=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
=C2=A0bitbake/bin/bitbake-selftest=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 =C2=A05 +-<br>
=C2=A0bitbake/lib/prserv/db.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A02 +-<br>
=C2=A0bitbake/lib/prserv/tests/.gitignore=C2=A0 |=C2=A0 =C2=A02 +<br>
=C2=A0bitbake/lib/prserv/tests/__init__.py |=C2=A0 =C2=A00<br>
=C2=A0bitbake/lib/prserv/tests/prserver.py | 213 ++++++++++++++++++++++++++=
+<br>
=C2=A06 files changed, 221 insertions(+), 2 deletions(-)<br>
=C2=A0create mode 100644 bitbake/lib/prserv/tests/.gitignore<br>
=C2=A0create mode 100644 bitbake/lib/prserv/tests/__init__.py<br>
=C2=A0create mode 100644 bitbake/lib/prserv/tests/prserver.py<br>
<br>
diff --git a/.gitignore b/.gitignore<br>
index 8f48d452da..c227363e3c 100644<br>
--- a/.gitignore<br>
+++ b/.gitignore<br>
@@ -36,3 +36,4 @@ _toaster_clones/<br>
=C2=A0downloads/<br>
=C2=A0sstate-cache/<br>
=C2=A0toaster.sqlite<br>
+.idea<br>
diff --git a/bitbake/bin/bitbake-selftest b/bitbake/bin/bitbake-selftest<br=
>
index f25f23b1ae..8b601aa2b8 100755<br>
--- a/bitbake/bin/bitbake-selftest<br>
+++ b/bitbake/bin/bitbake-selftest<br>
@@ -16,6 +16,7 @@ try:<br>
=C2=A0 =C2=A0 =C2=A0import bb<br>
=C2=A0 =C2=A0 =C2=A0import hashserv<br>
=C2=A0 =C2=A0 =C2=A0import layerindexlib<br>
+=C2=A0 =C2=A0 import prserv<br>
=C2=A0except RuntimeError as exc:<br>
=C2=A0 =C2=A0 =C2=A0sys.exit(str(exc))<br>
<br>
@@ -35,7 +36,9 @@ tests =3D [&quot;bb.tests.codeparser&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;hashserv.tests&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;layerindexlib.tests.layerindexobj&=
quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;layerindexlib.tests.restapi&quot;,=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;layerindexlib.tests.cooker&quot;]<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;layerindexlib.tests.cooker&quot;,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;prserv.tests.prserver&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
<br>
=C2=A0for t in tests:<br>
=C2=A0 =C2=A0 =C2=A0t =3D &#39;.&#39;.join(t.split(&#39;.&#39;)[:3])<br>
diff --git a/bitbake/lib/prserv/db.py b/bitbake/lib/prserv/db.py<br>
index b4bda7078c..8cefb28f16 100644<br>
--- a/bitbake/lib/prserv/db.py<br>
+++ b/bitbake/lib/prserv/db.py<br>
@@ -71,7 +71,7 @@ class PRTable(object):<br>
=C2=A0 =C2=A0 =C2=A0def sync(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not self.read_only:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.conn.commit()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._execute(&quot;BEGIN EXCLUS=
IVE TRANSACTION&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 #self._execute(&quot;BEGIN EXCLU=
SIVE TRANSACTION&quot;)<br></blockquote><div><br></div><div>Is this change =
intentional? imo they should be on another commit since it doesn&#39;t seem=
 related.<br><br>Jose</div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
<br>
=C2=A0 =C2=A0 =C2=A0def sync_if_dirty(self):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self.dirty:<br>
diff --git a/bitbake/lib/prserv/tests/.gitignore b/bitbake/lib/prserv/tests=
/.gitignore<br>
new file mode 100644<br>
index 0000000000..8609a37b69<br>
--- /dev/null<br>
+++ b/bitbake/lib/prserv/tests/.gitignore<br>
@@ -0,0 +1,2 @@<br>
+*.log<br>
+*.db<br>
diff --git a/bitbake/lib/prserv/tests/__init__.py b/bitbake/lib/prserv/test=
s/__init__.py<br>
new file mode 100644<br>
index 0000000000..e69de29bb2<br>
diff --git a/bitbake/lib/prserv/tests/prserver.py b/bitbake/lib/prserv/test=
s/prserver.py<br>
new file mode 100644<br>
index 0000000000..52972bcf49<br>
--- /dev/null<br>
+++ b/bitbake/lib/prserv/tests/prserver.py<br>
@@ -0,0 +1,213 @@<br>
+import os<br>
+import sys<br>
+import json<br>
+import socket<br>
+import logging<br>
+import itertools<br>
+import random<br>
+import unittest<br>
+<br>
+import sqlite3<br>
+import time<br>
+import bb<br>
+<br>
+<br>
+this_dir =3D os.path.abspath(os.path.dirname(__file__))<br>
+bitbake_dir =3D os.path.abspath(os.path.dirname(os.path.dirname(__file__))=
)<br>
+sys.path.insert(0, os.path.join(bitbake_dir, &#39;lib&#39;))<br>
+import prserv<br>
+import prserv.serv<br>
+<br>
+HOST =3D &quot;localhost&quot;<br>
+PORT =3D 18585<br>
+<br>
+logger =3D logging.getLogger(&quot;prserv_unittest&quot;)<br>
+logger.setLevel(logging.DEBUG)<br>
+logger.addHandler(logging.FileHandler(os.path.join(this_dir, &#39;prserv_u=
nittests.log&#39;), mode=3D&#39;w&#39;))<br>
+<br>
+logger.debug(&quot;-----------&quot;)<br>
+logger.debug(&quot;global setup&quot;)<br>
+logger.debug(&quot;bitbake_dir =3D %s&quot;, bitbake_dir)<br>
+logger.debug(&quot;this_dir =3D %s&quot;, this_dir)<br>
+<br>
+sock =3D None<br>
+conn =3D None<br>
+def setUpModule():<br>
+=C2=A0 =C2=A0 global sock, conn<br>
+=C2=A0 =C2=A0 logger.debug(&quot;setUpModule&quot;)<br>
+=C2=A0 =C2=A0 dbfile =3D os.path.join(this_dir, &#39;pr_test.db&#39;)<br>
+=C2=A0 =C2=A0 if os.path.exists(dbfile):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 os.remove(dbfile)<br>
+<br>
+=C2=A0 =C2=A0 logfile =3D os.path.join(this_dir, &#39;prserv_daemon.log&#3=
9;)<br>
+=C2=A0 =C2=A0 logging.getLogger(&quot;BitBake.PRserv&quot;).setLevel(loggi=
ng.DEBUG)<br>
+<br>
+=C2=A0 =C2=A0 if os.path.exists(logfile):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 os.remove(logfile)<br>
+<br>
+=C2=A0 =C2=A0 prserv.init_logger(os.path.abspath(logfile), &quot;DEBUG&quo=
t;)<br>
+=C2=A0 =C2=A0 prserv.serv.start_daemon(dbfile, HOST, PORT, logfile)<br>
+=C2=A0 =C2=A0 time.sleep(1)<br>
+<br>
+=C2=A0 =C2=A0 conn =3D sqlite3.connect(dbfile, isolation_level=3D&quot;EXC=
LUSIVE&quot;, check_same_thread=3DFalse)<br>
+<br>
+=C2=A0 =C2=A0 sock =3D socket.socket(socket.AF_INET, socket.SOCK_STREAM)<b=
r>
+=C2=A0 =C2=A0 sock.connect((&#39;localhost&#39;, PORT))<br>
+=C2=A0 =C2=A0 msg =3D b&#39;PRSERVICE 1.0\n\n&#39;<br>
+=C2=A0 =C2=A0 sock.send(msg)<br>
+<br>
+<br>
+def tearDownModule():<br>
+=C2=A0 =C2=A0 logger.debug(&quot;tearDownModule&quot;)<br>
+=C2=A0 =C2=A0 sock.close()<br>
+=C2=A0 =C2=A0 prserv.serv.stop_daemon(HOST, PORT)<br>
+<br>
+<br>
+class PRServerTest(unittest.TestCase):<br>
+=C2=A0 =C2=A0 def setUp(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://logger.info" rel=3D"noreferr=
er" target=3D"_blank">logger.info</a>(&quot;inst setUp()&quot;)<br>
+<br>
+=C2=A0 =C2=A0 def tearDown(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://logger.info" rel=3D"noreferr=
er" target=3D"_blank">logger.info</a>(&quot;inst tearDown()&quot;)<br>
+<br>
+=C2=A0 =C2=A0 def ping(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return True<br>
+<br>
+=C2=A0 =C2=A0 def getPR(self, version: str, arch: str, checksum: str) -&gt=
; int:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://bb.logger.info" rel=3D"noref=
errer" target=3D"_blank">bb.logger.info</a>(&quot;getting PRAUTO&quot;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 p =3D {&#39;get-pr&#39;: {&#39;version&#39;: v=
ersion, &#39;pkgarch&#39;: arch, &#39;checksum&#39;: checksum}}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D &quot;%s\n&quot; % json.dumps(p)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sock.send(data.encode(&#39;utf-8&#39;))<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D sock.recv(128)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D json.loads(data.decode(&#39;utf-8&#39=
;))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Returns {&#39;value&#39;: 1}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return data[&#39;value&#39;]<br>
+<br>
+=C2=A0 =C2=A0 def test_first_query(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 v =3D self.getPR(&quot;aaa&quot;, &quot;bbb&qu=
ot;, &quot;c&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert v =3D=3D 0, &#39;v =3D %s&#39; % v<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 v =3D self.getPR(&quot;aaa&quot;, &quot;bbb&qu=
ot;, &quot;c&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert v =3D=3D 0<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 v =3D self.getPR(&quot;xyz&quot;, &quot;y&quot=
;, &quot;z&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert v =3D=3D 0<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 v =3D self.getPR(&quot;xyz&quot;, &quot;y&quot=
;, &quot;z&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert v =3D=3D 0<br>
+<br>
+=C2=A0 =C2=A0 def test_bad_queries(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert self.ping()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.getPR(&quot;aaa&quot;, &quo=
t;bbb&quot;, &quot;c&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.getPR(&quot;aaa&quot;, &quo=
t;bbb&quot;, &quot;c&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.getPR(&quot;aaa&quot;, &quo=
t;bbb&quot;, &quot;c&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert False, &#39;Should have g=
otten an error&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 except Exception:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pass<br>
+<br>
+=C2=A0 =C2=A0 def test_checksum_changes(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert self.ping()<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 v1 =3D self.getPR(&quot;pkg-a&quot;, &quot;arm=
64&quot;, &quot;hash-a&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert v1 =3D=3D 0<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 v2 =3D self.getPR(&quot;pkg-a&quot;, &quot;arm=
64&quot;, &quot;hash-b&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert v2 =3D=3D 1<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 v3 =3D self.getPR(&quot;pkg-a&quot;, &quot;arm=
64&quot;, &quot;hash-c&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert v3 =3D=3D 2<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 v4 =3D self.getPR(&quot;pkg-a&quot;, &quot;arm=
64&quot;, &quot;hash-d&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert v4 =3D=3D 3<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 v5 =3D self.getPR(&quot;pkg-a&quot;, &quot;arm=
64&quot;, &quot;hash-b&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert v5 =3D=3D 4<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 v5 =3D self.getPR(&quot;pkg-a&quot;, &quot;arm=
64&quot;, &quot;hash-b&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert v5 =3D=3D 4<br>
+<br>
+=C2=A0 =C2=A0 def test_arch_changes(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert self.ping()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 v =3D self.getPR(&quot;pkg-b&quot;, &quot;arm6=
4&quot;, &quot;hash-a&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert v =3D=3D 0<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 v =3D self.getPR(&quot;pkg-b&quot;, &quot;imx8=
mm&quot;, &quot;hash-a&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert v =3D=3D 0<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 v =3D self.getPR(&quot;pkg-b&quot;, &quot;aarc=
h64&quot;, &quot;hash-a&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert v =3D=3D 0<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 v =3D self.getPR(&quot;pkg-b&quot;, &quot;8086=
&quot;, &quot;hash-a&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert v =3D=3D 0<br>
+<br>
+=C2=A0 =C2=A0 def test_autoinc(self):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 assert self.ping()<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sha1 =3D &quot;12345&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sha2 =3D &quot;23456&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sha3 =3D &quot;34567&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 v =3D self.getPR(&quot;AUTOINC-daemon-1.2.3+&q=
uot;, &quot;aarch64&quot;, &quot;AUTOINC+%s&quot; % sha1)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(v, 0)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 v =3D self.getPR(&quot;AUTOINC-daemon-1.2.3+&q=
uot;, &quot;aarch64&quot;, &quot;AUTOINC+%s&quot; % sha2)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(v, 1)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 v =3D self.getPR(&quot;AUTOINC-daemon-1.2.4+&q=
uot;, &quot;aarch64&quot;, &quot;AUTOINC+%s&quot; % sha1)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(v, 0)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 v =3D self.getPR(&quot;AUTOINC-daemon-1.2.3+&q=
uot;, &quot;x86_64&quot;, &quot;AUTOINC+%s&quot; % sha1)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(v, 0)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 v =3D self.getPR(&quot;AUTOINC-daemon-1.2.3+&q=
uot;, &quot;aarch64&quot;, &quot;AUTOINC+%s&quot; % sha3)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(v, 2)<br>
+<br>
+<br>
+=C2=A0 =C2=A0 def test_full(self):<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pkgs =3D [&#39;pkg-x&#39;, &#39;pkg-y&#39;, &#=
39;pkg-z&#39;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 arches =3D [&#39;arm64&#39;, &#39;x86_64&#39;]=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hashes =3D [&#39;hash-%d&#39; % i for i in ran=
ge(10)]<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 rand =3D random.Random(0)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Populate database with basic stuff<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for pkg, arch in itertools.product(pkgs, arche=
s):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v =3D self.getPR(pkg, arch, &quo=
t;0&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert v is not None<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Populate database with random-ish stuff<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for _ in range(100):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pkg =3D rand.choice(pkgs)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 arch =3D rand.choice(arches)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hash_ =3D rand.choice(hashes)<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v =3D self.getPR(pkg, arch, hash=
_)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert v is not None<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 table =3D &#39;PRMAIN_nohist&#39;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 old_versions =3D {}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 old_versions_2 =3D {}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for pkg, arch, hash_ in itertools.product(pkgs=
, arches, hashes):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # verify that all OSv2 versions =
are less than the OSv1 version<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 query =3D &#39;select ifnull(max=
(value),0) from %s where version=3D? AND pkgarch=3D?;&#39; % table<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 args =3D (pkg, arch)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 data =3D conn.execute(query, arg=
s)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 row =3D data.fetchone()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert row is not None<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 value =3D row[0]<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 k =3D &#39;%s-%s&#39; % (pkg, ar=
ch)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 old_v =3D old_versions.get(k, -1=
)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert value &gt;=3D old_v, &quo=
t;%s %s: old_v=3D%s, new_v=3D%s&quot; % (pkg, arch, old_v, value)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 old_versions[k] =3D value<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 k2 =3D &#39;%s-%s&#39; % (pkg, a=
rch)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 old_versions_2[k2] =3D value<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&#39;\n&#39;)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for k in sorted(old_versions_2.keys()):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 v =3D old_versions_2[k]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print(&quot;Max for %s is %s&quo=
t; % (k, v))<br>
-- <br>
2.25.1<br>
<br>
<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
Links: You receive all messages sent to this group.<br>
View/Reply Online (#15040): <a href=3D"https://lists.openembedded.org/g/bit=
bake-devel/message/15040" rel=3D"noreferrer" target=3D"_blank">https://list=
s.openembedded.org/g/bitbake-devel/message/15040</a><br>
Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/101331395/505=
2612" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/m=
t/101331395/5052612</a><br>
Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedded.org=
" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel/unsu=
b" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org/g/bi=
tbake-devel/unsub</a> [<a href=3D"mailto:quaresma.jose@gmail.com" target=3D=
"_blank">quaresma.jose@gmail.com</a>]<br>
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr">Best regards,<div><br>Jos=C3=A9 Quaresma</div></div></div></=
div>

--00000000000004210f06054dc87d--

