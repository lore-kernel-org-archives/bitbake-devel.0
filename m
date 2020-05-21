Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web11.5719.1590067249275250376
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 21 May 2020 06:20:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=EfLtcXee;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id s8so6617411wrt.9
        for <bitbake-devel@lists.openembedded.org>; Thu, 21 May 2020 06:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=ugvqj2Qcb5Ul17CVmmAF/DMvTq9Jroa1SQCM0FIx7KA=;
        b=EfLtcXee725wag1uOofYSzjNgn4ozr4ZICrDTWQ4C2Rfbom/sRvhmhdBxkZhf72RmX
         l+EOSxRJwhzh2XUWQnBN1elWhvkHAMe3UBlOoIw6Tk6pAQ1dtgtnyOLSM9SCsEcNwVK5
         sw7tNCJCIy/DTEggKwIhQRn3xdSgqzwEueFOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ugvqj2Qcb5Ul17CVmmAF/DMvTq9Jroa1SQCM0FIx7KA=;
        b=gLgXJnAoDKzixyzInEEeDg7Y/c9xzHJAQEG0ocwY6hp5EzWI2RU6y9WGF5DCiIkNAx
         rEfoZ1T2/DLnA2uahlJIdP+yeH1PJa9V/5CGfF9ucz5in7hQI8EDzWs+8NeENgIx38CW
         ZrhDBd/kjZ8nfFXQpXMjeZOTNoTEdDX9yk8JsRICXBBgT5o+F6CnKaqiK8ICSkXfOL6g
         yc744bAtpxCNbgKbr8750I5vlwNO9x6DuWFLZarMs+9bc7bduVMEYBkHg1TOTT8lPfCA
         W81Xt1I7BISw8hAnyz6pAbaDS19nekVv5LNLIXbNyXKWMByzOyaF+EPWBcrOfIchwuPj
         hwZw==
X-Gm-Message-State: AOAM533GmR0PV+Azj3t90c1PMg+m2U2NwBg35hUNHLZXB9L7qAbuvzAn
	L1lzg7xzuHcrgYyZDmk9JEr+jg==
X-Google-Smtp-Source: ABdhPJxGxXnNDI3lamfs5TiVr1wEXrVjCqatYimZlBV1E1HXqZ1z3bSi6wri7ck5sjFLP12vRvJp2g==
X-Received: by 2002:a05:6000:108d:: with SMTP id y13mr1600141wrw.180.1590067247736;
        Thu, 21 May 2020 06:20:47 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id b145sm7006317wme.41.2020.05.21.06.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 06:20:47 -0700 (PDT)
Message-ID: <a453ed4506f15303da0337ff26efa40b24575503.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] possible to generate all scripts one time ?
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: zhangyifan46@huawei.com, bitbake-devel@lists.openembedded.org
Date: Thu, 21 May 2020 14:20:45 +0100
In-Reply-To: <tLbr.1589505002949120275.wxj7@lists.openembedded.org>
References: <tLbr.1589505002949120275.wxj7@lists.openembedded.org>
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi,

On Thu, 2020-05-14 at 18:10 -0700, zhangyifan46@huawei.com wrote:
> I am now currently using a parallel tool like icecream. And my
> project has over 200 packages.So when the build starts,it need to
> start icecream 200 times and the start time is a great cost.
> So i am wondering do we have a method to generate all automake
> scripts(especially compile or install) one time and then i need to
> only start icecream once.
> Thanks for your ideas!

When you say "packages", I suspect you mean "recipes". The challenge is
that the recipes are all in independent processes. Its certainly
possible you could generate those tasks but not run them, then try and
collect and run them together but it wouldn't be easy. There are inter
dependencies between them too, so its unlikely all 200 couldn't run
together and there would have to be ordering between them.

I know very little about icecream but would it not be possible to start
it once, then use that instance for each of the tasks when they were
ready? That would probably the least invasive/complex approach.

Cheers,

Richard



