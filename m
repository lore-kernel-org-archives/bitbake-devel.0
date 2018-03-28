Return-Path: <ola.x.nilsson@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id EA4F47841B
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Mar 2018 09:41:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id D8BDC183B8
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Mar 2018 11:41:54 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id Zw0No1SU4xAY for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Mar 2018 11:41:53 +0200 (CEST)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
	by bastet.se.axis.com (Postfix) with ESMTPS id 9C968182C5
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Mar 2018 11:41:53 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E4241A06D
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Mar 2018 11:41:53 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 634B71A065
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Mar 2018 11:41:53 +0200 (CEST)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
	by boulder02.se.axis.com (Postfix) with ESMTP
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Mar 2018 11:41:53 +0200 (CEST)
Received: from XBOX03.axis.com (xbox03.axis.com [10.0.5.17])
	by thoth.se.axis.com (Postfix) with ESMTP id 576C03093
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Mar 2018 11:41:53 +0200 (CEST)
Received: from XBOX04.axis.com (10.0.5.18) by XBOX03.axis.com (10.0.5.17) with
	Microsoft SMTP Server (TLS) id 15.0.1263.5;
	Wed, 28 Mar 2018 11:41:53 +0200
Received: from XBOX04.axis.com ([fe80::6c88:230d:cafd:2f2a]) by
	XBOX04.axis.com ([fe80::6c88:230d:cafd:2f2a%22]) with mapi id
	15.00.1263.000; Wed, 28 Mar 2018 11:41:53 +0200
From: Ola x Nilsson <ola.x.nilsson@axis.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PULL] *** Fix build issue with html5lib in
	bitbake	1.26/1.28 ***
Thread-Index: AQHTxhDcEfzwTi6RzEaPg6tcet7AP6PlZZmI
Date: Wed, 28 Mar 2018 09:41:52 +0000
Message-ID: <1522230112838.18244@axis.com>
References: <cover.1522085586.git.soemoe.a@gmail.com>
In-Reply-To: <cover.1522085586.git.soemoe.a@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.60]
MIME-Version: 1.0
X-TM-AS-GCONF: 00
Subject: Re: [PULL] *** Fix build issue with html5lib in bitbake	1.26/1.28 ***
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
X-List-Received-Date: Wed, 28 Mar 2018 09:41:57 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

This has already been fixed on a few branches with =0A=
=0A=
bitbake: lib/bs4: Fix imports from html5lib >=3D 0.9999999/1.0b8=0A=
=0A=
It might be better to backport that where needed.=0A=
=0A=
-- =0A=
Ola Nilsson=0A=
________________________________________=0A=
From: bitbake-devel-bounces@lists.openembedded.org <bitbake-devel-bounces@l=
ists.openembedded.org> on behalf of Soemoe Aung <soemoe.a@gmail.com>=0A=
Sent: Tuesday, March 27, 2018 23:15=0A=
To: bitbake-devel@lists.openembedded.org=0A=
Subject: [bitbake-devel] [PULL] *** Fix build issue with html5lib in bitbak=
e    1.26/1.28 ***=0A=
=0A=
When I was running yocto-poky on the fido and jethro branches, I was gettin=
g build errors caused by the included html5lib in bitbake. It seems like a =
class is being called incorrectly there. I noticed the issue is resolved in=
 the krogoth branch and the html5lib is indeed different there.=0A=
=0A=
yocto-poky fido includes bitbake version 1.26 and jethro includes bitbake v=
ersion 1.28. Looking at the bitbake source repo for these versions confirms=
 that these files are the same. yocto-poky krogoth, which has the issue fix=
ed, uses bitbake 1.30, which also has the issue fixed in the bitbake repo.=
=0A=
=0A=
I originally created this patch in the yocto-poky contrib repo and was dire=
cted to send it to bitbake instead. Can someone here take a look at this an=
d accept the changes into the 1.26 and 1.28 branches? Can you also send the=
se changes upstream to the yocto-poky fido and jethro branches?=0A=
=0A=
Let me know if you need any changes here, like creating this patch from the=
 bitbake repo directly instead of indirectly through yocto-poky.=0A=
=0A=
The following changes since commit ea6d21066a7cce2fef08ad66287170c5995bb1e2=
:=0A=
=0A=
  bitbake: bitbake-user-manual: Fixed porno hack for hello world example (2=
018-01-17 22:32:46 +0000)=0A=
=0A=
are available in the Git repository at:=0A=
=0A=
  git://push.yoctoproject.org/poky-contrib saung/bitbake-html5lib=0A=
=0A=
Soemoe Aung (2):=0A=
  fix build error in included html5lib in bitbake=0A=
  fix html5lib fix to be the same as in the krogoth branch=0A=
=0A=
 bitbake/lib/bs4/builder/_html5lib.py | 17 ++++++++++++-----=0A=
 1 file changed, 12 insertions(+), 5 deletions(-)=0A=
=0A=
--=0A=
2.17.0.rc0.231.g781580f067-goog=0A=
=0A=
--=0A=
_______________________________________________=0A=
bitbake-devel mailing list=0A=
bitbake-devel@lists.openembedded.org=0A=
http://lists.openembedded.org/mailman/listinfo/bitbake-devel=0A=

