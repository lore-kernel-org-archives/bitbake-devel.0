Return-Path: <david.reyna@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 0DF3F7FA0A
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Nov 2019 00:43:15 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id xAR0hBfL024579
	(version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL);
	Tue, 26 Nov 2019 16:43:11 -0800 (PST)
Received: from ALA-MBD.corp.ad.wrs.com ([169.254.3.163]) by
	ALA-HCA.corp.ad.wrs.com ([147.11.189.40]) with mapi id 14.03.0468.000;
	Tue, 26 Nov 2019 16:43:11 -0800
From: "Reyna, David" <david.reyna@windriver.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	"richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"akuster (akuster@mvista.com)" <akuster@mvista.com>
Thread-Topic: [bitbake-devel][ZEUS][MASTER] [PATCH 2/2] toaster: improve
	warnings when adding	dependency to packages
Thread-Index: AdWku2hZ1Ey/HMIvRyOxi0Wzd9dv0w==
Date: Wed, 27 Nov 2019 00:43:10 +0000
Message-ID: <5E53D14CE4667A45B9A06760DE5D13D0FAE91779@ALA-MBD.corp.ad.wrs.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [147.11.117.105]
MIME-Version: 1.0
Subject: [ZEUS][MASTER] [PATCH 2/2] toaster: improve warnings when adding	dependency to packages
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
X-List-Received-Date: Wed, 27 Nov 2019 00:43:16 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Richard,

As we discussed at ELCE, I am putting this back on the top of your list. Th=
is was the missed patch for Zeus.

I am hoping that it gets merged to 3.0.1 and to master.

Thanks,
David


-----Original Message-----
From: Reyna, David=20
Sent: Tuesday, October 15, 2019 8:09 AM
To: bitbake-devel@lists.openembedded.org; richard.purdie@linuxfoundation.or=
g
Cc: Reyna, David
Subject: RE: [bitbake-devel] [PATCH 2/2] toaster: improve warnings when add=
ing dependency to packages

Hi Richard,

This is the second of two patches that I sent. The first one got merged but=
 this one did not.

- David

-----Original Message-----
From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-devel-bo=
unces@lists.openembedded.org] On Behalf Of David Reyna
Sent: Tuesday, October 01, 2019 4:18 PM
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake-devel] [PATCH 2/2] toaster: improve warnings when adding =
dependency to packages

From: David Reyna <David.Reyna@windriver.com>

Some of the objects that bitbake reports to Toaster as dependencies to pack=
ages
are known objects that are not packages, for example library files and kern=
el
modules. In the Toaster logs, mark these as "Info" instead of "Warning".

[YOCTO #13386]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/bb/ui/buildinfohelper.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index f2151c2..5cbca97 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -646,6 +646,9 @@ class ORMWrapper(object):
                 Target_Installed_Package.objects.create(target =3D target_=
obj, package =3D packagedict[p]['object'])
=20
         packagedeps_objs =3D []
+        pattern_so =3D re.compile(r'.*\.so(\.\d*)?$')
+        pattern_lib =3D re.compile(r'.*\-suffix(\d*)?$')
+        pattern_ko =3D re.compile(r'^kernel-module-.*')
         for p in packagedict:
             for (px,deptype) in packagedict[p]['depends']:
                 if deptype =3D=3D 'depends':
@@ -654,6 +657,13 @@ class ORMWrapper(object):
                     tdeptype =3D Package_Dependency.TYPE_TRECOMMENDS
=20
                 try:
+                    # Skip known non-package objects like libraries and ke=
rnel modules
+                    if pattern_so.match(px) or pattern_lib.match(px):
+                        logger.info("Toaster does not add library file dep=
endencies to packages (%s,%s)", p, px)
+                        continue
+                    if pattern_ko.match(px):
+                        logger.info("Toaster does not add kernel module de=
pendencies to packages (%s,%s)", p, px)
+                        continue
                     packagedeps_objs.append(Package_Dependency(
                         package =3D packagedict[p]['object'],
                         depends_on =3D packagedict[px]['object'],
--=20
1.9.1

--=20
_______________________________________________
bitbake-devel mailing list
bitbake-devel@lists.openembedded.org
http://lists.openembedded.org/mailman/listinfo/bitbake-devel

