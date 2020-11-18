Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
 by mx.groups.io with SMTP id smtpd.web10.28018.1605720282988253976
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Nov 2020 09:24:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=cVHRfz1H;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.66, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f66.google.com with SMTP id c9so3793576wml.5
        for <bitbake-devel@lists.openembedded.org>; Wed, 18 Nov 2020 09:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=TE3XxMFL3PVm/Nuk5V2yF5zZ2TJQqKghQl8JOkcy02M=;
        b=cVHRfz1HH3SSkBKc/H2hoqtxyGanoCN4b0hU7mUxKSUE4mOVPuk3koCZZQcSk6G2QY
         tWDgenuWjGP7UOszB1k5WtKENjGCw4xvbgcqeDBjLsclA11NBSsk2cjHN2DybIoZ7e+/
         8JgC2Mk5oFuh8X1KiL4wyDBWV+6VF2NR4qKSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=TE3XxMFL3PVm/Nuk5V2yF5zZ2TJQqKghQl8JOkcy02M=;
        b=a7VugnmC24FLQONtYFvd9dZzNt/nQ2+pvSQ4Mt018T7v+gYZCazogBe3M4G8UPuUVB
         lDLSWoIUO43T3fjcKMO65/XsrbVuOpDp9taEeO2gkaHJex4yTEZzdSjvO/Gbg7id4mlX
         /XDVbGRR06+OIVLLNsfR1NX1HEQTGRkWnQ5jjluOUbIzLZPh+sHqdLqM3zbQfk424P4f
         h7T77ibhgu20djWpBq+dBGfkt91gmCScDJQzct+MTiZWI+Q/veVf5nf2yD8cy1OU4TDN
         s7/mb+z3HSi4Q3XDrxy1fL5dyFLS7kosZ8KR3PjiY5rnzlTKzuuaXUqs71tY0fzOuMWU
         9ioQ==
X-Gm-Message-State: AOAM531Uz6IoNd1sgqIxaT2WHu1a+sYe6aNcEcTPARmHiQJ0y7Umuc8i
	VRB/DMkhakFjDtm/D/4q7xyCgw==
X-Google-Smtp-Source: ABdhPJy7+Hcd77sASDqPkcUKG3sycqGvsQ1p+1IWXsO2ujJvffDCxZATy6ByDyixydyxgZg0eZuqyg==
X-Received: by 2002:a1c:df8a:: with SMTP id w132mr160704wmg.90.1605720281424;
        Wed, 18 Nov 2020 09:24:41 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from 2.2.2.0.7.3.f.1.3.6.f.f.7.9.4.9.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa (2.2.2.0.7.3.f.1.3.6.f.f.7.9.4.9.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:9497:ff63:1f37:222])
        by smtp.gmail.com with ESMTPSA id n10sm35575629wrx.9.2020.11.18.09.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 09:24:40 -0800 (PST)
Message-ID: <989c6ad2362e7763866a566efa6715d66ebc2d0c.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH v3 00/10] optparse => argparse
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
Cc: "bitbake-devel@lists.openembedded.org"
	 <bitbake-devel@lists.openembedded.org>
Date: Wed, 18 Nov 2020 17:24:40 +0000
In-Reply-To: <SN1PR12MB24809AE9781F70F9F4ADBCCD8BE10@SN1PR12MB2480.namprd12.prod.outlook.com>
References: <20201108221059.16854-1-chris.laplante@agilent.com>
	 <79ada9503eb003e81ec3f90836837cccc787f836.camel@linuxfoundation.org>
	 <SN1PR12MB248066D339FDC42D95EB16218BE10@SN1PR12MB2480.namprd12.prod.outlook.com>
	 <710819fcc1b29838ea7d2f2b332fdd44495219c7.camel@linuxfoundation.org>
	 <SN1PR12MB24809AE9781F70F9F4ADBCCD8BE10@SN1PR12MB2480.namprd12.prod.outlook.com>
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2020-11-18 at 17:07 +0000, chris.laplante@agilent.com wrote:
> > > Can you please tell me specifically how the patches I'm sending are
> > > getting mangled? I'm having trouble finding information online about
> > > how I may fix this.
> > > 
> > > I also can't find an automated way of adding 'From: ' lines to the
> > > emails produced by git send-email.
> > 
> > groups.io (where the list is hosted) is rewriting your email address since your
> > domain does not allow it to send out messages 'pretending'
> > to be <something>@agilent.com. This is a general problem mailing lists have
> > with increased spam protections that are now in place. The rewritten version
> > is "Chris Laplante via lists.openembedded.org
> > <chris.laplante=agilent.com@lists.openembedded.org>" which works as we
> > allow groups.io to sent from lists.openembedded.org.
> > 
> > If you can influence the DNS/SPF for agilent.com, you can probably improve
> > things otherwise we're into workaround territory on one end or the other.
> > 
> > I can handle it worst case, I probably just need to increase the automation of
> > my patch handling and some brute force sed hackery...
> 
> Unfortunately I doubt I can do anything about the DNS/SPF:(
> 
> I'd rather avoid you needing to make changes to your scripting just
> to deal with my patches, so I'll make sure to set the 'From: '
> header. I'm going to submit a patch soon as a kind of test to see if
> it works (though it is an actual patch for an issue I found, separate
> from all the argparse stuff).

You aren't the only one! Most of our regular contributors don't have
the problem and it has improved for others over time as people
understand the issues and set the SPF more favourably. I don't know the
details, I've just noticed some people who had the issue don't now.

Its not been problematic enough that I've had to add scripts, I've just
hacked the odd patch but its probably inevitable I'll reach a threshold
at some point.

Ironically whilst my emails to the lists now work (I think/hope), the
copies I get back of my emails are always mangled and nothing can be
done about that.

> N.B.: I really wish git had a hook that runs at 'send-email' time. As
> I understand it, that would be the correct place to automatically
> prefix the message body with the 'From: ' header. I tried using
> 'prepare-commit-msg' to prefix the entire commit message with 'From:
> ' but that dirties the log and breaks 'git log --oneline'. Maybe I'm
> missing something but I just don't see a way to do this automatically
> without writing a wrapper script around send-email, which I'll
> probably end up doing.

I wish I had good answers but its a pain. Mailing lists are becoming
harder to run and maintain (one reason we switched to groups.io).

Thanks for looking at it!

Cheers,

Richard



