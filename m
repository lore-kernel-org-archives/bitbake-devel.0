Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CB1E7718B
	for <webhook@archiver.kernel.org>; Mon, 23 Dec 2024 11:56:54 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web11.12092.1734955005702849789
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 23 Dec 2024 03:56:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=P2/Kft58;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-436202dd730so29722415e9.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 23 Dec 2024 03:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1734955004; x=1735559804; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h2vJYtAueCT+JGewx9gqLBPSLo4FET+hDZywawSLjYI=;
        b=P2/Kft585ubjCS+PeHXFR6Zlar+WbzWZCCxuXm4gkigdk5O6AakH0A2u3Q/IL6TkEc
         W0bLJg9H8kMfMff/ms98PY2TS3ZMWjjtnscvVAjznAD7qL57ERjmmYMLoK1S21drFjgD
         w4sDezQMlw4w4Aw+Q5ys+/LTWE02u45zOmZ4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734955004; x=1735559804;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h2vJYtAueCT+JGewx9gqLBPSLo4FET+hDZywawSLjYI=;
        b=CruDjwQ1CBLMpSKtm2lBfe/kKFvixEXbz5mDSdO4BMrb2I5s11KhHoKvkGDAe36M8n
         6YFMI4ZTS9j1tM8gyxAE2JegLTiYQRF1r+DZyJtNNWJaVTqOpmxTNcJ59i23TcIrOqKn
         rr9o0m6e09GcuDt8suBAZtsM+Nl4Z0aZdE7r2WeqY+IPJ+B3/WmzwzNHcb+AQMfPK5rd
         QXXpw2Sb0ZGidEoISBnyH/bzmdWtWokFzC9UG8U4KaAHPIL+5hxlsUepfCuk5b21/13b
         fq7J57QBwfQ3opHIpqhNIf+M6K5Crom7bKRwzVyjhxb2/b5qun1PjMNDCNByEcMWyT3+
         lF1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXkFAoL35hPxiwKQdJNY+oDXvl1kaHfB9KSxoasSJGNfYVVGDDPelbNSav7qaU4L31+VxsXd6ub7fW1UYhe@lists.openembedded.org
X-Gm-Message-State: AOJu0YwJvDE67m/LtUaHEAW3SlY3jD6x01EeIGzm496PlOpZLuggxRPk
	UFYmtvS3kW/P8Uw34KeJ1Wy2Lg5Ew4EF5kdAi/tvJgYtRLa4iyJ17NINbWzgZHg=
X-Gm-Gg: ASbGncs/yguuNaCVh1EQGIGdFNti45AGbOH8USiEfgLxRw3Z4cliFydgqLXbhXLd9SH
	vZ6b6kTAvJS0+kHnmn/hkBn1+80OOqdbxRKjGmbnesU2xGw5avDCSBoz8O8aT3cHU/5c901B0cm
	H0OZRHFyNOpxL6gyRByXJ+8CTBlT9qgPEzrFNc4WqegD1zHLDCpglnAPL7m/SAPKiqh0hR6Mqv1
	rGfj77xdsRpY/P4+zphEquV/ZEmO86znfcfbiVvykaN9X3RohE7I0lCqRVINwKtpZiWFUKfOjzF
	moCVLJfC72KVYrFrSiKx082uZSqqdXHQzX1VOM9wZg3iAg==
X-Google-Smtp-Source: AGHT+IG5i7UoZ17nYBpAxa+n1Ir7ZFpvJNVrK4dJ4qdarHEGgP8X4yczAEHO9ccL143V29rGroz7FA==
X-Received: by 2002:a5d:648d:0:b0:388:da10:ff13 with SMTP id ffacd0b85a97d-38a221eaf55mr12431547f8f.21.1734955003893;
        Mon, 23 Dec 2024 03:56:43 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:6ed5:9162:4947:2803? ([2001:8b0:aba:5f3c:6ed5:9162:4947:2803])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e1acsm11241935f8f.68.2024.12.23.03.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 03:56:43 -0800 (PST)
Message-ID: <f9b92d30b08d5177de4941bc31c17add5ee2f8f4.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [RFC PATCH 07/21] fetch2: add unpack support
 for npm archives
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: stefan.herbrechtsmeier-oss@weidmueller.com, 
	bitbake-devel@lists.openembedded.org
Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Date: Mon, 23 Dec 2024 11:56:42 +0000
In-Reply-To: <20241220112613.22647-8-stefan.herbrechtsmeier-oss@weidmueller.com>
References: 
	<20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
	 <20241220112613.22647-8-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 23 Dec 2024 11:56:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16946

On Fri, 2024-12-20 at 12:25 +0100, Stefan Herbrechtsmeier via lists.openemb=
edded.org wrote:
> From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
>=20
> Add unpack support for npm archives with unusual member ordering and
> disable warnings for unknown extended header keywords.
>=20
> Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller=
.com>
> ---
>=20
> =C2=A0lib/bb/fetch2/__init__.py | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index 4b7c01d6a..7d8f71b20 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -1535,6 +1535,7 @@ class FetchMethod(object):
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if unpack:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
tar_cmd =3D 'tar --extract --no-same-owner'
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tar_c=
md +=3D ' --delay-directory-restore --warning=3Dno-unknown-keyword'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if 'striplevel' in urldata.parm:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 tar_cmd +=3D ' --strip-components=3D%s' %=C2=A0 ur=
ldata.parm['striplevel']
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if file.endswith('.tar'):

I think I'd be happier if this option was only added for the npm fetcher...

Cheers,

Richard

