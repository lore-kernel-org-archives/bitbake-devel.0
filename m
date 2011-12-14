Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1RadNN-0003ue-V2
	for bitbake-devel@lists.openembedded.org;
	Wed, 14 Dec 2011 02:11:18 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 13 Dec 2011 17:04:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="85426645"
Received: from pgsmsx601.gar.corp.intel.com ([10.221.43.69])
	by azsmga001.ch.intel.com with ESMTP; 13 Dec 2011 17:04:19 -0800
Received: from pgsmsx104.gar.corp.intel.com (10.221.44.91) by
	pgsmsx601.gar.corp.intel.com (10.221.43.69) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Wed, 14 Dec 2011 09:03:58 +0800
Received: from shsmsx602.ccr.corp.intel.com (10.239.4.104) by
	PGSMSX104.gar.corp.intel.com (10.221.44.91) with Microsoft SMTP Server
	(TLS) id 14.1.355.2; Wed, 14 Dec 2011 09:03:58 +0800
Received: from shsmsx501.ccr.corp.intel.com ([10.239.4.141]) by
	SHSMSX602.ccr.corp.intel.com ([10.239.4.104]) with mapi;
	Wed, 14 Dec 2011 09:03:56 +0800
From: "Xu, Dongxiao" <dongxiao.xu@intel.com>
To: Joshua Lock <josh@linux.intel.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, "Richard Purdie
	(richard.purdie@linuxfoundation.org)" <richard.purdie@linuxfoundation.org>
Date: Wed, 14 Dec 2011 09:03:56 +0800
Thread-Topic: [bitbake-devel] [PATCH 03/10] cooker: user
	bb.configuration.data to inject events
Thread-Index: Acy5tPPBMyPO1mA5TkeBFgG1Ow66MQARSOEA
Message-ID: <D5AB6E638E5A3E4B8F4406B113A5A19A12DBFD6E5E@shsmsx501.ccr.corp.intel.com>
References: <cover.1323656120.git.dongxiao.xu@intel.com>
	<c964cfa4b7bcde985223d41f7bd00937544bc791.1323656120.git.dongxiao.xu@intel.com>
	<4EE77DEF.8040906@linux.intel.com>
In-Reply-To: <4EE77DEF.8040906@linux.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
MIME-Version: 1.0
Subject: Re: [PATCH 03/10] cooker: user bb.configuration.data to inject events
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
X-List-Received-Date: Wed, 14 Dec 2011 01:11:18 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable



> -----Original Message-----
> From: bitbake-devel-bounces@lists.openembedded.org
> [mailto:bitbake-devel-bounces@lists.openembedded.org] On Behalf Of Joshua
> Lock
> Sent: Wednesday, December 14, 2011 12:32 AM
> To: bitbake-devel@lists.openembedded.org
> Subject: Re: [bitbake-devel] [PATCH 03/10] cooker: user bb.configuration.=
data
> to inject events
>=20
>=20
>=20
> On 11/12/11 18:20, Dongxiao Xu wrote:
> > For buildTargets function, we use bb.configuration.data as parameter
> > to inject events, since in hob environment, some variables are
> > modified dynamically and bb.configuration.event_data may out of date.
> >
> > Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
>=20
> If we can't rely on event_data to be consistent/up-to-date do we need to =
keep
> it around? The comment around its creation implies we want/need the copy =
of
> data.

Hmm, I am also not sure why we need the event_data. In the cooker.py, some =
place we use event_data to inject events, and some other place, we use bb.c=
onfiguration.data.
This event_data is introduced from an old bitbake commit: b708cf280fd1bc956=
6f822eeff4cc670a3ce28a0.
Hope Richard can give more hints on it?

Thanks,
Dongxiao

>=20
> This feels like we're working around on issue rather than fixing one.
>=20
> Joshua

>=20
> > ---
> >  lib/bb/cooker.py |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py index
> > 2c02e28..6ddb38e 100644
> > --- a/lib/bb/cooker.py
> > +++ b/lib/bb/cooker.py
> > @@ -1085,7 +1085,7 @@ class BBCooker:
> >                  return False
> >
> >              if not retval:
> > -                bb.event.fire(bb.event.BuildCompleted(buildname,
> targets, failures), self.configuration.event_data)
> > +                bb.event.fire(bb.event.BuildCompleted(buildname,
> > + targets, failures), self.configuration.data)
> >                  self.command.finishAsyncCommand()
> >                  return False
> >              if retval is True:
> > @@ -1095,7 +1095,7 @@ class BBCooker:
> >          self.buildSetVars()
> >
> >          buildname =3D self.configuration.data.getVar("BUILDNAME")
> > -        bb.event.fire(bb.event.BuildStarted(buildname, targets),
> self.configuration.event_data)
> > +        bb.event.fire(bb.event.BuildStarted(buildname, targets),
> > + self.configuration.data)
> >
> >          localdata =3D data.createCopy(self.configuration.data)
> >          bb.data.update_data(localdata)
>=20
> --
> Joshua Lock
>         Yocto Project "Johannes factotum"
>         Intel Open Source Technology Centre
>=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel


