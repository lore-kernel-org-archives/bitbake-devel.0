Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web10.63641.1600098426985391606
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Sep 2020 08:47:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=aOgAK6DI;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id o5so118112wrn.13
        for <bitbake-devel@lists.openembedded.org>; Mon, 14 Sep 2020 08:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=eZk2bzBFU/stxEmS/AS/ZfDk62bs5+MAGl93lbbLIxI=;
        b=aOgAK6DIex0vUIjEhQPVbwyT3F68kj8Tc6szX2/J/8tQSlwA3QIFfK8UWsFtA2ylvG
         9RL1/tMeGl2nO8uimUhOFlWK3K/06Xb4JZaZxuc9LX6ZmiFOMIXrRPAdNzI87TRpYPAk
         JCFwtdEh8AH7EzJpOVz83mXpjiGZpMuHuFZv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=eZk2bzBFU/stxEmS/AS/ZfDk62bs5+MAGl93lbbLIxI=;
        b=tP/9pORWFBlWinELbYn6CrjaUYpRSyrPR0IkayOZ4Ob64Ww4pD6BWACIy81R0mF4ff
         ZqMfrIjOOjh2vLG+ok08zDgQ/GdZSIXagYhjvcZUUuwu9GIcBlfWI7Yti+SMvw7PJXIC
         jQw1/5mDHiCxCMeQvcd93yu/p4KLUjLEKykyfcn17iurWXekW6cytoNTHaYmi8elmE3k
         ADG2EhkmpqArEOBXu5OXbuRr1i6ebMq1XX5sK2fmVTLXwpsQmBLZGvztZtAbwt/jclHw
         qSZhh42qge3fNXaJvn+rO6SNL14DmYbZmPcKGWxyIzEQyqtvMgImXevPqa7RT4RwFzxr
         p4+A==
X-Gm-Message-State: AOAM531yewgeLnMv23HRdwClUdxKTtlgNtuBK6SsmFFkB2sZOTPUs26t
	Dq82O1edmyqzZ09AAs922j/QGQ==
X-Google-Smtp-Source: ABdhPJxp6NmBhXLrFqMgdRnwf6V3akLTDPj7mkzPhklQldm9h4ZJtMTOY0rQjVJuH4af1GB9TupwEg==
X-Received: by 2002:a5d:4247:: with SMTP id s7mr16401318wrr.167.1600098425352;
        Mon, 14 Sep 2020 08:47:05 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from f.c.d.b.6.2.6.c.c.0.f.a.1.a.4.d.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (f.c.d.b.6.2.6.c.c.0.f.a.1.a.4.d.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:d4a1:af0c:c626:bdcf])
        by smtp.gmail.com with ESMTPSA id a83sm19988578wmh.48.2020.09.14.08.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 08:47:04 -0700 (PDT)
Message-ID: <b2a4d93c9c635940e30b11fcd56da9e58d83f0db.camel@linuxfoundation.org>
Subject: Re: 'lockfiles', 'dirs' and 'cleandirs' order of processing
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: "chris.laplante@agilent.com" <chris.laplante@agilent.com>, "BitBake
	Development (bitbake-devel@lists.openembedded.org)"
	 <bitbake-devel@lists.openembedded.org>
Date: Mon, 14 Sep 2020 16:47:03 +0100
In-Reply-To: <MW2PR12MB2474F256CC7B7B3A415148CC8B230@MW2PR12MB2474.namprd12.prod.outlook.com>
References: 
	<MW2PR12MB2474F256CC7B7B3A415148CC8B230@MW2PR12MB2474.namprd12.prod.outlook.com>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Mon, 2020-09-14 at 15:39 +0000, chris.laplante@agilent.com wrote:
> Hi all,
>  
> While I was debugging ‘cve-check’ failures under multiconfig, I
> noticed something a bit worrying in build.py. The processing of
> ‘dirs’ and ‘cleandirs’ varflags takes place before ‘lockfiles’ are
> acquired. While it was not responsible for any of the ‘cve-check’
> races I found, I think it has the possibility to cause nasty failures
> if a task uses both ‘cleandirs’ and ‘lockfiles’.  
>  
> I’m planning on sending a patch to delay ‘dirs’ and ‘cleandirs’
> processing until after the ‘lockfiles’ are acquired. Does anyone see
> a problem with this?

That seems obvious in hindsight. The dirs element probably doesn't
matter so much, cleandirs could though.

Cheers,

Richard

