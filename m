Return-Path: <david.reyna@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 6A5447826E
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 31 Aug 2017 02:12:39 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id v7V2CeNP011794
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 30 Aug 2017 19:12:41 -0700 (PDT)
Received: from ALA-MBC.corp.ad.wrs.com ([169.254.1.180]) by
	ALA-HCB.corp.ad.wrs.com ([147.11.189.41]) with mapi id 14.03.0361.001;
	Wed, 30 Aug 2017 19:12:40 -0700
From: "Reyna, David" <david.reyna@windriver.com>
To: Olaf Mandel <o.mandel@menlosystems.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH] toaster: make debug output more readable
Thread-Index: AQHTIYwsm50zfNVQFk2C/DK6w4516aKdtbzA
Date: Thu, 31 Aug 2017 02:12:39 +0000
Message-ID: <5E53D14CE4667A45B9A06760DE5D13D0CF78219E@ALA-MBC.corp.ad.wrs.com>
References: <20170830122438.30191-1-o.mandel@menlosystems.com>
In-Reply-To: <20170830122438.30191-1-o.mandel@menlosystems.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [128.224.21.153]
MIME-Version: 1.0
Subject: Re: [PATCH] toaster: make debug output more readable
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
X-List-Received-Date: Thu, 31 Aug 2017 02:12:40 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Olaf,

I have looked at both of your patches, and I think that they are both usefu=
l and consistent with Toaster, thank you!

They do not however have a Bugzilla reference, and they are missing the nor=
mal patch header. I propose that I go ahead and (a) create those Bugzilla e=
ntries for you and (b) submit them together with other pending Toaster fixe=
s using the standard bitbake-dev patch submission, together with my additio=
nal sign-off.

Created:
	Bug 12014 - debug message during build lists layers missing separators
	Bug 12015 - set default pokydirname if no external layers

Thanks!
David
Toaster maintainer


-----Original Message-----
From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-devel-bo=
unces@lists.openembedded.org] On Behalf Of Olaf Mandel
Sent: Wednesday, August 30, 2017 5:25 AM
To: bitbake-devel@lists.openembedded.org
Cc: Olaf Mandel
Subject: [bitbake-devel] [PATCH] toaster: make debug output more readable

One of the debug-messages during build contains a list of all layers,
but without spaces or other separators between them. Use pformat
instead.

Signed-off-by: Olaf Mandel <o.mandel@menlosystems.com>
---
 lib/toaster/bldcontrol/localhostbecontroller.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/=
bldcontrol/localhostbecontroller.py
index 358cce4d..12071029 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -221,7 +221,7 @@ class LocalhostBEController(BuildEnvironmentController)=
:
                 continue  # not a custom recipe, skip
=20
         layerlist.extend(nongitlayerlist)
-        logger.debug("\n\nset layers gives this list \n %s" % ''.join(laye=
rlist))
+        logger.debug("\n\nset layers gives this list %s" % pformat(layerli=
st))
         self.islayerset =3D True
         return layerlist
=20
--=20
2.11.0

--=20
_______________________________________________
bitbake-devel mailing list
bitbake-devel@lists.openembedded.org
http://lists.openembedded.org/mailman/listinfo/bitbake-devel

