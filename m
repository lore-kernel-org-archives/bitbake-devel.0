Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web09.3207.1627335311509212254
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 26 Jul 2021 14:35:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Md6e+dkn;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.53, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f53.google.com with SMTP id l11-20020a7bcf0b0000b0290253545c2997so911687wmg.4
        for <bitbake-devel@lists.openembedded.org>; Mon, 26 Jul 2021 14:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=xeZm9/Ns43e9FkXYAbUELLP5nH9hmZXj+lhNbyHlbBA=;
        b=Md6e+dknYEm65NK0VeKen3Yt7icm4S6671uny1RvEBAyM2grk4t2akfkrHRbzU7oXt
         /mHFbBa0LDbYxLHazWGrxBYp6uZO+lZNTpXugepVHJvLj0YDtbZ2Y5cx8/6+CTTJP+Pq
         /yHSUXkAWJnqFBjeMahxhxxd01QqXpQ2749mg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=xeZm9/Ns43e9FkXYAbUELLP5nH9hmZXj+lhNbyHlbBA=;
        b=BdHnJ/zX8gU5uZTtdp22pJi53fHwE1wukdXMaalRC022WDCyv2cX54Pl+c7hRp13Uj
         w+MvuXAc8NQDu/MNfHTdvbOVc2fGVZ5bZBgV+D3Ht66zefQj4sXJ/VKtkwFdiHwRKEdr
         ODkoy7/NTMMJEoNky5R02vgWXZSjyxv9Pu8RQuWud1KjN2QOyKhwtsOMVn/VyqU01vN0
         Qa1K/8xlk0xLfguMwjDTAHQq+nC2dZfr/5+uuCvtx7cuQZ5Yz4anCpeRUQjKhMnRp5Wr
         hnp+lb9za2AK578Gj7RTkr4jvdI3sMuGfgl2RGznhwavkBmPGySbfQrZ3bEplImJ/SY5
         MkOw==
X-Gm-Message-State: AOAM533nY7FWW1r0q3KbEj4TLxxurVgziRzoQNjmypyn5Ez36UFlx1sg
	+I/t3k4rKELtKLu43h7PSyjMTg==
X-Google-Smtp-Source: ABdhPJwVC0STuc5NRtlLyt61Fh3DqJzMaurRECU8iUXuUI4P0VS/YSxUKz+YPSf7IpR+19tlgxaiFg==
X-Received: by 2002:a1c:a74f:: with SMTP id q76mr16153161wme.112.1627335309872;
        Mon, 26 Jul 2021 14:35:09 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:8722:e8c0:4ebc:1cd4? ([2001:8b0:aba:5f3c:8722:e8c0:4ebc:1cd4])
        by smtp.gmail.com with ESMTPSA id z17sm947879wrr.35.2021.07.26.14.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 14:35:09 -0700 (PDT)
Message-ID: <3ceaefa5cac22edb1825a24444daf50e1cdd295c.camel@linuxfoundation.org>
Subject: Re: [docs] [PATCH 1/2] doc: bitbake-user-manual: ref-variables: order alphabetically the glossary sources
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Michael Opdenacker <michael.opdenacker@bootlin.com>, Quentin Schulz
	 <quentin.schulz@theobroma-systems.com>
Cc: docs@lists.yoctoproject.org, Quentin Schulz <foss@0leil.net>, BitBake
	developer list <bitbake-devel@lists.openembedded.org>
Date: Mon, 26 Jul 2021 22:35:06 +0100
In-Reply-To: <b3975308-cf7b-b7da-184a-a8b37af6f006@bootlin.com>
References: <20210726153523.2503355-1-quentin.schulz@theobroma-systems.com>
	 <b3975308-cf7b-b7da-184a-a8b37af6f006@bootlin.com>
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Mon, 2021-07-26 at 18:02 +0200, Michael Opdenacker wrote:
> Hi Quentin,
> 
> Thanks for the patch. Oops, you forgot to CC the "bitbake-devel" mailing
> list (done now). That's where Richard is supposed to take the BitBake
> documentation patches from.
> 
> On 7/26/21 5:35 PM, Quentin Schulz wrote:
> > This reorders a few entry so that they are alphabetically sorted.
> > 
> > Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> > Signed-off-by: Quentin Schulz <foss@0leil.net>
> > ---
> > 
[...]

> > 
> >     :term:`BB_ORIGENV`
> >        Contains a copy of the original external environment in which BitBake
> >        was run. The copy is taken before any whitelisted variable values are
> 
> 
> Reviewed-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> Richard, can you merge this patch as it was sent to the [docs] mailing list?

Merged, thanks.

Richard

