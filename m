Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB01C433F5
	for <webhook@archiver.kernel.org>; Thu, 12 May 2022 22:04:44 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web10.1331.1652393079915538934
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 May 2022 15:04:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=QQ9sEKCt;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id u3so9070819wrg.3
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 May 2022 15:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=U1INmrQfDgyoNkMPXvf74ty4l6Ey5GxfPtjOZQMf1CA=;
        b=QQ9sEKCtbZwWQpU/RBy2j3Gd2koqqqk3lWvs++AeEcjJBtR1zTszdLCK5rJjDxZvTh
         5vvOHxinFhG6JAlvIwlGN6gYaQ5gFCHXvD8aEzROPQ4pXgjzh4lg9eTfcFjH2q5KZjH9
         lcqxfCku5KoIjkfYylnzwCyD+0vcypVL0sIo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=U1INmrQfDgyoNkMPXvf74ty4l6Ey5GxfPtjOZQMf1CA=;
        b=ucOLSRV+ozxUfr74u/YHNgQ98QFgs2b9Tr9+JWAdZf2hZMjFNfZEQlpdk8yMa7vU6z
         UxOTQfFuFWCI3dt09tKTQqaSDlq/UuB/UUE6zzhi8XD95uvzFWqgMItE8spc67iTr4Bu
         Xs2emrP/PZtvE/vCNf+cqDtPm7ZRrPu5SEeNY5PCeTtecxNbMgZBnRp4orRmppCKWWUg
         d9SmvxtvdcUDyhpIG7eEdD3Iph6VH+CN+2BAb6VPKM8VmcG9OgdIFWIDHHzf+LMODZCK
         PlH/zeBIZ9h74OCDxxoiHsSk7GC4bSgEZ3gSVe1PyrbsGOi9Ajfv/BJdmYPdmzmYVd8T
         ozYw==
X-Gm-Message-State: AOAM533l4A3JeKSsGe6/HmSf6zoYOjaqZOTr/NGEWWxZz+CfrVp10/+Z
	26Q3TZ7u5Aj3/7aS+nJJM4I3Tw==
X-Google-Smtp-Source: 
 ABdhPJzs4yDI6kDBf78JwuUwB6/DS5Au9pbGaqdIsCPHrSyY1+f7wNugFaJsIrARYSTK6cKMadGhkQ==
X-Received: by 2002:a5d:58e3:0:b0:20c:d508:43d4 with SMTP id
 f3-20020a5d58e3000000b0020cd50843d4mr1383959wrd.51.1652393078073;
        Thu, 12 May 2022 15:04:38 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:a1e1:9ec5:5b27:abc8?
 ([2001:8b0:aba:5f3c:a1e1:9ec5:5b27:abc8])
        by smtp.gmail.com with ESMTPSA id
 q4-20020a05600c040400b003942a244f2esm3667052wmb.7.2022.05.12.15.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 15:04:37 -0700 (PDT)
Message-ID: 
 <f09538e33bbae7eca1ff6365492f165c2da32b0b.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v3 1/3] Honour BB_FETCH_PREMIRRORONLY
 option
From: richard.purdie@linuxfoundation.org
To: Pavel Zhukov <pavel@zhukoff.net>, bitbake-devel@lists.openembedded.org
Cc: Pavel Zhukov <pavel.zhukov@huawei.com>
Date: Thu, 12 May 2022 23:04:36 +0100
In-Reply-To: <16EE7864A573C566.16097@lists.openembedded.org>
References: <20220506141733.3298-1-pavel@zhukoff.net>
	 <16EE7864A573C566.16097@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0-1ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 May 2022 22:04:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13700

