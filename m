Return-Path: <andre.rosa@lge.com>
Received: from lgeamrelo11.lge.com (lgeamrelo13.lge.com [156.147.23.53])
	by mail.openembedded.org (Postfix) with ESMTP id 4B27B7D987
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 11 Apr 2019 20:20:55 +0000 (UTC)
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
	by 156.147.23.53 with ESMTP; 12 Apr 2019 05:20:56 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: andre.rosa@lge.com
Received: from unknown (HELO LGSVL-EXC02.lgsvl.net) (10.195.253.63)
	by 156.147.1.125 with ESMTP; 12 Apr 2019 05:20:55 +0900
X-Original-SENDERIP: 10.195.253.63
X-Original-MAILFROM: andre.rosa@lge.com
Received: from LGSVL-EXC01.lgsvl.net (10.195.253.62) by LGSVL-EXC02.lgsvl.net
	(10.195.253.63) with Microsoft SMTP Server (TLS) id 15.0.1044.25;
	Thu, 11 Apr 2019 13:20:55 -0700
Received: from LGSVL-EXC01.lgsvl.net ([10.195.253.62]) by
	LGSVL-EXC01.lgsvl.net ([10.195.253.62]) with mapi id 15.00.1044.021;
	Thu, 11 Apr 2019 13:20:54 -0700
From: andre.rosa <andre.rosa@lge.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [PATCH] utils: Let makedirhier fail if existing path is not a
	folder
Thread-Index: AQHU8KO9GWEqZA1QDUO7h+zYKr14HKY3ZnhA
Date: Thu, 11 Apr 2019 20:20:54 +0000
Message-ID: <6dd4cb3fb5a9479a864ee7e850f6c873@LGSVL-EXC01.lgsvl.net>
References: <20190411201831.13084-1-andre.rosa@lge.com>
In-Reply-To: <20190411201831.13084-1-andre.rosa@lge.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.192.223.156]
MIME-Version: 1.0
Subject: [PATCH] utils: Let makedirhier fail if existing path is not a folder
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
X-List-Received-Date: Thu, 11 Apr 2019 20:20:56 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

From: Andre Rosa <andre.rosa@lge.com>

... instead of assuming a directory hierarchy is there or was created.

Signed-off-by: Andre Rosa <andre.rosa@lge.com>
---
 lib/bb/utils.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py index d186b1fa..a3f75fbe 100=
644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -734,7 +734,7 @@ def mkdirhier(directory):
     try:
         os.makedirs(directory)
     except OSError as e:
-        if e.errno !=3D errno.EEXIST:
+        if e.errno !=3D errno.EEXIST or not os.path.isdir(directory):
             raise e
=20
 def movefile(src, dest, newmtime =3D None, sstat =3D None):
--
2.20.1.519.g8feddda32c


