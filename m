Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2A2C61DA4
	for <webhook@archiver.kernel.org>; Fri, 24 Feb 2023 13:41:20 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web11.17543.1677246076937656821
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Feb 2023 05:41:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ig1pYsnM;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id bt28so7291339wrb.8
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 Feb 2023 05:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PpDTV7nyatgEunei0SW1KCBiDfi1VbfMfnr+PA/HJ4E=;
        b=ig1pYsnMTncT2ceLfcV1MszfeaflSdRVoNxKXQmXzckUhrUcO62bvWU2DdrKLJTIrP
         MsKr+PXMnJH7T0dgIJvbwymWNcesXFPxalxQ5ODrcUbXC4CMt9tMLavSw4cnry75ng6t
         s8WaX8yg9K6kxEoSMaVBfdjPMLVGNJV8KLCRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PpDTV7nyatgEunei0SW1KCBiDfi1VbfMfnr+PA/HJ4E=;
        b=yPM0XwNi1eHDlJPPjKpSLiMvKN9Gp/3deHEWrmDn/nenagX8NyT218THCE8SYugaER
         cV8HKVk7JCpIu4mp1EUODGMkrUqYGqTv84NvWJ5GqkwueA48Qhse4+imLNtUWmzpy7qy
         9tk5lz71tfKEyLRsOgYaYVdxaEW4w3J03m6ZSpo9uo4qUzEtvNHa/ZutId4nvIKNAR4N
         vgP8kusQtto1QF2YuI7mv7bXkagJv+IQ0Ms0vo9dC9jwYrXEhguj04vdljXJIGUKQvh7
         hk1l1dxOW3B49Tfgg6iyJp86+P+vWlOPLPa6L0WVZhIlkUaqqND+ZzvcDf3JvXJgz2Oa
         WSpw==
X-Gm-Message-State: AO0yUKV+oA9pxjs487BJiILukdGURrV3YByiwSLgJ7SWPcNmQ4dfYtwz
	7WiX2HGer4/kcBocLBI2dREO6Q==
X-Google-Smtp-Source: AK7set8mHdpcdKhA5ynOadHoOiqJhFodTkCiZ1DXBpdWshiyqmgiN5qZUexaEhwo0+VQLRJGD5PlUA==
X-Received: by 2002:a05:6000:1007:b0:2c3:da8a:192 with SMTP id a7-20020a056000100700b002c3da8a0192mr12730006wrx.15.1677246075209;
        Fri, 24 Feb 2023 05:41:15 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:639b:9979:fd5f:bbb7? ([2001:8b0:aba:5f3c:639b:9979:fd5f:bbb7])
        by smtp.gmail.com with ESMTPSA id u11-20020adfdb8b000000b002c54fb024b2sm17108090wri.61.2023.02.24.05.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 05:41:14 -0800 (PST)
Message-ID: <dc9bfbf315b36243781e012ac8117fb8acd59711.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Bitbake repo using the same tag name as branch
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Martin Jansa <Martin.Jansa@gmail.com>, bitbake-devel
 <bitbake-devel@lists.openembedded.org>, Lee Chee Yang
 <chee.yang.lee@intel.com>
Cc: Michael Halstead <mhalstead@linuxfoundation.org>
Date: Fri, 24 Feb 2023 13:41:14 +0000
In-Reply-To: <CA+chaQcSZDgrbeZjOU+THvNTrQt+VzCUGg3p1FMVG9qiP4QDAw@mail.gmail.com>
References: 
	<CA+chaQcSZDgrbeZjOU+THvNTrQt+VzCUGg3p1FMVG9qiP4QDAw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 Feb 2023 13:41:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14486

On Fri, 2023-02-24 at 12:09 +0100, Martin Jansa wrote:
> Is there some reason why bitbake started to use tag name identical as
> branch name from 2.0?
>=20
> It happens only with 2.0 and 2.2, because previous 1.52 branch had
> first release named 1.52.0 not 1.52:
> commit c78ebac71ec976fdf27ea24767057882870f5c60 (tag: yocto-3.4, tag:
> 2021-10-honister, tag: 1.52.0)
>=20
> bitbake $ git show 1.52.0
> tag 1.52.0
> Tagger: Vineela Tummalapalli <vineela.tummalapalli@intel.com>
> Date: =C2=A0 Mon Oct 25 15:16:54 2021 -0700
>=20
> Tagging for 1.52.0 (yocto-3.4)
>=20
> This new scheme has small disadvantage:
>=20
> bitbake $ git push github 2.0
> error: src refspec 2.0 matches more than one
> error: failed to push some refs to 'github.com:shr-
> distribution/bitbake.git'
>=20
> I can work around it by using refs/heads/2.0 and refs/tags/2.0 to
> distinguish between them, but that's still a bit unusual and
> unfortunate.
>=20
> Adding Chee Yang Lee who authored these 2 tags (see another warning
> there):
>=20
> bitbake $ git show 2.0
> warning: refname '2.0' is ambiguous.
> tag 2.0
> Tagger: Chee Yang Lee <chee.yang.lee@intel.com>
> Date: =C2=A0 Mon Apr 25 22:27:04 2022 -0700
>=20
> bitbake $ git show 2.2
> warning: refname '2.2' is ambiguous.
> tag 2.2
> Tagger: Chee Yang Lee <chee.yang.lee@intel.com>
> Date: =C2=A0 Sun Oct 23 20:33:14 2022 -0700

We should probably drop the 2.0 and 2.2 tags and put 2.0.0 and 2.2.0
tags in place instead.

Cheers,

Richard



