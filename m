Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB24BCCD182
	for <webhook@archiver.kernel.org>; Fri,  3 Oct 2025 10:35:39 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.4447.1759487731033144736
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Oct 2025 03:35:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=OsRMDs0P;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e37d10ed2so18905595e9.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 03 Oct 2025 03:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1759487729; x=1760092529; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bVQmgPJQtEESqjI23MTJvuqI4sm59Cfa7kIx/IH8O+4=;
        b=OsRMDs0PIiWPF82yYwr+9MZpekgxE2cO3FvMfcdimicrveAdm7ePBfy1fD5h92HBck
         JkZ+sR3pE5IknwsjlyliPlR6uc/aF8WmjfzI1ASQ5YDAfWP3sIZ+HgK8ZSgWfiDccYrI
         eO06K9WK5FT4iOETvTvOf/XI2Anq6yRaeNKWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759487729; x=1760092529;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bVQmgPJQtEESqjI23MTJvuqI4sm59Cfa7kIx/IH8O+4=;
        b=SOizfjzKD8koCx7d844qPglYmlYHJusz+u9IswuBgAR1QFkH2YxZqFC3lspi3THxX5
         QERBL8C4u+TNcG00Tmt3BdT6gh2QxTmnoWyXN6QarmFu0hyzzGcZ/mUPUM6GcKezyFUW
         h2Q56C91dBp+NOlMUmsUPRUxtcc06FIrg3tPahxIi/g4uit1lwuh/iyFbhmgjsqYXU8a
         klMLwEJ/5MxKdjQ54s2j0a+QsQ8wpp9lEEpkcOhEVFGyVe0ogmUJ9mV8ONXsCZL12hQJ
         qfnM1zYpF3H/Q6Uo+JSLPkdZ1TCGRR09sj9pVxyAvQjb2ymia5dtNj50kmns4jrRegWy
         w2lw==
X-Forwarded-Encrypted: i=1; AJvYcCWY3Ue9vk7PONGWFXsenbzQ3IhoHxDcK3kRPL9svVeaaNC7s/LGNjm+iXcUQokDR8Y0hhpN9hJLLowi4+7d@lists.openembedded.org
X-Gm-Message-State: AOJu0Yxxxs7srcIiXA6yKpB+gAU2YawyXNSugELMDjK/XuwfrKToygy7
	3oLPpYcLMoLf5yq1Z0WSPUOZoz5CFl/NwwFi/wZ7lfas2M9mgm2glka/Vf1KqEk/9q4=
X-Gm-Gg: ASbGncunuMfzH7WgxrgV4aOl89fy7GnnW8WH3nXhwBe3lOsj96C5wVYBbC8ZY8O8TZH
	ve4oK+yOqgECJUFXVzgI0D/C9/0gx2sI54UBNwAPQsv0OpMq7u2EuHqsQI8oWwrgr0a0t3TbyeY
	64e8uz/+k1UNxLkK3FBIumV4QCDHMwEiB1cckQzjPxfse3gP69JeqJF04ADgvAZvClQq+NrGt61
	fgrPvrZ6IehcayEw76+NQAbFwfImbiafWXtX6ADYldmPscOUfXE2GIT/9kEDPY061VKqQZHCGqv
	agNXmQczCSSFKn5erHKFpVQ9vPJMGGdbLgt6HcDwNNUG0TOdebZH7aa16woEADMfHAXoznFQmZ5
	fjWfpzTdyRvLqt08+cDPzhSh275Qo+bAQj+6MDV0B3NnXMKTvB4seUPH2CrepMsdfez+qYy8yZJ
	IJ98P8NUMaHLv6qVslgiNxGucIzDqx2RthsGCpQBWV86Y=
X-Google-Smtp-Source: AGHT+IFFwnLcnViHw2jMeJkpRzqV/EVjRzmKjJ7WfqPmhoCjzWN4RIgO7u0EWw6dh2QgVpj13Ya4SQ==
X-Received: by 2002:a05:600c:3d90:b0:46e:3d5a:d15d with SMTP id 5b1f17b1804b1-46e7114dea1mr17467965e9.26.1759487729193;
        Fri, 03 Oct 2025 03:35:29 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:67c:cc8a:4a49:c12a? ([2001:8b0:aba:5f3c:67c:cc8a:4a49:c12a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e619c3a58sm121948495e9.6.2025.10.03.03.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 03:35:28 -0700 (PDT)
Message-ID: <0a686ee986ea0bb72079983b45d86e06068be6e1.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [RFC] fetch2: npm: do keep the sha256sum
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: jeroen@myspectrum.nl, Stefan Herbrechtsmeier
	 <stefan.herbrechtsmeier-oss@weidmueller.com>, 
	bitbake-devel@lists.openembedded.org
Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Date: Fri, 03 Oct 2025 11:35:27 +0100
In-Reply-To: <d4c9b66f-9e3d-48f7-b9fa-0744f3548c8a@myspectrum.nl>
References: <20250922195059.1052515-1-jeroen@myspectrum.nl>
	 <c136f020-69dd-427e-89ed-d9a487ff4477@myspectrum.nl>
	 <e4bd126f-ddbb-4632-a871-078e1a9ac383@weidmueller.com>
	 <d4c9b66f-9e3d-48f7-b9fa-0744f3548c8a@myspectrum.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Oct 2025 10:35:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18129

On Tue, 2025-09-23 at 12:31 +0200, Jeroen Hofstee via lists.openembedded.or=
g wrote:
> Hello Stefan,
>=20
> On 9/23/25 12:25, Stefan Herbrechtsmeier wrote:
> > Am 22.09.2025 um 22:05 schrieb Jeroen Hofstee via lists.openembedded.or=
g:
> > > cc-ing Stefan Herbrechtsmeier who is the author of mentioned
> > > patch.
> >=20
> > Please revert the mention patch. The npm fetcher inject the checksum=
=20
> > on the fly from the remote source. The mention patch was part of a=20
> > proposed rework of the npm fetcher to use local checksum and remove
> > the dependency to the npm binary.
> >=20
>=20
> I would say what you did actually a good thing. Afaiac we should
> get rid of "The npm fetcher inject the checksum on the fly from the
> remote source"

I agree, we should be providing these checksums locally, not trusting
the remote. I'd take a patch changing the code to do that.

Cheers,

Richard

