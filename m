Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369AAC04FFE
	for <webhook@archiver.kernel.org>; Mon, 29 Apr 2024 21:08:31 +0000 (UTC)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
 by mx.groups.io with SMTP id smtpd.web10.33824.1714424904667466728
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 29 Apr 2024 14:08:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=GSb6DI0t;
 spf=pass (domain: gmail.com, ip: 209.85.208.175, mailfrom: jpewhacker@gmail.com)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2dcc8d10d39so57773001fa.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 29 Apr 2024 14:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714424903; x=1715029703; darn=lists.openembedded.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXT7btfp9s1AfLXOSuekfwbiA1PZyh/Ng8xE1vsBw8U=;
        b=GSb6DI0tNskgqwt2NsLCj09M3nL6BQNxZilnPhF/ONMQ6h2i4TyGYUiZnJSv0qvgT0
         1P/U6Rn84MeihH1rUKEwQb+CcBXrTc5jYo3ra1b1szaFl4rDrNBOAL62pqdvFF1nwmMF
         b0VlIJDuWfb/mxY/RgaqkcB+an/5iW4Msu/e7+Dhqkh94h6404guRk9YTq1tLc/o3VR4
         jHijhqz9kxobZLbl0as4poNN/HcF7Ju0eHGd38C0Lf3C+CxxzwlnmqN/5nUR29OpeVLT
         5uRb/5AQz86dzchGubkd6/55GFG+a6W0jzZYJ/tRcO3Ul7gkeyt1YU2p0HoZxGW6V0Ji
         j1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714424903; x=1715029703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DXT7btfp9s1AfLXOSuekfwbiA1PZyh/Ng8xE1vsBw8U=;
        b=xFBMILwjrNOi7gx+JnJcsT7xQC5KRgL9QuI2J75P/KSJb2efzaJt2YAbWGQc62t7r2
         LoRJZ1pRwKZDJ3Vjad/ItY5ikHBbDFyvbT50s0Bk1TojFOsYxp/XmYfT3MmEZIMWdvcp
         AO/643evt6P84EeGbmjOPxebj+57qtms0xM3JKRVSNy06vMLT2gOsSwLJ+G1GQs0DJvL
         L6P9zN+DKmdHIw6bgsoa/r6ko/XvtP7AGDZdmyjzG+C5Qm3hS1fgH3FCMzbus59ZRDR3
         00SKKAnpc7b+A+52ooI8HqepZOROY9FZWABZQO99dxstnr3i0gzpYzmTMC7YZtbT+pff
         5m2Q==
X-Gm-Message-State: AOJu0YxZqLTNUI7KY1XMIZb7b1LCQtwCYP7aNXJQIESxjXDJk7xV8CLN
	wiN/XyhqgvWzVba2awlyn5WLiHb1/O7nsgRUzlnPWVZ2u2GWku5mvK+nEVZBQ/xPtwAtYPEd7kp
	4VwwqzkKtIS9CIZCkpmYmzDbzt4I=
X-Google-Smtp-Source: AGHT+IH9GXD2SYR5pf/Wpx2bpJMxieu8oiJE6nCQ3KzRYAPnHE9A8fLLDbWUhdvROSp/js97j/5MG13/Ec/6rqdSpbA=
X-Received: by 2002:a05:651c:50f:b0:2e0:3132:94d4 with SMTP id
 o15-20020a05651c050f00b002e0313294d4mr3353302ljp.16.1714424902591; Mon, 29
 Apr 2024 14:08:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240429201418.657042-1-michael.opdenacker@bootlin.com> <20240429201418.657042-6-michael.opdenacker@bootlin.com>
In-Reply-To: <20240429201418.657042-6-michael.opdenacker@bootlin.com>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Mon, 29 Apr 2024 15:08:10 -0600
Message-ID: <CAJdd5GZd-UQ6uQh3m__fU21KGOcMvQbt93zeR2S33DOxi02f3Q@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] prserv: add bitbake selftests
To: michael.opdenacker@bootlin.com
Cc: bitbake-devel@lists.openembedded.org, Tim Orling <ticotimo@gmail.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 29 Apr 2024 21:08:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16158

