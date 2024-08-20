Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00891C3DA4A
	for <webhook@archiver.kernel.org>; Tue, 20 Aug 2024 14:11:02 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web11.20445.1724163058998049388
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Aug 2024 07:10:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=YRqmBZzL;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42809d6e719so46973075e9.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 20 Aug 2024 07:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1724163057; x=1724767857; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jB8fCEOm/1/KukrmlVZ0Vuf9+UDmlxhuJwR5NbC1J1k=;
        b=YRqmBZzLnGNKCoBa9jKFtDkX4piyTLKhgw59037MiiI849HgD3U+Pa14De5rmiezsV
         /u5oe7S3mwfUGyz3wu3mg+LdWa75kBug2c0mJ/gebDN2F4zg4HtRRfy3GHpzu/FQCP/3
         zBG5FEkL9v0M4gq7ESpXTDwEO7k/+hvcMme9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724163057; x=1724767857;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jB8fCEOm/1/KukrmlVZ0Vuf9+UDmlxhuJwR5NbC1J1k=;
        b=UfgZBgp+QwX370FnwytjoSUvFdn+Xt1tBgqjG5UDHJf2JhgO/Y7WZft+XHzfPXfARl
         br/Gg8L2ApMMvlr5RdN3yeXKtw923JPr6f7USeCx5rCM8iR9Funfq5whEpuLorE9hUkH
         Jb0t/qwrCoYHTAAAsp+u9vJfM6ogkwKtZCvSSgaEuRy1moRaQeiyMrVLP6zO8fvGZ+l1
         m91seJpkkks90LZR3q7wF5+UaR4r6CGXupNPFMSZrGTQMQbIhGRbu8P25PN7X/cmShfg
         Bya0g6/l/djJgHCzrXMFEtcdAl5xb+k3JDx4jQdKCudqJcWl+okS0hQuF5B6TRMZjlbW
         RJoA==
X-Forwarded-Encrypted: i=1; AJvYcCVZIOyPlDfFaYO1tA/ZQ7srje02pEkCSllGZcTHfwrlSRTSmnkaXK4+QPveGK8Bv9N1wZInzrU3dOXbBchLhAAa2GvYrJOLPVLR736Lgbvvsp/icWo=
X-Gm-Message-State: AOJu0Yw/ntx+m6klTc3OBBNIWGMBoc5NxHs3TAzWv2ixaBx6L9QBbaOi
	VR5JOycIXwI9CF68bOK8tbXqjyBOM6G0gn8legs0eKHbaa9+nH69oq4AEbPg8ps=
X-Google-Smtp-Source: AGHT+IHVHqydezOvaj3Qlf0pt05/Mrw6lHnA5WLoDM/bHPkdt5bQ5qAbiyOdd5ZVI+FFKWx4x841lA==
X-Received: by 2002:a05:600c:1d1d:b0:426:67f0:b4eb with SMTP id 5b1f17b1804b1-42ab670e107mr15079905e9.2.1724163057206;
        Tue, 20 Aug 2024 07:10:57 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:7b46:4014:5d19:3520? ([2001:8b0:aba:5f3c:7b46:4014:5d19:3520])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded28cdasm195260825e9.16.2024.08.20.07.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 07:10:56 -0700 (PDT)
Message-ID: <3c11c796ba2c91178e0b67d7bc3ce508618c2ffe.camel@linuxfoundation.org>
Subject: Re: Pickle vs. sqlite3 for cache?
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "chris.laplante@agilent.com" <chris.laplante@agilent.com>, 
 "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Tue, 20 Aug 2024 15:10:55 +0100
In-Reply-To: <DM8PR12MB5430C4D4EA06B2AD975C00928B8D2@DM8PR12MB5430.namprd12.prod.outlook.com>
References: 
	<DM8PR12MB5430C4D4EA06B2AD975C00928B8D2@DM8PR12MB5430.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 20 Aug 2024 14:11:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16501

On Tue, 2024-08-20 at 13:56 +0000, chris.laplante@agilent.com wrote:
> Apologies if this discussion has already happened (I searched the
> archives but couldn=E2=80=99t find anything), but I had a thought the oth=
er
> day. I wonder if the decision to use =E2=80=98pickle=E2=80=99 for bb_cach=
e.dat still
> makes sense? BitBake performance has certainly been getting better
> over the years I=E2=80=99ve used it, however it still seems to spend an
> inordinate amount of time loading gigantic pickled data into memory.
> I wonder if it is time to dump pickle and consider sqlite3 instead?
> =C2=A0
> Just wanted to get the discussion started, since there=E2=80=99s a chance
> there is some detail(s) I missed that will stop this idea cold :(.

I'd not be in favour of using sqlite here, it is not a good fit for
what we need. We've used it in other areas in bitbake in the past and
it never seemed to work too well. We're effectively storing python data
structures in the cache and having mappings in/out of sqlite is not
going to help performance.

We should probably have a look at what exactly is being stored in the
cache and using the most space as I strongly suspect there are ways to
optmise that. Interning strings was very effective in the past for
example as you then only have one copy of the string and everything
else is a reference to it.

Also, the hope was also that BB_SERVER_TIMEOUT (i.e. memory resident
bitbake) would avoid this pickle time in particular. I don't know how
effectively that is happening.

Right now, I think the priority needs to be to sort out the
"runcommand" async vs a sync command issues and clean up that area of
the API, then we can think more about performance.

Cheers,

Richard



