Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
 by mx.groups.io with SMTP id smtpd.web12.11670.1586182891330744936
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 06 Apr 2020 07:21:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=UAQ4/W10;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.65, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f65.google.com with SMTP id g3so15402551wrx.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 06 Apr 2020 07:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=1mp/moepsYUwCugBPpZVOd4PYKqZ1caFlH4gMJymvZY=;
        b=UAQ4/W10VtkU+AYEK4mkxONxeYLtQCmqKrFbH8o+qmIU19cBGMUFl8isOZ5wSg0Jhe
         arayIIfqWLuY0SCrtqABbEnFlPwZtzweSshMBfsZoSFimEjE6pRY+k/6hCt4SKEDCrKw
         2zhewhLPclJADvg2S7k6LG95L6BfsTeEY5ZOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=1mp/moepsYUwCugBPpZVOd4PYKqZ1caFlH4gMJymvZY=;
        b=B9vIY7seshK9XtqUu2datBTjWND4iA4FsESZ+qeaH+kKd3TGC2cz6BLlr7RXSv++8E
         pufrKMvmctfVKLp4iXhkWT6puQ0odUf+2nKMUfZhJAHT1zNvSjZHvqJw+v7S6TurGR2P
         Ar7hic6SHs47RYqZGHWXwmKCauwnI4ALlMmtFHIugPiQHSVHfR1SvSiLQlBzuIweoKlg
         5k/ZLmtIzdZwD/hjbaG35bG2rDJXGXP6GPfDmqii4l4aw6ibJTvjcuNkfMGeN/dbNVPe
         WevOTtJXzUSvKciOxRpmmOHoR5ht1F2WwWMusl2zA6aOyBSlFIApT/pVQ0BxBj9y+lnt
         GE5g==
X-Gm-Message-State: AGi0PuY2Ne1LCq9AkOkFOqlfEWhbCY8qtU8vgQoYQWAKGqXrGZmOJEOE
	zeSGxibb2c9vak4vg5pqgWnpzA==
X-Google-Smtp-Source: APiQypJVmgQyfmwhFlV7ZWA77t2OAGdoe2mcy+W+fE1PHlMwQbN13fYRYFXlheOexlMIhgWM5JGAIg==
X-Received: by 2002:adf:e948:: with SMTP id m8mr24071854wrn.193.1586182889704;
        Mon, 06 Apr 2020 07:21:29 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id n6sm34133wrs.81.2020.04.06.07.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 07:21:28 -0700 (PDT)
Message-ID: <30103069a456a800fd8d332e6ca504c1d8df6e2e.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] lib: Fix not selecting the newest version from the versions that match the wildcard-preferred version
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Henry Chang <mr.changyuheng@gmail.com>, 
	bitbake-devel@lists.openembedded.org
Date: Mon, 06 Apr 2020 15:21:26 +0100
In-Reply-To: <20200406070428.6918-1-mr.changyuheng@gmail.com>
References: <20200406070428.6918-1-mr.changyuheng@gmail.com>
User-Agent: Evolution 3.36.1-1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2020-04-06 at 15:04 +0800, Henry Chang wrote:
> Same issue can be found here: 
> https://patchwork.openembedded.org/patch/108877/
> 
> Quote:
> > I have two recipes within a single layer:
> > 
> >   stblinux_3.14-1.7.bb
> >   stblinux_3.14-1.8.bb
> > 
> > If PREFERRED_VERSION_stblinux is set to "3.14%", then I would
> > expect
> > the version 3.14-1.8 recipe to be selected, however 3.14-1.7 gets
> > selected instead.
> > 
> > Reversing the order of files stored in pkg_pn[pn] seems to help. Is
> > it
> > a reasonable solution?
> 

It is a reasonable solution however:

a) It won't work for 3.14-1.7 and 3.14-1.10
b) I'd like to see new tests added to bitbake-selftest for this please
so we can ensure we don't regress in future.

Thanks,

Richard

