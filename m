Return-Path: <dlazzari@leapfrog.com>
Received: from mx3.leapfrog.com (mx3.leapfrog.com [63.114.26.253])
	by mail.openembedded.org (Postfix) with ESMTP id 5D64D65E76
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 14 Apr 2014 17:39:23 +0000 (UTC)
Received: from NAEMCASHT01.na.leapfrog.com (unknown [10.12.2.37])
	by mx3.leapfrog.com (Postfix) with ESMTP
	id 7553B60BF; Mon, 14 Apr 2014 10:39:24 -0700 (PDT)
Received: from NAEMMAIL01.na.leapfrog.com ([fe80::252e:28a6:3d8f:6991]) by
	NAEMCASHT01.na.leapfrog.com ([::1]) with mapi id 14.01.0379.000;
	Mon, 14 Apr 2014 10:39:24 -0700
From: Daniel Lazzari <dlazzari@leapfrog.com>
To: Anders Darander <anders@chargestorm.se>,
	"g@ad.chargestorm.se" <g@ad.chargestorm.se>
Thread-Topic: [bitbake-devel] Can't clone password protected git repo
Thread-Index: Ac9XbME12beOE+QOTei4dti+GE93VwAgbocAAAY9QWA=
Date: Mon, 14 Apr 2014 17:39:24 +0000
Message-ID: <E7A9054A5ACABE48B0E540E46E862B0F0139F4A3D2@NAEMMAIL01.na.leapfrog.com>
References: <E7A9054A5ACABE48B0E540E46E862B0F0139F49EB2@NAEMMAIL01.na.leapfrog.com>
	<20140414073318.GA20694@ad.chargestorm.se>
In-Reply-To: <20140414073318.GA20694@ad.chargestorm.se>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.206.206]
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: Can't clone password protected git repo
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
X-List-Received-Date: Mon, 14 Apr 2014 17:39:27 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thanks Anders! This definitely gets me past the issue I was having and I ag=
ree, much nicer than leaving my login credentials in a recipe, so I'm going=
 to go ahead with the ssh solution.

That said, I did some digging late last night and found the cause of the is=
sue in bitbake. It appears that the fetcher does parse the password out of =
the url, but then doesn't include the password when calling git ls-remote o=
r git clone. I tried out a patch I made against our version of bitbake and =
it seems to have resolved the issue so that bitbake behaves as expected. I =
will probably have time to submit a patch against master later today, but I=
 have some questions.

1) Since placing your password in the recipe bleeds the password out into t=
he log files, should bitbake log a warning to the user?

2) Since I'm not using the latest bitbake and I don't have time to set up a=
 machine to use it, would anyone be able to test my patch against master?

Thanks again for the help!
Daniel

> -----Original Message-----
> From: Anders Darander [mailto:anders@chargestorm.se]
> Sent: Monday, April 14, 2014 12:33 AM
> To: Daniel Lazzari; g@ad.chargestorm.se
> Cc: bitbake-devel@lists.openembedded.org
> Subject: Re: [bitbake-devel] Can't clone password protected git repo
>=20
> Hi,
>=20
> * Daniel Lazzari <dlazzari@leapfrog.com> [140414 01:19]:
> > There's a project we are trying to pull from a private BitBucket repo.
> > I tried setting the SRC_URI to something like:
> > SRC_URI =3D "git://user:pass@bitbucket.org/path/project;protocol=3Dhttp=
s"
>=20
> > but bitbake hangs waiting for the password. Am I missing something?
> > I'm stuck on the ancient bitbake 1.15.2 in case this has been fixed in =
a later
> release.
>=20
> Maybe not the answer you're looking for. When I'm using private repos, I =
use
> ssh keys for authentication, which works without any issues with bitbake.
>=20
> If you need a buildserver to access the private repos, I'd guess that usi=
ng ssh-
> agent together with keys with an empty passphrase will be just as secure =
as
> adding the password to the SRC_URI.
>=20
> Cheers,
> Anders
>=20
> --
> Anders Darander
> ChargeStorm AB / eStorm AB

