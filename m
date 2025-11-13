Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539E4CD6E60
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 13:51:39 +0000 (UTC)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24321.1763041889173439955
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Nov 2025 05:51:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ZeFThN/t;
 spf=pass (domain: gmail.com, ip: 209.85.219.44, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-88044caaa3eso7750636d6.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 13 Nov 2025 05:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763041888; x=1763646688; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QW840VdNbzcaglNvcji8TJK8TGbPduD8EGtf9RNKcHM=;
        b=ZeFThN/tdIMeEzJcd25Ni/k7o62b4r62mcsXZHxLjGaUtsKzt0glLgsyC/AmfJmgc6
         vVKwYpmqyQC11HWWfASAuYla5eyg04tcRFcZi5TbrZBnxf8LX49fB/ljscFF3Y5nC1a4
         ifQnVouLN0gWO2G5/sOWp4dEEHw2iqcHRrsnO8xVK3TuGs+jxugupI9NXK4JxB13qI8A
         sNLd6lpJBKpz2Mhm9+GGXvH9TmLdYZFd0oYcXJ4U6N/H33/66+ljaBjXwXr4WiP9edql
         fSltSqcLad5SfZpEyAg+D+STlJQyoSqjYbxDZgh75QhIbR3Qewv4HNo6EfiikDEqa3zV
         X6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763041888; x=1763646688;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QW840VdNbzcaglNvcji8TJK8TGbPduD8EGtf9RNKcHM=;
        b=ed63O+I1FEP1bXxqebkqW0Cz8SjG+gDadUZ0pNd0UCJY6pKrr5Umz596ugp1xUZpjW
         fE9f9kIpLCPuPC5zY3yo4A0XTH1Ec0ERW6hAl8Zbyj9UiNTfamxqTyCuslORwi0PQOn/
         CoisNxygwmz2o4RWuZhLRc4oAWuiY2t5952W7hZ+V5Paoa3xi4mN4o1IPyx/rkWgfOad
         RH9MbmsS2LqgP716NkFtqUYUu5O218WT5l0Owez4V263+2GQnhO4BMSkdzeErRBCMkz1
         wQj6hFUjvHOskI4ojRxAUFKQC9eFdl6K5pcRbi2jHd1XzJFJ4d2Uq1XKO15Q+NoWPItm
         NLDw==
X-Forwarded-Encrypted: i=1; AJvYcCU8j2i0SGfL/ZESWvKg/RvkIo3G5zcCy0heGzp4oDlf77PD2EamLjT6lHNSHVpHGAMXad9gY6p44solMrz8@lists.openembedded.org
X-Gm-Message-State: AOJu0YzEmV9kzjibhH73rPv3Nkgygfq9V2Y/HIF4zZEwjKfciGGauQqF
	0XRa0KLynpe1MiQZv5l+Lovcrx0nriC9jJhY/e/Gjo6FJuJSnRxq8LL3jAeT6ukv3Aeia6mfEXb
	su2V6Ol/7Y0aUEktcraTuMqgFG4VFw38=
X-Gm-Gg: ASbGncuoOxqt+bJM2JaKQfXvJold0i6DKyjbbl5YhP5dKR1xAknpaqS/p2MHl0kcQyS
	v0tlObbUw/gyk1mx2qJw1P25/UmYxCceVgWkvcqhUUiAzkZz2mW/JPMj0qYFtnvNXh+u0vY2gRJ
	fQlQz8IT2sENw61wxBbIgOFw3MU36UAqqpXiKYYjhlWJ/ahA4qnNS6avILRD2aIysprgiT4GO4M
	TKQKG2BRWMON2oAQB31wGZ5tRsVYiImV03GeDxBKKIguENrG2bx34A2sMIhrWGkn09NllYey/U/
	C4NuT769Vc0vpsof2FLQOmVubfXxbw==
X-Google-Smtp-Source: AGHT+IELOdUVEPpdQS/8zVvdN6XnQqfg7dJvfqkageevGi061A0h7f/USbeI6wzEb4pvIK88smCNLjgG9vAbiutzEWo=
X-Received: by 2002:ad4:5bea:0:b0:882:47e2:9cb1 with SMTP id
 6a1803df08f44-88271a29e5amr99805356d6.43.1763041888133; Thu, 13 Nov 2025
 05:51:28 -0800 (PST)
MIME-Version: 1.0
References: <2acc6d2e53840e35ca2d99839e89d94e136dd304.camel@linuxfoundation.org>
 <d13ed5957b2de69f5985ee524e006835f9e2b740.camel@pbarker.dev>
In-Reply-To: <d13ed5957b2de69f5985ee524e006835f9e2b740.camel@pbarker.dev>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Thu, 13 Nov 2025 14:51:17 +0100
X-Gm-Features: AWmQ_blI60bf0b0kRjOhTtrmTRGlapTc9OWjO9DabyfLQfoXnPEsn8yDd5_AcrA
Message-ID: <CANNYZj_oVoUaM_3v-k4=q=P7tekjVXCBrCivswEfEc+dauqZ-Q@mail.gmail.com>
Subject: Re: bitbake-setup steps for release
To: Paul Barker <paul@pbarker.dev>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>, Ross Burton <ross.burton@arm.com>, 
	reatmon <reatmon@ti.com>, Robert Yang <liezhi.yang@windriver.com>, 
	"antonin.godard" <antonin.godard@bootlin.com>, 
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, Joshua Watt <JPEWhacker@gmail.com>, 
	Adrian Freihofer <adrian.freihofer@siemens.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Nov 2025 13:51:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18374

On Thu, 13 Nov 2025 at 14:18, Paul Barker <paul@pbarker.dev> wrote:

> I'd like to be able to override the sources specified in a bitbake-setup
> conf.json file without having to create and manage a new conf.json file
> myself. I'm imagining a command line argument that I can pass to
> bitbake-setup, perhaps --local-override/-L, to drop the "git-remote"
> settings for a given source and set a local path:
>
>     bitbake-setup init -L bitbake=~/src/bitbake \
>         -L openembedded-core=~/src/openembedded-core
>
> I don't think this would be difficult to support and I think it'd be a
> usability win for developers. I'd like to get this in before the release
> if we can, otherwise I'm going to be hand editing bblayers.conf and
> fighting against the tools until we have something in place.
>
> We will need bitbake-setup to remember that sources have been overridden
> so that running `bitbake-setup update` does the right thing.

There's already support for source override files (yes, there's an
extra step of making the file, but you only need to make it once, and
it covers all possible tweaks to the sources from the original
config), and you can also achieve this by not having these entries in
the sources section to begin with, and then enabling the locally
managed layers with a bb-layers-relative-this-file. I'm not firmly
against a new option but it needs to be justified against these two
already existing ones, otherwise we're heading into featuritis
territory.

I'd probably extend the schema to have 'local'-type entry in addition
to 'git-remote'-type, and then you can override one with the other
from the override file.

Alex

