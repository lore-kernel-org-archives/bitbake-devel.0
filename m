Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF47D46966
	for <webhook@archiver.kernel.org>; Wed, 21 Jan 2026 18:44:33 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19104.1769021069750936598
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 21 Jan 2026 10:44:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=LtMalMGa;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-432755545fcso102619f8f.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 21 Jan 2026 10:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1769021068; x=1769625868; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOwSoo9eS9pbInYQSyBcIs2t3fwCseaM48+dpmGfJ4A=;
        b=LtMalMGaOddTgAQ5a6PQahylqFiEioQiXJd27GJAn7S1UA1R7k5nmUakmCZQit9xJu
         jBDXdQO/on0wExNn0kNq5DrzpAtxO9wIaabIbnOKcQpcF91Bms04L0qzbfPO3Ie/j51+
         dd5FMZQjPu9sV2fL0F7l+SdkNoPXW+qyeMxnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769021068; x=1769625868;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vOwSoo9eS9pbInYQSyBcIs2t3fwCseaM48+dpmGfJ4A=;
        b=JHaxXuHAtez0CNQ/zfSAlvyiOllw4LCBYiUM3SuEN5gdnUkgcgLnxmtxH252wkGD0u
         dwH4Nsqy760tbex+4mw9OsnfnJOX3o8gKg/CdHzFL+Ll8M6leXMnOm7TW4+qU7fIIa2C
         fwiIZ2+f8bDquzwymBBLQeyW/RBDjcWK3ciT2WcCZX7DBIay4fPGeo0ie+OHRmyYaiBX
         4UL6Kbc3A46/0L0TssX54/w9lToOL2qSLM9Bh+80TE3nnw1ZzIEfZ9enSOcm1POWzKD6
         phkuLHaT1lBiCEOFSgfolYyGcdcLQCvuBM4WzhoIw5AE+HPmKRC+PuxqVIJhbqGeAZMa
         NBqg==
X-Gm-Message-State: AOJu0Yx53I2xfWCqmpdv5SxmXAJygvc1g/kIUa1i+gH6KpEp1AB/c1F/
	YuKC6klKJskB4PfLew/PYQOstScCqPh4OYJRQcQ+etHmjbrffcCS4bIPmApoAov2euqin7ou6mG
	q0w+cbpY=
X-Gm-Gg: AZuq6aKPxzk38km6bTf+yoXs835taESojewzwSW9gHyE2lyiqluFGgdZtpOLD9aeN7d
	WvbnfUOUmkUQR+bONli3kKHlfleBFVdIRhvTyCA2B6hzyIPIlpY8jm1buYJf+ctPRQsba1R5ewu
	SxakmKYmZ/Cv8KJ+7SbK3hEQ+Yh8FqRBHqhsqgcXgrCWeaf8MGSIsWIV+1G8LWl5H8OkYOPBNlL
	QNZpYSws9q28UyGRWxLW3P+UOkhvGxhZ/h+oATwhbYqtXM84KkCXBGLD4bfGU6YqWP/xDs31Wok
	4wCexg4deymsaPCbYHbkzzHtPxb2IaBxEj5KleQDuqqDhX2gN0Aun5hQC+zOVXCpzwzyNphYxqo
	KCxZulmsMVzSxiqi6EUm2BW6uY7s3KVDo68G7BFNzDa3mVCkk9tjUnTNMHqOXEyQp9j99C7n0Tu
	51Ajd5xPmb5NljH9/PjsrtcnfNaY+L5KI+Q8KRRXfJq4eIu6ForTgoBQqSz3IjNz2t13ZSTt8Hc
	dJyWR20EOL1yA==
X-Received: by 2002:a05:6000:1786:b0:435:a370:2d71 with SMTP id ffacd0b85a97d-435a3702f47mr2963287f8f.33.1769021067251;
        Wed, 21 Jan 2026 10:44:27 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:b41a:7081:80dc:66f5? ([2001:8b0:aba:5f3c:b41a:7081:80dc:66f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569921dddsm39862242f8f.6.2026.01.21.10.44.26
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 10:44:26 -0800 (PST)
Message-ID: <80835073604216efd7372b2b019f3d4463f11e0e.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] fetch2/npm/npmsw: Disable npm and npmsw
 fetchers due to security concerns
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Jan 2026 18:44:25 +0000
In-Reply-To: <188CD19B4A7A27E1.3547823@lists.openembedded.org>
References: <188CD19B4A7A27E1.3547823@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1ubuntu0.1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 Jan 2026 18:44:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18840

On Wed, 2026-01-21 at 18:13 +0000, Richard Purdie via lists.openembedded.or=
g wrote:
> We've been made aware that are security issues within the npm/npmsw fetch=
ers.
> The issue is that the code accepts data like checksums from the upstream
> servers, rather than verifying it against local data from the recipes. Th=
is
> means the upstream servers could feed aritrary data into the build.
>=20
> There have been maintainance issues on these fetchers for a while and des=
pite
> asking in multiple forums, we've been unable to find anyone to help fix t=
he
> issues. Until that issue is resolved and we can be convinced the fetcher =
is
> secure and modelling best practices for reproduciblity (inc. mirroring), =
this
> patch disables the fetchers. This has been discussed and agreed by the OE=
 TSC.
>=20
> Parsing will not show errors but the recipes using these fetchers will no=
t be
> available. Recipes will be skipped at parsing amd will show an error if a=
 user
> tries to build a recipe using them.
>=20
> [YOCTO #16105]
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
> =C2=A0lib/bb/fetch2/npm.py=C2=A0=C2=A0 | 5 ++++-
> =C2=A0lib/bb/fetch2/npmsw.py | 4 ++++
> =C2=A02 files changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
> index e469d667687..15057da7d3f 100644
> --- a/lib/bb/fetch2/npm.py
> +++ b/lib/bb/fetch2/npm.py
> @@ -39,6 +39,7 @@ from bb.fetch2 import URI
> =C2=A0from bb.fetch2 import check_network_access
> =C2=A0from bb.fetch2 import runfetchcmd
> =C2=A0from bb.utils import is_semver
> +from bb.parse import SkipRecipe
> =C2=A0
> =C2=A0def npm_package(package):
> =C2=A0=C2=A0=C2=A0=C2=A0 """Convert the npm package name to remove unsupp=
orted character"""
> @@ -150,7 +151,9 @@ class Npm(FetchMethod):
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 def supports(self, ud, d):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """Check if a given url =
can be fetched with npm"""
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ud.type in ["npm"]
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #return ud.type in ["npm"]
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ud.type in ["npm"]:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise=
 SkipRecipe("The npm fetcher has been disabled due to security issues and t=
here is maintainer to address them")

I will fix this to say "there is no maintainer to address them" on both
messages.

Cheers,

Richard

