Return-Path: <henning.schroeder@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 9CEB76AC4B
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Feb 2016 15:07:29 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga103.jf.intel.com with ESMTP; 08 Feb 2016 07:07:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,416,1449561600"; d="scan'208";a="910873234"
Received: from irsmsx152.ger.corp.intel.com ([163.33.192.66])
	by fmsmga002.fm.intel.com with ESMTP; 08 Feb 2016 07:07:16 -0800
Received: from irsmsx111.ger.corp.intel.com (10.108.20.4) by
	IRSMSX152.ger.corp.intel.com (163.33.192.66) with Microsoft SMTP Server
	(TLS) id 14.3.248.2; Mon, 8 Feb 2016 15:07:15 +0000
Received: from irsmsx109.ger.corp.intel.com ([169.254.13.100]) by
	irsmsx111.ger.corp.intel.com ([169.254.2.198]) with mapi id
	14.03.0248.002; Mon, 8 Feb 2016 15:07:15 +0000
From: "Schroeder, Henning" <henning.schroeder@intel.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [PATCH] cooker: extended dot styling
Thread-Index: AdFigbWGC/PyR2kKSgS7GHkIr5REUQ==
Date: Mon, 8 Feb 2016 15:07:14 +0000
Message-ID: <093B67FB09E7C1439E8DF68949D5ACF32A51C926@IRSMSX109.ger.corp.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [163.33.239.182]
MIME-Version: 1.0
Cc: "Kanevskiy, Alexander" <alexander.kanevskiy@intel.com>
Subject: [PATCH] cooker: extended dot styling
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
X-List-Received-Date: Mon, 08 Feb 2016 15:07:29 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Extended the dot styling of dependencies created by bitbake -g in dot synta=
x to differentiate between the various kinds.
  depends: solid
  rdepends: dashed
  rrecommends: dotted
 =

The change observed is that depends get an explicit style which is the same=
 as dot default behavior and the runtime recommends get
dotted while before they were dashed. This helps to distinguish them graphi=
cally as well as eases post processing by script.
 =

Signed-off-by: Henning Schroeder <henning.schroeder@intel.com>
---
 lib/bb/cooker.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
 =

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index df730f6..bc02207 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -908,7 +908,7 @@ class BBCooker:
         logger.info("PN build list saved to 'pn-buildlist'")
         for pn in depgraph["depends"]:
             for depend in depgraph["depends"][pn]:
-                print('"%s" -> "%s"' % (pn, depend), file=3Ddepends_file)
+                print('"%s" -> "%s" [style=3Dsolid]' % (pn, depend), file=
=3Ddepends_file)
         for pn in depgraph["rdepends-pn"]:
             for rdepend in depgraph["rdepends-pn"][pn]:
                 print('"%s" -> "%s" [style=3Ddashed]' % (pn, rdepend), fil=
e=3Ddepends_file)
@@ -926,13 +926,13 @@ class BBCooker:
             else:
                 print('"%s" [label=3D"%s(%s) %s\\n%s"]' % (package, packag=
e, pn, version, fn), file=3Ddepends_file)
             for depend in depgraph["depends"][pn]:
-                print('"%s" -> "%s"' % (package, depend), file=3Ddepends_f=
ile)
+                print('"%s" -> "%s" [style=3Dsolid]' % (package, depend), =
file=3Ddepends_file)
         for package in depgraph["rdepends-pkg"]:
             for rdepend in depgraph["rdepends-pkg"][package]:
                 print('"%s" -> "%s" [style=3Ddashed]' % (package, rdepend)=
, file=3Ddepends_file)
         for package in depgraph["rrecs-pkg"]:
             for rdepend in depgraph["rrecs-pkg"][package]:
-                print('"%s" -> "%s" [style=3Ddashed]' % (package, rdepend)=
, file=3Ddepends_file)
+                print('"%s" -> "%s" [style=3Ddotted]' % (package, rdepend)=
, file=3Ddepends_file)
         print("}", file=3Ddepends_file)
         logger.info("Package dependencies saved to 'package-depends.dot'")
 =

-- =

2.1.0
Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid, Christian Lamprechter
Chairperson of the Supervisory Board: Nicole Lau
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928