On Mon, Apr 29, 2024 at 2:14=E2=80=AFPM <michael.opdenacker@bootlin.com> wr=
ote:
>
> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
>
> Run them with "bitbake-selftest prserv.tests"
>
> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> Cc: Joshua Watt <JPEWhacker@gmail.com>
> Cc: Tim Orling <ticotimo@gmail.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> ---
>  bin/bitbake-selftest |   2 +
>  lib/prserv/tests.py  | 416 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 418 insertions(+)
>  create mode 100644 bitbake/lib/prserv/tests.py
>
> diff --git a/bin/bitbake-selftest b/bin/bitbake-selftest
> index f25f23b1ae..ce901232fe 100755
> --- a/bin/bitbake-selftest
> +++ b/bin/bitbake-selftest
> @@ -15,6 +15,7 @@ import unittest
>  try:
>      import bb
>      import hashserv
> +    import prserv
>      import layerindexlib
>  except RuntimeError as exc:
>      sys.exit(str(exc))
> @@ -33,6 +34,7 @@ tests =3D ["bb.tests.codeparser",
>           "bb.tests.utils",
>           "bb.tests.compression",
>           "hashserv.tests",
> +         "prserv.tests",
>           "layerindexlib.tests.layerindexobj",
>           "layerindexlib.tests.restapi",
>           "layerindexlib.tests.cooker"]
> diff --git a/lib/prserv/tests.py b/lib/prserv/tests.py
> new file mode 100644
> index 0000000000..051a03c876
> --- /dev/null
> +++ b/lib/prserv/tests.py
> @@ -0,0 +1,416 @@
> +#! /usr/bin/env python3
> +#
> +# Copyright (C) 2024 BitBake Contributors
> +#
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +
> +from . import create_server, create_client, increase_revision, revision_=
greater, revision_smaller, _revision_greater_or_equal
> +import prserv.db as db
> +from bb.asyncrpc import InvokeError
> +import logging
> +import os
> +import sys
> +import tempfile
> +import unittest
> +import socket
> +import subprocess
> +from pathlib import Path
> +
> +THIS_DIR =3D Path(__file__).parent
> +BIN_DIR =3D THIS_DIR.parent.parent / "bin"
> +
> +version =3D "dummy-1.0-r0"
> +pkgarch =3D "core2-64"
> +other_arch =3D "aarch64"
> +
> +checksumX =3D "51bf8189dbe9ea81fa6dd89608bf19380c437a9cf12f6c6239887801b=
a4ab4f0"
> +checksum0 =3D "51bf8189dbe9ea81fa6dd89608bf19380c437a9cf12f6c6239887801b=
a4ab4a0"
> +checksum1 =3D "51bf8189dbe9ea81fa6dd89608bf19380c437a9cf12f6c6239887801b=
a4ab4a1"
> +checksum2 =3D "51bf8189dbe9ea81fa6dd89608bf19380c437a9cf12f6c6239887801b=
a4ab4a2"
> +checksum3 =3D "51bf8189dbe9ea81fa6dd89608bf19380c437a9cf12f6c6239887801b=
a4ab4a3"
> +checksum4 =3D "51bf8189dbe9ea81fa6dd89608bf19380c437a9cf12f6c6239887801b=
a4ab4a4"
> +checksum5 =3D "51bf8189dbe9ea81fa6dd89608bf19380c437a9cf12f6c6239887801b=
a4ab4a5"
> +checksum6 =3D "51bf8189dbe9ea81fa6dd89608bf19380c437a9cf12f6c6239887801b=
a4ab4a6"
> +checksum7 =3D "51bf8189dbe9ea81fa6dd89608bf19380c437a9cf12f6c6239887801b=
a4ab4a7"
> +checksum8 =3D "51bf8189dbe9ea81fa6dd89608bf19380c437a9cf12f6c6239887801b=
a4ab4a8"
> +checksum9 =3D "51bf8189dbe9ea81fa6dd89608bf19380c437a9cf12f6c6239887801b=
a4ab4a9"
> +checksum10 =3D "51bf8189dbe9ea81fa6dd89608bf19380c437a9cf12f6c6239887801=
ba4ab4aa"
> +
> +def server_prefunc(server, name):
> +    logging.basicConfig(level=3Dlogging.DEBUG, filename=3D'prserv-%s.log=
' % name, filemode=3D'w',
> +                        format=3D'%(levelname)s %(filename)s:%(lineno)d =
%(message)s')
> +    server.logger.debug("Running server %s" % name)
> +    sys.stdout =3D open('prserv-stdout-%s.log' % name, 'w')
> +    sys.stderr =3D sys.stdout
> +
> +class PRTestSetup(object):
> +
> +    def start_server(self, name, dbfile, upstream=3DNone, read_only=3DFa=
lse, prefunc=3Dserver_prefunc):
> +
> +        def cleanup_server(server):
> +            if server.process.exitcode is not None:
> +                return
> +            server.process.terminate()
> +            server.process.join()
> +
> +        server =3D create_server(socket.gethostbyname("localhost") + ":0=
",
> +                               dbfile,
> +                               upstream=3Dupstream,
> +                               read_only=3Dread_only)
> +
> +        server.serve_as_process(prefunc=3Dprefunc, args=3D(name,))
> +        self.addCleanup(cleanup_server, server)
> +
> +        return server
> +
> +    def start_client(self, server_address):
> +        def cleanup_client(client):
> +            client.close()
> +
> +        client =3D create_client(server_address)
> +        self.addCleanup(cleanup_client, client)
> +
> +        return client
> +
> +class FunctionTests(unittest.TestCase):
> +
> +    def test_0a_increase_revision(self):
> +        self.assertEqual(increase_revision("1"), "2")
> +        self.assertEqual(increase_revision("1.0"), "1.1")
> +        self.assertEqual(increase_revision("1.1.1"), "1.1.2")
> +        self.assertEqual(increase_revision("1.1.1.3"), "1.1.1.4")
> +        self.assertRaises(ValueError, increase_revision, "1.a")
> +        self.assertRaises(ValueError, increase_revision, "1.")
> +        self.assertRaises(ValueError, increase_revision, "")
> +
> +    def test_0b_revision_greater_or_equal(self):
> +        self.assertTrue(_revision_greater_or_equal("2", "2"))
> +        self.assertTrue(_revision_greater_or_equal("2", "1"))
> +        self.assertTrue(_revision_greater_or_equal("10", "2"))
> +        self.assertTrue(_revision_greater_or_equal("1.10", "1.2"))
> +        self.assertFalse(_revision_greater_or_equal("1.2", "1.10"))
> +        self.assertTrue(_revision_greater_or_equal("1.10", "1"))
> +        self.assertTrue(_revision_greater_or_equal("1.10.1", "1.10"))
> +        self.assertFalse(_revision_greater_or_equal("1.10.1", "1.10.2"))
> +        self.assertTrue(_revision_greater_or_equal("1.10.1", "1.10.1"))
> +        self.assertTrue(_revision_greater_or_equal("1.10.1", "1"))
> +        self.assertTrue(revision_greater("1.20", "1.3"))
> +        self.assertTrue(revision_smaller("1.3", "1.20"))
> +
> +    # DB tests
> +
> +    def test_0b_db(self):
> +        dbfile =3D "testtable.sqlite3"
> +        if os.path.exists(dbfile):
> +            os.remove(dbfile)
> +
> +        self.db =3D db.PRData(dbfile)
> +        self.table =3D self.db["PRMAIN"]
> +
> +        self.table.store_value(version, pkgarch, checksum0, "0")
> +        self.table.store_value(version, pkgarch, checksum1, "1")
> +        # "No history" mode supports multiple PRs for the same checksum
> +        self.table.store_value(version, pkgarch, checksum0, "2")
> +        self.table.store_value(version, pkgarch, checksum2, "1.0")
> +
> +        self.assertTrue(self.table.test_package(version, pkgarch))
> +        self.assertFalse(self.table.test_package(version, other_arch))
> +
> +        self.assertTrue(self.table.test_value(version, pkgarch, "0"))
> +        self.assertTrue(self.table.test_value(version, pkgarch, "1"))
> +        self.assertTrue(self.table.test_value(version, pkgarch, "2"))
> +
> +        self.assertEqual(self.table.find_package_max_value(version, pkga=
rch), "2")
> +
> +        self.assertEqual(self.table.find_min_value(version, pkgarch, che=
cksum0), "0")
> +        self.assertEqual(self.table.find_max_value(version, pkgarch, che=
cksum0), "2")
> +
> +        # Test history modes
> +        self.assertEqual(self.table.find_value(version, pkgarch, checksu=
m0, True), "0")
> +        self.assertEqual(self.table.find_value(version, pkgarch, checksu=
m0, False), "2")
> +
> +        self.assertEqual(self.table.find_new_subvalue(version, pkgarch, =
"3"), "3.0")
> +        self.assertEqual(self.table.find_new_subvalue(version, pkgarch, =
"1"), "1.1")
> +
> +        # Revision comparison tests
> +        self.table.store_value(version, pkgarch, checksum1, "1.3")
> +        self.table.store_value(version, pkgarch, checksum1, "1.20")
> +        self.assertEqual(self.table.find_min_value(version, pkgarch, che=
cksum1), "1")
> +        self.assertEqual(self.table.find_max_value(version, pkgarch, che=
cksum1), "1.20")
> +
> +class PRBasicTests(PRTestSetup, unittest.TestCase):
> +
> +    def setUp(self):
> +        dbfile =3D "prtest-basic.sqlite3"

It's generally considered bad form to dump test files in the users CWD
and also blindly os.remove() things there :)

