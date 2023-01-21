Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29131C27C76
	for <webhook@archiver.kernel.org>; Sat, 21 Jan 2023 22:15:49 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.7320.1674339342038505501
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 21 Jan 2023 14:15:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=RMD2kA+T;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id f19-20020a1c6a13000000b003db0ef4dedcso8146256wmc.4
        for <bitbake-devel@lists.openembedded.org>; Sat, 21 Jan 2023 14:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZbVuvbuAHEeE15sm0kdQxZDqaAoDCt+RkvEWicqP4p4=;
        b=RMD2kA+TpwNRHPyMKYPuf0rRnnouRB0r2DnUIR4POzgcuIY7OlnsclY3lwnadjOGCx
         5LxzhFhyB2omaKOPnWUnsOBB5Kv5UTSBB0STBeA0NaGPOMOal/hfnIS4h2ZAlF1O9d3i
         5th9bYFutzdnizh2dU9kfDS4KZAFB54mZrIDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZbVuvbuAHEeE15sm0kdQxZDqaAoDCt+RkvEWicqP4p4=;
        b=Oma7D2hcR85r0fXfUk4L3RxEQDY7Tti8Hwr9e6Xwb0cLMj3M/2MdQAHD8JEMAJ4o0i
         N61O/jtTWnCXKF+YWHmbeKeAds/Wf4atqKofZJ0xtz/i8AUXaOqYqTYM2749vkeEuBzr
         euwJoIP+REEzFIBqJBx+ofGbgvEtfrFXyy+lrhiziYc6SEEtBzLtefO+2HmkAooKBEDx
         5TqFQzjGa52qYjuVxL2kIrWYe7yxGLDjpy3/5i5Yb/kcZNyyqZx3BPyNKJ8Wadjw1RH9
         kM3LiyjlxZ9ShhzwrDzXtr0FfE0IcpyTGt++0k+YfVlpgizkXe97CV/Z3AqZACEOmbC5
         M2/Q==
X-Gm-Message-State: AFqh2ko8YNeaW4YMziDQig5uq5OfSoGIZ7tMxgfxZkIGLjDptvQP2Bnj
	BsSovK2WoyOwEh6H964KUCgoNw==
X-Google-Smtp-Source: AMrXdXsecu5BG5DOd+v4IKCtDA5in7ispII3lYMbOUpfffRlGjYyTG0fSAFkOpIiR26ydwWdsaR+wQ==
X-Received: by 2002:a05:600c:4e0f:b0:3db:3695:11b4 with SMTP id b15-20020a05600c4e0f00b003db369511b4mr6121149wmq.33.1674339340248;
        Sat, 21 Jan 2023 14:15:40 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:3f1f:fd3b:ca38:d2c5? ([2001:8b0:aba:5f3c:3f1f:fd3b:ca38:d2c5])
        by smtp.gmail.com with ESMTPSA id h11-20020a05600c314b00b003db2e3f2c7csm8904522wmo.0.2023.01.21.14.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 14:15:39 -0800 (PST)
Message-ID: <c181c4385f0b8053ac6b75c5fac4681209cc8e1f.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 3/6] cache: Only write files if we have
 data
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Christopher Larson <kergoth@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Date: Sat, 21 Jan 2023 22:15:39 +0000
In-Reply-To: <78456D01-2CB1-4F29-88AD-9C603004DDBA@gmail.com>
References: <20230121212305.2171310-3-richard.purdie@linuxfoundation.org>
	 <78456D01-2CB1-4F29-88AD-9C603004DDBA@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 21 Jan 2023 22:15:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14337

On Sat, 2023-01-21 at 14:42 -0700, Christopher Larson wrote:
> Hmm have_data =3D any(self.cachedata_extras) perhaps?

That looks a lot neater! :)

Cheers,

Richard

