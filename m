Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671CBC433EF
	for <webhook@archiver.kernel.org>; Thu, 12 May 2022 21:21:34 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web10.839.1652390486437590395
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 May 2022 14:21:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=YAwnqhQf;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id j25so7917874wrc.9
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 May 2022 14:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=UD7epRr4t2gt5BdXI8HWf2E5JwSrp9FycvhPyiVEHk8=;
        b=YAwnqhQfZwZcMQQk3IJ3fzKPo5RULkcssJJsg1eefecbbPz9x8IYrabjlmfEHEu8I5
         T+DrrKKikDqJUkh1GzHD1XSqEwxGnupJlGvxsKvqUtQlJQc7ZGGz6ZW+W58fW/wikXrH
         1MM4jNDliU86sqifTMN3ESA/KGzXfPEJEWk6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=UD7epRr4t2gt5BdXI8HWf2E5JwSrp9FycvhPyiVEHk8=;
        b=AyJhc2g/sedYgB+igEHWIhy0I/zu5XlYGZ8WL3Xbu2RAKN7uqhwtYeUf4IqbeSVnuw
         6fFidQrfegfmtu43KMrbs5Bw4b73MWHIDbc3IpDG4FwtY+ewAoQNUv0sXQQymq5N/SYg
         L5qylrv1oeoSUxrg3oBmYgmSDSDFkCo76tPRSESzcMh3ErAcKK0KDfEx9QlUMcfmDvW4
         Fbqvz36Jg7oJQOImp0FP4m1S0qPlOX7YusqaNPWCFLPOIa503pOrBKZoY/HyThqPukmT
         mi5L+hoHppihQkAAHHyiDPdKCicIzC67DtSIy9fZ3e5TcRy4L/f2+maj3elKo56diIAl
         YSuA==
X-Gm-Message-State: AOAM531M2YER0LLHVsN2MvybvZpryLtKiwETSPwMy9Z1LojRMgRQ9Dmo
	CHmROoTCvOsOXWybAw3HyINeag==
X-Google-Smtp-Source: 
 ABdhPJxV1x0JAs9ANzlyAfeP7/rpT9IWpS20Q8jhjsGKeagxkdGLLM8sNEjz6oppNmPRDrctd6EiPw==
X-Received: by 2002:a05:6000:1f1b:b0:20c:9ea8:b650 with SMTP id
 bv27-20020a0560001f1b00b0020c9ea8b650mr1307421wrb.300.1652390484676;
        Thu, 12 May 2022 14:21:24 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:a1e1:9ec5:5b27:abc8?
 ([2001:8b0:aba:5f3c:a1e1:9ec5:5b27:abc8])
        by smtp.gmail.com with ESMTPSA id
 t9-20020a1c7709000000b003942a244f4dsm3663609wmi.38.2022.05.12.14.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 14:21:24 -0700 (PDT)
Message-ID: 
 <fe6d38f97f3ad3dce9fbeffbde6628570ac6bd72.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v3 1/3] Honour BB_FETCH_PREMIRRORONLY
 option
From: richard.purdie@linuxfoundation.org
To: Pavel Zhukov <pavel@zhukoff.net>, bitbake-devel@lists.openembedded.org
Cc: Pavel Zhukov <pavel.zhukov@huawei.com>
Date: Thu, 12 May 2022 22:21:21 +0100
In-Reply-To: <20220506141733.3298-1-pavel@zhukoff.net>
References: <20220506141733.3298-1-pavel@zhukoff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0-1ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 May 2022 21:21:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13699

On Fri, 2022-05-06 at 16:17 +0200, Pavel Zhukov wrote:
> This should fix [Yocto 13353] and related to [Yocto 13233] as well.
> Previously if git repo mirror has been updated in between of two builds
> fetcher of the second build didn't try updated mirror but switched to
> git clone from upstream instead. This is problem for offline builds.
> Fix this to raise MirrorException if BB_FETCH_PREMIRRORONLY has been
> specified by the mirror doesn't contain SRC_REV.
>=20
> Signed-off-by: Pavel Zhukov <pavel.zhukov@huawei.com>
> ---
>  lib/bb/fetch2/__init__.py | 2 ++
>  lib/bb/fetch2/git.py      | 6 ++++--
>  2 files changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index ac557176..c99cd104 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -1745,6 +1745,8 @@ class Fetch(object):
>                              done =3D False
> =20
>                  if premirroronly:
> +                    if not done:
> +                        raise FetchError("Failed to download premirror {=
} and BB_FETCH_PREMIRRORONLY has been set to 1.".format(self.d.getVar("PREM=
IRRORS")))
>                      self.d.setVar("BB_NO_NETWORK", "1")
> =20
>                  firsterr =3D None
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index bdcfa497..e556f297 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -353,10 +353,12 @@ class Git(FetchMethod):
>          if ud.shallow and os.path.exists(ud.fullshallow) and self.need_u=
pdate(ud, d):
>              ud.localpath =3D ud.fullshallow
>              return
> -        elif os.path.exists(ud.fullmirror) and not os.path.exists(ud.clo=
nedir):
> +        if os.path.exists(ud.fullmirror) and self.try_premirror(ud, d) a=
nd self.need_update(ud, d):
>              bb.utils.mkdirhier(ud.clonedir)
>              runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=3Dud.c=
lonedir)
> -
> +            if self.need_update(ud, d) and bb.utils.to_boolean(d.getVar(=
"BB_FETCH_PREMIRRORONLY")):
> +                    raise bb.fetch2.FetchError("Premirror doesn't contai=
n revisions {} and "\
> +                            "upstream cannot be used due to BB_FETCH_PRE=
MIRRORONLY setting".format(ud.revisions))
>          repourl =3D self._get_repo_url(ud)
>=20

Thanks for this series, it is a long standing issue we need to fix.
Sorry for the delayed reply, I've had to think about this for while. I
think your patch is mostly correct. What I'm worried about is the
fetchers having premirror knowledge, that was intended to say inside
__init__.py in the fetcher.

I think there is a better way for the git fetcher to behave. It tries
hard to preserve clonedir if it already exists but in the premirror
case it will remove it.

This does lead me to one concern with the patch as it stands which is
that if clonedir already exists and we untar ud.fullmirror over the top
of it, the mix of existing and new files may be toxic (e.g. expanded
refs and packed-refs being mixed). At the very least we need a delete
in there.

I think what it should do is untar ud.fullmirror to a temp directory,
then replace clonedir if this looks "better" than clonedir, else if
just deletes the temp directory.

I think that way we can remove a lot of the twisted logic and simplify
things. Would you agree and is that something you could look at?

Cheers,

Richard



