Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web11.13391.1586071022517381769
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 05 Apr 2020 00:17:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=DKz9mEUH;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id j19so12344687wmi.2
        for <bitbake-devel@lists.openembedded.org>; Sun, 05 Apr 2020 00:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=u7zFrce/EgC2b7c2dE6MiGC2kRpe6QTHWTBpDVdYnOA=;
        b=DKz9mEUHk2QNBnrscaBzpyqTv2pAFUgtDVhq2SHWNYRGMo900NJESsKkWVQoWSOQ6f
         8BNO6+2c5nAZHBiwx94Jn1OX4siVyfA6I0sphAZBHvXBz3b/gMkKKEeS0VAxOsdNoo8d
         soKn4xuYKSwp1x7bi5hCQq/nki+Qkr6C6/v8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=u7zFrce/EgC2b7c2dE6MiGC2kRpe6QTHWTBpDVdYnOA=;
        b=l2Qr0nP4QBKoYcSCAp5iraqN9d3KK42CqZKg/XGQenctCsGGuKkI4kUQQoSgkoP1vP
         g5PExkRtNaaFYhs7aZBvD/2O6F4N2Prgx4QTiWRj+QJNSZq7XJAd/xAr/UL5wdZ0aOCm
         4ATfRq/7RDbSyUmikijyZZewVJD89MInBHqjgS9pm4kJO3NFMncYwJmpD4DMQzUjMCKk
         cOufOwqyYs0TCnEcC1FOxY+gtHOTHlEJ+u2z5KlF13V8qfTAUyY8ooHyqMpM+r3oYhjJ
         KcUmGpw7OWo2Ghar9C6S9FeXoAJQLdv5YgPY6gcAh5WXF97mDM7HD0CK/w/iWkuEA8Dr
         /4ow==
X-Gm-Message-State: AGi0PubfvWEJr4bN+G/EcSISHDl28u5/aixYHxaVf3tOLZ3+92xgX4W8
	oyF5DMaT12geSa5X6U5Zmzqe9A==
X-Google-Smtp-Source: APiQypKEQloYzG0YvVrQ7CNf+z2qu/89a2wNxJvjJutIE+DM2ZIdYAfKswB05vsZbRn7OAZa60rbPg==
X-Received: by 2002:a1c:b356:: with SMTP id c83mr17366565wmf.10.1586071020986;
        Sun, 05 Apr 2020 00:17:00 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id r3sm20300956wrm.35.2020.04.05.00.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 00:17:00 -0700 (PDT)
Message-ID: <f48a8d347ce4ee70171c374f81090cd186652117.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] Custom variable value: (OVERRIDES?)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Mauro Ziliani <mauro@faresoftware.it>, 
	bitbake-devel@lists.openembedded.org
Date: Sun, 05 Apr 2020 08:16:59 +0100
In-Reply-To: <6bce089d-050d-7c57-15ac-a182b548f694@faresoftware.it>
References: <6bce089d-050d-7c57-15ac-a182b548f694@faresoftware.it>
User-Agent: Evolution 3.36.1-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2020-04-02 at 17:34 +0200, Mauro Ziliani wrote:
> I don't understand how can I change a the value of a variable inside
> a  .bb file
> 
> I do this work
> 
> if MYVAR is empty I need to install default.txt in /etc
> 
> if MYVAR contains "white" i need to install white.txt in /etc
> 
> 
> So I extend myreciped.bb with this file
> 
> 
> myrecipe.bbappend
> 
> MYVAR = "default.txt"
> 
> MYVAR_white = "white.txt"
> 
> 
> do_install_append() {
> 
>      install -m 0755 -d ${D}/etc
> 
>      install -m 0644 ${MYVAR}    ${D}/etc/value
> 
> }
> 
> 
> In conf/local.conf I put
> 
> MYVAR_pn-myrecipe = "white"
> 
> 
> But nothing works as I expect.
> 
> Where is my mistakes?

You're mixing up a couple of concepts. In local.conf you could put:

MYVAR_pn-myrecipe = "white.txt"

which would force the value of MYVAR to be "white.txt" in myrecipe.

- or -

OVERRIDES_append_pn-myrecipe = ":white"

which adds "white" as an extra override for myrecipe, which would then
means:

MYVAR_white = "white.txt"
becomes
MYVAR = "white.txt"

Hope that helps explain things!

Cheers,

Richard

