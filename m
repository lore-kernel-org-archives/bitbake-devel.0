Return-Path: <mikko.rapeli@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB43FC28D13
	for <webhook@archiver.kernel.org>; Mon, 22 Aug 2022 05:20:02 +0000 (UTC)
Received: from esa7.hc324-48.eu.iphmx.com (esa7.hc324-48.eu.iphmx.com
 [207.54.71.126])
 by mx.groups.io with SMTP id smtpd.web12.14672.1661145597178304979
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 21 Aug 2022 22:19:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=T7hGXJn+;
 spf=pass (domain: bmw.de, ip: 207.54.71.126,
 mailfrom: prvs=226cd0590=mikko.rapeli@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1661145597; x=1692681597;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JDlkZ1D5KI67oFfMjdzpTrDdr7j+TxXLP5KzScuUD+w=;
  b=T7hGXJn+cT9jMW9bY7dN7IywO7Rgk8Zl2N0dx+XtZxo7PDk7h59GGc4Q
   iZbDxz6Knz7PMK6rokVomUCtO/2mlmr4ULdROCy6BY9BZMpA1cre39oZ1
   0FngF1TI3hfpGd8+6gumvU2AU9fd2sU5onGXABJPlrHCmiRBwzkKWOysq
   w=;
Received: from esagw6.bmwgroup.com (HELO esagw6.muc) ([160.46.252.49]) by
 esa7.hc324-48.eu.iphmx.com with ESMTP/TLS; 22 Aug 2022 07:19:54 +0200
Received: from esabb1.muc ([160.50.100.31])  by esagw6.muc with ESMTP/TLS;
 22 Aug 2022 07:19:54 +0200
Received: from smucmp08a.bmwgroup.net (HELO SMUCMP08A.europe.bmw.corp)
 ([10.30.13.67])
 by esabb1.muc with ESMTP/TLS; 22 Aug 2022 07:19:54 +0200
Received: from SMUCMP08E.europe.bmw.corp (2a03:1e80:a15:58f::1:24) by
 SMUCMP08A.europe.bmw.corp (2a03:1e80:a15:58f::212c) with Microsoft SMTP
 Server (version=TLS; Mon, 22 Aug 2022 07:19:54 +0200
Received: from SMUCMP08E.europe.bmw.corp ([10.30.13.71]) by
 SMUCMP08E.europe.bmw.corp ([10.30.13.71]) with mapi id 15.02.0922.027; Mon,
 22 Aug 2022 07:19:54 +0200
From: <Mikko.Rapeli@bmw.de>
To: <peter.kjellerstedt@axis.com>
CC: <marex@denx.de>, <bitbake-devel@lists.openembedded.org>,
	<Martin.Jansa@gmail.com>, <richard.purdie@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] [RFC] fetch2/git: Prevent git fetcher
 from fetching gitlab repository metadata
Thread-Topic: [bitbake-devel] [PATCH] [RFC] fetch2/git: Prevent git fetcher
 from fetching gitlab repository metadata
Thread-Index: AQHYs+yI6ZkxFnyDGU+Z/Quo9ksiHa23kU2AgAKy7wA=
Date: Mon, 22 Aug 2022 05:19:53 +0000
Message-ID: <YwMR+H8KWePvpJtn@korppu>
References: <20220819165455.270130-1-marex@denx.de>
 <ab9e6c5562c44ac68e5d5e13e82dc8c0@axis.com>
In-Reply-To: <ab9e6c5562c44ac68e5d5e13e82dc8c0@axis.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <27AC70E34F9A6B41A8F7A0C864D2E091@bmwmail.corp>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Aug 2022 05:20:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13910

Hi,

On Sat, Aug 20, 2022 at 12:06:55PM +0000, Peter Kjellerstedt wrote:
> > -----Original Message-----
> > From: Marek Vasut <marex@denx.de>
> > Sent: den 19 augusti 2022 18:55
> > To: bitbake-devel@lists.openembedded.org
> > Cc: Marek Vasut <marex@denx.de>; Martin Jansa <Martin.Jansa@gmail.com>;=
 Peter Kjellerstedt <peter.kjellerstedt@axis.com>; Richard Purdie <richard.=
purdie@linuxfoundation.org>
> > Subject: [PATCH] [RFC] fetch2/git: Prevent git fetcher from fetching gi=
tlab repository metadata
> >=20
> > The bitbake git fetcher currently fetches 'refs/*:refs/*', i.e. every
> > single object in the remote repository. This works poorly with gitlab
> > and github, which use the remote git repository to track its metadata
> > like merge requests, CI pipelines and such.
> >=20
> > Specifically, gitlab generates refs/merge-requests/*, refs/pipelines/*
> > and refs/keep-around/* and they all contain massive amount of data that
> > are useless for the bitbake build purposes. The amount of useless data
> > can in fact be so massive (e.g. with FDO mesa.git repository) that some
> > proxies may outright terminate the 'git fetch' connection, and make it
> > appear as if bitbake got stuck on 'git fetch' with no output.
> >=20
> > To avoid fetching all these useless metadata, tweak the git fetcher suc=
h
> > that it only fetches refs/heads/* and refs/tags/* . Avoid using negativ=
e
> > refspecs as those are only available in new git versions.
> >=20
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > ---
> > Cc: Martin Jansa <Martin.Jansa@gmail.com>
> > Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
> > Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
> > ---
> >  lib/bb/fetch2/git.py | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> > index 4534bd75..b5fc0a51 100644
> > --- a/lib/bb/fetch2/git.py
> > +++ b/lib/bb/fetch2/git.py
> > @@ -382,7 +382,7 @@ class Git(FetchMethod):
> >                runfetchcmd("%s remote rm origin" % ud.basecmd, d, workd=
ir=3Dud.clonedir)
> >=20
> >              runfetchcmd("%s remote add --mirror=3Dfetch origin %s" % (=
ud.basecmd, shlex.quote(repourl)), d, workdir=3Dud.clonedir)
> > -            fetch_cmd =3D "LANG=3DC %s fetch -f --progress %s refs/*:r=
efs/*" % (ud.basecmd, shlex.quote(repourl))
> > +            fetch_cmd =3D "LANG=3DC %s fetch -f --progress %s refs/hea=
ds/*:refs/heads/* refs/tags/*:refs/tags/*" % (ud.basecmd, shlex.quote(repou=
rl))
> >              if ud.proto.lower() !=3D 'file':
> >                  bb.fetch2.check_network_access(d, fetch_cmd, ud.url)
> >              progresshandler =3D GitProgressHandler(d)
> > --
> > 2.35.1
>=20
> Seems like the right thing to do. We use Gerrit, which also has its=20
> metadata in special refs/ spaces. One repository I tested with grew=20
> from 3 MB to 35 MB when I fetched using refs/* while another grew=20
> from 20 MB to 120 MB, so there is definitely space and time to be=20
> saved by only fetching the refs/heads and refs/tags spaces....

As user of Gerrit, I fear this will cause problems. In my case developers
are used to creating test topics and using git hashes in recipes which
are not yet released, e.g. not yet in release branches or tags. This can of
course create problems when such changes end up in real releases.

Workaround is that developers can create throw away testing branches
and refer to them in recipes.

From one side this is an improvement to have less data in caches, but on
the other side this adds extra actions to developers who want to test
changes to their recipes. Can't decide which one is more important though :=
/

Cheers,

-Mikko=

