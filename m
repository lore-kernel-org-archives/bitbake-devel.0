Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B766ACA551A
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 09:22:33 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.7523.1694596943626280951
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 13 Sep 2023 02:22:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=T00QWyhy;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-401c90ed2ecso71525815e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 13 Sep 2023 02:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1694596942; x=1695201742; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Afe87omXHp5E7IEPgpfYYNnnVsmOFFAUALLaQwxwwsw=;
        b=T00QWyhyercOddead8lxcuQnl79g14K2ZqBlv/7+ScBHWKhV3UW/h6X6bg03Mwl56k
         rvyos2C+d8Ky3Dp93mU47cDkGjnMH44biF1oX/Py9tj2zw67T5N3Oi+xsFbdskIxuMIf
         55r+TRRzSOj9AUo+DDpF0Qu7s8PDkgkSLRRW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694596942; x=1695201742;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Afe87omXHp5E7IEPgpfYYNnnVsmOFFAUALLaQwxwwsw=;
        b=wsgTdbKQiCbH5A3X7t08d7/rKfOyb3979N9V7VrLfUFc+fBQAPl+PHdYfzKC//m5qN
         /KM0y5O7eBA6aKLRCD8SyBxrTDL6CKq0ZbKjId5SMWYSZNZF6JgHV9VZQLrmO7f8em1R
         HwazpKyVsfa+/M9BweWLVhR/I9OPeZU4wJ7+GeAgtdfVf2tgK2ThuaZIjUHfoBL8dKuU
         lfy3sxGh9+BInPZaMuF4hWlaQ6a02TMya8zm7brUrOptc0gJhgg4eyiBsoyHhuWDofh7
         1wI2M/829VNkferfIWITR1rW85bUt7Plxo5sP5nTBONtzFPTgtey4EpDXYcpaRePhQa9
         qpXQ==
X-Gm-Message-State: AOJu0YygRH59phpqYsLJirkmdgQK372IlbfZydmWmEOQshyY9GEtqPec
	hps6pFpNtshWPvpyYvf3uDSlHw==
X-Google-Smtp-Source: AGHT+IGmqxnOA94YPieQcSN6Rm/K4El9YE3qhxiQO+sKWhwROfZtkOf/AIoex589qhNDqMhyLLXqMw==
X-Received: by 2002:a7b:c7d5:0:b0:3fe:e7b2:c97f with SMTP id z21-20020a7bc7d5000000b003fee7b2c97fmr1426363wmk.36.1694596941937;
        Wed, 13 Sep 2023 02:22:21 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:2a8:4888:9029:4207? ([2001:8b0:aba:5f3c:2a8:4888:9029:4207])
        by smtp.gmail.com with ESMTPSA id m7-20020a05600c280700b003fed630f560sm1455233wmb.36.2023.09.13.02.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 02:22:21 -0700 (PDT)
Message-ID: <ee62b58ba8e8b1bd085631b8fdd55d0dad698b2e.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] bitbake: fetch2: git: revert path checks
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Mikko Rapeli <mikko.rapeli@linaro.org>
Cc: bitbake-devel@lists.openembedded.org, Joshua Watt <JPEWhacker@gmail.com>
Date: Wed, 13 Sep 2023 10:22:20 +0100
In-Reply-To: <ZQF7NWTYQQvVX3JE@nuoska>
References: <20230913084344.29928-1-mikko.rapeli@linaro.org>
	 <969bbf65ba6459eedd8df5a3b2cc3f378fdf05d2.camel@linuxfoundation.org>
	 <ZQF7NWTYQQvVX3JE@nuoska>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 Sep 2023 09:22:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15045

On Wed, 2023-09-13 at 12:04 +0300, Mikko Rapeli wrote:
> Hi,
>=20
> On Wed, Sep 13, 2023 at 09:51:39AM +0100, Richard Purdie wrote:
> > On Wed, 2023-09-13 at 11:43 +0300, Mikko Rapeli wrote:
> > > Commit 10f38157a069cb6938323cadd5e523037a29ace9
> > > triggers re-clones of uptodate repositories when their
> > > access path changes. This is wrong. It is enough that
> > > needed commits are found from the git repo. For example
> > > when same DL_DIR is accessed using two different paths
> > > due to a symlink, then the resulting absolute paths will
> > > differ but the content is the same. Trust the content.
> > >=20
> > > Avoids extra downloads of large repositories like linux-yocto
> > > for kernel when the local cache was already uptodate.
> > >=20
> > > Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
> > > ---
> > >  bitbake/lib/bb/fetch2/git.py | 14 +-------------
> > >  1 file changed, 1 insertion(+), 13 deletions(-)
> > >=20
> > > diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git=
.py
> > > index e11271b757..0c547ea303 100644
> > > --- a/bitbake/lib/bb/fetch2/git.py
> > > +++ b/bitbake/lib/bb/fetch2/git.py
> > > @@ -371,19 +371,7 @@ class Git(FetchMethod):
> > >              # The directory may exist, but not be the top level of a=
 bare git
> > >              # repository in which case it needs to be deleted and re=
-cloned.
> > >              try:
> > > -                # Since clones can be bare, use --absolute-git-dir i=
nstead of --show-toplevel
> > > -                output =3D runfetchcmd("LANG=3DC %s rev-parse --abso=
lute-git-dir" % ud.basecmd, d, workdir=3Dud.clonedir)
> > > -
> > > -                toplevel =3D os.path.abspath(output.rstrip())
> > > -                abs_clonedir =3D os.path.abspath(ud.clonedir).rstrip=
('/')
> > > -                # The top level Git directory must either be the clo=
ne directory
> > > -                # or a child of the clone directory. Any ancestor di=
rectory of
> > > -                # the clone directory is not valid as the Git direct=
ory (and
> > > -                # probably belongs to some other unrelated repositor=
y), so a
> > > -                # clone is required
> > > -                if os.path.commonprefix([abs_clonedir, toplevel]) !=
=3D abs_clonedir:
> > > -                    logger.warning("Top level directory '%s' doesn't=
 match expected '%s'. Re-cloning", toplevel, ud.clonedir)
> > > -                    needs_clone =3D True
> > > +                runfetchcmd("LANG=3DC %s rev-parse --absolute-git-di=
r" % ud.basecmd, d, workdir=3Dud.clonedir)
> > >              except bb.fetch2.FetchError as e:
> > >                  logger.warning("Unable to get top level for %s (not =
a git directory?): %s", ud.clonedir, e)
> > >                  needs_clone =3D True
> >=20
> > Doesn't this give rise to some of the original issues (it could find a
> > parent git repo instead of the one being cloned)?
>=20
> Yes, but this has not been a problem for me. Re-cloning existing fully ca=
ched
> repositories is the effect I see.
>=20
> I think the git commit id and branch should decide if fetch or re-clone s=
teps are needed.
> The path of the repository should not matter. The git remotes also not. B=
oth of those can
> and do change.

In that case you're effectively sending a revert and we should probably
be clear about that...

We really need to find a way to resolve things for everyone.

Cheers,

Richard

