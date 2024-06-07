Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C51C27C53
	for <webhook@archiver.kernel.org>; Fri,  7 Jun 2024 13:08:20 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.41526.1717765697071434650
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Jun 2024 06:08:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=XRSo0Mru;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-421727f4e4aso3396165e9.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 07 Jun 2024 06:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717765695; x=1718370495; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnpPJvPtI1B5jrkytN5nsnp6x+rGobSSqzLg7JuUbKY=;
        b=XRSo0MruuO7j4dS6nyqwVKaMpim8+kUyqJWDmGxFYFwsmApW7Bl8mX2fEx+VWApxxO
         5qLtHVyaeyYkjRx8PKj0v6VevNMkduXnN+DJ5bA//NWtyiVx/N9KsgIFu0wM2+dqm3w/
         Qqsybfew2dj4cOjQhHIYi3h9nsXLM6BcGYeV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717765695; x=1718370495;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fnpPJvPtI1B5jrkytN5nsnp6x+rGobSSqzLg7JuUbKY=;
        b=vBoRvQPDP95nPJSpDBmrmP8/17dUkacyCXL5360B+aOP7/2W8vKfvh3LkLbPvfMQy7
         XKbQxn7Id4UL2pr0z9el5Fi7JOapBApmLt77EtHa4xqi4eMLJjApQTI7AHFt9zwQ+fnk
         gQjtaHmvmouuyPfvwV1msnl3ddG5fh/PNhfq8iisZW0lSBWEn/VxiP8W8tFkZk4KODRb
         d+Acg6lBuxpZg+XSgYczD7ZBT1rBrwYrr71b6L68kdAlOowko5WF/2xiR6aE/wDk273t
         ijW0XKH45RpkPNgvxR7ZXXrlqTHEr/72U8Jm9ZThMeWfsVrG6ChXehGXgGwZSuFsERTL
         5qzA==
X-Forwarded-Encrypted: i=1; AJvYcCX1qgYF9HXC/pcc2W6UokRXQ7Fq5LkYy1fq4jsNC+AkJNo0ELF/L3twtnQoplEGugYF0u7v+nI1rK0vVwa/38WQeFK+ljASQZ+HrShUZKZKX6BPbzU=
X-Gm-Message-State: AOJu0Yxogaox8ZJqT/r3xDXCfOS/n1Fbso9cGfhlHwM54oCG4uktPm+s
	aCQdfcmgqSEygpKPaFm02YfI+JfW5hZ0D3S2abJypHy6FmQxllDMluKw9chvxqs=
X-Google-Smtp-Source: AGHT+IFuvh915Znr/XydrZ6AzCw33b9KX4/KV3ZfyQ0lJC99dGuqbhhkF7sZ+8DYHySzR7gYE5IaqQ==
X-Received: by 2002:adf:fe41:0:b0:35f:e79:1b48 with SMTP id ffacd0b85a97d-35f0e791fbcmr158021f8f.16.1717765695350;
        Fri, 07 Jun 2024 06:08:15 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:910f:5798:f456:d86d? ([2001:8b0:aba:5f3c:910f:5798:f456:d86d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5d685c9sm3994126f8f.53.2024.06.07.06.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 06:08:14 -0700 (PDT)
Message-ID: <63183a1c5b60502ed5b4c160a62fc327694fb127.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] wget2
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Rudolf J Streif <rudolf.streif@ibeeto.com>, 
	bitbake-devel@lists.openembedded.org
Date: Fri, 07 Jun 2024 14:08:14 +0100
In-Reply-To: <89068048-ee96-425d-a640-684cd6fded58@ibeeto.com>
References: <234ddf00-756c-4863-a508-6a0ec75558ea@ibeeto.com>
	 <e22ec7329d8c18c254b8fa116ffebb32d4d8b86d.camel@linuxfoundation.org>
	 <89068048-ee96-425d-a640-684cd6fded58@ibeeto.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0-1build2 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Jun 2024 13:08:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16328

On Thu, 2024-06-06 at 13:18 -0700, Rudolf J Streif wrote:
> > Thanks for sharing, this should stop anyone else trying to track
> > down
> > this problem! It does sound a pain to get to the bottom of.
> >=20
> > I'd accept a patch to bitbake to resolve the path names to work
> > around
> > this problem as I suspect more people are going to start running
> > into
> > this. Did you happen to have such a patch?
> >=20
> > Cheers,
> >=20
> > Richard
> >=20
> Thank you, Richard. I submitted a patch. Please let me know if
> acceptable.

It looked good me and passed testing so it has merged, thanks.

Cheers,

Richard

