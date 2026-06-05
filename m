Return-Path: <anders.heimer@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C6ACD6E5D
	for <webhook@archiver.kernel.org>; Fri,  5 Jun 2026 04:58:39 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.29])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1519.1780635511989931224
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Jun 2026 21:58:34 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@est.tech header.s=selector1 header.b=Vf1YHNVb;
 spf=pass (domain: est.tech, ip: 52.101.66.29, mailfrom: anders.heimer@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rYOHMaJFsYq3A6nn8XIysVZPE+YP1sBmBEJH6DsH6RVhdqKFvGfR8Nzsp/IHe/Lc2zcKOo3KlKPJuyxJbH6B0a2tms7OlsP8zc6cw+mJ3nloMYhPjD7dxhVMrUtLHM/BKOqOdfMufJlaEhAxiZ9whE+G/uLJ7bjGbMtAMnDem0lUGLYw2OBR28AkRI8d/XIA5GRcAF8fJ0Sc1oNdcnNMmK60pw4UM1jnmkM+ImAE+9LIhNOaXvCqpO4U5x2TDv0klW+xWeg8zOBjDukJoJbHePs9JCxbfus1vlf4YcqF5K8CbEnFYPXpFdD8AFnOYMjGM+WM6ZGXmohZshbCBMSBxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1tg91+QzR+Cd4Fgk2E6z/stnOD0Fqg3KXJbiU46psJg=;
 b=Q2Gu2gDMDY1zQcTfUq0rECvxY5ctmr9uv3W+/2SnkFUCQf8wktNmn4GhTePQGZypT4IkcMoet5lrefx3D0WZVwEhYBEpIUU62JB3AAgsTr/dbaO+tNk8QAkHeGZpywTBNehQTZOFVFFzxWMO+QoeJ24YjQ+4sAtZT4ui/iiJZBKjKdoLab94aPwlDX28qQAafOoSdY9kZ/2J51BPYW8E0UW2tFLvRG2F9jmxHbBNyhQym5Dx7XCbZKj+6+PVnDu0b5dwvx7DHxER1vLUBRASU4x7fd7RInYkWcxMUi34ErWieWoxfojm7hqQQq+BmmbeGB2F41Bt8eAAoF/cIxo2KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tg91+QzR+Cd4Fgk2E6z/stnOD0Fqg3KXJbiU46psJg=;
 b=Vf1YHNVbYaLZqoevLQxSZCJHIgc3zByegikCMq7LEGBO3SPea2rbTaW+wRmxGTx7r/PYdwU4wQkNduj7j/t6ZKQm+9Db/UB6lwDhzvaxB+Qg+m7KvPJ5CSFOqCtvbpCyQjoYXo1E4HmmebLEqtu2tqkY3GLay5jF+fcr2wr0su3+X536wrUCMoYz9mK/LprMlU4rhtm5VauUqQ3rOVQuuMU/UJAWsKVQPdjJDLdGDzOdFr4R6Dc210fhJeYvgA6oP0h56SffLHKSRFz0X+wlbeT8qe9mPr+UILP5Dmw90lc/Kz/2ge0JwZqfXicowmWU+9dueNFyrh2NAowkMc7Phg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:2ac::9) by
 AM0P189MB0785.EURP189.PROD.OUTLOOK.COM (2603:10a6:208:19f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.8; Fri, 5 Jun 2026 04:58:30 +0000
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82]) by DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 04:58:30 +0000
From: Anders Heimer <anders.heimer@est.tech>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] hashserv: validate unihash values
Date: Fri,  5 Jun 2026 06:58:26 +0200
Message-ID: <20260605045826.2052909-3-anders.heimer@est.tech>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605045826.2052909-1-anders.heimer@est.tech>
References: <20260605045826.2052909-1-anders.heimer@est.tech>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: DB9PR01CA0028.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::33) To DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:2ac::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P189MB1641:EE_|AM0P189MB0785:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c988abd-d344-43af-0605-08dec2bf166b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|6133799003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: 
	88P0G1KstdKZegQs968vMcXO9SmB3LoLN77NC7o5S8WOROy1lzIuVgrO7satRuhUjDG3k0JTDHvDagcoU+eDgkVQi214Lq+COyoTXWbiPpvDT/As/Wk2DesGv0o/+hTE+opOONdt7PROO2Gdej3yLTejlTLpforM/AOZf3h+fW5zMIzdGP+S0gujFPaIR1iaKP4EXkZGrXEOvR02chkDgqy/kPLyHlQstoaLWLYiwQ2v/U7OGanNvKdeIc+d1+nJ4uW/UdYohv5Pq/TVnpRyHNE9UfUc0e+LuX972ST3k5uaN4GXtzNU+++LZLgg6Xqrke3R8X2ScrXrpQRiwQh5WKuhfUsJOxbb8vqE0pOhRuzUo1mvTxIDV9Epw55DcEi/t5dsiCYrjEo3mMnggAodgrrhjFeRrjZbLA6CN0jbnVKf9mrKASIXfo8TgrCPohwp8+CjOTgd51N9n+JyyucPVlszNR4h2bTQWpRJ6m4ln9CYdG9Vzd+eezsnemSkiDBl0dKXdNrEPw3Xlc7yy+lyr2noC13ad3rtHTZ0L72bSnT8CeQS5cpA4p+D2n74e+bNel3tdT8ASUwa0lpa1/l2EML/1EoDdG/1Ts/aeCX+n34zDaxVgjIrm5MVqjuexOKQOuKrpI4xVstbKcC2mVQOP6oG5ubRGwu0A4xox1qJHgx27jO2NsRosMzt/WByPD/G
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P189MB1641.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qOE1zRfV9S1AAo0fQP6LKTeFiyA+16U0AoFXNkjHpTrONUpajHKOxPYsOOem?=
 =?us-ascii?Q?3vmt3+uz6IJtNL/9oO4TrNt2RyPLRM+FbYWmyqxqPknuaerMVnwxbjyZTQSZ?=
 =?us-ascii?Q?vdWTTOt+Tsw7kWvb3fz6yt7FA5ap1Fh9Spttb/3rk5X/DaaLwJg5C/6Dt38u?=
 =?us-ascii?Q?nkIGJOOXWCFosBrfb2rnZWIROo7eX3yYpOHoGTo38boav6CqkWCxkUSB0ZZe?=
 =?us-ascii?Q?muQPKP5UmAAPphTnO0wJitGHaHSmBf38aIgYtSBEZ+25wbLSzY0IDtNfC5+m?=
 =?us-ascii?Q?Kj0IyK58ARIxYr4KFtt8lIZE6/SDgRPEYYF7876k+M+TWg53pKDWAbEgO/y/?=
 =?us-ascii?Q?yFwOvyilRNysUCK6rOQdE8xR5vZrCKFt8j1mxoHTTLeSqwViXVV0zCBUYzBx?=
 =?us-ascii?Q?Zs2f9rvTrEY+AQyygY6ajXXO+wc347xZ63nYz2kv9f0kS/mZpX573Jr46amf?=
 =?us-ascii?Q?DEooXPHfW/VnEHSMY9gMU3IYJkwFXXjfP1Dq+O0zWuge9QtA76MAhDwU9dKG?=
 =?us-ascii?Q?L/qYdr+N1WzgYyWD2Y9eSCWroSLKvyyfKHfF2Z5Sd6lLwTfCve2mVUMcYe/g?=
 =?us-ascii?Q?sT1pu462XAZi+Nyr1XvJRubcLfdoxM3aEWkgkSo8c7tR5KXCprXNat/fno9t?=
 =?us-ascii?Q?HiOEY1hPgaiQeYDXk2zsC3yz8VzaMAI+mKpv9PRfhXio54ax42AzQk/jmDgJ?=
 =?us-ascii?Q?0zQBPmxAW6h0BSnrcAyOIBkeT7+o0gEmNIeT15n3lnyKiw6I3REF85OVk9G3?=
 =?us-ascii?Q?hiV+FN+LLVARr18eOu2lnyXV361WXNJfp39L8E2Xm094PsNTo/POL7qOFqIt?=
 =?us-ascii?Q?YC/EdzE/wk2N/n6F+YOg+k6+aKo78LAXkIqQ7hx7CRuDdSDpKNPF9/7IAVk6?=
 =?us-ascii?Q?ONOjwEaaUqYinQslGbaVRMTECGSjAU2oKqFGVHEj6wzkXvHiebznWW448/PD?=
 =?us-ascii?Q?mlW+B+KMDvqzXFqH7P6/Set9nR6bagm5XjAWS2IRmAKCSvQxPmmuPFV6ZUys?=
 =?us-ascii?Q?06cZN/vDU/uryrDbzkU9eq3vZ5IY/ea+fjVLCukuHmrpf+tSVkot28CivDxv?=
 =?us-ascii?Q?TV92Ikn94BLcjSOje8mA4SA+Q96+/Oe54oVp0zFTAj/wzXUUQ+fhH80bed3N?=
 =?us-ascii?Q?qoEg0oTjX1Xkc5de3VHpWi+NHIkQqOYeQ/RiWZDYWeWE4b/3B7LmHYBsNUNf?=
 =?us-ascii?Q?LZuTglt9PqsEdjf6IOtxbhw6zTCAF9KwjJssF+u/4vOu765ZEJXoGcfQKViL?=
 =?us-ascii?Q?1e8D4+x/y3SdlRQ3lw8z+jUtzR82u4BWtJC2W8OgJwmAH0OnDioG357aPTN3?=
 =?us-ascii?Q?e07DuovO4zREaRDTJ1Rgd2hg3SNVhUSKryEDrY4afRo2TaV+J+NzdoW+B+Wu?=
 =?us-ascii?Q?iWvqBw9tBW7nCZaLNGnPWpKkAvHa5sNrG4JnjwSd1wi9npy0fnFKdfoaQbT5?=
 =?us-ascii?Q?5jR9KSLaG1csOcLCmMVYXg8hvUFKj69WFaKK2l0tBu6GkpfDsQCS1vA65+u8?=
 =?us-ascii?Q?YWZYY+heOfwA5trrkRNK3nDY44WoNW35yexNlWJJ4KtdEjiVx/HdL5B0j4OO?=
 =?us-ascii?Q?5IK6O4AoLL5gYR4l1IngYNDzql/2metWjMrWLzEaoYOQdYmoF3R2n/2ZM++t?=
 =?us-ascii?Q?TEQSwEhJQ8PyoyYRnaTCM0NhVJGFIPEyL8ydA+4QL6FOozVv/7SqCsxFA8lu?=
 =?us-ascii?Q?SouD3sbLq0mJKbBGG/IULUX5TcgS3ujGMFI4cYbwOLJPy4r9OCYI7tdyeiBh?=
 =?us-ascii?Q?sevjPCTy8Q=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c988abd-d344-43af-0605-08dec2bf166b
