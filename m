Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B21CC3ABC5
	for <webhook@archiver.kernel.org>; Wed, 14 May 2025 06:29:08 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web10.95707.1747204138602723261
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 May 2025 23:28:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=JCa17VQ4;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a1f5d2d91eso3663791f8f.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 13 May 2025 23:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1747204137; x=1747808937; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHxRBlWhwRQ2Xky8cyvthP+cazo+DuXuAUB/fuGQ0s8=;
        b=JCa17VQ47pkbTYAx0znpNX/9FzxajfpQ3jUlkEEqne7CSAzN3EzhnJQcm29Bz8mP1f
         Lrs14g5mwFqWR3kT4GLLEhoZcOJBmrzqKowor914fvFcys36+GZ0jMEu20uo+fbgzy2I
         4XA3RfxoBMFpGakdSKdPyglhdowYm37Xc8Vjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747204137; x=1747808937;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VHxRBlWhwRQ2Xky8cyvthP+cazo+DuXuAUB/fuGQ0s8=;
        b=wZ6hf54hLj/Av33mVAbGIkQtGbFfawCq+pJwAnxIqBvau6cN/e/tLOZxVptUFXwqcb
         foND8yb+6UJnO82WWiKBksf/jizYz0EgKV3YJvoAYzGPZwo9WD5WYknW5x/FCUYl7vJs
         5szwXMAU+pZfUefzKYxQmPzwvyuUEDH6+wRQOAjdbwuhq34URF5Hv9XQCSD9UiQzK27F
         L9vZTDhB5klsRSP+ZP62pcT/m3eWRygSpGKBMnJuI4J3A4v0HzD2VdrLFpJHrgST3WUZ
         uDibFes8QJ1nsd741P83REvhQ+NSvIfjErDSJi7WqnjNM9yWH/PV1kTH872GBy1mN4a+
         V4Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUSBcxeiUKf4NZMmNHI/Ge+WgEecXvqLVcLicD2f3Jg/16ZauhwtrwPadxEWeGXYn5+yVIeTITr2ImwnsCT@lists.openembedded.org
X-Gm-Message-State: AOJu0YyAmmPInOVVwZNWQTKcrusGm9UEeJBbFrjcsv7Yaan1JruwN4FF
	YIAzEkajl743E3exf17PEHp4R0IOg8lqjGnRTwLXcrXpM1oKxB+8KC/UA5xmCHk=
X-Gm-Gg: ASbGncuN6VbeqcXQdGGDfu6CrLer7eAoiX/0/Mpd2AfP6pY6TAokhijt7lfKjMCUGF5
	m0ai4PQrKh/mWnr8mFVsBuhhhDCDjD3a+N6A7fwEuNGx0cCDkfsC3X9cLX/P7xgvXH6XmP3L4gi
	igHqGdbOXV6Z/VstZPmqQy18j1uZ4IaX9ZmhE/dESlepsaRNNMI7Z57ByjGxusYQCLSS/7mDWlI
	iisSgO2RcetsZRXLVSkA9wtK1D5byJKvycFuM0tDbcpy4Bg73VsLiRNQFE+c7EQZQnwbYyGDTpC
	nZ+M9NT9GWnhhdyYMjy6q6mRly6l7/egOCmCk7ZyPUKzhsu7sOQuLcPm2aQ7ieol4fLc8/X46rv
	c3oBUR4lNsS7jjrtS7uA2a2d4N3Ebp3qY7+XIhOO4
X-Google-Smtp-Source: AGHT+IESk1S6VStKy8mZNmnoJcq/d+EtK837hZsKwyAVDP/+4tD3A32a50VsA+uG2Y7U0JH6A7JbAA==
X-Received: by 2002:a05:6000:118d:b0:3a3:4b8a:9a36 with SMTP id ffacd0b85a97d-3a34b8a9c04mr573118f8f.11.1747204136736;
        Tue, 13 May 2025 23:28:56 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:ac80:8bbf:3444:fa34? ([2001:8b0:aba:5f3c:ac80:8bbf:3444:fa34])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f482f1d6sm11567335e9.14.2025.05.13.23.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 23:28:55 -0700 (PDT)
Message-ID: <49e877afefd86763dc916c0f5f6445026986c752.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH] fetch2/git: fix shallow clone for tag
 containing slash
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Qi.Chen@windriver.com, bitbake-devel@lists.openembedded.org, 
	liezhi.yang@windriver.com
Date: Wed, 14 May 2025 07:28:53 +0100
In-Reply-To: <20250514050900.2096691-1-Qi.Chen@windriver.com>
References: <20250514050900.2096691-1-Qi.Chen@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 14 May 2025 06:29:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17606

On Wed, 2025-05-14 at 13:09 +0800, Chen Qi via lists.openembedded.org wrote=
:
> From: Chen Qi <Qi.Chen@windriver.com>
>=20
> If a tag contains slash, e.g., debian/5.22, then shallow clone
> fails because it's using a wrong ref.
>=20
> To reproduce the issue, add the following lines in local.conf:
>=20
> =C2=A0 BB_GIT_SHALLOW =3D "1"
> =C2=A0 BB_GENERATE_SHALLOW_TARBALLS =3D "1"
>=20
> And then run 'bitbake debianutils -c fetch'.
>=20
> What the original os.path.basename(ref) wanted to do is to remove
> the strings such as refs/heads/. So we do it explitly to fix this
> issue.
>=20
> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
> ---
> =C2=A0bitbake/lib/bb/fetch2/git.py | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
> index 11cda2007d..784a45bda2 100644
> --- a/bitbake/lib/bb/fetch2/git.py
> +++ b/bitbake/lib/bb/fetch2/git.py
> @@ -639,7 +639,7 @@ class Git(FetchMethod):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 extra_refs.append(r)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for ref in extra_refs:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ref_f=
etch =3D os.path.basename(ref)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ref_f=
etch =3D ref.replace('refs/heads/', '').replace('refs/remotes/origin/', '')=
.replace('refs/tags/', '')
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
runfetchcmd("%s fetch origin --depth 1 %s" % (ud.basecmd, ref_fetch), d, wo=
rkdir=3Ddest)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
revision =3D runfetchcmd("%s rev-parse FETCH_HEAD" % ud.basecmd, d, workdir=
=3Ddest)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
runfetchcmd("%s update-ref %s %s" % (ud.basecmd, ref, revision), d, workdir=
=3Ddest)
>=20

Thanks, I just saw a few people reporting this.

Would it be possible to add a test case to bitbake-selftest so we can
esure this doesn't regress in future?

Cheers,

Richard


