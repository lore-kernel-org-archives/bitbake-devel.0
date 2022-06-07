Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E178C433EF
	for <webhook@archiver.kernel.org>; Tue,  7 Jun 2022 13:26:41 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web12.12491.1654608394885458596
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Jun 2022 06:26:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=eGb+LlOh;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id
 l2-20020a05600c1d0200b0039c35ef94c4so7507045wms.4
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Jun 2022 06:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=r/xS8ARLCJ2UbPgwWLnztCp3asgihjF3pdlQ2l/AfsU=;
        b=eGb+LlOhWkRuwrGPlplN32O/eShqvyTxXk4N60N2y6a+6p4lqGC7oPFHB5R/a6AlHS
         Up0Oqpwg1iYCYaWlXpG5f7UK3+QRU/+ogIlX/3Vo1PwspviUWSmP5HPHJbk66BHfDXu0
         NfnFbVFJnWoiHv7d0pWEjIODSB8eApoACx48I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=r/xS8ARLCJ2UbPgwWLnztCp3asgihjF3pdlQ2l/AfsU=;
        b=7d6+JO9SsCVFc6ZzQA/BMhxaaGniGsDNEyWBWjcj7AtktQTatQDnL5NDmuvSmyb3dI
         HzKgcFoj0he0wCscjM/A5uKrGO9HU6wovxLUwmXYnFASyBA4hErud3xg12j1U6ZPj5RS
         kPRLLX0tJzpjxu2ZpCh9Fz68+18tTvr669ZURWMyxmB4Ue0Gzq5TpLecOUNo1F4kSRlf
         brpDRag2xHZ+gNrRxQXgj0gzefYJUD3SjRSOM7gTn+2Q2lliLNA3Qvs3Cfq25szJHI6x
         ugX6z4cH130ZgFhFFDZUdOr3lBaBpx1l4hsrc2f3GtmbvtUhVqAXbpLm/bRzDOl/ZFK/
         GZIg==
X-Gm-Message-State: AOAM533j6ICPXuKV70sPHjqvgksjFhiX14yaTWBDWbsm+nNCdx9Qq1/J
	J/XgtJAEPgK4C/5c9BcYEDtbUQ==
X-Google-Smtp-Source: 
 ABdhPJyRuJzAKU1DuXQwykh4D5gRdsEolKQBUNe/ann3+VDzb1VIUruCwY0xov68yjd6HPR7LfFxlA==
X-Received: by 2002:a05:600c:1d1f:b0:39c:5350:c5a3 with SMTP id
 l31-20020a05600c1d1f00b0039c5350c5a3mr9052740wms.136.1654608393291;
        Tue, 07 Jun 2022 06:26:33 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:e835:fc94:6c5b:fc12?
 ([2001:8b0:aba:5f3c:e835:fc94:6c5b:fc12])
        by smtp.gmail.com with ESMTPSA id
 m19-20020a05600c4f5300b003942a244f2esm26403049wmq.7.2022.06.07.06.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 06:26:32 -0700 (PDT)
Message-ID: 
 <0086651cf6f7f2c893fbb901b3effdd4fe3f6a7c.camel@linuxfoundation.org>
Subject: Re: [PATCH v4] Honour BB_FETCH_PREMIRRORONLY option
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: pavel@zhukoff.net
Cc: bitbake-devel@lists.openembedded.org, Pavel Zhukov
 <pavel.zhukov@huawei.com>
Date: Tue, 07 Jun 2022 14:26:31 +0100
In-Reply-To: <87fskg39ln.fsf@gentoo.zhukoff.net>
References: 
	<f09538e33bbae7eca1ff6365492f165c2da32b0b.camel@linuxfoundation.org>
	 <20220525144243.19999-1-pavel@zhukoff.net>
	 <2c0eaba3e77b0313ad4d861076e52a2e51fe4656.camel@linuxfoundation.org>
	 <87fskg39ln.fsf@gentoo.zhukoff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Jun 2022 13:26:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13735

