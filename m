Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D41FE77188
	for <webhook@archiver.kernel.org>; Thu,  2 Jan 2025 14:07:29 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.8340.1735826844071209374
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 02 Jan 2025 06:07:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=WoFib9fX;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43690d4605dso41649685e9.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 02 Jan 2025 06:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1735826842; x=1736431642; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YlaqTokTyzHExNrJHPVj7WNn4sCQsetUc83A3YkcAZw=;
        b=WoFib9fXtUpLsfwrOumgM/0g9NI1c5zjUfzkXjmw3Q7ywdJrd2WfzGcxaFWN6lsddA
         1UYMrspiJiDhw06Z4sPs4CEV3RfrOvXBUJZYAMZldpd6+qqFwSaTM7bP8elJacSPnFuM
         nqGN6+VnJbU7U2ABtLuNBErai2o+Iqg02AHug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735826842; x=1736431642;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YlaqTokTyzHExNrJHPVj7WNn4sCQsetUc83A3YkcAZw=;
        b=YsR9NdEbSHIOk8rhKVXjMpDf6+fE6jJ4hT68x1HFaCPDH/xzXeNQyIjIeZ7ZdkPGjS
         SzuIIIG7TjdIiZZXbXMf5VrmbejeEVD0Wx+e6QfaTS6+SYh3AGiDfkaOdyNWNGb+Kxyg
         j5A4JKxjE6CZAhJksmUZwqdk+jSFtGlx8XlOU7GDcUCD+bHgLlxDzl85ZPP6BrnTBYlY
         menN2Isu+db1Kd/InruD5LAI0q40zgA9sZarRYOoUm9O9aZ0PIF9QZTuubLrR9uqsChR
         P7NaIaSEbOeh/HcaTGE/eN4FrWw5WTEKQaBfVi6liTyGEPOAbSuHnaUBHE5W6pKxdeeZ
         JvBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvWriIF8+K07IfxWjb/bP6GKZtvKlwt4+SfUxDflEdPk6mGoNvmfrf3ITIxeWu75uCKq5a3IPJpZ8JQs6s@lists.openembedded.org
X-Gm-Message-State: AOJu0YxF1GTXgiZTLhi8HP9/ZlFA8I5s+a8mkZOPMSFMnyalLWQom4gw
	OeESpVQnQF8iRZmokrA8JrwPpTuuTLS38PU75WtjaCnO+mPM9hK2dxUuBGJCwkA=
X-Gm-Gg: ASbGnctAecOX/bYUertYxcUX41wna32VSd0S3QTWejBOHmHIOVj+hj6maKwgcXtnjU0
	IYcM1IjqzW/orAmpWdS18Eh2IOkY2jNPlz/1zx/md3/1C9cpb+RKwPCh/bVllmLwQ51AJ+koHD3
	XsoltP/BpGF4vjgUFbmnKRQ8Tozdh+6YnYQwBD1jfDI/UT1dIzt97BPAP5jSv6JmMe+jNIB3HHT
	hboI9pPPwsfWneO0yDe5ney1WkNR9sfXjaoECV2VCFgQeasuBEJShzEKf/GfHEWqw9PPSpLiKCZ
	6sDAgL7+LLTL8cQ/izuNv9fqoCYPXBNv+vECnBRAIdZEUA==
X-Google-Smtp-Source: AGHT+IGbavxQmCd089GNrgNB76C7e+7Hk+MEHbvAE0pSGGADSZHSEYKCWWrdXDBnM9HIfMmwrmKyWA==
X-Received: by 2002:a5d:584d:0:b0:385:e0d6:fb73 with SMTP id ffacd0b85a97d-38a221fa9cdmr36988244f8f.15.1735826842492;
        Thu, 02 Jan 2025 06:07:22 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:ae2e:9f02:55c2:739d? ([2001:8b0:aba:5f3c:ae2e:9f02:55c2:739d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a412f778esm23637874f8f.4.2025.01.02.06.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 06:07:21 -0800 (PST)
Message-ID: <2ef6ab29f58822233bd2599b00d7b444852e828c.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [RFC PATCH 00/21] Concept for tightly coupled
 package manager (Node.js, Go, Rust)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>, 
	bitbake-devel@lists.openembedded.org
Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Date: Thu, 02 Jan 2025 14:07:20 +0000
In-Reply-To: <f5aaf9dc-6c1e-44c1-afce-33c6beac0290@weidmueller.com>
References: 
	<20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
	 <aeac8b24d43c57b7b426983ae50ec65680dafc24.camel@linuxfoundation.org>
	 <347682f4-d1ce-4f8b-9665-3a3490235d1e@weidmueller.com>
	 <7fcc6a2d93e0535c8c79c60ae302ca92e322fd4a.camel@linuxfoundation.org>
	 <f5aaf9dc-6c1e-44c1-afce-33c6beac0290@weidmueller.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 02 Jan 2025 14:07:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16961

On Thu, 2025-01-02 at 14:50 +0100, Stefan Herbrechtsmeier wrote:
> >=20
> > I'm trying to aid the review process by asking
> > those questions, it will just take longer if I have to work this
> > out
> > myself.
> > =C2=A0
> Maybe we are able to discuss some design decision without code to
> simplify the review:
>=20
> =C2=A0The dependency fetcher need to know the path of the dependency
> specification file. In case of the local fetcher the path is the uri.
> In case of the git fetcher the path depends on the subdir and
> destsuffix parameter. In case of the wget the path is unknown. This
> series requires the parameters=C2=A0striplevel=3D1 and subdir=3D${BP} to =
work.
> Additionally it doesn't support specification files inside sub
> directories. Therefore I plan to add a srcdir parameter. Should this
> parameter be mandatory for the wget fetcher or should the fetcher use
> the PN or S variable to determine a default value?

do_fetch never touches ${S}, it would only touch ${DL_DIR}. For that
reason, ${S} is passed as a parameter to do_unpack and is only
referenced at that time.=C2=A0

wget shouldn't need more information to have a default it already has
in the current code so something isn't adding up.

I'm still not sure why you'd need both a subdir and srcdir but I think
I need to think about this more deeply, FWIW I'm technically still on
vacation.

Cheers,

Richard



