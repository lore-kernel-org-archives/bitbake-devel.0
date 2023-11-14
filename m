Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384DAC4332F
	for <webhook@archiver.kernel.org>; Tue, 14 Nov 2023 09:44:30 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web10.9358.1699955066361397531
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Nov 2023 01:44:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=bghnm0+w;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-32fb1c35fe0so3072467f8f.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 14 Nov 2023 01:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1699955064; x=1700559864; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4X5yWfsl2wZNwlyn08YzSijAc0JLT97ndTr7LFyInbY=;
        b=bghnm0+wYIkIrVkStm2J1zHvEcwM5dsAwCr0W/PRzF5qlIyzHEOeza9FdYu9vWioqt
         vFemUmepefFWl/3qA2Gxb7zwWdxMjsBnsNSlMdA97LgrYvhpWlRJtcIDkq5Gf8M3mWoh
         xQoT6SDexgwEEdCDSMu9nbbcW2E+eYiJFhrBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699955064; x=1700559864;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4X5yWfsl2wZNwlyn08YzSijAc0JLT97ndTr7LFyInbY=;
        b=wk3N1R5VhDWC5+JZ6MGEC9lZaJvCvsaO1o8TTemIHNjt7UCe8OlY6zn+LKW5lf0u1M
         TAD+VPPFVxSmjiiSw9GJxmfIOe7QV8LuXRvLoGnwvvlqiclQThvgOQd6bilxAncZDNfO
         BXPVybGhVuEef9k57ibdiRy1OerWX5zC3qo29ZwJ1mOe3nU1fW/xKyNPriVbKWhjftsH
         j92G36e4zLEAkq7m954+096rIS8N3CKxgnoqG7vyT2kACTgzyFRcYkUpwS55XiqUR54T
         gsJWaB494Iq1StdYYeC1h2+pOuKtfL4VogW2a/rjmd0GPCEPpsgjuje3sr4bJeSy1Lb8
         /iUw==
X-Gm-Message-State: AOJu0YxUvmF5PHmPLdV8NQJ4W+AEJjvNLXcqGnw5A0ZGtqY9DlAD7GtK
	sZsfWiCs6vGYY0275YEPb8+1tw==
X-Google-Smtp-Source: AGHT+IF7sRIjcTLl+i2pWA12k1yaLDSOXJd9d3QuohywP2hued05+fFzLurzPsP3PS79WzIzLLMh3A==
X-Received: by 2002:a05:6000:1818:b0:32d:81b5:82d0 with SMTP id m24-20020a056000181800b0032d81b582d0mr5809861wrh.33.1699955064477;
        Tue, 14 Nov 2023 01:44:24 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:c86b:91bb:bc1f:9d3f? ([2001:8b0:aba:5f3c:c86b:91bb:bc1f:9d3f])
        by smtp.gmail.com with ESMTPSA id i1-20020adffc01000000b0032f7f4089b7sm7361467wrr.43.2023.11.14.01.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 01:44:24 -0800 (PST)
Message-ID: <6323b545ad2bf3419acf78d58720c41bc8f5cdf0.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 1/6] Toaster: Write UI TestCase ->
 Visualize all builds
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alassane Yattara <alassane.yattara@savoirfairelinux.com>, 
	bitbake-devel@lists.openembedded.org
Date: Tue, 14 Nov 2023 09:44:23 +0000
In-Reply-To: <20231110172620.396838-1-alassane.yattara@savoirfairelinux.com>
References: <20231110172620.396838-1-alassane.yattara@savoirfairelinux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 Nov 2023 09:44:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15519

Hi Alassane,

For this series, the patches themselves look ok but the commit messages
still needs improvement.

To show why, have a look at this view:

https://git.openembedded.org/bitbake-contrib/log/?h=3Dabelloni/master-next-=
success

I see:

	Toaster: Toaster: Write UI TestCase -> Visualize all builds
	Toaster: Toaster: Write UI TestCase -> Visualize all builds
	Toaster: Write UI TestCase -> Visualize all builds
	Toaster: Write UI TestCase -> Visualize all builds
	Toaster: Write UI TestCase -> Visualize all builds
	Toaster: Write UI TestCase -> Visualize all builds

and the issue is that the detail is buried in the main body of the
commit message. I can tell they're toaster tests but that is it, I
can't tell the difference between those commits. If instead you change
the shortlog, you could have a more useful and specific summary like:

	toaster/tests: Add no builds message test
	toaster/tests: Add test for build by recipe name search box=20

which is then more meaningful. These messages go on to end up in things
like our release logs so they are important.

Could you resend please with the shortlog/subject tweaked please?

Cheers,

Richard

On Fri, 2023-11-10 at 18:26 +0100, Alassane Yattara wrote:
> Test a message is shown when there are no build in all builds page
>=20
> Signed-off-by: Alassane Yattara <alassane.yattara@savoirfairelinux.com>
> ---
>  lib/toaster/tests/browser/test_sample.py | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/lib/toaster/tests/browser/test_sample.py b/lib/toaster/tests=
/browser/test_sample.py
> index b0067c21..73973778 100644
> --- a/lib/toaster/tests/browser/test_sample.py
> +++ b/lib/toaster/tests/browser/test_sample.py
> @@ -27,3 +27,12 @@ class TestSample(SeleniumTestCase):
>          self.get(url)
>          brand_link =3D self.find('.toaster-navbar-brand a.brand')
>          self.assertEqual(brand_link.text.strip(), 'Toaster')
> +
> +    def test_no_builds_message(self):
> +        """ Test that a message is shown when there are no builds """
> +        url =3D reverse('all-builds')
> +        self.get(url)
> +        div_msg =3D self.find('#empty-state-allbuildstable .alert-info')
> +
> +        msg =3D 'Sorry - no data found'
> +        self.assertEqual(div_msg.text, msg)
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15506): https://lists.openembedded.org/g/bitbake-deve=
l/message/15506
> Mute This Topic: https://lists.openembedded.org/mt/102511272/1686473
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [richar=
d.purdie@linuxfoundation.org]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20


