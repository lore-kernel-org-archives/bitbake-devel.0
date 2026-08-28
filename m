Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8037AC61DCB
	for <webhook@archiver.kernel.org>; Fri, 28 Aug 2026 20:47:39 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4327.1787950052912360514
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Aug 2026 13:47:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=QDX+HLoo;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-499ac87c92bso12689795e9.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 28 Aug 2026 13:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1787950051; x=1788554851; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yzyRHPWMf7YrKHE9mWe9QeYU4YfX5A98hllSdh720Qk=;
        b=QDX+HLooJTFu31Sm/f+hljq1OqPywo1jKdgjYbhIHZwL2bZGz15WWxxVJyiQTvoAwa
         al31ZZoAF5AtZSpGHG9w1nYaqW5gLgvAI1EY8yYMvYH3cjtxt95j5EWmNB2oNl83lNEa
         jYnYJuXh2JzBsvKm538F7qWvtDppRQ/P/dHlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787950051; x=1788554851;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yzyRHPWMf7YrKHE9mWe9QeYU4YfX5A98hllSdh720Qk=;
        b=rVcob8OayBopSzZf36rraSppwpQtk/OF88tiNMut2o5EfNgDUJIQiIaTQBnrLJ2TN/
         cYb+MiNInDGLHRpWLHEbcbHY/lZZ6aSm2clcEOb/SErBHrwZbSfamVM9Fcj19fhBIMXG
         Vo4J1q/kvM0D+Z2Qo0gaDumOjUj9n/plSkNy14ZxUDhX/zJU4j2tYg1uxN4T/PFrvQ4V
         HWBwUzGIW9ZTQWanqFnCMPyOutWKIVHEUw/R0XujZRwjfFDJzAYINHki+oK8a5JQQfad
         c1EsDv2krLrVsLJGlgL14ysWg3wAhQpH1BNZurvahjc5fDRxkkyDF14mFzAAfppMa+am
         CqQA==
X-Forwarded-Encrypted: i=1; AHgh+RrkSnr82YiMZlskdT+nEdtFivqiBwR2ct3hs7gBBXNSt5tC/zOQjKcVxSeCIZh9Wq4n5x3qgUV9Dr/dgrd7@lists.openembedded.org
X-Gm-Message-State: AFuF++lNl+m8+xNZnBhXbMt9biz4g2nAPeaxs3WkF3XqT3XSrBVU3wwU
	gln3BSCaL/OsM5arneCMOAa9/jVUqgwVk0fg5pzDr9z3M72lyR/GQCHfm652BUysX+M=
X-Gm-Gg: AR+sD10ielG6UijjHW7leIL4xPTq/l1gjmAQUR5Kh9Dw4JuBdgfn5X5p8uyy02xqGrs
	vBQg0e2hCml+Fo/ZZog7BVFgKzkJRSf+dTdyNcuDj7HKQ6fTpXb/RWmx8gE9RSNhKCtU736orIr
	406HqlnaWWSexYhIdEuqrZszJ7bMQiuSWKv36fwwaNKKReHpDsigPBnsVTdf7kyzyV3wtPM0/fh
	bQcUnZIJvEH7SpX7x7N32h1O1cz6fbjQz1RVIhCXEdkKhTdwsngf2QUpryXx7uW/FVJXp0oVk9A
	BBFTMphPk0okWpezK6t3XzjJrUUMrnulJDsL4g0soN+Ske91yPKUj2N5l2sbb3QFzXeA9LXO0K1
	o6P07bi98F4woXl2VO6Yg5oz39Ujw5HB0q3MtVQgVgwJh/dkLGZtRa9/uIkk+uldCeuzWvTrA5/
	zYmM/b45w7bG4pU2cnc3gLkkKHMwihPWAVC8gr6/4H5VzGqUBCghdWSj3n3EsoeY7LTKxu+cOLL
	rNzleRviK+givCI39/5UtFBhZ8jvs6ubv3sbxkGHxamnIRTAJuLQJNRics7tC98
X-Received: by 2002:a05:600c:4443:b0:499:b3f0:ff05 with SMTP id 5b1f17b1804b1-49b91c56f41mr116345035e9.13.1787950051010;
        Fri, 28 Aug 2026 13:47:31 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:c3f1:c7b4:8368:83c1? ([2001:8b0:aba:5f3c:c3f1:c7b4:8368:83c1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b95018ee8sm78600835e9.15.2026.08.28.13.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 13:47:29 -0700 (PDT)
Message-ID: <f6e8e40b847ff7e79f865e4223e6a131a88603ed.camel@linuxfoundation.org>
Subject: Re: [PATCH] cooker: Clean up collect_bbfiles handling
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Freihofer, Adrian" <adrian.freihofer@siemens.com>, 
 "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Fri, 28 Aug 2026 21:47:28 +0100
In-Reply-To: <6cdb0405632935cfe1c97600ceb741e88ab16fc1.camel@siemens.com>
References: <20260826162530.2483331-1-richard.purdie@linuxfoundation.org>
	 <6cdb0405632935cfe1c97600ceb741e88ab16fc1.camel@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 28 Aug 2026 20:47:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20122

On Fri, 2026-08-28 at 13:11 +0000, Freihofer, Adrian wrote:
> This looks very good. Thank you so much.
>=20
> I tested master-next manually with remote debugging from the IDE.
> I also created one more test case in the openembedded-core tinfoil
> test suite:
> https://git.openembedded.org/openembedded-core-contrib/commit/?h=3Dadrian=
f/ide-sdk-improvements-quick-install&id=3Db3d2e53c431dfe12a0194e5976e2d6dc3=
4cd5cdb
> which could be added after bitbake will be updated to the version
> with these patches merged.

Thanks for testing, I'll get this merged :)

Cheers,

Richard