X-MS-Exchange-CrossTenant-AuthSource: DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 04:58:30.4866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cpOPwg9mFvr0OfJDxQ4G4zWyGvcs9nVbJ9dm626TRs6KXCg9oE2j1pNCwCx7q4vRVGoH8TX136t3VzCvPmHFiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P189MB0785
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Jun 2026 04:58:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19614

Signed-off-by: Anders Heimer <anders.heimer@est.tech>
---
 lib/bb/siggen.py         |  9 +++++++-
 lib/bb/tests/siggen.py   | 47 ++++++++++++++++++++++++++++++++++++++++
 lib/hashserv/__init__.py |  7 ++++++
 lib/hashserv/server.py   | 27 ++++++++++++++++++-----
 lib/hashserv/tests.py    | 30 +++++++++++++++++++++++++
 5 files changed, 114 insertions(+), 6 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 985fa7e4c..3a203676e 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -43,6 +43,10 @@ def check_siggen_version(siggen):
     if siggen.find_siginfo_version < siggen.find_siginfo_minversion:
         bb.fatal("Siggen from metadata (OE-Core?) is too old, please updat=
e it (%s vs %s)" % (siggen.find_siginfo_version, siggen.find_siginfo_minver=
sion))
=20
+def check_hashserv_unihash(unihash):
+    if not hashserv.is_valid_unihash(unihash):
+        bb.fatal("Hash Equivalence Server returned invalid unihash")
+
 class SetEncoder(json.JSONEncoder):
     def default(self, obj):
         if isinstance(obj, set) or isinstance(obj, frozenset):
