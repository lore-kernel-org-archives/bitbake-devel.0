Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F928E77170
	for <webhook@archiver.kernel.org>; Thu,  5 Dec 2024 17:06:34 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
 by mx.groups.io with SMTP id smtpd.web10.16996.1733418389367126452
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Dec 2024 09:06:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=RRSs9xON;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.167.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53e28cf55cdso483275e87.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 05 Dec 2024 09:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1733418387; x=1734023187; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nC87EM+2G43atNanqQZric8YW1F45/M9TB2DMUQN4FE=;
        b=RRSs9xONIfcBVBSZw/nRH1+sYjQqNOQFv23OpuqBjol+8aEB4D3HQJOHDCyEJ9EGL1
         V6KhFA0mQDqIRc4GE/B0hkkpnWAqHTuERniaStYxqkRrbotMUtcLNn2D9g0NWKcJfVfs
         2SRrcBWDA8ti8y8nwP1yAIz3lYJigivTCfR5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733418387; x=1734023187;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nC87EM+2G43atNanqQZric8YW1F45/M9TB2DMUQN4FE=;
        b=LZEAWaUtjnw8JW99uHXvsU+/+dfNi3bue/L3ISvuYANj7stJ9h1VwVKZHkBJWKKTPh
         D2utsEE4CjJ131vactHRbrXIFb14igE6SYgRKRXBevW0ssocjIk/Lym5XdncoMXy5iX8
         sj5WVGRU2JiKlmdcrvZ/QFtfvps70K0HGFKCeRDCEA6XBm6o4csLzftlQ2syLQrwlMuf
         ZWiARSOZfWpOsJQ+R2GN6mxM3ujX4XydDxcDef0JstiYlYlLeTZFGuoEWN8U97be9qhX
         KsCDgM32cQCd1wvwdTxApDcDlNkMHzFmoL8OZpv6bAZTIHqbH7OsX0OpMj7iTb26MZ5R
         fqeg==
X-Gm-Message-State: AOJu0YwCFNe1LHBP6Vc84F1YRr3s0+vr5G6YzG52J7LBJba/dgveHR3S
	8ovkmtWQzUiSjRDxEdbes0f1qZiMmo2HGPHhAnjfjz/NCFyQoqkZ+89rEIA+v+o=
X-Gm-Gg: ASbGncvsEppBQdnQIKDF7ij25tDAUbZeHKVCFX7+kaNAVtYK0Z/Tvlgo5nNU12Gpn4i
	ePYyxANKB2Yox1uZDmMBSx5lH3anmSGRZShIKvioMR0h2LWKZeKseBnDmQjoSpEm+v4KibgBIEV
	HRhef2hXeN2Ynqgt85MWxFjfGocWm+lKpleYTkkCFqxAuA3OVsoWLKlXWpu3btuFSJOjrJbS74a
	zYQNxT6YEwryEOl+y9z2bCYFAh2O7D8mSc0F/deYonV1Dv2KWi2TBFyrUDlrvbIxmjc74tRLDBL
	91FM6sUwByEIgUR9m/2EOOIZPGC1oTgRyGgVhYQ=
X-Google-Smtp-Source: AGHT+IHXUwC/4QE6lO2pcDiFj/Yh1lf0zK5dG3NrfsPclJfOaJX7/dDJ5U2hDrcC7oi529SvgGR/1g==
X-Received: by 2002:a05:6512:6c9:b0:53d:a8cd:4285 with SMTP id 2adb3069b0e04-53e12a2e8damr6837497e87.39.1733418387495;
        Thu, 05 Dec 2024 09:06:27 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:7d2d:8585:e7e1:10f7? ([2001:8b0:aba:5f3c:7d2d:8585:e7e1:10f7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da0dab9esm29423545e9.22.2024.12.05.09.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 09:06:26 -0800 (PST)
Message-ID: <879fd4f6acb6cd6ae5a95261ccc3bb50cbaf38d8.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v3 3/4] parse: add support for
 'addfragments' directive
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Thu, 05 Dec 2024 17:06:25 +0000
In-Reply-To: <CANNYZj93zQDL_3zOTATNgfh30_Y=SCkaKoqs4NNgHuaYH=-Q7g@mail.gmail.com>
References: <20241118162610.1423384-1-alex.kanavin@gmail.com>
	 <20241118162610.1423384-3-alex.kanavin@gmail.com>
	 <215a45a05eb2be50b71ad3c044334635239ff0e4.camel@linuxfoundation.org>
	 <CANNYZj8hDKYRQ3cCLQGb0ddch3Q4stYyx=o15uF9ohSs8Bh1DA@mail.gmail.com>
	 <70cd6dd736551401d88185c060ee45fcc3d02819.camel@linuxfoundation.org>
	 <CANNYZj93zQDL_3zOTATNgfh30_Y=SCkaKoqs4NNgHuaYH=-Q7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Dec 2024 17:06:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16883

On Thu, 2024-12-05 at 16:47 +0100, Alexander Kanavin wrote:
> On Thu, 5 Dec 2024 at 16:28, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
>=20
> > The patch is therefore probably ok but I am a bit worried about
> > this
> > potentially breaking in the future if someone else (or I!) miss the
> > subtly in the code.
>=20
> I still need to improve variable naming. I'll do that and send v2,
> but I'm not sure at the moment what can be done about this subtlety.

Probably a comment:

# No need to use mark_dependency since we would only match a fragment=C2=A0
# from a specific layer and there can only be a single layer with a=C2=A0
# given namespace.

Cheers,

Richard

