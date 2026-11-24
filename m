Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15973.1795520674052403758
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 24 Nov 2026 03:44:36 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@prevas.dk header.s=selector1 header.b=KD4awclY;
 spf=pass (domain: prevas.dk, ip: 52.101.65.4, mailfrom: rasmus.villemoes@prevas.dk)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TqLaMBxu1clq9YftZ3ofAZS6tz85LCvJFi+erd2niiqxRYFkz4IkBwj78RUu2kvqlnkeY4A67IiGaBg/Ra7KsIxws11/8Bh4Bmdj6Gz+j6zNQtYPp32tNmq7yJiVV9XHVJfC+QkRpxs5NrhjVQQ97M+5LPOR/Q4lAAPGDRkHc/QGdWEHwrjwh5B4pPmvX91d22mAl58qbVT27WOB+cFhJ9N7aU7guY9lUmyllvyRxGJxC8YdL0gl3WDL/Pl2I1funFqeuI/SqYGyqbmq4XkS8wPrvUfEQyGIGJylD5FZj9U5r0yW3l8B+oKOeUPGW6ztRTz8vH69mGxjnFFgFtT7cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Z4tb4/ojbvkfzs5uwlYiQg16Seo0JNjqz3YgDUlgP0=;
 b=saA5pKqpXDPUp8raYEzN2JMw+E8A0NIhZwfMhwn6IEbBLa7B/rN2WgIXYWowWfwdeHzzNmQr9nS+APTCN1xRzgZ/3YwYQN6g5lPvE3NOVNIV7KYTUj0GF+taZvw3Kckpw8sBfAystfP9/5SPBzkg9j4D3e3Gygbe3EkWpLgzOby3E/tTYXMnQDl9s905CTD4xKuOUsh5lGo26zuOKm662d9BtbfdlZzVl19BWrrFw0W9plVpAmRaAUxSm+se9bn4mcQ2OJDh5XGXyadCXFgRlHT3oXWmU0E6u6WdNf6yGMyFUfCXLi6iadDNyzpe6BAWsWhku6wNUbLRiEzzyA2ihA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Z4tb4/ojbvkfzs5uwlYiQg16Seo0JNjqz3YgDUlgP0=;
 b=KD4awclYBA+5GFhnUHxDyEIn7+AsaNoRFuuJVGBvTlLKdu8yhEuwoFrT5qcwbg5x+qgN8JJi9kOR7zFOAPxBWbWRI23rW9oc7B8JE1jC+j0CmIw1/9B2mLAv+z4bF/Yea7FPPFsZ01I5DeYjZ39Dalnq6Zhaw1EiGTS4VWcjFpw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DU0PR10MB6387.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:40c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Tue, 24 Nov
 2026 11:44:28 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.21.0662.001; Tue, 24 Nov 2026
 11:44:28 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: bitbake-devel@lists.openembedded.org