On Tue, 2022-06-07 at 14:57 +0200, Pavel Zhukov wrote:
> Richard Purdie <richard.purdie@linuxfoundation.org> writes:
>=20
> > On Wed, 2022-05-25 at 16:42 +0200, Pavel Zhukov wrote:
> > > This should fix [Yocto 13353] and related to [Yocto 13233] as well.
> > > Previously if git repo mirror has been updated in between of two buil=
ds
> > > fetcher of the second build didn't try updated mirror but switched to
> > > git clone from upstream instead. This is problem for offline builds.
> > > Fix this to raise MirrorException if BB_FETCH_PREMIRRORONLY has been
> > > specified by the mirror doesn't contain SRC_REV.
> > >=20
> > > Signed-off-by: Pavel Zhukov <pavel.zhukov@huawei.com>
> > > ---
> > >  lib/bb/fetch2/__init__.py |  2 ++
> > >  lib/bb/fetch2/git.py      | 16 ++++++++++++----
> > >  2 files changed, 14 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> > > index ac557176..c99cd104 100644
> > > --- a/lib/bb/fetch2/__init__.py
> > > +++ b/lib/bb/fetch2/__init__.py
> > > @@ -1745,6 +1745,8 @@ class Fetch(object):
> > >                              done =3D False
> > > =20
> > >                  if premirroronly:
> > > +                    if not done:
> > > +                        raise FetchError("Failed to download premirr=
or {} and BB_FETCH_PREMIRRORONLY has been set to 1.".format(self.d.getVar("=
PREMIRRORS")))
> > >                      self.d.setVar("BB_NO_NETWORK", "1")
> > > =20
> > >                  firsterr =3D None
> > > diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> > > index 23f8c0da..bf7c9d26 100644
> > > --- a/lib/bb/fetch2/git.py
> > > +++ b/lib/bb/fetch2/git.py
> > > @@ -353,10 +353,18 @@ class Git(FetchMethod):
> > >          if ud.shallow and os.path.exists(ud.fullshallow) and self.ne=
ed_update(ud, d):
> > >              ud.localpath =3D ud.fullshallow
> > >              return
> > > -        elif os.path.exists(ud.fullmirror) and not os.path.exists(ud=
.clonedir):
> > > -            bb.utils.mkdirhier(ud.clonedir)
> > > -            runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=3D=
ud.clonedir)
> > > -
> > > +        elif os.path.exists(ud.fullmirror) and self.need_update(ud, =
d):
> > > +            if not os.path.exists(ud.clonedir):
> > > +                bb.utils.mkdirhier(ud.clonedir)
> > > +                runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdi=
r=3Dud.clonedir)
> > > +            else:
> > > +                tmpdir =3D tempfile.mkdtemp(dir=3Dd.getVar('DL_DIR')=
)
> > > +                runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdi=
r=3Dtmpdir)
> > > +                fetch_cmd =3D "LANG=3DC %s fetch -f --progress %s " =
% (ud.basecmd, shlex.quote(tmpdir))
> > > +                runfetchcmd(fetch_cmd, d, workdir=3Dud.clonedir)
> > > +            if self.try_premirror(ud, d) and self.need_update(ud, d)=
:
> > > +                    raise bb.fetch2.FetchError("Premirror doesn't co=
ntain revisions {} and "\
> > > +                            "upstream cannot be used due to BB_FETCH=
_PREMIRRORONLY setting".format(ud.revisions))
> > >          repourl =3D self._get_repo_url(ud)
> > > =20
> > >          # If the repo still doesn't exist, fallback to cloning it
> >=20
> >=20
> > Sorry about the delay in reviewing this, I finally ran some tests I
> > wanted to run to check a couple of things. I think there are two
> > changes in here and they should really be separated out. The mirror
> > unpack and fetch piece in a temp directory is great and just what I
> > think is needed here.
> >=20
> > The piece I worry a little more about is the raising of fetch errrors
> > if premirrors are configured. The code currently disables the network
> > but continues, this changes that behaviour to a hard stop.
> >=20
> > I tested with the patch below applied and things still work as expected
> > so if you're ok with that, I'd like to merge this with these tweaks,
> > preserving the network disabled behaviour?
> I'm ok with that. However in that case *ONLY* part of the
> BB_FETCH_PREMIRRORONLY doesn't make much sense for me because fetcher
> will check (clone) upstream in case if revision is not in the mirror(s). =
This
> naming inconsistence is not so important though

It could attempt it, yes, but it would fail if it needed to access the
network.

I'm a bit worried that somewhere there is a corner case where there is
a mirror under a different name cached locally which would succeed as
the code stands today but fail under the new case. I can't quite work
out that case right now but there is something bugging me a bit about
it :/.

Cheers,

Richard