@@ -729,6 +733,7 @@ class SignatureGeneratorUniHashMixIn(object):
=20
             if unihashes and unihashes[idx]:
                 unihash =3D unihashes[idx]
+                check_hashserv_unihash(unihash)
                 # A unique hash equal to the taskhash is not very interest=
ing,
                 # so it is reported it at debug level 2. If they differ, t=
hat
                 # is much more interesting, so it is reported at debug lev=
el 1
@@ -747,7 +752,7 @@ class SignatureGeneratorUniHashMixIn(object):
         import importlib
=20
         taskhash =3D d.getVar('BB_TASKHASH')
-        unihash =3D d.getVar('BB_UNIHASH')
+        unihash =3D d.getVar('BB_UNIHASH', expand=3DFalse)
         report_taskdata =3D d.getVar('SSTATE_HASHEQUIV_REPORT_TASKDATA') =
=3D=3D '1'
         tempdir =3D d.getVar('T')
         mcfn =3D d.getVar('BB_FILENAME')
@@ -809,6 +814,7 @@ class SignatureGeneratorUniHashMixIn(object):
                     data =3D client.report_unihash(taskhash, method, outha=
sh, unihash, extra_data)
=20
                 new_unihash =3D data['unihash']
+                check_hashserv_unihash(new_unihash)
=20
                 if new_unihash !=3D unihash:
                     hashequiv_logger.debug('Task %s unihash changed %s -> =
%s by server %s' % (taskhash, unihash, new_unihash, self.server))
@@ -848,6 +854,7 @@ class SignatureGeneratorUniHashMixIn(object):
                 return False
=20
             finalunihash =3D data['unihash']
+            check_hashserv_unihash(finalunihash)
=20
             if finalunihash =3D=3D current_unihash:
                 hashequiv_logger.verbose('Task %s unihash %s unchanged by =
server' % (tid, finalunihash))
diff --git a/lib/bb/tests/siggen.py b/lib/bb/tests/siggen.py
index 0dc67e6cc..eb07cc920 100644
--- a/lib/bb/tests/siggen.py
+++ b/lib/bb/tests/siggen.py
@@ -9,7 +9,9 @@
 import unittest
 import logging
 import bb
+import bb.data
 import time
+from contextlib import contextmanager
=20
 logger =3D logging.getLogger('BitBake.TestSiggen')
=20
@@ -26,3 +28,48 @@ class SiggenTest(unittest.TestCase):
         for t in tests:
             self.assertEqual(bb.siggen.build_pnid(*t), tests[t])
=20
+    def test_get_unihashes_rejects_invalid_hashserv_unihash(self):
+        class TestClient:
+            def get_unihash_batch(self, query):
+                list(query)
+                return ["${@os.system('true')}"]
+
+        class TestSiggen(bb.siggen.SignatureGeneratorUniHashMixIn):
+            def __init__(self):
+                self.server =3D "test-server"
+                self.method =3D "test-method"
+                self.extramethod =3D {}
+                self.taskhash =3D {"test.bb:do_compile": "a" * 64}
+                self.unihash =3D {}
+                self.unitaskhashes =3D {}
+                self.tidtopn =3D {}
+                self.setscenetasks =3D set()
+
+            @contextmanager
+            def client(self):
+                yield TestClient()
+
+        siggen =3D TestSiggen()
+
+        with self.assertRaises(bb.BBHandledException):
+            siggen.get_unihashes(["test.bb:do_compile"])
+
+        self.assertEqual(siggen.unihash, {})
+        self.assertEqual(siggen.unitaskhashes, {})
+
+    def test_report_unihash_reads_bb_unihash_without_expansion(self):
+        class TestSiggen(bb.siggen.SignatureGeneratorUniHashMixIn):
+            def __init__(self):
+                self.setscenetasks =3D set()
+                self.taskhash =3D {"test.bb:do_compile": "b" * 64}
+
+        d =3D bb.data.init()
+        d.setVar("BB_TASKHASH", "a" * 64)
+        d.setVar("BB_UNIHASH", "${@d.setVar('EXPANDED_UNIHASH', '1') or 'b=
ad'}")
+        d.setVar("SSTATE_HASHEQUIV_REPORT_TASKDATA", "0")
+        d.setVar("T", "/tmp")
+        d.setVar("BB_FILENAME", "test.bb")
+
+        TestSiggen().report_unihash(".", "compile", d)
+
+        self.assertIsNone(d.getVar("EXPANDED_UNIHASH"))
diff --git a/lib/hashserv/__init__.py b/lib/hashserv/__init__.py
index ac891e017..ba8e0acce 100644
--- a/lib/hashserv/__init__.py
+++ b/lib/hashserv/__init__.py
@@ -7,12 +7,19 @@ import asyncio
 from contextlib import closing
 import itertools
 import json
+import re
 from collections import namedtuple
 from urllib.parse import urlparse
 from bb.asyncrpc.client import parse_address, ADDR_TYPE_UNIX, ADDR_TYPE_WS
=20
 User =3D namedtuple("User", ("username", "permissions"))
=20
+UNIHASH_REGEX =3D re.compile(r"^[0-9a-f]{64}$")
+
+
+def is_valid_unihash(value):
+    return isinstance(value, str) and UNIHASH_REGEX.fullmatch(value) is no=
t None
+
=20
 def create_server(
     addr,
diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index 58f95c7bc..3ff434785 100644
--- a/lib/hashserv/server.py
+++ b/lib/hashserv/server.py
@@ -13,6 +13,7 @@ import base64
 import json
 import hashlib
 from . import create_async_client
+from . import is_valid_unihash
 import bb.asyncrpc
=20
 logger =3D logging.getLogger("hashserv.server")
@@ -173,6 +174,11 @@ def hash_token(algo, salt, token):
     return ":".join([algo, salt, h.hexdigest()])
=20
=20
+def validate_unihash(value):
+    if not is_valid_unihash(value):
+        raise bb.asyncrpc.InvokeError("Invalid unihash")
+
+
 def permissions(*permissions, allow_anon=3DTrue, allow_self_service=3DFals=
e):
     """
     Function decorator that can be used to decorate an RPC function call a=
nd
@@ -345,7 +351,7 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
                 d =3D {k: row[k] for k in row.keys()}
             elif self.upstream_client is not None:
                 d =3D await self.upstream_client.get_taskhash(method, task=
hash)
-                await self.db.insert_unihash(d["method"], d["taskhash"], d=
["unihash"])
+                await self.insert_unihash(d["method"], d["taskhash"], d["u=
nihash"])
=20
         return d
=20
@@ -377,9 +383,13 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
         if data is None:
             return
=20
-        await self.db.insert_unihash(data["method"], data["taskhash"], dat=
a["unihash"])
+        await self.insert_unihash(data["method"], data["taskhash"], data["=
unihash"])
         await self.db.insert_outhash(data)
=20
+    async def insert_unihash(self, method, taskhash, unihash):
+        validate_unihash(unihash)
+        return await self.db.insert_unihash(method, taskhash, unihash)
+
     async def _stream_handler(self, handler):
         await self.socket.send_message("ok")
=20
@@ -467,6 +477,8 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
     # report is made inside the function
     @permissions(READ_PERM)
     async def handle_report(self, data):
+        validate_unihash(data.get("unihash"))
+
         if self.server.read_only or not self.user_has_permissions(REPORT_P=
ERM):
             return await self.report_readonly(data)
=20
@@ -509,7 +521,7 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
                     if upstream_data is not None:
                         unihash =3D upstream_data["unihash"]
=20
-            await self.db.insert_unihash(data["method"], data["taskhash"],=
 unihash)
+            await self.insert_unihash(data["method"], data["taskhash"], un=
ihash)
=20
         unihash_data =3D await self.get_unihash(data["method"], data["task=
hash"])
         if unihash_data is not None:
@@ -525,7 +537,9 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
=20
     @permissions(READ_PERM, REPORT_PERM)
     async def handle_equivreport(self, data):
-        await self.db.insert_unihash(data["method"], data["taskhash"], dat=
a["unihash"])
+        validate_unihash(data.get("unihash"))
+
+        await self.insert_unihash(data["method"], data["taskhash"], data["=
unihash"])
=20
         # Fetch the unihash that will be reported for the taskhash. If the
         # unihash matches, it means this row was inserted (or the mapping
@@ -888,7 +902,10 @@ class Server(bb.asyncrpc.AsyncServer):
                 method, taskhash =3D item
                 d =3D await client.get_taskhash(method, taskhash)
                 if d is not None:
-                    await db.insert_unihash(d["method"], d["taskhash"], d[=
"unihash"])
+                    if is_valid_unihash(d.get("unihash")):
+                        await db.insert_unihash(d["method"], d["taskhash"]=
, d["unihash"])
+                    else:
+                        self.logger.warning("Upstream server returned inva=
lid unihash")
                 self.backfill_queue.task_done()
=20
     def start(self):
diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index 83ce0c5ca..c2ed1035a 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
@@ -292,6 +292,36 @@ class HashEquivalenceCommonTests(object):
         self.assertEqual(result_outhash['outhash'], outhash)
         self.assertEqual(result_outhash['outhash_siginfo'], siginfo)
=20
+    def test_report_rejects_invalid_unihash(self):
+        taskhash =3D '68a9206490b2321bb033fb3eab013a4ec62c41f9'
+        outhash =3D 'bf5f2efaf1ca351f3b4c3d079363540ab48f7c58db3d23cfbb069=
cf4ff1ea8f7'
+        invalid_unihashes =3D (
+            "${@os.system('true')}",
+            'a' * 63,
+            'a' * 65,
+            'A' * 64,
+            None,
+        )
+
+        for unihash in invalid_unihashes:
+            with self.subTest(unihash=3Dunihash):
+                with self.start_client(self.server_address) as client:
+                    with self.assertRaises(InvokeError) as context:
+                        client.report_unihash(taskhash, self.METHOD, outha=
sh, unihash)
+
+                self.assertEqual(str(context.exception), "Invalid unihash"=
)
+
+        self.assertClientGetHash(self.client, taskhash, None)
+
+    def test_equivreport_rejects_invalid_unihash(self):
+        taskhash =3D 'ae6339531895ddf5b67e663e6a374ad8ec71d81c'
+
+        with self.assertRaises(InvokeError) as context:
+            self.client.report_unihash_equiv(taskhash, self.METHOD, "${@os=
.system('true')}")
+
+        self.assertEqual(str(context.exception), "Invalid unihash")
+        self.assertClientGetHash(self.start_client(self.server_address), t=
askhash, None)
+
     def test_stress(self):
         def query_server(failures):
             client =3D Client(self.server_address)
--=20
2.34.1