CC: Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH] lib/bb: remove redundant subprocess_setup()
Date: Tue, 24 Nov 2026 12:44:21 +0100
Message-ID: <20261124114421.2802597-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.56.1
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CPBP307CA0015.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380:2::9)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
Return-Path: rasmus.villemoes@prevas.dk
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DU0PR10MB6387:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ea55ce0-1cc1-473a-5bbd-08df4a204bf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|261102123227099003|261026130827099003|261026140227099003|261026135527099003|261022115727099003|261022105027099003|261022075727099003|261022113327099003|261026121527099003|261028144727099003|11063799006|56012099006|10067099003|6133799003|18002099003|261021121427099003|261021123027099003|261021130227099003|261021135927099003|261021133027099003|3023799007;
X-Microsoft-Antispam-Message-Info: 8y9j6ueDxwiD1MIFPJE/AZ9temXqD0Ze3Tyin1d10P33RI50GOeSvWLKtb2ECOjydeVenG0Tlc28bpPKEp2FFG0Py7uGOMLBIky3hxzYCkV8qn9c+ZVt1m3rQdsYoaewCcidGLNGtyQqyRFedIBSD7ZyFlR71lu95rpmMTUAYDqSU5elAjPdvU6yKaqKGiCI/3+1yI5PEwawrTFmLghCXImUJeKaHvNw4PeVj/Y/UnP55ypDaWbIxdj9pXN9RMLrAG/lMCBRvQ+U3063Dzua9/oQawUmXmW/V0oHiL3d6JS3PnDXwwxcgS2vY8g3H9SptdXWXZlTZWeb4mVMgUDfAhh3bhCYZYsZ+brE93RUm7SpDQo89dFJMQzlb08ylvCWfdL8r3FRuN8DXCaKIGcsRzu/q3+9hVsq8BQ/ou6gKgnE3cZPzU8Ko/Pnh42AwYgblx085nSYp7VKenqk1W+X7hM7egbRS//+P3O5/HgrVUlBUbJBKo5O0jr9r6baQ+HcBWEcQhv2zICGfZVTh8OcoZwcb85J73OMn0cJl1Ssu0mXwN71HgRMQc7KevNOzh9HYcpZhj6ETPKw39qVBZg50Lc8hbRCp79GvUUv60V6VoPmYkGjF8GCmBEWIrURHJtzgCLMlbmGUy+bX6Rzbtg+PkzniF0QIg5ROO50Buosf/8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(261102123227099003)(261026130827099003)(261026140227099003)(261026135527099003)(261022115727099003)(261022105027099003)(261022075727099003)(261022113327099003)(261026121527099003)(261028144727099003)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(261021121427099003)(261021123027099003)(261021130227099003)(261021135927099003)(261021133027099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?64WDif4dIygYQ0d4TQA0JDLygyEDMuQoPuOolU7u2209xXE126jO8yDNr6jY?=
 =?us-ascii?Q?02hLlEnu1CXY1tHHltJox8KoZzsf1wqlIEaivvKLT9TWhAbziVfP3bhEFpIC?=
 =?us-ascii?Q?oTuMEsjz2fzfJOy1fMFGJCfKk4zAJIVa62TxlzwDHek/12t5e2eVj46yHWTo?=
 =?us-ascii?Q?xauFoZ3ciir/tgjQPsYJ+K8yuoR9lDP4Qlr3/1a1y7698bPXCuaNl/pMDJrJ?=
 =?us-ascii?Q?VC39qikAlcC5W21NCoNOvjMQUdh7gFLvHeFub9uOpLgCU90oKn17TXOJRSuo?=
 =?us-ascii?Q?6OxXV0ItkU8jYEhthLaLJspjhwnQWB4Gr9H7yN/uHjmGEY9zlM4x+FooRqXg?=
 =?us-ascii?Q?qaTw015KSWBA17VpF48RImBCZ5DWeGw778r5HK0bc30AeyGKs/ifUEHtyvIb?=
 =?us-ascii?Q?2pqjvR79ApTbyxujr3DwsP2tGEcwhw7jays8xrbdW+TOqozdyKJFjycViU0f?=
 =?us-ascii?Q?/RoYLImNrABZuFeHMMD855lx/NlQgISgbVVDiwjn6QV8hLdF0zc8j3VxDfMR?=
 =?us-ascii?Q?gsa+e7yQ7rTPpFAL7Dxy1z2c2kaDwzZ5I1YbtAMReymbLCPNcWnfNVoLJH4b?=
 =?us-ascii?Q?RNEBRmdCOP/LW8NHzeUPl5RXmJuCRyI+5bhKCikKzOiofrjVT60dh73k0jpa?=
 =?us-ascii?Q?Fj4UV9z+PzrJFOViMchyZvzWny4Qe6BqcFaDnyBrXYrA3aFuDk5aT5HOYwBP?=
 =?us-ascii?Q?i/Bh91fz2j5Z8e8R6J9hIlHTnLPLi42tNA5yT63bEp55q2zqiZPTBdyhrXVU?=
 =?us-ascii?Q?yC2h+7u9/w8VEeMYoKoldq1UuJ8CiSy4Fj/SeKMXfodOEasmpJ2ooPdDeHcj?=
 =?us-ascii?Q?vXgZqaWoQ/EiRWIpO6TBBI9tlmqkya6dyLvcT1616N/Vx8+lDSjX3fOAhK2T?=
 =?us-ascii?Q?I8Zdo6Wn9a0xDAiBdQLOgCA2DT1bTqg67m3MNJRogttlH2qAMJiF8nYuwp45?=
 =?us-ascii?Q?GgJgZxv4hzSbTOe65hOSumqF7SJ995dgXHElGTfYhqY6SE0eHIHZELmR1kBE?=
 =?us-ascii?Q?nTkJ5UnkaKFhoEz+fRustLTVPueglmQINfU9aR3xFeOX+JJqdBcq49Y5DlQa?=
 =?us-ascii?Q?fZ3IY3VnIuN9pEi8n5yFfR7uFnJ2tyCxb3iAVpYxYhAemUeVwcyHZTeNpvYg?=
 =?us-ascii?Q?F+3x1IiGvK/OoQr2iyorx926nvPTT8dTR+dTGXcjG0NiHx3Ze7ypu803J9ya?=
 =?us-ascii?Q?3pHG6o+FA+44vY2fz5RR2brY+5cdn/BInazfdVreC3xpbZAyjptcxHvRg7cB?=
 =?us-ascii?Q?jL7QPRWLAVzk/C4dGGC6a9JKxOrjPDZotq6IRTgywrEwtn6D9BpKc2LLKH+3?=
 =?us-ascii?Q?W7jvl+EhM2vvm28ZSDxMqudt5fMG9/a8UX3Z7PY9FPCGwJsxPhXD9+alfcZK?=
 =?us-ascii?Q?iD/0cjz9tAVNdZIZEcB4FMJF8BLrjW5Ag949RydMP5hHdqLFjM8k6u6POZ0j?=
 =?us-ascii?Q?dJWlAfVcWZhS7uRvw4KAVTGT+ed8wcz8/mu3lXAnzx7Wbkan86YZphIxwPvT?=
 =?us-ascii?Q?Yg+Z0bK40kK/Gn6Qvu0slQVqqx4L+Kt7IT601wwTSb54TpnSJVIrzN0pqmdX?=
 =?us-ascii?Q?mBEdaVXlCm3Hh6QS0jIRH/tPxUDn1tjoK+jJUfGVfBF6cD4brM4z6F+BBOVE?=
 =?us-ascii?Q?0n1ismeQsIn+9kojDoqhHQaXy4uUAvdMXVsWhfdy2ooYDvZRYVWmP7IU7zLH?=
 =?us-ascii?Q?IrVRSku5kHIwHiJq1m9XY5jMKNKuIMsHadmFJafd9HqV20kgT1o+PdB58Knj?=
 =?us-ascii?Q?xvd77oViP6OcSN2Lud8HVAFc0R2rAoE=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea55ce0-1cc1-473a-5bbd-08df4a204bf9
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 11:44:28.5449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RVC7GXt+QquVduyG281TQoIIpo8yfiGhjxOc+WQ/v4E1OcWWbpLL//5Hjm0i7q+q3iofdXguB1W5lMOlly6/lQTfXvixB+UGIidlQOoD00w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6387
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Tue, 24 Nov 2026 11:44:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20475
Content-Type: text/plain; charset="utf-8"

