Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E627E7718B
	for <webhook@archiver.kernel.org>; Mon, 23 Dec 2024 09:56:43 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.11013.1734947792767380586
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 23 Dec 2024 01:56:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=I1y8PD/8;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-436249df846so27004665e9.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 23 Dec 2024 01:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1734947791; x=1735552591; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GCH1xyl3YbZhr/f8kiDGJxn8wNaBgiaa6YMKS+soQIc=;
        b=I1y8PD/82pElrvHv1r0HSo3ZQ0so8HdhOmp6SWEXkjg8w+AiLPxviPAfkbKpK80xcJ
         Nu6MGB+YnLB1a3XpSlTjbVnw8/2osMSoSuQzNH+QGCcaJuO5A2XCm6dTgk1IWaLA/AlT
         urZ8f5zBeD7acXBYuiURn3h0Ycpg0WJ1YqbGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734947791; x=1735552591;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GCH1xyl3YbZhr/f8kiDGJxn8wNaBgiaa6YMKS+soQIc=;
        b=ZzSEnivthF1n8YsSOi2HEf9tK3NWK3DJqw2R2P0E7bbHkveV9K/HhIGEZPrV2a38wG
         jdDgJMQULaU8IJ4TbaOBzK4ujGq/GPoKmrHkPF+IXCp3NtxaFekR4h4Tydn4TpJdYtwG
         Kh65eGkXiLNjsUHL1Qd39GMHThHmHAf7GDrEnkvsmvvRxmNsalaJbXlTXeCgSfTW+Epk
         gHAznA8BoBfm54IL/lhUUb58Nf5xCzrTtvqA9C45/7ESkFAy2PK4sLL+BoXqo8vnZeIK
         CwITxOYKYDcc52PhmF1xB8VwuNH8PSwGKGMdrwQLZckGWP8+rDNKP3hrVtm0vZKID5zx
         DWaQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0085OdWCm2hvvcx8OYZPyonQl5rXeYVoY0j35fKm2CjCuvCkQGnPMkjx602i2LTZDaywGG4Hk6t2LpkLi@lists.openembedded.org
X-Gm-Message-State: AOJu0Yz/GtXtY8CWMR87IQWRBV3+0GOHHiU2HCrpT1BSCnEMoGt3NKOc
	yKF/pAzwRoJa22158cMZBEbPXzUjl/3fYLkGSA/coJBC8l7hrWL1J/YrIYjecxY=
X-Gm-Gg: ASbGncsjcGBVXC+EJ2VGMdzsuknHBDUa2cghsx9HNA8W8I0pPBM91WY9iB4F8CPEQWx
	Jte3kR9zvnxeiqhHZ6BRebtUroWTUTXQ0HXWh12Y6Faw9DsMHsEG2bufcKVCkJdaIcupfHcsf5j
	MBsbSiuJh6UusOsllQIdSbES6/Nb9YaPlxwQYatqBe2KopjWZnWqsfEy6TdzXNWXLDS0K5Lql8X
	A6b8asQXccmMRLV0fkNc+xN4B6ILy6fnTezGKhqF7L4RabBy9NDf7eKCaJXBndnvjuFE64WPCnP
	OaaTtJ4dxiN3kJucz2BUVuP9r0KkpFREbVWlQVYBwV0RxQ==
X-Google-Smtp-Source: AGHT+IFc4wkzeoM7ANXkxZF1qouwz7GwLstighWi6imPmOZaQPAK7MjEjTb9LQoFcCRfIPqZiljyIw==
X-Received: by 2002:a05:600c:150c:b0:431:5aea:95f with SMTP id 5b1f17b1804b1-4366a0cf7e7mr105215385e9.16.1734947791160;
        Mon, 23 Dec 2024 01:56:31 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:6ed5:9162:4947:2803? ([2001:8b0:aba:5f3c:6ed5:9162:4947:2803])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c832c45sm10871549f8f.32.2024.12.23.01.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 01:56:30 -0800 (PST)
Message-ID: <c855bfdf35f81072ded4863673930dbc8aa622fc.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [RFC PATCH 09/21] fetch2: add destdir to
 FetchData
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: stefan.herbrechtsmeier-oss@weidmueller.com, 
	bitbake-devel@lists.openembedded.org
Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Date: Mon, 23 Dec 2024 09:56:28 +0000
In-Reply-To: <20241220112613.22647-10-stefan.herbrechtsmeier-oss@weidmueller.com>
References: 
	<20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
	 <20241220112613.22647-10-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 23 Dec 2024 09:56:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16943

On Fri, 2024-12-20 at 12:26 +0100, Stefan Herbrechtsmeier via lists.openemb=
edded.org wrote:
> From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
>=20
> Add a `destdir` variable to the `FetchData` class to record destination
> directory of unpack method. Users of the `FetchData` class can use the
> directory to unpack additional content into the directory. The git
> fetcher class already records the destination directory in `destdir`
> class variable of `FetchData`.
>=20
> Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller=
.com>
> ---
>=20
> =C2=A0lib/bb/fetch2/__init__.py | 3 +++
> =C2=A01 file changed, 3 insertions(+)

Where/how is this being used/needed?

unpackdir is only used during the do_unpack task and we've deliberately
kept this out of FetchFata since in general it is meant to be
independent of the target location.

Cheers,

Richard

