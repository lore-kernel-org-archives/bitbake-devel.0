Return-Path: <prvs=380cec95a=Mikko.Rapeli@bmw.de>
X-Greylist: delayed 588 seconds by postgrey-1.34 at layers.openembedded.org;
	Wed, 02 Aug 2017 11:53:00 UTC
Received: from esa7.bmw.c3s2.iphmx.com (esa7.bmw.c3s2.iphmx.com
	[68.232.133.109])
	by mail.openembedded.org (Postfix) with ESMTP id 5EE0E781CD
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Aug 2017 11:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
	t=1501674783; x=1533210783;
	h=from:to:cc:subject:date:message-id:references:
	in-reply-to:content-id:content-transfer-encoding: mime-version;
	bh=HRgvfjpYY1gww1PKWlMegF9K9G+UFS1nFlSrGcTxFKI=;
	b=hja9G5Rq9w8AcFpD2XfeUEjiAHuJ47TSGfdnYZ++9oWZYOKdagNk+WhY
	L3iGw+s02QgdCWrSUHjLCycM88pShb6hc7rywaQg6pqzTE+ZjEtGKNB69
	kgfejOe7zyhi8XCRN+UvFBvA3OlLQxvRRTP7Kkb7B5PawOtLQ9JetbWJq E=;
Received: from esagw1.bmwgroup.com (HELO esagw1.muc) ([160.46.252.34]) by
	esa7.bmw.c3s2.iphmx.com with ESMTP/TLS; 02 Aug 2017 13:43:13 +0200
Received: from esabb3.muc ([160.50.100.30])  by esagw1.muc with ESMTP/TLS;
	02 Aug 2017 13:43:13 +0200
Received: from smucm10m.bmwgroup.net (HELO smucm10m.europe.bmw.corp)
	([160.48.96.49])
	by esabb3.muc with ESMTP/TLS; 02 Aug 2017 13:43:13 +0200
Received: from smucm10k.europe.bmw.corp (160.48.96.47) by
	smucm10m.europe.bmw.corp
	(160.48.96.49) with Microsoft SMTP Server (TLS;
	Wed, 2 Aug 2017 13:43:12 +0200
Received: from smucm10k.europe.bmw.corp ([160.48.96.47]) by
	smucm10k.europe.bmw.corp ([160.48.96.47]) with mapi id 15.00.1263.000;
	Wed, 2 Aug 2017 13:43:12 +0200
From: <Mikko.Rapeli@bmw.de>
To: <ross.burton@intel.com>
Thread-Topic: [bitbake-devel] [PATCH] fetch2/git.py: try to handle local clone
	failures by pruning branches
Thread-Index: AQHTC3RvK4nHM6rnmEm7Hhqq6uq5e6JwzZ6AgAAC/AA=
Date: Wed, 2 Aug 2017 11:43:12 +0000
Message-ID: <20170802114312.vv7lxocehnh5jb5k@hiutale>
References: <1501667264-32012-1-git-send-email-mikko.rapeli@bmw.de>
	<CAJTo0LawBBCPg73-fuEXoe354MiacxdM37mZQqRrc0izCQt0Jw@mail.gmail.com>
In-Reply-To: <CAJTo0LawBBCPg73-fuEXoe354MiacxdM37mZQqRrc0izCQt0Jw@mail.gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.44.101]
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] fetch2/git.py: try to handle local clone failures by pruning branches
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
X-List-Received-Date: Wed, 02 Aug 2017 11:53:01 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8C6B4393C2086E41B8E0C3D4125E583A@bmwmail.corp>
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2017 at 12:32:31PM +0100, Burton, Ross wrote:
> On 2 August 2017 at 10:47, Mikko Rapeli <mikko.rapeli@bmw.de> wrote:
>=20
> > +            except bb.fetch2.FetchError:
> > +                # try to recover by pruning deleted remote branches wh=
ich
> > +                # make cloning local git tree fail in git 2.7.x but no=
t in
> > +                # git 1.9.x
> > +                try:
> > +                    runfetchcmd("%s -C %s remote prune origin" %
> > (ud.basecmd, ud.clonedir), d)
> > +                except bb.fetch2.FetchError:
> > +                    pass
> >
>=20
> Would it be best to simplify the logic by aways pruning before fetching?
> Prune doesn't take a long time, and it will keep the size of the mirror
> down.

Depends. Is download directory supposed to be treated read-only for all but
real do_fetch?

I would prefer that pruning happened after the real fetch from remote git t=
ree
since the tree in download dir is modified at that point.

In this exceptional case the pruning is needed when fetching an uptodate gi=
t
tree from download dir to workspace, because git has decided to start faili=
ng
the local clone. (I guess this was called do_unpack for glibc recipe where =
we
saw this issue.)

-Mikko=

