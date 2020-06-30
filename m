Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
 by mx.groups.io with SMTP id smtpd.web10.1220.1593535121799164455
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 30 Jun 2020 09:38:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=QD5Xb5d/;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.67, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f67.google.com with SMTP id 22so19443737wmg.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 30 Jun 2020 09:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=+uaV/pXscLfWirYYUOnD/iPw6/RhcyY3KATCm+KrgQo=;
        b=QD5Xb5d/VXU+KukOsWW3DiIU95DgUOO0MOr0ErD5emrWQhKRogTT8L+YVWZt0d8oGp
         joFqbOeRu7zwL+0XQBZkg8VsefBtZwDEKsscaNNBDXugrRDq9KwAV1lrqwXpR8rsbyea
         iSqw2tWdKg1hUm5TM5hWg1vPGofOzgTl0nVW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=+uaV/pXscLfWirYYUOnD/iPw6/RhcyY3KATCm+KrgQo=;
        b=i2ZTiPd31O3qD7IOpVjZxGAMC4AzjTQIFcdigJvZ5Z8f7EvGhf4rZ5WwlCp2ZI6txm
         LC5ct0uZsJ+UXf2PYW32v6yDhtmtZnkyzc2siD5TZfKKfDCbmrAIXLlVs+tsPwdGrHy0
         AgcKeJxY0ybqNO1HcrU03MPAc5q1gMUI27a2uCkYccKAPDL5OXgQ00sLo89tux6Ik1ye
         EVjePLwyddt+uGSECSk5MKSeRfjg/PmPcYSQ2Nv/pk+13TyZzsZ9cP7Uv1nn/CyIPokZ
         AoEg798JKos6TlreeE5JlIyz5rWwTUEeOcgvVabcbzpFf1P7P4reCUM3yCL9aYPa9nv4
         CD8Q==
X-Gm-Message-State: AOAM533OBqpfZ8+ogUKf9uOYFyOkTbUImhBnzD0y0Cibv0BLBknRiDp0
	hrSz89KcbQS7F8sKBjieZHrfsg==
X-Google-Smtp-Source: ABdhPJzHKQ/PMPMEvs4vpDa38AkYFEkyXrFUR4DOz07mHgGER1bmnpckuH8m2H+PnauSpwSbkiwuug==
X-Received: by 2002:a7b:c406:: with SMTP id k6mr21470829wmi.130.1593535120204;
        Tue, 30 Jun 2020 09:38:40 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id k14sm4073943wrn.76.2020.06.30.09.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 09:38:39 -0700 (PDT)
Message-ID: <92bab537996baef9999adaa8b18f280068f850e7.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [bitbake][dunfell][1.46][PATCH 3/6] hashserv: Chunkify large messages
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Steve Sakoman <steve@sakoman.com>, Paul Barker <pbarker@konsulko.com>
Cc: bitbake-devel@lists.openembedded.org, Joshua Watt <JPEWhacker@gmail.com>
Date: Tue, 30 Jun 2020 17:38:38 +0100
In-Reply-To: <CAOSpxdbcn+-gV8E+WT4KwkwrScPS42topwthkMRQ0U3chViHcQ@mail.gmail.com>
References: <cover.1593486375.git.steve@sakoman.com>
	 <224ed6abbfa7b9c2d968fbbb75cc0dc6a3129813.1593486375.git.steve@sakoman.com>
	 <CAM9ZRVvTyP3r6+JewPfpPiYAKrFBZcZxk9pOZebyb0ygcxaLfQ@mail.gmail.com>
	 <CAOSpxdbcn+-gV8E+WT4KwkwrScPS42topwthkMRQ0U3chViHcQ@mail.gmail.com>
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2020-06-30 at 04:05 -1000, Steve Sakoman wrote:
> On Tue, Jun 30, 2020 at 3:33 AM Paul Barker <pbarker@konsulko.com>
> wrote:
> > On Tue, 30 Jun 2020 at 04:09, Steve Sakoman <steve@sakoman.com>
> > wrote:
> > > From: Joshua Watt <JPEWhacker@gmail.com>
> > > 
> > > The hash equivalence client and server can occasionally send
> > > messages
> > > that are too large for the server to fit in the receive buffer
> > > (64 KB).
> > > To prevent this, support is added to the protocol to "chunkify"
> > > the
> > > stream and break it up into manageable pieces that the server can
> > > each
> > > side can back together.
> > > 
> > > Ideally, this would be negotiated by the client and server, but
> > > it's
> > > currently hard coded to 32 KB to prevent the round-trip delay.
> > > 
> > > Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> > > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org
> > > >
> > > (cherry picked from commit
> > > e27a28c1e40e886ee68ba4b99b537ffc9c3577d4)
> > > Signed-off-by: Steve Sakoman <steve@sakoman.com>
> > > ---
> > > 
> > My understanding of
> > https://lists.openembedded.org/g/bitbake-devel/message/11453 is
> > that
> > this isn't suitable for backporting to the LTS. I may be wrong
> > though,
> > probably worth getting confirmation from Joshua or Richard (Cc'd).
> 
> Richard was the one who suggested I take this patch, but definitely
> worth getting confirmation!

People would run into the same issue on dunfell as we have in master
with large data sizes. The change does require any server is upgraded
so we will need to release note that.

We did run into an issue where we hadn't upgarded the autobuilder
server, all was fine once we did and it was obvious there was a
problem.

I'm leaning towards using the same code in dunfell and master for this
area. dunfell is already using the master upgraded server on the
infrastructure.

Cheers,

Richard

