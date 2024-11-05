Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E234D3E77A
	for <webhook@archiver.kernel.org>; Tue,  5 Nov 2024 22:29:49 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web10.33071.1730845775671661771
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 05 Nov 2024 14:29:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=BRWe8vOA;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4315eac969aso1452525e9.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 05 Nov 2024 14:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730845774; x=1731450574; darn=lists.openembedded.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BL+qyWav7NyrF/mq2RvvTqJK8rw0c6zjsWDoZrhu21s=;
        b=BRWe8vOAGq2f87ZyrRxUr7N18MHg8fCsbqnHfn8ofgdbfyQh92ndUHZgv30Z2JJeZ+
         nDw6X3zHilwmYefcMFDb9/O2M2ITso7krMcUmXe9u4NfQ+CJks4UQJyJu1Ti021K6cYY
         n1PL+To4IMYvFqFuELeqI9GSfgFeM8R2+Z0n8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730845774; x=1731450574;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BL+qyWav7NyrF/mq2RvvTqJK8rw0c6zjsWDoZrhu21s=;
        b=IW5qYQdmjj6xQ43K2A2ROJ8eR0W+8ANePuty3Rin+ISM2EsgbQuHY3x8+1veUKVKEa
         ElqtnVBSlX3qARxt5BEpp4V9Q29XBnjKg3HtRkS4DBZQkhIah6lY8CKG9MPnqlomMalL
         fDpEAbXf9+WW5LlQp+SKzi/voGfaZa9cMbRO8vSotir33FVYK12/+oh6Lt0TVGZzAHZ7
         M0zqrIEtcaLWW5u3G9GigJlG2vnkbm0vQ7/3hDiZdMY2rf2y+ARjpEGeDF6g3GwnHCD7
         JZX0PTI+VTwsZkdfJHJ/GAETp/+n3rbExVup6xJeXPgZ75nSStPn+XraBGUkfxyJYTbw
         BRLQ==
X-Gm-Message-State: AOJu0YywiRgVbSnZDMF/rplfp43nm/kUaurzoH0rreAvJb20Pl2TRr74
	LdG35yk9Bew8FPjq24bj7U1natPPJnb9No8gjcLy5sFVbolbE5+Vm8LMMzYCfw66eIdFQJArZTs
	5KvU=
X-Google-Smtp-Source: AGHT+IFXStnlt+EtmB1+mvKmE1SXD1zDLqY+9TjNDbzHPoTuO9xnkT1yi2ddR2WSkw0MofxsdIABcA==
X-Received: by 2002:a05:600c:6987:b0:426:5e32:4857 with SMTP id 5b1f17b1804b1-432a99a3338mr3319185e9.0.1730845773554;
        Tue, 05 Nov 2024 14:29:33 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:bcf1:9af4:492:5ab9? ([2001:8b0:aba:5f3c:bcf1:9af4:492:5ab9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7bf7sm17592127f8f.9.2024.11.05.14.29.32
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 14:29:33 -0800 (PST)
Message-ID: <db1360d3161d626b669756306c6106cc2aee6567.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH 2/2] server/process: Decrease idle/main
 loop frequency
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 05 Nov 2024 22:29:31 +0000
In-Reply-To: <ZypKhYgAkvrse6bx@bootlin-mathieu>
References: <20241105150628.2827698-1-richard.purdie@linuxfoundation.org>
	 <20241105150628.2827698-2-richard.purdie@linuxfoundation.org>
	 <ZypKhYgAkvrse6bx@bootlin-mathieu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0-1 
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 05 Nov 2024 22:29:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16782

On Tue, 2024-11-05 at 17:40 +0100, Mathieu Dubois-Briand wrote:
> On Tue, Nov 05, 2024 at 03:06:28PM +0000, Richard Purdie wrote:
> > The idle and main loops have socket select calls to know when to
> > execute.
> > This means we can increase the normal timeout frequency since this
> > is
> > just a fall back and have some small efficiency gains.
> >=20
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>=20
> Hi Richard,
>=20
> This patch set does not apply cleanly on master nor on my master-
> next. I
> believe it misses the "Merge a function to simplfy code" from your
> master-next branch.

Sorry, I've sent that one as well. I need to stop missing a single
patch like this!

Cheers,

Richard

