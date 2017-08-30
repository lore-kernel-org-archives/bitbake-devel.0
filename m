Return-Path: <david.reyna@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id E490871A18
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Aug 2017 14:51:40 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id v7UEpe8g006827
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 30 Aug 2017 07:51:41 -0700 (PDT)
Received: from ALA-MBC.corp.ad.wrs.com ([169.254.1.180]) by
	ALA-HCA.corp.ad.wrs.com ([147.11.189.40]) with mapi id 14.03.0361.001;
	Wed, 30 Aug 2017 07:51:40 -0700
From: "Reyna, David" <david.reyna@windriver.com>
To: Olaf Mandel <o.mandel@menlosystems.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] Question on toaster bringup
Thread-Index: AQHTIY0wOlcznRtPUUe3+OEyuS10WqKc+q5g
Date: Wed, 30 Aug 2017 14:51:39 +0000
Message-ID: <5E53D14CE4667A45B9A06760DE5D13D0CF7815B7@ALA-MBC.corp.ad.wrs.com>
References: <adcc19b8-8834-cfe9-cb26-9a463ce42f43@menlosystems.com>
In-Reply-To: <adcc19b8-8834-cfe9-cb26-9a463ce42f43@menlosystems.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [147.11.118.250]
MIME-Version: 1.0
Subject: Re: Question on toaster bringup
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
X-List-Received-Date: Wed, 30 Aug 2017 14:51:41 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Olaf,

Thank you for using Toaster! There is a Toaster team and we have a meeting =
each week, for which I am the lead and the Toaster maintainer. I will forwa=
rd you the link (it is in about 10 minutes :-)

1) See 11957 for a resolution for your question. The fixtures are strictly =
additive, so 11957 provides the way to disable the default fixtures.

2) Yes, create and enhancement request and we can address that. It is too l=
ate for enhancements for YP-2.4 but we can look at that for 2.5.

3) Ideally you would provide your own Layer Index server so that you can ge=
t the full power of the interface. We can certainly look at alternatives fo=
r your reduced use case.

- David Reyna

-----Original Message-----
From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-devel-bo=
unces@lists.openembedded.org] On Behalf Of Olaf Mandel
Sent: Wednesday, August 30, 2017 5:39 AM
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake-devel] Question on toaster bringup

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hello,

I want to initialize toaster from fixtures alone, if possible. It should
only provide a "local" release (no network dependency at all). Here I
ran into two to three problems:

* the oe-core.xml fixture adds three releases. Is it possible to
remove/delete objects in the custom.xml fixture that I do not want?
Currently I am working around that by just configuring out the line
call_command("loaddata", "oe-core") in checksettings.py.

* the custom.xml fixture needs to reside in the
bitbake/lib/toaster/orm/fixtures directory to be found. How can I search
at other places? Setting an environment variable FIXTURE_DIRS didn't
seem to help.

* minor point: would it make sense to detect if
call_command("lsupdates") is needed? One does not need that for a purely
local release and I have it commented out.

Thank you for your time,
Olaf
- --=20
Olaf Mandel

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJZprHhAAoJEFS9nbRiUh3/YeEIAIWvZIb0gECYO+mTrcZu+7w7
Zmtg2ZcYM2BWwthzJl4aA48vVjwYOpY74oQnByorEJh6yjSob/GqAFgPKbNGVF+a
zH1BCkzao7oAdYtY5naYfYyaD5iDvStl/pfxCoxujh7wC9k7o11gBXO2HIp4U/Ww
8kiNlDpjI2dOciuanYB9hluOtwJ+pBJsuFhktTRKn3f7hSkPq1Q/C+L8dJEBc9sl
JyQ5yNdEhXhrvCPT1wyJtxnHiAXIK/nQrXb0uEFzLv1ENxgCiGVxY6GsHm7KSXf/
I53I+m5kWiBozgo5bXPfj6W0se/v7EsU30kOCilUCAf6bl65LS2EyqVndTJCHZ4=3D
=3DGW/i
-----END PGP SIGNATURE-----
--=20
_______________________________________________
bitbake-devel mailing list
bitbake-devel@lists.openembedded.org
http://lists.openembedded.org/mailman/listinfo/bitbake-devel

