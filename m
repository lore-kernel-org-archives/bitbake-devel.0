Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5E1CCA47B
	for <webhook@archiver.kernel.org>; Tue,  5 Jul 2022 21:27:43 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by mx.groups.io with SMTP id smtpd.web11.478.1657056461177155561
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 Jul 2022 14:27:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ZhPJe+PG;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.208.43,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-ed1-f43.google.com with SMTP id n8so16980318eda.0
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 Jul 2022 14:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=B3zTxRVduzgwgs8Hcp0dgb25Y+VHvK49PFnhtqL+X0g=;
        b=ZhPJe+PG3e+8h27YDgAqS96BBNSPXzBUHIPxVV4XiX+sC90QNQH2eErSY3g0T0D+Yo
         0vwe1OJOp/IgPswtJUwbsnw0RVcWrA9dtCMI4IKrKwspyNRkMdj3SHFizn/Z/EbRiXvJ
         mJWaQtqEl9EAYvPs4GodMGICyANTRrBPOO1bU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=B3zTxRVduzgwgs8Hcp0dgb25Y+VHvK49PFnhtqL+X0g=;
        b=MO8hBhA56whLo0DYb0uTlwhuLPkTZFotSEbD2goh7BcZZ2uync+1JsHQtbSyZ0Tgol
         8YLCuWrWu7LthQG42jiBciD0IqPq7BsiN9NsKW2nncwb2hIUsWzl4QQ1Gy5EJwrvpgRQ
         GSbJSDNlOl2WbzXfHNBdPFy+BT23y1gUYTZ2VCCbhBj6cEM8XsysLus9cQvS8CPiIPWe
         Pjr1mVRCZHL/5g4OBUAxt/I7TzIt/N/HpkhdWD+OuJkiPafLEAXVQ/e6t0VLAUUR3+g6
         4WFwiWnonNHqMMjRezbfLN2+LLyfDdWby2LWHCP7Zr7Z8ISliwMpmi1KwKv51KY7W4QB
         yK6g==
X-Gm-Message-State: AJIora942l/I4SuKd4Skwk7Tc21tMrpa2BhW4saOzGAlRAEXhSuJIsxO
	TPJh4xu5lSoQNy0iI+7IxEQabQ==
X-Google-Smtp-Source: 
 AGRyM1sM0qsUY0gKNjpvxKcKVxanCXjFAZxODpqrBCeMV7L/H/66CwGxecVGXQk1yY0Q2iLpilMKoA==
X-Received: by 2002:a05:6402:35ca:b0:43a:737d:56ca with SMTP id
 z10-20020a05640235ca00b0043a737d56camr9096902edc.80.1657056459509;
        Tue, 05 Jul 2022 14:27:39 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:9b71:63f4:5737:a5c8?
 ([2001:8b0:aba:5f3c:9b71:63f4:5737:a5c8])
        by smtp.gmail.com with ESMTPSA id
 jp1-20020a170906f74100b006fe0abb00f0sm16261531ejb.209.2022.07.05.14.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 14:27:38 -0700 (PDT)
Message-ID: 
 <1ce72dadf44e9ee42094cc3d8afd906373fdc043.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch2/git: Check srcrev exists in
 checkstatus()
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Maia Xiao <t-maiaxiao@linux.microsoft.com>,
	bitbake-devel@lists.openembedded.org
Cc: Paul Eggleton <Paul.Eggleton@microsoft.com>
Date: Tue, 05 Jul 2022 22:27:38 +0100
In-Reply-To: <20220705174630.13360-1-t-maiaxiao@linux.microsoft.com>
References: <20220705174630.13360-1-t-maiaxiao@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 05 Jul 2022 21:27:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13800

On Tue, 2022-07-05 at 17:46 +0000, Maia Xiao wrote:
> Currently we only check that we can list the remote, but do not validate
> if the srcrev actually exists. Now we ensure that the rev exists by
> attempting to shallow clone it from the remote.
>=20
> Fixes [YOCTO #11199].
>=20
> Signed-off-by: Maia Xiao <t-maiaxiao@linux.microsoft.com>
> ---
>  lib/bb/fetch2/git.py  | 28 +++++++++++++++++++++++-----
>  lib/bb/tests/fetch.py | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 57 insertions(+), 5 deletions(-)
>=20
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 07b3d9a7..99780de8 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -832,8 +832,26 @@ class Git(FetchMethod):
>              return True, str(rev)
> =20
>      def checkstatus(self, fetch, ud, d):
> -        try:
> -            self._lsremote(ud, d, "")
> -            return True
> -        except bb.fetch2.FetchError:
> -            return False
> +        repourl =3D self._get_repo_url(ud)
> +        for name in ud.names:
> +            tmpdir =3D tempfile.mkdtemp()
> +            revision =3D ud.revisions[name]
> +
> +            try:
> +                # Initialise an empty git repo for shallow fetching
> +                runfetchcmd("%s init" % ud.basecmd, d, workdir=3Dtmpdir)
> +                runfetchcmd("%s remote add origin %s" %
> +                            (ud.basecmd, shlex.quote(repourl)),
> +                            d,
> +                            workdir=3Dtmpdir)
> +
> +                # Try to fetch only the specified srcrev
> +                runfetchcmd("%s fetch -f --progress --depth 1 origin %s"=
 %
> +                            (ud.basecmd, revision),
> +                            d,
> +                            workdir=3Dtmpdir)
> +            except bb.fetch2.FetchError:
> +                return False
> +            finally:
> +                bb.utils.remove(tmpdir, recurse=3DTrue)
> +        return True

This makes the git backend do something quite different from the
design. For instance the wget backend will only check that an http file
exists, it won't attempt to actually download it.

I'm therefore not convinced this is the right thing to make
checkstatus() do...

Cheers,

Richard

