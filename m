Return-Path: <david.reyna@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 7487079ECD
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  1 Nov 2018 18:07:59 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id wA1I796Z007394
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 1 Nov 2018 11:07:39 -0700
Received: from ALA-MBD.corp.ad.wrs.com ([169.254.3.145]) by
	ALA-HCA.corp.ad.wrs.com ([147.11.189.40]) with mapi id 14.03.0415.000;
	Thu, 1 Nov 2018 11:07:30 -0700
From: "Reyna, David" <david.reyna@windriver.com>
To: Awais Belal <awais_belal@mentor.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH] bitbake: toaster: allow OE_ROOT to be
	provided through environment
Thread-Index: AQHUceeyYiSjwDYch0C4Dx0t3ga85KU7NhpQ
Date: Thu, 1 Nov 2018 18:07:30 +0000
Message-ID: <5E53D14CE4667A45B9A06760DE5D13D0F3B29051@ALA-MBD.corp.ad.wrs.com>
References: <1541079270-28297-1-git-send-email-awais_belal@mentor.com>
In-Reply-To: <1541079270-28297-1-git-send-email-awais_belal@mentor.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [128.224.18.162]
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
X-List-Received-Date: Thu, 01 Nov 2018 18:08:00 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Awais,

I agree to the idea. My only concern is that you are using a bashism to exp=
and the variable, and that will fail on systems that for example are based =
on "dash". Since the "toaster" script is sourced, it cannot override the sh=
ell executor to "bash".

While not as compact, I would prefer a shell-safe expansion such as:

vvvv

if [ -z "$OE_ROOT" ] ; then
    OE_ROOT=3D`dirname $TOASTER`/../..
endif

^^^^

- David

-----Original Message-----
From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-devel-bo=
unces@lists.openembedded.org] On Behalf Of Awais Belal
Sent: Thursday, November 01, 2018 6:35 AM
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake-devel] [PATCH] bitbake: toaster: allow OE_ROOT to be prov=
ided through environment

Updates for YOCTO #12891 allowed a user to have a directory
structure different to that of yocto (bitbake isn't inside
oe-core) whereas the definition of OE_ROOT in the main toaster
binary still assumes the same while checking for .templateconf
and hence we see an error on the cmdline in such cases:
bash: <repo-path>/bitbake/bin/../../.templateconf: No such file or director=
y
The change here now allows the user to provide OE_ROOT through
the environment in such cases and otherwise defaults to the older
mechanism to fix this issue.

Signed-off-by: Awais Belal <awais_belal@mentor.com>
---
 bin/toaster | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/toaster b/bin/toaster
index 9fffbc6..4e227cc 100755
--- a/bin/toaster
+++ b/bin/toaster
@@ -161,7 +161,7 @@ fi
=20
 export BBBASEDIR=3D`dirname $TOASTER`/..
 MANAGE=3D"python3 $BBBASEDIR/lib/toaster/manage.py"
-OE_ROOT=3D`dirname $TOASTER`/../..
+OE_ROOT=3D${OE_ROOT:-`dirname $TOASTER`/../..}
=20
 # this is the configuraton file we are using for toaster
 # we are using the same logic that oe-setup-builddir uses
--=20
2.7.4

--=20
_______________________________________________
bitbake-devel mailing list
bitbake-devel@lists.openembedded.org
http://lists.openembedded.org/mailman/listinfo/bitbake-devel

