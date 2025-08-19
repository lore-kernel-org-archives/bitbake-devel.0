Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7DE0CA0EED
	for <webhook@archiver.kernel.org>; Tue, 19 Aug 2025 10:26:02 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web11.10779.1755599156784890134
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 Aug 2025 03:25:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=UuNOTVOn;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b9dc52c430so2518114f8f.0
        for <bitbake-devel@lists.openembedded.org>; Tue, 19 Aug 2025 03:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1755599155; x=1756203955; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2G9OjacdEuTkwERX8R71m/Bpe5n+/7bC2twrSBXuT8=;
        b=UuNOTVOnX2MpVAfpC2+Wb0/bxjVEybnoKsEKOwverozROLFP3f+xiGXG4sib9XAwKD
         XguGXoqW/yah75ftFYGIdLKHiIMU5w/1FDLVIIe/BsAMB3gi0o4MyleVDupHdmiviZjY
         RXi4+zu88LUITjQSdZplwytraHbFhR+wEYhsk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755599155; x=1756203955;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y2G9OjacdEuTkwERX8R71m/Bpe5n+/7bC2twrSBXuT8=;
        b=SasEbXzDfKFXpqVzE+XcJ1gqo0BszFJEMRrb7PxIbNTXxA7r3s+tu1BSuR3fXvoGw7
         gsH7FXBS60doh7Ddak1+6acoAfRqJoQ2suvWadq4Fszfy8F/TdR3gBMQCD2lX39uKiVo
         39uutUph+tAR3FaUCxA7sDiWA+aCZLbsLIZ1x0cM1gdMfzuu5dTMysVVF8X86keoPcZE
         yzwTz4UdC7wrhOPIvztQc+hyxYtt0hrfMy0dFJCuKxLYX7IKwfBJsRyLpNoEdp2G0dmv
         Aovrny/hsyGeWHcUdmSM1/pq18eVnpPMuzBuhtb6N1WGEvpVMMUoyn9g5TFy7AaopgcC
         qitg==
X-Forwarded-Encrypted: i=1; AJvYcCW7nvyQg5TlE2adRe+pLYxN0H+9MTN8jvG9Q53jejfgXHMhCeM93IAkwU59GZUDAumglxUwph0fTgz6x/fO@lists.openembedded.org
X-Gm-Message-State: AOJu0YyjFmGx0epnk8FOy2fDgNM4wVhHxyM3BBIYSFxu7ebJt5CE3mdr
	Ogg7AUl6RjsAZJa7hJrs0N1EZ2lcjhzn5HSfTygHbwsJzWS/JbfPwXavzS0++KsmOrhirVJ1s6u
	WhMJC
X-Gm-Gg: ASbGnctuEaQAFO0l2dRmKRkMDZUmLhOa9PymY0cKCTQM61Vg8duxVjSm3ThW3DpIdd8
	1IblJmTxMYkSZZ+Vw7gN1/fm7MMlScZTM+Ucnc9oQukEjOHUSEbv3xvtf6zz4keDTmLWKU7qcdU
	x3DTrQPa88tKV4eNaNDXwVMSyYUcXT9Cwz1Pmyoshu3lyG88ClJ/fA8UJ0TUWi/Vm9ppYpshHlr
	pUgk9LjCjiKKpN694/c2/1FZl6zeS1jXUZYHgnwOJPZkaevwoYBask4BPwy9PRavsUgigPlkuPu
	BOULzSjFg0U50VHdDuzsykftqzB1GK+rlpmh84F1BS28V7pQ2cY6WWIbe4YvN7GHqXHb3L3eZ7b
	7VLWFn6ZGVRlQQgnxLlxwwXZvAFU1swQNyuzZVIQ8qmVCWdR/sGQh3ehGfOWye1WIVF+f5rMxz1
	ybW7QwcOYQHgM=
X-Google-Smtp-Source: AGHT+IGvOG+UBMMm43Ls6bL6qQEzsFqDkmY26RHklzcONkSY3XDkHKVXLUftRuuLjncxAJ575W+Ouw==
X-Received: by 2002:a5d:64e9:0:b0:3b9:1d32:cf2f with SMTP id ffacd0b85a97d-3c0ecc32123mr1753859f8f.38.1755599155056;
        Tue, 19 Aug 2025 03:25:55 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:3d5c:7b3b:65dd:ef80? ([2001:8b0:aba:5f3c:3d5c:7b3b:65dd:ef80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c0771c19fbsm3182457f8f.41.2025.08.19.03.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 03:25:54 -0700 (PDT)
Message-ID: <7e828700163fb4218a19a60b7113f296a5bb96db.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Bitbake and epileptic seizures
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: william.martin@muxen.fr, bitbake-devel@lists.openembedded.org
Date: Tue, 19 Aug 2025 11:25:53 +0100
In-Reply-To: <b937fbb5-f398-414a-a440-7020004d91f8@muxen.fr>
References: <b937fbb5-f398-414a-a440-7020004d91f8@muxen.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 19 Aug 2025 10:26:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17884

Hi,

On Tue, 2025-08-19 at 11:56 +0200, William MARTIN via lists.openembedded.or=
g wrote:
> I send you this message today to talk about technical choices that can=
=20
> have serious health problems.
>=20
> Some days ago, we have an external person at our office who have see a=
=20
> bitbake terminal building an image.
> We discover that he is sensible to epileptic seizures (he is ban from
> traveling by plane for that).
> The story finish pretty well for him, but we have to ensure no bitbake=
=20
> terminal is open when he is here.
>=20
> I am not sure that refreshing the task list at very high speed have any=
=20
> interest for anyone.
> Maybe an update at 1Hz max is enough to ensure the build is working.

Firstly, I'm sorry to hear about that person. Nobody likes to think
something they've worked on causes an issues like that :(.=C2=A0I hope they
are ok.

The fast refresh rate isn't an intentional design decision but the
result of a number of changes over the past decade coming together and
interacting badly. Those include CPUs with higher core counts, addition
of progress bars to many tasks and time output on the console view, all
of which were developed semi-independently.

There are some patches that were submitted a while back but there were
issues in the implementation and we've never got to providing feedback
and sorting them out. Sadly that is a common theme for many different
things.

I am going to try and get this one resolved though given this report.

Thanks for bringing it to our attention.

Regards,

Richard


