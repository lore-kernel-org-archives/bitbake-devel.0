Return-Path: <andre.rosa@lge.com>
X-Greylist: delayed 1801 seconds by postgrey-1.34 at layers.openembedded.org;
	Sat, 06 Apr 2019 00:42:25 UTC
Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
	by mail.openembedded.org (Postfix) with ESMTP id 789017D021
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  6 Apr 2019 00:42:25 +0000 (UTC)
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
	by 156.147.23.51 with ESMTP; 6 Apr 2019 09:12:24 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: andre.rosa@lge.com
Received: from unknown (HELO LGSVL-EXC01.lgsvl.net) (10.195.253.62)
	by 156.147.1.126 with ESMTP; 6 Apr 2019 09:12:24 +0900
X-Original-SENDERIP: 10.195.253.62
X-Original-MAILFROM: andre.rosa@lge.com
Received: from LGSVL-EXC01.lgsvl.net (10.195.253.62) by LGSVL-EXC01.lgsvl.net
	(10.195.253.62) with Microsoft SMTP Server (TLS) id 15.0.1044.25;
	Fri, 5 Apr 2019 17:12:23 -0700
Received: from LGSVL-EXC01.lgsvl.net ([10.195.253.62]) by
	LGSVL-EXC01.lgsvl.net ([10.195.253.62]) with mapi id 15.00.1044.021;
	Fri, 5 Apr 2019 17:12:23 -0700
From: andre.rosa <andre.rosa@lge.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [PATCH] Make prune_suffix prune a suffix
Thread-Index: AQHU7AplRBEUC0EzGkWYx+gAFVa1faYuQb9w
Date: Sat, 6 Apr 2019 00:12:23 +0000
Message-ID: <8e39484d440c465c840087dd65e1c163@LGSVL-EXC01.lgsvl.net>
References: <20190405235047.24415-1-andre.rosa@lge.com>
In-Reply-To: <20190405235047.24415-1-andre.rosa@lge.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.192.223.164]
MIME-Version: 1.0
X-Mailman-Approved-At: Sun, 07 Apr 2019 22:34:51 +0000
Subject: [PATCH] Make prune_suffix prune a suffix
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
X-List-Received-Date: Sat, 06 Apr 2019 00:42:26 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

From: Andre Rosa <andre.rosa@lge.com>

... instead of replacing a substring that could happen more than once and n=
ot only when it ends with it.

Signed-off-by: Andre Rosa <andre.rosa@lge.com>

diff --git a/lib/bb/utils.py b/lib/bb/utils.py index b652a683..d186b1fa 100=
644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -722,8 +722,8 @@ def prune_suffix(var, suffixes, d):
     # See if var ends with any of the suffixes listed and
     # remove it if found
     for suffix in suffixes:
-        if var.endswith(suffix):
-            return var.replace(suffix, "")
+        if suffix and var.endswith(suffix):
+            return var[:-len(suffix)]
     return var
=20
 def mkdirhier(directory):
--
2.20.1


