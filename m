Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F55C61DA4
	for <webhook@archiver.kernel.org>; Wed, 22 Feb 2023 12:03:16 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web11.6972.1677067387683746066
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Feb 2023 04:03:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=I4ISTLeT;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id o4so7485459wrs.4
        for <bitbake-devel@lists.openembedded.org>; Wed, 22 Feb 2023 04:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lW6E+mE7vxZcvWrVKhbKj0Fe3GdAf3zRTYTKkAZfl2M=;
        b=I4ISTLeTES1H9AWL8tA7TW1PC8SKsDD6Ecv42aSiOqUvxFp1P1bXrfWmcS5JHM5Rkt
         QWJniMZpYBeH3kIsRWKliYW2TG4h2QyvZMqt2Te6AA938FQD948SIzFBhjPk2UYFarrh
         f4Y0VrgoIkJT4CJV9PqOcZsZXMEGIkbZM7Up4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lW6E+mE7vxZcvWrVKhbKj0Fe3GdAf3zRTYTKkAZfl2M=;
        b=bAG3ddDKCXGhgccMyK6P5qhte0GTpQSkdufMLe8zg+L7NMj4aNiS4FSBY1oPPQ4aOU
         TUTnOYrE/qXSrTFwqcNFtU83uBHE15frK76JyUDGELLbDRBCL+VawX+A0limcKYDaZly
         tvuRCOgxP7b7Iur43RJjjazs9wjrrJmd4K42HljYLKjhwjxDiA23tbFwG1TYeqWw0pZY
         UfjLEvwEPdhMMEbC9cFVmvVsFZIs3BN2jF0DDnNVU1UfYBWVKXBcuk4QeA5v9tC8nfuc
         GaqaDZ22QAzkyRuhVU2HX6fVZq37AZXmlgFqxHhfkE3bYrxJULyL7DB9UeBx0M3ARZ4F
         NBdw==
X-Gm-Message-State: AO0yUKXUQP64PT3HuPz26k5p/66xImfUGstu1XaKKqtW/cUxIk1x51De
	FD6SX2YG2QLYYhTK6s0q8zgr7gDWYReY83iL
X-Google-Smtp-Source: AK7set/XRXE4MkopWo89m+KER5qkgEwqlELBMmFbBWOpqEZLoB/GGmmPBEZutOcM1o0qwKX6AgvDTQ==
X-Received: by 2002:a05:6000:18cc:b0:2c3:f00c:ebaa with SMTP id w12-20020a05600018cc00b002c3f00cebaamr7374494wrq.4.1677067386117;
        Wed, 22 Feb 2023 04:03:06 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:d5d1:6a95:9b62:17ab? ([2001:8b0:aba:5f3c:d5d1:6a95:9b62:17ab])
        by smtp.gmail.com with ESMTPSA id u16-20020a05600c441000b003e21638c0edsm7721126wmn.45.2023.02.22.04.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 04:03:05 -0800 (PST)
Message-ID: <7508e1a2be0154ba2357fe44e6d614428cbcb965.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 3/5] git: Remove is None check on
 _find_git_lfs
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paulo Neves <paulo@myneves.com>, bitbake-devel@lists.openembedded.org
Date: Wed, 22 Feb 2023 12:03:05 +0000
In-Reply-To: <20230217170009.58707-3-paulo@myneves.com>
References: <20230217170009.58707-1-paulo@myneves.com>
	 <20230217170009.58707-3-paulo@myneves.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 Feb 2023 12:03:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14476

On Fri, 2023-02-17 at 17:00 +0000, Paulo Neves wrote:
> shutil.which returns None when the argument is not found.
> As per documentation[1] None is evaluated to False and everything
> else is True, so it is safe to have _find_git_lfs just return
> the value of shutil.which
>=20
> [1] https://docs.python.org/3/library/stdtypes.html#truth-value-testing
>=20
> Signed-off-by: Paulo Neves <paulo@myneves.com>
> ---
>  lib/bb/fetch2/git.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 2e3d32515..a3f29d2b9 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -687,7 +687,7 @@ class Git(FetchMethod):
>          Return True if git-lfs can be found, False otherwise.
>          """
>          import shutil
> -        return shutil.which("git-lfs", path=3Dd.getVar('PATH')) is not N=
one
> +        return shutil.which("git-lfs", path=3Dd.getVar('PATH'))
>=20
>      def _get_repo_url(self, ud):
>          """

I don't agree with this change since currently the function does return
True/False as it says in the docstring but after your change, it
returns other things.

Yes, evaluating these in python will result in True/False and that is
safe but that isn't what it is documented to return.

Cheers,

Richard

