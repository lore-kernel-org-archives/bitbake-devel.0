Return-Path: <andre.rosa@lge.com>
Received: from lgeamrelo11.lge.com (lgeamrelo13.lge.com [156.147.23.53])
	by mail.openembedded.org (Postfix) with ESMTP id 961967D297
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  6 Apr 2019 01:29:38 +0000 (UTC)
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
	by 156.147.23.53 with ESMTP; 6 Apr 2019 10:29:38 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: andre.rosa@lge.com
Received: from unknown (HELO LGSVL-EXC02.lgsvl.net) (10.195.253.63)
	by 156.147.1.121 with ESMTP; 6 Apr 2019 10:29:38 +0900
X-Original-SENDERIP: 10.195.253.63
X-Original-MAILFROM: andre.rosa@lge.com
Received: from LGSVL-EXC01.lgsvl.net (10.195.253.62) by LGSVL-EXC02.lgsvl.net
	(10.195.253.63) with Microsoft SMTP Server (TLS) id 15.0.1044.25;
	Fri, 5 Apr 2019 18:29:37 -0700
Received: from LGSVL-EXC01.lgsvl.net ([10.195.253.62]) by
	LGSVL-EXC01.lgsvl.net ([10.195.253.62]) with mapi id 15.00.1044.021;
	Fri, 5 Apr 2019 18:29:37 -0700
From: andre.rosa <andre.rosa@lge.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [PATCH] Make prune_suffix prune a suffix
Thread-Index: AQHU7AplRBEUC0EzGkWYx+gAFVa1faYuQb9wgAAWgwA=
Date: Sat, 6 Apr 2019 01:29:37 +0000
Message-ID: <c11872a34a3749e6a787d1b1e4db78dc@LGSVL-EXC01.lgsvl.net>
References: <20190405235047.24415-1-andre.rosa@lge.com> 
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.192.223.164]
MIME-Version: 1.0
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
X-List-Received-Date: Sat, 06 Apr 2019 01:29:39 -0000
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


