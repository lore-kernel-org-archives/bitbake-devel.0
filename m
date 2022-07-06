Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA52C43334
	for <webhook@archiver.kernel.org>; Wed,  6 Jul 2022 16:19:24 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web12.8290.1657124360369041611
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Jul 2022 09:19:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=fh7om+BK;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id bk26so7707371wrb.11
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Jul 2022 09:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=KXp7g5hBqmzb8ICj16ixpp9/E4XeYeCDK8WpLsl6rDc=;
        b=fh7om+BKU2ipUr8nh4qgqFwB6K7/YC8lT+Mvn2GjHeN8yA8u+/II5/p504vLUwMVNT
         RZ+pknjvtOkF8aSxftooE/SDa9Y7BBgckFYN1dkjL2LaAgVbOp4EiP6K/AgGSBr8srAb
         pujyLBrBpARHKqt1SsYdS6QuwDMADX4mgfFwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=KXp7g5hBqmzb8ICj16ixpp9/E4XeYeCDK8WpLsl6rDc=;
        b=m+HFK2aMzyG55HULCpDFYOn9iU1AaocVKqW6i6a7Sq8VON8dz//Z66N5txLjmkiEQO
         RZay70vj3TCtCRwhyPYY1adZeaoE8IEwVPzmTCCdEU1LzJKZSzmixk7fp3TXvYG6GKal
         X02UZYQOpmm6BBzEweZ7n1NXo1vWW31uJMSSrZu7TIvN1ZAu6yk+NpmV4Kt9Okpars0y
         Uz/isbfxL705JeQjDgSLAX+MjchDHoJpUJsVsMXcnr6wq5RXlwew2eG9I11Xuq1Z9OBR
         EDVUF85mBld0r7ZIuWr2ozF0V+IfPEOPMosXjmS5eacRP8o1sgN26pS59SpzrMyKGuhz
         QMvw==
X-Gm-Message-State: AJIora97S/QUlz9n0S+PVbFZFNy1OxvahdwnFeC+rl0XV0+MXXwkT4Mn
	sL3Zmnef+6GM1tmqAd+S2t9nsg==
X-Google-Smtp-Source: 
 AGRyM1t/xZcQFDGpGOGf3AGya2Z+f8QfzW7CLpCaZ/dftmuyXwdLOirRh3foSgXjYl4v/VuQ2dR2oQ==
X-Received: by 2002:adf:dd01:0:b0:21d:6df2:be30 with SMTP id
 a1-20020adfdd01000000b0021d6df2be30mr13620067wrm.255.1657124358707;
        Wed, 06 Jul 2022 09:19:18 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:9b71:63f4:5737:a5c8?
 ([2001:8b0:aba:5f3c:9b71:63f4:5737:a5c8])
        by smtp.gmail.com with ESMTPSA id
 e22-20020a05600c4e5600b003973435c517sm27109632wmq.0.2022.07.06.09.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 09:19:17 -0700 (PDT)
Message-ID: 
 <970e2ed4c836e291aa9845849c0d3d86b57f849c.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch2/git: Check srcrev exists in
 checkstatus()
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Bruce Ashfield <bruce.ashfield@gmail.com>, Maia Xiao
	 <t-maiaxiao@linux.microsoft.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>, Paul Eggleton
	 <Paul.Eggleton@microsoft.com>
Date: Wed, 06 Jul 2022 17:19:16 +0100
In-Reply-To: 
 <CADkTA4P_9hfBFO1Pbj+cMpiaBQPL3xaCOPgnRYnO=tyKVS0n-g@mail.gmail.com>
References: <20220705174630.13360-1-t-maiaxiao@linux.microsoft.com>
	 <CADkTA4O_bxHU9hdEiMRo=yKoY1HMd-OCzX2ey9VFJqDs08coJQ@mail.gmail.com>
	 <CADkTA4P_9hfBFO1Pbj+cMpiaBQPL3xaCOPgnRYnO=tyKVS0n-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 Jul 2022 16:19:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13804

On Wed, 2022-07-06 at 11:13 -0400, Bruce Ashfield wrote:
> On Wed, Jul 6, 2022 at 11:12 AM Bruce Ashfield <bruce.ashfield@gmail.com>=
 wrote:
> >=20
> > On Tue, Jul 5, 2022 at 1:46 PM Maia Xiao <t-maiaxiao@linux.microsoft.co=
m> wrote:
> > >=20
> > > Currently we only check that we can list the remote, but do not valid=
ate
> > > if the srcrev actually exists. Now we ensure that the rev exists by
> > > attempting to shallow clone it from the remote.
> > >=20
> > > Fixes [YOCTO #11199].
> > >=20
> > > Signed-off-by: Maia Xiao <t-maiaxiao@linux.microsoft.com>
> > > ---
> > >  lib/bb/fetch2/git.py  | 28 +++++++++++++++++++++++-----
> > >  lib/bb/tests/fetch.py | 34 ++++++++++++++++++++++++++++++++++
> > >  2 files changed, 57 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> > > index 07b3d9a7..99780de8 100644
> > > --- a/lib/bb/fetch2/git.py
> > > +++ b/lib/bb/fetch2/git.py
> > > @@ -832,8 +832,26 @@ class Git(FetchMethod):
> > >              return True, str(rev)
> > >=20
> > >      def checkstatus(self, fetch, ud, d):
> > > -        try:
> > > -            self._lsremote(ud, d, "")
> > > -            return True
> > > -        except bb.fetch2.FetchError:
> > > -            return False
> > > +        repourl =3D self._get_repo_url(ud)
> > > +        for name in ud.names:
> > > +            tmpdir =3D tempfile.mkdtemp()
> > > +            revision =3D ud.revisions[name]
> > > +
> > > +            try:
> > > +                # Initialise an empty git repo for shallow fetching
> > > +                runfetchcmd("%s init" % ud.basecmd, d, workdir=3Dtmp=
dir)
> > > +                runfetchcmd("%s remote add origin %s" %
> > > +                            (ud.basecmd, shlex.quote(repourl)),
> > > +                            d,
> > > +                            workdir=3Dtmpdir)
> > > +
> > > +                # Try to fetch only the specified srcrev
> > > +                runfetchcmd("%s fetch -f --progress --depth 1 origin=
 %s" %
> >=20
> > I think this is something that has to be optional, and not always enabl=
ed.
> > I'm sure Richard can advise better than I can on the options for that.
> >=20
>=20
> Actually never mind on this first point, assuming that this isn't run on =
all
> fetch paths (I didn't check that).
>=20
> But my second comment about the depth is something to consider.

Yes, I'm also remembering comments someone made to me recently that
many git servers don't support limited depth clones because of the load
they put on the server.

I appreciate this was moved to a newcomer bug as I think we assumed
there was a straightforward way to remotely ask "is revision X in the
repo" but it is looking like that might not be that easy :(

Cheers,

Richard



