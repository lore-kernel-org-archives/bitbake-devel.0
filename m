Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0D8C433FE
	for <webhook@archiver.kernel.org>; Thu, 24 Nov 2022 15:13:51 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web11.26195.1669302826021806667
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 24 Nov 2022 07:13:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=FDjSkaJn;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f50.google.com with SMTP id q7so2001648wrr.8
        for <bitbake-devel@lists.openembedded.org>; Thu, 24 Nov 2022 07:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VRYRgrBgIfQGSzf4KP6Gxu2US5LHV7YLzIjHXBVRjmo=;
        b=FDjSkaJnKtnEpeJFsGhJlALs2c3iQXPhrqefs2U7c0BSgtflO7EZq2Qz0xwN8blLuX
         NzNTy1fq88zIS0idG1UmNJvqH/ec4sUePfeCF1nYDpCYFmlmuBrJU4eQDWJvKPfFcUpM
         04TihEGZlsb9s8ggYxeIpwcqhIupyh8sX3mW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VRYRgrBgIfQGSzf4KP6Gxu2US5LHV7YLzIjHXBVRjmo=;
        b=7Nsdzqgm8w5CSlA7rPt/jENZ0/YrC91GKna9FLeWVgXsGQD5Bk1JoiZlJWOTPCD5Y6
         H0kJUGBcFip2zzmSnFAc2pROtK7FIC3b76P1A/5rWzJ9LD4LFsFGhla0xAsmSVlHK2JL
         jRRrS4WLZzkfH4vLQZIvg50zJBd8/s/EO2Dbo6JpMfw2e/ayeWN3ITfI7q7mq7gH90FX
         g0az+pjl8GBdld/fVWsMyKarxNtkRutC/Ubg9HHpjjhyYnpbqhfH10SY2PLJ+MZyhZk7
         xsgyiN9S1EYEcfWWZ3CBgq9c3aoOWuykHyywyLMr1AuZUXDHn84k+pPD+axedrZYMT2R
         OgZQ==
X-Gm-Message-State: ANoB5pmRsaIRdmezvOwjr28zNYmiJZShgIMO/c6RZOVdijTnQj9H2l4Z
	0CKqgxGeZX/8gjrfu/luIBBjgQ==
X-Google-Smtp-Source: AA0mqf5lXlXcSbgV4uuyUYaTa5yGaXC4A6jEAI+jpnb8nGLQGwlcsU9xzfz6oF7kvGEGFahcyQbxiw==
X-Received: by 2002:adf:fe51:0:b0:22e:362e:570a with SMTP id m17-20020adffe51000000b0022e362e570amr19586685wrs.127.1669302824270;
        Thu, 24 Nov 2022 07:13:44 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:4038:3d32:5f00:5957? ([2001:8b0:aba:5f3c:4038:3d32:5f00:5957])
        by smtp.gmail.com with ESMTPSA id w5-20020adfde85000000b00241cbb7f15csm1535085wrl.106.2022.11.24.07.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 07:13:43 -0800 (PST)
Message-ID: <f6fdcf752a1f69c9712b2124755a9c5f24242645.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] command.py: cleanup
 bb.cache.parse_recipe
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Chen, Qi" <Qi.Chen@windriver.com>, 
	"bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Cc: "Yang, Liezhi" <Liezhi.Yang@windriver.com>
Date: Thu, 24 Nov 2022 15:13:42 +0000
In-Reply-To: <CO6PR11MB560282F9B2FC30CCCA5803D9ED0F9@CO6PR11MB5602.namprd11.prod.outlook.com>
References: <20221124091045.12018-1-Qi.Chen@windriver.com>
	 <089c8b5944101a3ec48844fc744d7b6fd1558931.camel@linuxfoundation.org>
	 <CO6PR11MB560282F9B2FC30CCCA5803D9ED0F9@CO6PR11MB5602.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 24 Nov 2022 15:13:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14108

Hi Qi,

On Thu, 2022-11-24 at 12:17 +0000, Chen, Qi wrote:
> I met the error on our layerindex.
>=20
> Error message is as below.
> NOTE: Starting bitbake server...
> ERROR: Unable to read /home/oelayer/layerindex/git___lxgit_wrs_com_layers=
_meta-arm/meta-arm/recipes-bsp/trusted
> -firmware-m/trusted-firmware-m_1.6.0.bb: Traceback (most recent call last=
):
>   File "/home/oelayer/layerindex/git___lxgit_wrs_com_bitbake/lib/bb/comma=
nd.py", line 90, in runCommand
>     result =3D command_method(self, commandline)
>   File "/home/oelayer/layerindex/git___lxgit_wrs_com_bitbake/lib/bb/comma=
nd.py", line 567, in parseRecipeFile
>     envdata =3D bb.cache.parse_recipe(config_data, fn, appendfiles, mc)['=
']
> AttributeError: module 'bb.cache' has no attribute 'parse_recipe'

Thanks.

I had a look at what could call parseRecipeFile(). I can see some
commented out code in layerindex but it doesn't pass a config_data. The
only other calls are from tinfoil's parse_recipe_file() function and
none of those I can see pass config_data either.

Can you see where the config_data is coming from?

It looks like we've broken this at least once before:

https://git.yoctoproject.org/poky/commit/bitbake/lib/bb/command.py?id=3D70e=
e928f8f4152f198f4db61517c958d54f1c0a7

so we really need to figure out what is using it and add a test to
ensure coverage. Is this some local customisation you have to
layerindex?

Cheers,

Richard


