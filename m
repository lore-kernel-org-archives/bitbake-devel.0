Return-Path: <Awais_Belal@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
	by mail.openembedded.org (Postfix) with ESMTP id D961E79EFF
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  8 Nov 2018 06:24:11 +0000 (UTC)
Received: from nat-ies.mentorg.com ([192.94.31.2]
	helo=SVR-IES-MBX-03.mgc.mentorg.com)
	by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
	id 1gKdjg-0004x7-By from Awais_Belal@mentor.com ;
	Wed, 07 Nov 2018 22:24:12 -0800
Received: from SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3) by
	SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3) with Microsoft SMTP
	Server (TLS) id 15.0.1320.4; Thu, 8 Nov 2018 06:24:08 +0000
Received: from SVR-IES-MBX-03.mgc.mentorg.com ([fe80::1072:fb6e:87f1:ed17]) by
	SVR-IES-MBX-03.mgc.mentorg.com ([fe80::1072:fb6e:87f1:ed17%22]) with
	mapi id 15.00.1320.000; Thu, 8 Nov 2018 06:24:08 +0000
From: "Belal, Awais" <Awais_Belal@mentor.com>
To: "Reyna, David" <david.reyna@windriver.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH v2] bitbake: toaster: allow OE_ROOT to be
	provided through environment
Thread-Index: AQHUciuOYb9/3As5NkqgW4dv8trIl6U7r5qAgAnDREA=
Date: Thu, 8 Nov 2018 06:24:08 +0000
Message-ID: <1541658246944.14342@mentor.com>
References: <1541108415-15634-1-git-send-email-awais_belal@mentor.com>,
	<5E53D14CE4667A45B9A06760DE5D13D0F3B29466@ALA-MBD.corp.ad.wrs.com>
In-Reply-To: <5E53D14CE4667A45B9A06760DE5D13D0F3B29466@ALA-MBD.corp.ad.wrs.com>
Accept-Language: en-US, en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [137.202.0.90]
MIME-Version: 1.0
Subject: Re: [PATCH v2] bitbake: toaster: allow OE_ROOT to be	provided through environment
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
X-List-Received-Date: Thu, 08 Nov 2018 06:24:14 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Ping! Can we get this into sumo?=0A=
=0A=
BR,=0A=
Awais=0A=
=0A=
________________________________________=0A=
From: Reyna, David <david.reyna@windriver.com>=0A=
Sent: Friday, November 2, 2018 6:18 AM=0A=
To: Belal, Awais; bitbake-devel@lists.openembedded.org=0A=
Subject: RE: [bitbake-devel] [PATCH v2] bitbake: toaster: allow OE_ROOT to =
be   provided through environment=0A=
=0A=
Looks good to me!=0A=
=0A=
- David=0A=
=0A=
-----Original Message-----=0A=
From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-devel-bo=
unces@lists.openembedded.org] On Behalf Of Awais Belal=0A=
Sent: Thursday, November 01, 2018 2:40 PM=0A=
To: bitbake-devel@lists.openembedded.org=0A=
Subject: [bitbake-devel] [PATCH v2] bitbake: toaster: allow OE_ROOT to be p=
rovided through environment=0A=
=0A=
Updates for YOCTO #12891 allowed a user to have a directory=0A=
structure different to that of yocto (bitbake isn't inside=0A=
oe-core) whereas the definition of OE_ROOT in the main toaster=0A=
binary still assumes the same while checking for .templateconf=0A=
and hence we see an error on the cmdline in such cases:=0A=
bash: <repo-path>/bitbake/bin/../../.templateconf: No such file or director=
y=0A=
The change here now allows the user to provide OE_ROOT through=0A=
the environment in such cases and otherwise defaults to the older=0A=
mechanism to fix this issue.=0A=
=0A=
Signed-off-by: Awais Belal <awais_belal@mentor.com>=0A=
---=0A=
 bin/toaster | 4 +++-=0A=
 1 file changed, 3 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/bin/toaster b/bin/toaster=0A=
index 9fffbc6..ecf66fa 100755=0A=
--- a/bin/toaster=0A=
+++ b/bin/toaster=0A=
@@ -161,7 +161,9 @@ fi=0A=
=0A=
 export BBBASEDIR=3D`dirname $TOASTER`/..=0A=
 MANAGE=3D"python3 $BBBASEDIR/lib/toaster/manage.py"=0A=
-OE_ROOT=3D`dirname $TOASTER`/../..=0A=
+if [ -z "$OE_ROOT" ]; then=0A=
+    OE_ROOT=3D`dirname $TOASTER`/../..=0A=
+fi=0A=
=0A=
 # this is the configuraton file we are using for toaster=0A=
 # we are using the same logic that oe-setup-builddir uses=0A=
--=0A=
2.7.4=0A=
=0A=
--=0A=
_______________________________________________=0A=
bitbake-devel mailing list=0A=
bitbake-devel@lists.openembedded.org=0A=
http://lists.openembedded.org/mailman/listinfo/bitbake-devel=0A=

