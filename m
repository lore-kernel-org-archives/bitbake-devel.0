Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AE1C3DA7D
	for <webhook@archiver.kernel.org>; Tue,  3 Jan 2023 22:24:43 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.1204.1672784681641012830
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 03 Jan 2023 14:24:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Rx7bzcOf;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id m26-20020a05600c3b1a00b003d9811fcaafso18277379wms.5
        for <bitbake-devel@lists.openembedded.org>; Tue, 03 Jan 2023 14:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4c49jYClkhG05o52rdsi31lc97GSElcGsPy97Q+jhkM=;
        b=Rx7bzcOfjiQKqOmFsrrOofRYNyYWAEog6fD5uBpToWbuKWGo03L6Yb/K6tNsTsUxdU
         zojncivvtg9NWv0EfP0GFdunmfZn1QNy5TsZy81B8/nqOybozKDfDxSqIEhUR4CYuTA7
         /oS48RC2boA+lYlg9Pa+QsB+3oz9/emf1xZfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4c49jYClkhG05o52rdsi31lc97GSElcGsPy97Q+jhkM=;
        b=RAG3d3zDtO8nLMJKssnVkd26fz51uTWfELnRqJ/a5O9x2Bns5ceB/KJqA2JpAXS/0l
         0GAaM7rNvc2MRZq5P45yGxqBQGit2p64NiLSYSb3UmkmUuEhYqmObL3T424n5vNtOV3S
         HKiKd5ImLOmVt2SppXulQMmiIj/2xi/iakaeEBiGvU3g0UiFDPGyKJPk01bRrptjyNN3
         HlgDmylHPS3t2uZI1OAjcIhqF2BexcKRAc5wwsINsZ7auzX1B39Fr2g3nmDomo1bZSKa
         hTGNA7HkeVcv77MhIXgznJlmhT0i7HgXajYtVmubQHK/oMjAp2MuSGJ5EfGggHhr1Lzp
         eHqA==
X-Gm-Message-State: AFqh2koQGXct6wcUI78kl4jKz+t6wi0QruVJdfP4BQMDxgMi6WfXLCUE
	uUXqoWetGbuRKQ1gQbNPoFxmfQ==
X-Google-Smtp-Source: AMrXdXuIoJYQPNgOhwx47hzQJwjrdu5rS/1sMnFUZnnlgJQjnB4YV791lgC49YeIfnbjGACtkdN4NA==
X-Received: by 2002:a05:600c:5024:b0:3d3:55ad:a114 with SMTP id n36-20020a05600c502400b003d355ada114mr32939270wmr.38.1672784679485;
        Tue, 03 Jan 2023 14:24:39 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:fcc2:4e85:26d2:6527? ([2001:8b0:aba:5f3c:fcc2:4e85:26d2:6527])
        by smtp.gmail.com with ESMTPSA id bd25-20020a05600c1f1900b003cfd4cf0761sm48747842wmb.1.2023.01.03.14.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 14:24:39 -0800 (PST)
Message-ID: <dee6ed9a3beabd5cd18042c61b0dfd31c2c4ff8e.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Typo on the BitBake Documentation
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: than.matos+bitbake@gmail.com, bitbake-devel@lists.openembedded.org
Date: Tue, 03 Jan 2023 22:24:38 +0000
In-Reply-To: <bWm9.1672174859052782246.2l5k@lists.openembedded.org>
References: <bWm9.1672174859052782246.2l5k@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 03 Jan 2023 22:24:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14285

On Tue, 2022-12-27 at 13:00 -0800, than.matos+bitbake@gmail.com wrote:
> I'm not sure if this is the right place to report and if I'm writing
> in the wrong place, please feel free to remove this post.
> =C2=A0
> I'm also not a native of English, but I think there is a typo on the
> BitBake documentation page.
> =C2=A0
> > You can obtain BitBake several different ways:
> I feel like there is a missing `in` before the word `several`.
> =C2=A0
> Sorry to bother you!

Thanks for reporting it.

I'm a little torn on this. I am a native speaker and I'd have said it
was probably sounds better as it is now. Adding "in" could likely be
argued to me more grammatically correct and more formal for a written
document but it doesn't feel quite right to me. I suspect it is one of
those cases where there isn't a 100% correct answer.

Cheers,

Richard


