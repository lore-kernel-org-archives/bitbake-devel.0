Return-Path: <osama.abdelkader@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0ED8CFD34C
	for <webhook@archiver.kernel.org>; Mon, 24 Nov 2025 18:49:09 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24381.1764010144724041786
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 24 Nov 2025 10:49:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BcYip8sB;
 spf=pass (domain: gmail.com, ip: 209.85.128.53, mailfrom: osama.abdelkader@gmail.com)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477632d9326so28438435e9.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 24 Nov 2025 10:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764010143; x=1764614943; darn=lists.openembedded.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B6K/GbYqPB2IVTgKOaD4q0Mec2xSanTW2i+MuG18MUI=;
        b=BcYip8sBPJWww4sVNnXVHh7nk3FA6ghRSzB4PEsWchHRuJ+H64Ws1tEgNQWZ09S4E+
         eadP657I8Cd/v2bxCuiSDVDbHQrRP2J42lUy8M2LJv+pP+IqrXmO6RJ/miXiIF+dLHpQ
         WxSGl+f2lfnVaXWHWfy+zodBR8bOKTbTmHcKoyVwYZsLYjJuQ+fDXyoP5C04bMeGb2RX
         BZgmqJRZhd3kkxTm1LVLLLH9vbjfiZP1vPlMMP7+BrCAk5AVI5JTI0O4ZF1qvHSa18ti
         O8BE09KJCgS79p202WDG4v08D/NB9FUHYbRDl3XitBOlCkYI1XFBYxzrGTjIjRwWVLGx
         KQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764010143; x=1764614943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B6K/GbYqPB2IVTgKOaD4q0Mec2xSanTW2i+MuG18MUI=;
        b=aNZtz3bY6eYe9KmHO8bSw+19PaYuSmTdu2XbUtVBdLAfNUZ3GvwXpsJCYnUkCEKkAo
         6y4vnXJ3XSqqdFK4vNTePo4bY/iYfjnUtC7iq9v5Ot8xJL2NoankAI/FBL58ZTdF87cR
         vmZ7uvXWfFYxedvGmNz6szYZngw13Od7sAPFOlht57djAFE03L/QqZvM3V0p9g90fN+/
         mPNJS9+8SZ+GEtFhL0kf0NZGEdIyKALqzVH94wr3fgUhhvwfptoB6mCiR8cBiHdgxoZG
         mGZVNdH9MYcaviINlJM/qJiXLDk4zGXdyrgWiiJZouW7OKyRrcheT7Y7BJ2AbfLePoxF
         0Ftw==
X-Gm-Message-State: AOJu0YwVaUEX27E1cdPoCq0ukU7u69ExZ7bYwkpCLhEL0A1UJ0nt3r22
	YY9QUBiExaJEK82+CzDpiu5O0soXrtmH8vaVT0eOy2a/RpR8V28Q1GhHUZMPWXvr
X-Gm-Gg: ASbGncsROLSvBgcMRM4NIf2NP8QL0Ymb+uyWTEChRAWsigi0A1ajSgtWjjlND23QjgN
	s7JDaqTey5cqpRIMcoF0aVRvpyY2Ae8XHomJdJthePczc9/Djs0yz7HOZKU3nITvkcz8mkvPq+Z
	5VkE0hZT1a6iQd1FpFOX0+apzZk4qtgyOcOHEoxFlVdlpPc7QBOnvcS86KqzdWbETZ6PpyTQpHr
	lSm9vuuB8I3j8wLIR+P1tnPybYFNsujZVGTuNPbthYGiqVlX7hp4Cc5/hVeC9lONgmVc0lkUwDC
	gytuN3l9Q219cVI/hPlpXVyGe+dKT+yYdfbrJsP1P88LUXT4/JHmMUlfZhw0N3zqhMMkvkEj25d
	yfqttEBROM6y6AHkgpKN/deg8BE5LBRpPwWDcUdSF/2+zs8ieXD8guWGEtTsfgCMatZSH9HMyOF
	ijUfy4+EYj8P5l