On Thu, 2022-05-12 at 22:21 +0100, Richard Purdie via
lists.openembedded.org wrote:
> On Fri, 2022-05-06 at 16:17 +0200, Pavel Zhukov wrote:
> > This should fix [Yocto 13353] and related to [Yocto 13233] as well.
> > Previously if git repo mirror has been updated in between of two builds
> > fetcher of the second build didn't try updated mirror but switched to
> > git clone from upstream instead. This is problem for offline builds.
> > Fix this to raise MirrorException if BB_FETCH_PREMIRRORONLY has been
> > specified by the mirror doesn't contain SRC_REV.
> >=20
> > Signed-off-by: Pavel Zhukov <pavel.zhukov@huawei.com>
> > ---
> >  lib/bb/fetch2/__init__.py | 2 ++
> >  lib/bb/fetch2/git.py      | 6 ++++--
> >  2 files changed, 6 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> > index ac557176..c99cd104 100644
> > --- a/lib/bb/fetch2/__init__.py
> > +++ b/lib/bb/fetch2/__init__.py
> > @@ -1745,6 +1745,8 @@ class Fetch(object):
> >                              done =3D False
> > =20
> >                  if premirroronly:
> > +                    if not done:
> > +                        raise FetchError("Failed to download premirror=
 {} and BB_FETCH_PREMIRRORONLY has been set to 1.".format(self.d.getVar("PR=
EMIRRORS")))
> >                      self.d.setVar("BB_NO_NETWORK", "1")
> > =20
> >                  firsterr =3D None
> > diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> > index bdcfa497..e556f297 100644
> > --- a/lib/bb/fetch2/git.py
> > +++ b/lib/bb/fetch2/git.py
> > @@ -353,10 +353,12 @@ class Git(FetchMethod):
> >          if ud.shallow and os.path.exists(ud.fullshallow) and self.need=
_update(ud, d):
> >              ud.localpath =3D ud.fullshallow
> >              return
> > -        elif os.path.exists(ud.fullmirror) and not os.path.exists(ud.c=
lonedir):
> > +        if os.path.exists(ud.fullmirror) and self.try_premirror(ud, d)=
 and self.need_update(ud, d):
> >              bb.utils.mkdirhier(ud.clonedir)
> >              runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=3Dud=
.clonedir)
> > -
> > +            if self.need_update(ud, d) and bb.utils.to_boolean(d.getVa=
r("BB_FETCH_PREMIRRORONLY")):
> > +                    raise bb.fetch2.FetchError("Premirror doesn't cont=
ain revisions {} and "\
> > +                            "upstream cannot be used due to BB_FETCH_P=
REMIRRORONLY setting".format(ud.revisions))
> >          repourl =3D self._get_repo_url(ud)
> >=20
>=20
> Thanks for this series, it is a long standing issue we need to fix.
> Sorry for the delayed reply, I've had to think about this for while. I
> think your patch is mostly correct. What I'm worried about is the
> fetchers having premirror knowledge, that was intended to say inside
> __init__.py in the fetcher.
>=20
> I think there is a better way for the git fetcher to behave. It tries
> hard to preserve clonedir if it already exists but in the premirror
> case it will remove it.
>=20
> This does lead me to one concern with the patch as it stands which is
> that if clonedir already exists and we untar ud.fullmirror over the top
> of it, the mix of existing and new files may be toxic (e.g. expanded
> refs and packed-refs being mixed). At the very least we need a delete
> in there.
>=20
> I think what it should do is untar ud.fullmirror to a temp directory,
> then replace clonedir if this looks "better" than clonedir, else if
> just deletes the temp directory.
>=20
> I think that way we can remove a lot of the twisted logic and simplify
> things. Would you agree and is that something you could look at?

I realised I wasn't clear. I've never liked deleting clonedir since
this has the potential to lose data. The pathalogical case is where we
screw up a revision of linux-yocto, it gets deleted as bitbake can't
find the revision and then the user has to download the whole thing
again.

I mentioned deletion above but I've realised we could clone into
clonedir from the temp dir, thereby removing the risk other revisions
were removed from the repo too. That would seem to be the best way to
handle this to mitigate the most issues.

Cheers,

Richard





