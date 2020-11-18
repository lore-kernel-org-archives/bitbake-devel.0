Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web12.27129.1605717900902775200
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Nov 2020 08:45:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PFcMDK0b;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id d142so3665767wmd.4
        for <bitbake-devel@lists.openembedded.org>; Wed, 18 Nov 2020 08:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Ls4dC3iuR6Hxg4lafZI+42gjKjUJNhnfDi4AJHYwglk=;
        b=PFcMDK0b83vzir6/fTmu4oW2gVBiP4k6J8jivdqBLwg9dP3+76wZFPBMXPBfpwmbbE
         FkuSfjSQvnhobnyCnQFjZ9MYaMNGvbTTcJ6HPplCgobXpKkL5h9a/MyrJ4uKlBlNcPkD
         bU0QbiNzmbkmxvFhifEyKeYLp5pKHYVADb+F0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Ls4dC3iuR6Hxg4lafZI+42gjKjUJNhnfDi4AJHYwglk=;
        b=kcfi8/SLKksXh01wFWzj2JYJJoJ17IcXQgmdenAiksR1nWdt1F3EU/ieLv+nc2jOXS
         GYWEojUFK1kLjD6YQAV//ZplTfdgcaYcCqHFTp81Kp/gv3OkV6irta/Sr93bDyhRVmJj
         1OkUtQA0P+MM5pSdBLdS4BphC43Lsr7HphIc9gqmuhb0mmMkfOLVl6JMQHaKuwy4QrHx
         MqXd1MktOVf1KrPGpivHrlUcmrAvdraPhGmCzfsGO8h4I/pp8jhqcWc2Z8wXjWV0mzCY
         8Su5ja6Srvi6k4fUlYtye11YrsPDKY31O23o8KkjbHQjR7z9qbbo+xr3cuKgIJK0kAUz
         8VdA==
X-Gm-Message-State: AOAM530NMUWGSl3psA/7M2LYZLy68xtI6FJSeIDj4CfF+Jt5seYH601l
	x68gVgBax6Rs3xq9hjBUC7vb1A==
X-Google-Smtp-Source: ABdhPJyidf//kiP+VvwieG7BDju5VK/kiNgbc0Uq/BonDzeUOaAeYbA1HEqYwqO3gGl5P3b8dFXJAg==
X-Received: by 2002:a1c:b0c4:: with SMTP id z187mr896996wme.113.1605717899338;
        Wed, 18 Nov 2020 08:44:59 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from 2.2.2.0.7.3.f.1.3.6.f.f.7.9.4.9.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (2.2.2.0.7.3.f.1.3.6.f.f.7.9.4.9.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:9497:ff63:1f37:222])
        by smtp.gmail.com with ESMTPSA id a128sm5014978wmf.5.2020.11.18.08.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 08:44:58 -0800 (PST)
Message-ID: <710819fcc1b29838ea7d2f2b332fdd44495219c7.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v3 00/10] optparse => argparse
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
Cc: "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Wed, 18 Nov 2020 16:44:56 +0000
In-Reply-To: <SN1PR12MB248066D339FDC42D95EB16218BE10@SN1PR12MB2480.namprd12.prod.outlook.com>
References: <20201108221059.16854-1-chris.laplante@agilent.com>
	 <79ada9503eb003e81ec3f90836837cccc787f836.camel@linuxfoundation.org>
	 <SN1PR12MB248066D339FDC42D95EB16218BE10@SN1PR12MB2480.namprd12.prod.outlook.com>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2020-11-18 at 16:37 +0000, chris.laplante@agilent.com wrote:
> Hi Richard,
> 
> > One other thing which would really help me is if you could either
> > fix your
> > SMTP server setup so the list isn't as unhappy and therefore
> > doesn't present
> > you as "Chris Laplante via lists.openembedded.org <
> > chris.laplante=agilent.com@lists.openembedded.org>", or add From:
> > lines to
> > the start of the patches so the author is set correctly, or CC: me
> > directly on
> > the patches so I get a copy which hasn't hit the mailing list and
> > been
> > mangled.
> > 
> > I've been fixing these up manually but its getting a bit wearing
> > given the
> > number you've sent. I guess the alternative is I improve my
> > scripting which
> > may be the other options, its kind of inevitable.
> 
> Can you please tell me specifically how the patches I'm sending are
> getting mangled? I'm having trouble finding information online about
> how I may fix this.
> 
> I also can't find an automated way of adding 'From: ' lines to the
> emails produced by git send-email. 

groups.io (where the list is hosted) is rewriting your email address
since your domain does not allow it to send out messages 'pretending'
to be <something>@agilent.com. This is a general problem mailing lists
have with increased spam protections that are now in place. The
rewritten version is "Chris Laplante via lists.openembedded.org 
 <chris.laplante=agilent.com@lists.openembedded.org>" which works as we
allow groups.io to sent from lists.openembedded.org.

If you can influence the DNS/SPF for agilent.com, you can probably
improve things otherwise we're into workaround territory on one end or
the other.

I can handle it worst case, I probably just need to increase the
automation of my patch handling and some brute force sed hackery...

Cheers,

Richard