X-Google-Smtp-Source: AGHT+IHbmvbHgN3HC6kFKRd3//q4sOJcaF/nShMJWhQ0Cls/B5JeJppp+3w2dF9lbUIrK/jHj39xqQ==
X-Received: by 2002:a05:600c:1d1d:b0:477:7a87:48d1 with SMTP id 5b1f17b1804b1-477c01ff5bbmr151485325e9.30.1764010142684;
        Mon, 24 Nov 2025 10:49:02 -0800 (PST)
Received: from osama ([156.223.112.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47903c6c4a6sm1179645e9.1.2025.11.24.10.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 10:49:02 -0800 (PST)
Date: Mon, 24 Nov 2025 20:48:59 +0200
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: bitbake-devel@lists.openembedded.org, yocto@lists.yoctoproject.org
Subject: Re: [bitbake-devel] [RFC] Proposal: New tool to display recipe
 dependency trees
Message-ID: <aSSom6zUzX4X4Xmd@osama>
References: <aSSUtHYFQlychNQk@osama>
 <CANNYZj85vK7o4KVDUtJ_DkW73bxs7UMA-bM6K2VRada-yCFpfA@mail.gmail.com>
 <dd843658-cf46-4858-bb0d-fc78fc25e894@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd843658-cf46-4858-bb0d-fc78fc25e894@cherry.de>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 24 Nov 2025 18:49:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18484

On Mon, Nov 24, 2025 at 07:20:52PM +0100, Quentin Schulz wrote:
> Hi Osama,
> 
> On 11/24/25 7:04 PM, Alexander Kanavin via lists.openembedded.org wrote:
> > On Mon, 24 Nov 2025 at 18:24, Osama Abdelkader via
> > lists.openembedded.org
> > <osama.abdelkader=gmail.com@lists.openembedded.org> wrote:
> > > Should the tool:
> > > 
> > > cover only DEPENDS (build-time)?
> > > include RDEPENDS with pkgdata?
> > > resolve virtual/ providers?
> > > 
> > > Any prior work I may have missed?
> > > 
> > > If the idea is acceptable, I will prepare a proper implementation and send a patchset to the appropriate mailing list.
> > > Thank you for your feedback!
> > 
> > Hello Osama,
> > 
> > DEPENDS is a somewhat unfortunate variable name that we're stuck with.
> > 
> > It does not actually specify a recipe dependency, it specifies
> > something more specific:
> > 
> > - run A.do_populate_sysroot before B.do_prepare_recipe_sysroot (a task
> > dependency)
> > - within B.do_prepare_recipe_sysroot task, take the output that
> > A.do_populate_sysroot produced and place that into B's sysroot (a hint
> > for sysroot creation)
> > 
> > So I feel that any tool that aims to make things easier should
> > continue to present particular tasks; there's really no such thing as
> > 'recipe-level dependency'.
> > 
> > In addition to that RDEPENDS is not specifying recipes. It is
> > specifying packages that the recipes produce (which sometimes match
> > the recipe names, but are otherwise distinct). You really should not
> > mix them together.
> > 
> 
> In addition to what Alex said, you also have RRECOMMENDS, PACKAGECONFIG,
> anonymous python functions, dynamic packaging, etc. that allow to specify
> build or runtime dependencies outside of the more common DEPENDS/RDEPENDS,
> so you'd need to interface with the internals of bitbake and not simply
> checking those variables.
> 
> Finally, there are other ways to do dependencies than those variables, as
> highlighted by Alex already. DEPENDS does A.do_populate_sysroot before
> B.do_prepare_recipe_sysroot, but you also have other ways to have
> dependencies, see the u-boot recipe for Rockchip boards here https://git.yoctoproject.org/meta-rockchip/tree/recipes-bsp/u-boot/u-boot-rockchip.inc.
> We depend on 1+ binary (TF-A/BL31 and OP-TEE OS/BL32) that needs to be
> available in the deploy directory before building the u-boot recipe.
> 
> Cheers,
> Quentin

Hi Quentin,

Yes, that needs to be taken into consideration too. IMHO, we need to know if 
such tool/sub-command would be helpful, or we can enhance bitbake -g, or something else
and we can go further with the details.

Thanks.

BR,
Osama