In the hash server tests, we create a temporary directory and clean it
up when the test ends by doing this in setUp():

        self.temp_dir =3D tempfile.TemporaryDirectory(prefix=3D'bb-hashserv=
')
        self.addCleanup(self.temp_dir.cleanup)

Then use self.temp_dir as the base whenever you need a path, e.g:

        dbfile =3D os.path.join(self.temp_dir, "prtest-basic.sqlite3")


> +        if os.path.exists(dbfile):
> +            os.remove(dbfile)
> +
> +        self.server1 =3D self.start_server("basic", dbfile)
> +        self.client1 =3D self.start_client(self.server1.address)
> +
> +    def test_1a_basic(self):
> +
> +        # Checks on non existing configuration
> +
> +        result =3D self.client1.test_pr(version, pkgarch, checksum0)
> +        self.assertIsNone(result, "test_pr should return 'None' for a no=
n existing PR")
> +
> +        result =3D self.client1.test_package(version, pkgarch)
> +        self.assertFalse(result, "test_package should return 'False' for=
 a non existing PR")
> +
> +        result =3D self.client1.max_package_pr(version, pkgarch)
> +        self.assertIsNone(result, "max_package_pr should return 'None' f=
or a non existing PR")
> +
> +        # Add a first configuration
> +
> +        result =3D self.client1.getPR(version, pkgarch, checksum0)
> +        self.assertEqual(result, "0", "getPR: initial PR of a package sh=
ould be '0'")
> +
> +        result =3D self.client1.test_pr(version, pkgarch, checksum0)
> +        self.assertEqual(result, "0", "test_pr should return '0' here, m=
atching the result of getPR")
> +
> +        result =3D self.client1.test_package(version, pkgarch)
> +        self.assertTrue(result, "test_package should return 'True' for a=
n existing PR")
> +
> +        result =3D self.client1.max_package_pr(version, pkgarch)
> +        self.assertEqual(result, "0", "max_package_pr should return '0' =
in the current test series")
> +
> +        # Check that the same request gets the same value
> +
> +        result =3D self.client1.getPR(version, pkgarch, checksum0)
> +        self.assertEqual(result, "0", "getPR: asking for the same PR a s=
econd time in a row should return the same value.")
> +
> +        # Add new configurations
> +
> +        result =3D self.client1.getPR(version, pkgarch, checksum1)
> +        self.assertEqual(result, "1", "getPR: second PR of a package sho=
uld be '1'")
> +
> +        result =3D self.client1.test_pr(version, pkgarch, checksum1)
> +        self.assertEqual(result, "1", "test_pr should return '1' here, m=
atching the result of getPR")
> +
> +        result =3D self.client1.max_package_pr(version, pkgarch)
> +        self.assertEqual(result, "1", "max_package_pr should return '1' =
in the current test series")
> +
> +        result =3D self.client1.getPR(version, pkgarch, checksum2)
> +        self.assertEqual(result, "2", "getPR: second PR of a package sho=
uld be '2'")
> +
> +        result =3D self.client1.test_pr(version, pkgarch, checksum2)
> +        self.assertEqual(result, "2", "test_pr should return '2' here, m=
atching the result of getPR")
> +
> +        result =3D self.client1.max_package_pr(version, pkgarch)
> +        self.assertEqual(result, "2", "max_package_pr should return '2' =
in the current test series")
> +
> +        result =3D self.client1.getPR(version, pkgarch, checksum3)
> +        self.assertEqual(result, "3", "getPR: second PR of a package sho=
uld be '3'")
> +
> +        result =3D self.client1.test_pr(version, pkgarch, checksum3)
> +        self.assertEqual(result, "3", "test_pr should return '3' here, m=
atching the result of getPR")
> +
> +        result =3D self.client1.max_package_pr(version, pkgarch)
> +        self.assertEqual(result, "3", "max_package_pr should return '3' =
in the current test series")
> +
> +        # Ask again for the first configuration
> +
> +        result =3D self.client1.getPR(version, pkgarch, checksum0)
> +        self.assertEqual(result, "4", "getPR: should return '4' in this =
configuration")
> +
> +        # Ask again with explicit "no history" mode
> +
> +        result =3D self.client1.getPR(version, pkgarch, checksum0, False=
)
> +        self.assertEqual(result, "4", "getPR: should return '4' in this =
configuration")
> +
> +        # Ask again with explicit "history" mode. This should return the=
 first recorded PR for checksum0
> +
> +        result =3D self.client1.getPR(version, pkgarch, checksum0, True)
> +        self.assertEqual(result, "0", "getPR: should return '0' in this =
configuration")
> +
> +        # Check again that another pkgarg resets the counters
> +
> +        result =3D self.client1.test_pr(version, other_arch, checksum0)
> +        self.assertIsNone(result, "test_pr should return 'None' for a no=
n existing PR")
> +
> +        result =3D self.client1.test_package(version, other_arch)
> +        self.assertFalse(result, "test_package should return 'False' for=
 a non existing PR")
> +
> +        result =3D self.client1.max_package_pr(version, other_arch)
> +        self.assertIsNone(result, "max_package_pr should return 'None' f=
or a non existing PR")
> +
> +        # Now add the configuration
> +
> +        result =3D self.client1.getPR(version, other_arch, checksum0)
> +        self.assertEqual(result, "0", "getPR: initial PR of a package sh=
ould be '0'")
> +
> +        result =3D self.client1.test_pr(version, other_arch, checksum0)
> +        self.assertEqual(result, "0", "test_pr should return '0' here, m=
atching the result of getPR")
> +
> +        result =3D self.client1.test_package(version, other_arch)
> +        self.assertTrue(result, "test_package should return 'True' for a=
n existing PR")
> +
> +        result =3D self.client1.max_package_pr(version, other_arch)
> +        self.assertEqual(result, "0", "max_package_pr should return '0' =
in the current test series")
> +
> +    def test_1b_is_readonly(self):
> +        result =3D self.client1.is_readonly()
> +        self.assertFalse(result, "Server should not be described as 'rea=
d-only'")
> +
> +class PRReadOnlyTests(PRTestSetup, unittest.TestCase):
> +
> +    def setUp(self):
> +        # Here we're using the database test table, as for reasons not u=
nderstood yet,
> +        # the other tables we created from the PR server in prior tests,=
 have empty contents!
> +        dbfile =3D "testtable.sqlite3"
> +        self.server1 =3D self.start_server("basic-readonly", dbfile, rea=
d_only=3DTrue)
> +        self.client1 =3D self.start_client(self.server1.address)
> +
> +    def test_2a_read_only_server(self):
> +
> +        result =3D self.client1.is_readonly()
> +        self.assertTrue(result, "Database should be described as 'read-o=
nly'")
> +
> +        # Checks on non existing configuration
> +        self.assertIsNone(self.client1.test_pr(version, pkgarch, checksu=
mX))
> +        self.assertFalse(self.client1.test_package("unknown", pkgarch))
> +
> +        # Look up an existing configuration
> +        self.assertEqual(self.client1.getPR(version, pkgarch, checksum0)=
, "2") # "no history" mode
> +        self.assertEqual(self.client1.getPR(version, pkgarch, checksum0,=
 True), "0") # "history" mode
> +        self.assertEqual(self.client1.getPR(version, pkgarch, checksum2)=
, "3")
> +        self.assertEqual(self.client1.getPR(version, pkgarch, checksum2,=
 True), "1.0")
> +        self.assertEqual(self.client1.max_package_pr(version, pkgarch), =
"2")
> +
> +        # Try to insert a new value. The value should be correct given t=
he read-only dababase, but won't be saved
> +        self.assertEqual(self.client1.getPR(version, pkgarch, checksum3)=
, "3")
> +        # Same of another value
> +        self.assertEqual(self.client1.getPR(version, pkgarch, checksum3)=
, "3")
> +
> +class PRUpstreamTests(PRTestSetup, unittest.TestCase):
> +
> +    def setUp(self):
> +
> +        dbfile2 =3D "prtest-upstream2.sqlite3"
> +        if os.path.exists(dbfile2):
> +            os.remove(dbfile2)
> +
> +        self.server2 =3D self.start_server("upstream2", dbfile2)
> +        self.client2 =3D self.start_client(self.server2.address)
> +
> +        dbfile1 =3D "prtest-upstream1.sqlite3"
> +        if os.path.exists(dbfile1):
> +            os.remove(dbfile1)
> +
> +        self.server1 =3D self.start_server("upstream1", dbfile1, upstrea=
m=3Dself.server2.address)
> +        self.client1 =3D self.start_client(self.server1.address)
> +
> +        dbfile0 =3D "prtest-local.sqlite3"
> +        if os.path.exists(dbfile0):
> +            os.remove(dbfile0)
> +
> +        self.server0 =3D self.start_server("local", dbfile0, upstream=3D=
self.server1.address)
> +        self.client0 =3D self.start_client(self.server0.address)
> +        self.shared_db =3D dbfile0
> +
> +    def test_3a_upstream(self):
> +
> +        # For identical checksums, all servers should return the same PR
> +
> +        result =3D self.client2.getPR(version, pkgarch, checksum0)
> +        self.assertEqual(result, "0", "getPR: initial PR of a package sh=
ould be '0'")
> +
> +        result =3D self.client1.getPR(version, pkgarch, checksum0)
> +        self.assertEqual(result, "0", "getPR: initial PR of a package sh=
ould be '0' (same as upstream)")
> +
> +        result =3D self.client0.getPR(version, pkgarch, checksum0)
> +        self.assertEqual(result, "0", "getPR: initial PR of a package sh=
ould be '0' (same as upstream)")
> +
> +        # Now introduce new checksums on server1 for, same version
> +
> +        result =3D self.client1.getPR(version, pkgarch, checksum1)
> +        self.assertEqual(result, "0.0", "getPR: first PR of a package wh=
ich has a different checksum upstream should be '0.0'")
> +
> +        result =3D self.client1.getPR(version, pkgarch, checksum2)
> +        self.assertEqual(result, "0.1", "getPR: second PR of a package t=
hat has a different checksum upstream should be '0.1'")
> +
> +        # Now introduce checksums on server0 for, same version
> +
> +        result =3D self.client1.getPR(version, pkgarch, checksum1)
> +        self.assertEqual(result, "0.2", "getPR: can't decrease for known=
 PR")
> +
> +        result =3D self.client1.getPR(version, pkgarch, checksum2)
> +        self.assertEqual(result, "0.3")
> +
> +        result =3D self.client1.max_package_pr(version, pkgarch)
> +        self.assertEqual(result, "0.3")
> +
> +        result =3D self.client0.getPR(version, pkgarch, checksum3)
> +        self.assertEqual(result, "0.3.0", "getPR: first PR of a package =
that doesn't exist upstream should be '0.3.0'")
> +
> +        result =3D self.client0.getPR(version, pkgarch, checksum4)
> +        self.assertEqual(result, "0.3.1", "getPR: second PR of a package=
 that doesn't exist upstream should be '0.3.1'")
> +
> +        result =3D self.client0.getPR(version, pkgarch, checksum3)
> +        self.assertEqual(result, "0.3.2")
> +
> +        # More upstream updates
> +        # Here, we assume no communication between server2 and server0. =
server2 only impacts server0
> +        # after impacting server1
> +
> +        self.assertEqual(self.client2.getPR(version, pkgarch, checksum5)=
, "1")
> +        self.assertEqual(self.client1.getPR(version, pkgarch, checksum6)=
, "1.0")
> +        self.assertEqual(self.client1.getPR(version, pkgarch, checksum7)=
, "1.1")
> +        self.assertEqual(self.client0.getPR(version, pkgarch, checksum8)=
, "1.1.0")
> +        self.assertEqual(self.client0.getPR(version, pkgarch, checksum9)=
, "1.1.1")
> +
> +        # "history" mode tests
> +
> +        self.assertEqual(self.client2.getPR(version, pkgarch, checksum0,=
 True), "0")
> +        self.assertEqual(self.client1.getPR(version, pkgarch, checksum2,=
 True), "0.1")
> +        self.assertEqual(self.client0.getPR(version, pkgarch, checksum3,=
 True), "0.3.0")
> +
> +        # More "no history" mode tests
> +
> +        self.assertEqual(self.client2.getPR(version, pkgarch, checksum0)=
, "2")
> +        self.assertEqual(self.client1.getPR(version, pkgarch, checksum0)=
, "2") # Same as upstream
> +        self.assertEqual(self.client0.getPR(version, pkgarch, checksum0)=
, "2") # Same as upstream
> +        self.assertEqual(self.client1.getPR(version, pkgarch, checksum7)=
, "3") # This could be surprising, but since the previous revision was "2",=
 increasing it yields "3".
> +                                                                        =
       # We don't know how many upstream servers we have
> +    def test_3b_readonly(self):
> +
> +        # Start read-only server
> +        self.server_ro =3D self.start_server("local-ro", self.shared_db,=
 upstream=3Dself.server1.address, read_only=3DTrue)
> +        self.client_ro =3D self.start_client(self.server_ro.address)
> +
> +        self.assertTrue(self.client_ro.is_readonly(), "Database should b=
e described as 'read-only'")
> +
> +        # Checks on non existing configurations
> +        self.assertIsNone(self.client_ro.test_pr(version, pkgarch, check=
sumX))
> +        self.assertFalse(self.client_ro.test_package("unknown", pkgarch)=
)
> +
> +        # Look up existing configurations
> +        self.assertEqual(self.client_ro.getPR(version, pkgarch, checksum=
0), "2") # "no history" mode
> +        #self.assertEqual(self.client_ro.getPR(version, pkgarch, checksu=
m0, True), "0") # "history" mode
> +        #self.assertEqual(self.client_ro.getPR(version, pkgarch, checksu=
m3), "0.3.0")
> +        #self.assertEqual(self.client_ro.getPR(version, pkgarch, checksu=
m3, True), "0.3.0")
> +        self.assertEqual(self.client_ro.max_package_pr(version, pkgarch)=
, "3")
> +
> +        # Try to insert a new value. The value should be correct given t=
he read-only dababase, but won't be saved
> +        self.assertEqual(self.client_ro.getPR(version, pkgarch, checksum=
7), "3")
> +        # Same of another value which only exists in the upstream upstre=
am
> +        # It's as it's a completely new one. We may want the upstream se=
rver to ask its upstream server for this value though.
> +        self.assertEqual(self.client_ro.getPR(version, pkgarch, checksum=
8), "4")
> +        # Try to insert a completely new value. It should also return "4=
" as the previous value wasn't saved by the read-only server.
> +        self.assertEqual(self.client_ro.getPR(version, pkgarch, checksum=
10), "4")
> +
> +class ScriptTests(unittest.TestCase):
> +
> +    def test_5a_start_bitbake_prserv(self):
> +        try:
> +            subprocess.check_call([BIN_DIR / "bitbake-prserv", "--start"=
, "-f", "testtable.sqlite3"])
> +        except subprocess.CalledProcessError as e:
> +            self.fail("Failed to start bitbake-prserv: %s" % e.returncod=
e)
> +
> +    def test_5b_stop_bitbake_prserv(self):
> +        try:
> +            subprocess.check_call([BIN_DIR / "bitbake-prserv", "--stop"]=
)
> +        except subprocess.CalledProcessError as e:
> +            self.fail("Failed to stop bitbake-prserv: %s" % e.returncode=
)
> --
> 2.34.1
>

