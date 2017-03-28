Return-Path: <pidge@toganlabs.com>
X-Greylist: delayed 899 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 28 Mar 2017 13:30:46 UTC
Received: from burlywood.maple.relay.mailchannels.net
	(burlywood.maple.relay.mailchannels.net [23.83.214.26])
	by mail.openembedded.org (Postfix) with ESMTP id E65CD71A74
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Mar 2017 13:30:46 +0000 (UTC)
X-Sender-Id: hostpapa|x-authuser|pidge@toganlabs.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id C77037C141B;
	Tue, 28 Mar 2017 13:05:38 +0000 (UTC)
Received: from hp181.hostpapa.com (unknown [100.96.129.119])
	by relay.mailchannels.net (Postfix) with ESMTPA id 404E17C1EEA;
	Tue, 28 Mar 2017 13:05:38 +0000 (UTC)
X-Sender-Id: hostpapa|x-authuser|pidge@toganlabs.com
Received: from hp181.hostpapa.com (hp181.hostpapa.com [172.20.107.195])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
	by 0.0.0.0:2500 (trex/5.7.37); Tue, 28 Mar 2017 13:05:38 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: hostpapa|x-authuser|pidge@toganlabs.com
X-MailChannels-Auth-Id: hostpapa
X-Broad-Bored: 600c5e3c758bd101_1490706338628_1173580696
X-MC-Loop-Signature: 1490706338628:728131156
X-MC-Ingress-Time: 1490706338627
Received: from [213.46.252.136] (port=54841 helo=[192.168.227.177])
	by hp181.hostpapa.com with esmtpsa
	(TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.87)
	(envelope-from <pidge@toganlabs.com>)
	id 1csqob-000p9N-G9; Tue, 28 Mar 2017 15:05:38 +0200
Message-ID: <1490706334.16596.10.camel@toganlabs.com>
From: Beth 'pidge' Flanagan <pidge@toganlabs.com>
Reply-To: pidge@toganlabs.com
To: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel@lists.openembedded.org
Date: Tue, 28 Mar 2017 15:05:34 +0200
In-Reply-To: <1490705814.13980.278.camel@linuxfoundation.org>
References: <1490701183-20278-1-git-send-email-pidge@toganlabs.com>
	<1490705814.13980.278.camel@linuxfoundation.org>
Organization: toganlabs.com
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
X-OutGoing-Spam-Status: No, score=5.0
X-AuthUser: pidge@toganlabs.com
Subject: Re: [PATCH] s3.py: Add support for fetching source mirrors/minor cleanup
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
X-List-Received-Date: Tue, 28 Mar 2017 13:30:47 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2017-03-28 at 13:56 +0100, Richard Purdie wrote:
> On Tue, 2017-03-28 at 13:39 +0200, Elizabeth 'pidge' Flanagan wrote:
> >=20
> > This commits main purpose is to add support for fetching source
> > mirrors. In the current incarnation:
> >=20
> > SOURCE_MIRROR_URL ?=3D "s3://mybucket/downloads"
> >=20
> > will fail for two reasons. First, download doesn't support it,
> > but second, without aws included in HOSTTOOLS you'll end up
> > with aws not being found by bitbake (for either source mirrors or
> > sstate mirrors).
> >=20
> > Part of this is fixed with this commit. However, this will still
> > fail if HOSTTOOLS doesn't include 'aws' in bitbake.conf. I've
> > another
> > commit or two to fix that as well.
> >=20
> > I've also DRYed up some of the error handling, removed the
> > hardcoded
> > aws and added some logging.
> >=20
> > Signed-off-by: Elizabeth 'pidge' Flanagan <pidge@toganlabs.com>
> > ---
> > =C2=A0lib/bb/fetch2/s3.py | 20 ++++++++++++++------
> > =C2=A01 file changed, 14 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/lib/bb/fetch2/s3.py b/lib/bb/fetch2/s3.py
> > index 27993aa..dbd86f4 100644
> > --- a/lib/bb/fetch2/s3.py
> > +++ b/lib/bb/fetch2/s3.py
> > @@ -34,6 +34,7 @@ import urllib.request, urllib.parse, urllib.error
> > =C2=A0from bb.fetch2 import FetchMethod
> > =C2=A0from bb.fetch2 import FetchError
> > =C2=A0from bb.fetch2 import runfetchcmd
> > +from bb.fetch2 import logger
> > =C2=A0
> > =C2=A0class S3(FetchMethod):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"""Class to fetch urls via 'aws s3'"""
> > @@ -60,8 +61,13 @@ class S3(FetchMethod):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Fetch urls
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Assumes localpa=
th was called first
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"""
> > -
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cmd =3D 'aws s3 cp s=
3://%s%s %s' % (ud.host, ud.path,
> > ud.localpath)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if 'downloadfilename=
' in ud.parm:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0dldir =3D d.getVar("DL_DIR", True)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0bb.utils.mkdirhier(os.path.dirname(dldir + os.sep +
> > ud.localfile))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0cmd =3D '%s cp s3://%s%s %s%s%s' %
> > (d.getVar("FETCHCMD_s3"), ud.host, ud.path, dldir, os.sep,
> > ud.localpath)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0cmd =3D '%s cp s3://%s%s %s' % (d.getVar("FETCHCMD_s3"),
> > ud.host, ud.path, ud.localpath)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0logger.debug(2, "Fet=
ching %s using command '%s'" %
> > (ud.url,
> > cmd))
> Do you actually need/use=C2=A0FETCHCMD_s3 ?
>=20

I use it so I can rip out aws-cli and use s3cmd.

-b

> I'd prefer not to add this unless we really do need it.
>=20
> Cheers,
>=20
> Richard



