Return-Path: <daniel.gomez@silicon-gears.com>
X-Greylist: delayed 501 seconds by postgrey-1.34 at layers.openembedded.org;
	Wed, 28 Feb 2018 18:48:56 UTC
Received: from relay4.cloudcontrol.es (relay4.cloudcontrol.es [93.90.30.99])
	by mail.openembedded.org (Postfix) with ESMTP id 2C829788DA
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Feb 2018 18:48:56 +0000 (UTC)
Received: from relay.cloudcontrol.es (unknown [93.90.30.95])
	by relay4.cloudcontrol.es (Postfix) with ESMTP id 08655D7E5C
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Feb 2018 19:40:33 +0100 (CET)
Received: from Twenty.silicon-gears.com
	(96.red-81-47-169.staticip.rima-tde.net [81.47.169.96])
	by relay.cloudcontrol.es (Postfix) with ESMTP id 05284D72A3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Feb 2018 19:40:31 +0100 (CET)
Received: from Twenty.silicon-gears.com (10.20.0.101) by
	Twenty.silicon-gears.com (10.20.0.101) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
	15.1.1034.26; Wed, 28 Feb 2018 19:40:31 +0100
Received: from Twenty.silicon-gears.com ([fe80::997d:ba46:67c2:3dd1]) by
	Twenty.silicon-gears.com ([fe80::997d:ba46:67c2:3dd1%17]) with mapi id
	15.01.1034.026; Wed, 28 Feb 2018 19:40:31 +0100
From: =?iso-8859-1?Q?Daniel_G=F3mez_Cruces?= <daniel.gomez@silicon-gears.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: devtool workspace creation problem
Thread-Index: AQHTsMELJIbA+K+kbECeqWZ1NRmQhg==
Date: Wed, 28 Feb 2018 18:40:31 +0000
Message-ID: <b9a59fcf839f436a9ec20c45321c576a@silicon-gears.com>
Accept-Language: en-US, es-ES
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.200.199.3]
MIME-Version: 1.0
X-ProcessControl-SpamMailControl-Information: Por favor,
	contacte con el administrador
X-ProcessControl-SpamMailControl-ID: 05284D72A3.A36EA
X-ProcessControl-SpamMailControl: Not scanned: please contact your Internet
	E-Mail Service Provider for details
X-ProcessControl-SpamMailControl-From: daniel.gomez@silicon-gears.com
X-Spam-Status: No
Subject: devtool workspace creation problem
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 28 Feb 2018 18:48:56 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I'm working with yocto (krogoth) and I'm having some problems with devtool =
while I'm doing my custom kernel recipe based on linux-yocto.inc

The problem is that .config file is not found when devtool command is creat=
ing the workspace for the custom kernel recipe and it is not able to find t=
he .config because it has already moved it from TMP directory to the worksp=
ace directory.

So, I created a simple patch that only checks if .config still exists but w=
hat I would like to know is if I have something missing in my kernel recipe=
 that is provoking this problem or it is a problem of the script.

Thanks,
Daniel


From ce66d072ee26678f774630a0a8f6f4e69794177f Mon Sep 17 00:00:00 2001
From: Daniel Gomez <daniel.gomez@silicon-gears.com>
Date: Wed, 28 Feb 2018 19:35:05 +0100
Subject: [PATCH] From ce66d072ee26678f774630a0a8f6f4e69794177f Mon Sep 17 0=
0:00:00 2001
From: Daniel Gomez <daniel.gomez@silicon-gears.com>
Date: Wed, 28 Feb 2018 19:35:05 +0100
Subject: [PATCH] Check kconfig when devtool is generating workspace

Signed-off-by: Daniel Gomez <daniel.gomez@silicon-gears.com>
---
 scripts/lib/devtool/standard.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/lib/devtool/standard.py b/scripts/lib/devtool/standard=
.py
index 77a82d5..7e41bd2 100644
--- a/scripts/lib/devtool/standard.py
+++ b/scripts/lib/devtool/standard.py
@@ -634,7 +634,9 @@ def _extract_source(srctree, keep_temp, devbranch, sync=
, d):
=20
         if kconfig:
             logger.info('Copying kernel config to srctree')
-            shutil.copy2(kconfig, srctree)
+            if os.path.exists(kconfig):
+                logger.info('Kernel config file does not exist anymore')
+                shutil.copy2(kconfig, srctree)
=20
     finally:
         bb.logger.setLevel(origlevel)
--=20
2.7.4



Signed-off-by: Daniel Gomez <daniel.gomez@silicon-gears.com>
---
 scripts/lib/devtool/standard.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/lib/devtool/standard.py b/scripts/lib/devtool/standard=
.py
index 77a82d5..7e41bd2 100644
--- a/scripts/lib/devtool/standard.py
+++ b/scripts/lib/devtool/standard.py
@@ -634,7 +634,9 @@ def _extract_source(srctree, keep_temp, devbranch, sync=
, d):
=20
         if kconfig:
             logger.info('Copying kernel config to srctree')
-            shutil.copy2(kconfig, srctree)
+            if os.path.exists(kconfig):
+                logger.info('Kernel config file does not exist anymore')
+                shutil.copy2(kconfig, srctree)
=20
     finally:
         bb.logger.setLevel(origlevel)
--=20
2.7.4









=A0=A0=A0 =