Since Python 3.2, the subprocess.Popen() constructor has had a
"restore_signals" parameter defaulting to True:

  If restore_signals is True (the default) all signals that Python has
  set to SIG_IGN are restored to SIG_DFL in the child process before
  the exec. Currently this includes the SIGPIPE, SIGXFZ and SIGXFSZ
  signals.

So ever since bitbake's minimal supported Python version was bumped to
3.4 in 710351610 ("lib/bb: Set required python 3 version to 3.4.0"),
this subprocess_setup has been redundant.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 lib/bb/fetch/__init__.py | 13 +++----------
 lib/bb/fetch/crate.py    |  2 +-
 lib/bb/fetch/gomod.py    |  7 ++-----
 lib/bb/process.py        |  7 -------
 4 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/lib/bb/fetch/__init__.py b/lib/bb/fetch/__init__.py
index 41ce55921..612336170 100644
--- a/lib/bb/fetch/__init__.py
+++ b/lib/bb/fetch/__init__.py
@@ -13,7 +13,6 @@ BitBake build tools.
 # Based on functions from the base bb module, Copyright 2003 Holger Schuri=
g
=20
 import os, re
-import signal
 import logging
 import urllib.request, urllib.parse, urllib.error
 if 'git' not in urllib.parse.uses_netloc:
@@ -780,12 +779,6 @@ def update_stamp(ud, d):
             bb.utils.remove(ud.donestamp)
             raise
=20
-def subprocess_setup():
-    # Python installs a SIGPIPE handler by default. This is usually not wh=
at
-    # non-Python subprocesses expect.
-    # SIGPIPE errors are known issues with gzip/bash
-    signal.signal(signal.SIGPIPE, signal.SIG_DFL)
-
 def mark_recipe_nocache(d):
     if d.getVar('BB_SRCREV_POLICY') !=3D "cache":
         d.setVar('BB_DONT_CACHE', '1')
@@ -1553,9 +1546,9 @@ class FetchMethod(object):
=20
         def _run(cmd):
             if isinstance(cmd, str):
-                ret =3D subprocess.call(cmd, preexec_fn=3Dsubprocess_setup=
, shell=3DTrue, cwd=3Dunpackdir, env=3Denv)
+                ret =3D subprocess.call(cmd, shell=3DTrue, cwd=3Dunpackdir=
, env=3Denv)
             else:
-                ret =3D subprocess.call(cmd, preexec_fn=3Dsubprocess_setup=
, cwd=3Dunpackdir, env=3Denv)
+                ret =3D subprocess.call(cmd, cwd=3Dunpackdir, env=3Denv)
             if ret !=3D 0:
                 raise UnpackError("Unpack command %s failed with return va=
lue %s" % (cmd, ret), urldata.url)
=20
@@ -1618,7 +1611,7 @@ class FetchMethod(object):
                 else:
                     cmd =3D 'rpm2cpio.sh %s | cpio --no-absolute-filenames=
 -id' % (file)
             elif file.endswith('.deb') or file.endswith('.ipk'):
-                output =3D subprocess.check_output(['ar', '-t', file], pre=
exec_fn=3Dsubprocess_setup, env=3Denv)
+                output =3D subprocess.check_output(['ar', '-t', file], env=
=3Denv)
                 datafile =3D None
                 valid_datafiles =3D ('data.tar', 'data.tar.gz', 'data.tar.=
xz',
                                    'data.tar.zst', 'data.tar.bz2', 'data.t=
ar.lzma')
diff --git a/lib/bb/fetch/crate.py b/lib/bb/fetch/crate.py
index bf38fa45b..f340f62cb 100644
--- a/lib/bb/fetch/crate.py
+++ b/lib/bb/fetch/crate.py
@@ -26,7 +26,7 @@ import subprocess
 import re
 from functools import cmp_to_key
 import bb
-from   bb.fetch import logger, subprocess_setup, UnpackError, runfetchcmd
+from   bb.fetch import logger, UnpackError, runfetchcmd
 from   bb.fetch.wget import Wget
=20
=20
diff --git a/lib/bb/fetch/gomod.py b/lib/bb/fetch/gomod.py
index 1950429d8..024e8eb7b 100644
--- a/lib/bb/fetch/gomod.py
+++ b/lib/bb/fetch/gomod.py
@@ -70,7 +70,6 @@ import bb
 from bb.fetch import FetchError
 from bb.fetch import MissingParameterError
 from bb.fetch import runfetchcmd
-from bb.fetch import subprocess_setup
 from bb.fetch.git import Git
 from bb.fetch.wget import Wget
=20
@@ -267,8 +266,7 @@ class GoModGit(Git):
                 f =3D os.path.join(ud.parm['subpath'], f)
             if f in files:
                 cmd =3D ['git', 'cat-file', 'blob', srcrev + ':' + f]
-                subprocess.check_call(cmd, stdout=3Dmf, cwd=3Drepodir,
-                                      preexec_fn=3Dsubprocess_setup)
+                subprocess.check_call(cmd, stdout=3Dmf, cwd=3Drepodir)
             else:
                 # If the module does not have a go.mod file, synthesize on=
e
                 # containing only a module statement.
@@ -281,6 +279,5 @@ class GoModGit(Git):
             prefix =3D module + '@' + version + '/'
             for f in files:
                 cmd =3D ['git', 'cat-file', 'blob', srcrev + ':' + f]
-                data =3D subprocess.check_output(cmd, cwd=3Drepodir,
-                                               preexec_fn=3Dsubprocess_set=
up)
+                data =3D subprocess.check_output(cmd, cwd=3Drepodir)
                 zf.writestr(prefix + f, data)
diff --git a/lib/bb/process.py b/lib/bb/process.py
index 4c7b6d39d..9189a7a7e 100644
--- a/lib/bb/process.py
+++ b/lib/bb/process.py
@@ -5,7 +5,6 @@
 #
=20
 import logging
-import signal
 import subprocess
 import errno
 import select
@@ -13,11 +12,6 @@ import bb
=20
 logger =3D logging.getLogger('BitBake.Process')
=20
-def subprocess_setup():
-    # Python installs a SIGPIPE handler by default. This is usually not wh=
at
-    # non-Python subprocesses expect.
-    signal.signal(signal.SIGPIPE, signal.SIG_DFL)
-
 class CmdError(RuntimeError):
     def __init__(self, command, msg=3DNone):
         self.command =3D command
@@ -60,7 +54,6 @@ class ExecutionError(CmdError):
 class Popen(subprocess.Popen):
     defaults =3D {
         "close_fds": True,
-        "preexec_fn": subprocess_setup,
         "stdout": subprocess.PIPE,
         "stderr": subprocess.PIPE,
         "stdin": subprocess.PIPE,
--=20
2.56.1

