Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEE8CCF9F5
	for <webhook@archiver.kernel.org>; Thu, 30 Oct 2025 09:39:25 +0000 (UTC)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
 by mx.groups.io with SMTP id smtpd.web11.22634.1761817161016673313
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Oct 2025 02:39:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=VVeNwtj7;
 spf=pass (domain: gmail.com, ip: 209.85.160.172, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ed06acf75dso18184691cf.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 30 Oct 2025 02:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761817160; x=1762421960; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SOeeiG/jYxF2C4brWsI8VTu9W4ly5ruxPDiiPCotNsE=;
        b=VVeNwtj7laI3kgn50VWooy57J6jpz7EfoK9H1EkVUaJwKCdATDesUjm1HxRJ2p9xTe
         s7bYwVf8q2yW8CdY7EKTZ6cii0E6Qo6NLaeZ5k8VHExharEddoorCY2YpucNyDZLF5OI
         onK3nCdW9LfsuXTsE2yLXcfgyaQWCPKKkZrI7qTuOfIwG6ji+s/UzvE68HCA08BIAMDO
         KJHOP7r4GAry8cN70u3D9p9ijriaMTsEfGHTr3g1vP7Hxvl3YeIEhGSwecvaQFTPhAcX
         M1TeZTnV/YJB7kpwqzHyGwQFsIZH9urTYjw6RdT2YSIzp9gPFwIdEaFinpXz+OPH2Dji
         IULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761817160; x=1762421960;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SOeeiG/jYxF2C4brWsI8VTu9W4ly5ruxPDiiPCotNsE=;
        b=dtRkPtTPE6DXHa36599wOm7pUlxi2pU00cRJW+RzXEWd32A+GLRPn858DtTd6o0cEc
         ZkZGpMtEJU1SX+KXSJ3gezLN6o2+5I9TiLTiG4JvfRxxmQonuhkHlN+k+tWx7bbbrd94
         mJFkwSjAlT3wD5nPInrlkRVCyXLpfGfH2QqRWJe8o1/wx3oFyoEfYLrLsSjhZbxSHe6d
         luS+re897XIotcj7ggvhIgK5G/eqEOQum9ZHWcM1LXEdHA/z/fTlWk4d+sr1mL4GJyP5
         +eAEEXZ2wwmzWlydfqmU4h6nrIFZpv0fAVAV6BstNIfFEhUggm3Ezrbv9pHcDwl13B2W
         0cEQ==
X-Gm-Message-State: AOJu0YxKu5BJJbPhOxlSh3EF1oGU0qD75BOlETJyVVZJOZirV9USgiaT
	mO0MxugRkO0v5oHWMw47gHeDh6e8V86DXQ0RVf+DVJKesaYSi81/FPsUujQ3ozB7WcYm0wXjySW
	lMKXQMkWFVfFI80GJKGIIxVFL07AVEL0=
X-Gm-Gg: ASbGncts6fqtQCF5SYQn4Annyg2WIRRRYJ8CnBuLsNhqatREtgfEW66oHDb/ckaTVuL
	NK7KgwElo9FxLDuwDOsnk29TegutLW5p3zzLhXITP6mG75HeqpL+QrIf44dY1nIW93fXfv5iiZZ
	JOxCM6++7LXBQ4OQh4H9tm3yYO2xcwo7tk06Cz5JubT1MGJpIc6GFre7MTjFfIWMZiY3RS20ufJ
	ZQWjXKZFBavP+Bk0NeWdrNh2PdYA0y8CkLHl5tpFoCJQVJx57MgehCstnOmP7Ntjhf2fGjfUHWQ
	GxZglLwUEd9f7dFLb3uhSIJ4rdMl1+v+c68Sxfrx11xMwGm12B//Vb/6X9QzYVTwPLg2qdbV/B1
	wq59Am3KPAZEaItHm+f2NV3PXvM0u
X-Google-Smtp-Source: AGHT+IGmWNLqaOztmhPVeyuiiFxI4GKZy/iytfRkFHjkrpwgF9//wCaBbMPJh7MgCPoGR5j41ybe/4LRLZfCqGMSiXk=
X-Received: by 2002:a05:622a:c9:b0:4e6:df3e:2abe with SMTP id
 d75a77b69052e-4ed217b7186mr34544131cf.9.1761817159951; Thu, 30 Oct 2025
 02:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <20251027181206.3798705-1-alex.kanavin@gmail.com> <cc2529069117bfeb9b66101c4227dc6ce3f3bb4d.camel@linuxfoundation.org>
In-Reply-To: <cc2529069117bfeb9b66101c4227dc6ce3f3bb4d.camel@linuxfoundation.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 30 Oct 2025 10:39:09 +0100
X-Gm-Features: AWmQ_bnYMexLpyClEICpFCDJIDL4Gf1h0p55dNhd0rVT2u0gsAsUJNJX9ooh9l0
Message-ID: <CANNYZj_pWWDZUPZHzCFTD9kohe2KqrjL29gm=087X99VK_rbyg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] parse: add bitbake version check via
 bitbake_min_version keyword
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org, 
	Alexander Kanavin <alex@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 30 Oct 2025 09:39:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18225

On Wed, 29 Oct 2025 at 18:26, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> Why not just allow a BB_MINVERSION variable in layer.conf which we
> check? Do we really need a special new syntax just for this which then
> has to be documented?

We don't, I'm just unsure where to perform the check. I'm somewhat
reluctant to insert a special case like this into DataSmart's
setVar(), even though that would ensure the check is peformed as soon
as possible.

Alex

