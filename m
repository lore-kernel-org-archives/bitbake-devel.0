Return-Path: <Awais_Belal@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
	by mail.openembedded.org (Postfix) with ESMTP id 0C1A879DF1
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  1 Nov 2018 13:36:45 +0000 (UTC)
Received: from nat-ies.mentorg.com ([192.94.31.2]
	helo=svr-ies-mbx-02.mgc.mentorg.com)
	by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
	id 1gID9T-00047u-9p from Awais_Belal@mentor.com 
	for bitbake-devel@lists.openembedded.org;
	Thu, 01 Nov 2018 06:36:47 -0700
Received: from SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3) by
	svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2) with Microsoft SMTP
	Server (TLS) id 15.0.1320.4; Thu, 1 Nov 2018 13:36:43 +0000
Received: from SVR-IES-MBX-03.mgc.mentorg.com ([fe80::1072:fb6e:87f1:ed17]) by
	SVR-IES-MBX-03.mgc.mentorg.com ([fe80::1072:fb6e:87f1:ed17%22]) with
	mapi id 15.00.1320.000; Thu, 1 Nov 2018 13:36:43 +0000
From: "Belal, Awais" <Awais_Belal@mentor.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH] bitbake: toaster: allow OE_ROOT to be
	provided through environment
Thread-Index: AQHUceexcv3Yg+cb5EWlgh3HI4mAuaU66+9+
Date: Thu, 1 Nov 2018 13:36:43 +0000
Message-ID: <1541079403214.48441@mentor.com>
References: <1541079270-28297-1-git-send-email-awais_belal@mentor.com>
In-Reply-To: <1541079270-28297-1-git-send-email-awais_belal@mentor.com>
Accept-Language: en-US, en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [137.202.0.90]
MIME-Version: 1.0
Subject: Re: [PATCH] bitbake: toaster: allow OE_ROOT to be	provided through environment
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
X-List-Received-Date: Thu, 01 Nov 2018 13:36:46 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

This should be applied to master as well as sumo.=0A=
=0A=
BR,=0A=
Awais=0A=
=0A=
________________________________________=0A=
From: bitbake-devel-bounces@lists.openembedded.org <bitbake-devel-bounces@l=
ists.openembedded.org> on behalf of Belal, Awais=0A=
Sent: Thursday, November 1, 2018 6:34 PM=0A=
To: bitbake-devel@lists.openembedded.org=0A=
Subject: [bitbake-devel] [PATCH] bitbake: toaster: allow OE_ROOT to be  pro=
vided through environment=0A=
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
 bin/toaster | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/bin/toaster b/bin/toaster=0A=
index 9fffbc6..4e227cc 100755=0A=
--- a/bin/toaster=0A=
+++ b/bin/toaster=0A=
@@ -161,7 +161,7 @@ fi=0A=
=0A=
 export BBBASEDIR=3D`dirname $TOASTER`/..=0A=
 MANAGE=3D"python3 $BBBASEDIR/lib/toaster/manage.py"=0A=
-OE_ROOT=3D`dirname $TOASTER`/../..=0A=
+OE_ROOT=3D${OE_ROOT:-`dirname $TOASTER`/../..}=0A=
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

