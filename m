Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1Rad14-0002OZ-Nl
	for bitbake-devel@lists.openembedded.org;
	Wed, 14 Dec 2011 01:48:14 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 13 Dec 2011 16:41:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="101901632"
Received: from pgsmsx603.gar.corp.intel.com ([10.221.43.87])
	by fmsmga002.fm.intel.com with ESMTP; 13 Dec 2011 16:41:16 -0800
Received: from pgsmsx101.gar.corp.intel.com (10.221.44.78) by
	pgsmsx603.gar.corp.intel.com (10.221.43.87) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Wed, 14 Dec 2011 08:41:15 +0800
Received: from shsmsx602.ccr.corp.intel.com (10.239.4.104) by
	PGSMSX101.gar.corp.intel.com (10.221.44.78) with Microsoft SMTP Server
	(TLS) id 14.1.355.2; Wed, 14 Dec 2011 08:41:15 +0800
Received: from shsmsx501.ccr.corp.intel.com ([10.239.4.141]) by
	SHSMSX602.ccr.corp.intel.com ([10.239.4.104]) with mapi;
	Wed, 14 Dec 2011 08:41:14 +0800
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: Joshua Lock <josh@linux.intel.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Date: Wed, 14 Dec 2011 08:41:14 +0800
Thread-Topic: [bitbake-devel] [PATCH 05/10] command.py: add
	parseConfigurationFiles API
Thread-Index: Acy5ta9vQQ0uxnJOTi2YdWiJbepuEQAQszwQ
Message-ID: <D5AB6E638E5A3E4B8F4406B113A5A19A12DBFD6E25@shsmsx501.ccr.corp.intel.com>
References: <cover.1323656120.git.dongxiao.xu@intel.com>
	<5e6bb33f07469e4ee3925104c8ee4e3036a3cee4.1323656120.git.dongxiao.xu@intel.com>
	<4EE77F8A.5030900@linux.intel.com>
In-Reply-To: <4EE77F8A.5030900@linux.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
MIME-Version: 1.0
Subject: Re: [PATCH 05/10] command.py: add parseConfigurationFiles API
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 14 Dec 2011 00:48:15 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Josh,

> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org
> [mailto:bitbake-devel-bounces@lists.openembedded.org] On Behalf Of Joshua
> Lock
> Sent: Wednesday, December 14, 2011 12:39 AM
> To: bitbake-devel@lists.openembedded.org
> Subject: Re: [bitbake-devel] [PATCH 05/10] command.py: add
> parseConfigurationFiles API
>=20
> On 11/12/11 18:20, Dongxiao Xu wrote:
> > The parseConfigurationFiles API calls the related function in
> > cooker.py to parse config files.
> >
> > Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
> > ---
> >  lib/bb/command.py |   10 ++++++++++
> >  1 files changed, 10 insertions(+), 0 deletions(-)
> >
> > diff --git a/lib/bb/command.py b/lib/bb/command.py index
> > 701b286..6b4a598 100644
> > --- a/lib/bb/command.py
> > +++ b/lib/bb/command.py
> > @@ -326,3 +326,13 @@ class CommandsAsync:
> >          else:
> >              command.finishAsyncCommand()
> >      compareRevisions.needcache =3D True
> > +
> > +    def parseConfigurationFiles(self, command, params):
> > +        """
> > +        Parse the configuration files
> > +        """
> > +        prefiles =3D params[0]
> > +        postfiles =3D params[1]
>=20
> Should we be able to use this method without having prefiles and postfile=
s set
> in the params container?
>=20
> A common pattern throughout this module is to check the size of the param=
s
> container [using len(params)] and set appropriate (empty) defaults if all
> required parameters aren't passed.

When calling parseConfigurationFiles(), we must pass the prefiles and postf=
iles as parameters, although they may be empty strings, for example,

self.server.runCommand(["parseConfigurationFiles", "", ""])

Therefore it is ensured that this API accepts two variables and it is not n=
eeded to check the length of parameters.

There are many functions in command.py doing the similar thing, like buildF=
ile, generateDepTreeEvent, etc.

Thanks,
Dongxiao

>=20
> Cheers,
> Joshua
> --
> Joshua Lock
>         Yocto Project "Johannes factotum"
>         Intel Open Source Technology Centre
>=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel


