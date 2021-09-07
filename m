Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web10.1501.1631042270344277906
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Sep 2021 12:17:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=OK3bUsav;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id b6so16013534wrh.10
        for <bitbake-devel@lists.openembedded.org>; Tue, 07 Sep 2021 12:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=hEV5qcYQFk7IXOz3nEdesrGhVe5aiFlK30gKklZ6SQM=;
        b=OK3bUsavwBK3ill9mzE7rAa5hIRxzkjYphYzDqeJkeoRAmm8wLSHnh6E1x5Rn+ZGxk
         OCn1sws39wGppR+Xt9hJeBUrppUvBDyyvkulbNovzLgIYxOeH3Mxyb3WHXX4hIQOxVZK
         ElU7EMbyqDdDAG+qKxZn5lQag0/Uu3wtWrit4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=hEV5qcYQFk7IXOz3nEdesrGhVe5aiFlK30gKklZ6SQM=;
        b=d/AbGfPK24+iEzWSLyFG3TgYNQqKLd3EeDqiFl3WlkF8N9GRz8PksKltv35mlsNUth
         rmJ/7Y+LVHTrQagppfeOlDvrIS75HMm1gltUt+7/2EZ4Qvcba8B4E03NBhIfqyqSXNmJ
         krHsiHxaQ3GCqpUjq3Dsgv4Yd/DSpTX6Ufe+iYee8Kevo8eBraYBNK2CTGnpJkSanm6Z
         Ocr9v4LcOv6wBy6glpF4p992mtzj+4AEnqxpQwwZwSnkZAm67PU6CF5/8MAi0Ctq9uqZ
         wRc+mn5Mrlfk7Lump2z1GdoGDBf+xS1i6DF/wxfU/rNTc5cE1fh63vuBapxc1wLQIETd
         uNyA==
X-Gm-Message-State: AOAM530cBDhSGLZMMsEqBCLY0JuIDUf/dTWANhbzXc/3FS2cVYAOAxNN
	eapHICW5k8haMn+Fnm1dXsvgZQ==
X-Google-Smtp-Source: ABdhPJxqndp3V4/YBmLLzMTEpjku6yksQaHVTwTH4cCEDRS91pSNT+2LtUq+FPdWibFtfXWh4E6Urg==
X-Received: by 2002:a05:6000:1150:: with SMTP id d16mr20908192wrx.357.1631042268495;
        Tue, 07 Sep 2021 12:17:48 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from ?IPv6:2001:8b0:aba:5f3c:7ba0:bddf:c938:8f16? ([2001:8b0:aba:5f3c:7ba0:bddf:c938:8f16])
        by smtp.gmail.com with ESMTPSA id h18sm2701889wrb.33.2021.09.07.12.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 12:17:48 -0700 (PDT)
Message-ID: <0945d013a2111bc32698d527ede2fa747a25ad85.camel@linuxfoundation.org>
Subject: Re: [bitbake-devel] [PATCH] cooker: Only warn on potentially incompatible layer
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: Damian Wrobel <dwrobel@ertelnet.rybnik.pl>, 
	bitbake-devel@lists.openembedded.org
Date: Tue, 07 Sep 2021 20:17:45 +0100
In-Reply-To: <13276.1631032728323594714@lists.openembedded.org>
References: 
	<CANNYZj88WpKLuHORum8vMnhW6UVWqJMYLDM1vz-+MX3uu3Lh7w@mail.gmail.com>
	 <13276.1631032728323594714@lists.openembedded.org>
User-Agent: Evolution 3.40.2-1build1 
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2021-09-07 at 09:38 -0700, Damian Wrobel wrote:
> On Tue, Sep 7, 2021 at 05:49 PM, Alexander Kanavin wrote:
> 
> > Sorry, not possible. If dunfell branch doesn't do what you need it to, the
> > correct solution is to send patches for the branch, or backport the needed
> > changes into your internal copy of that layer. But certainly not to start
> > mixing layer revisions from different releases and demand that this must be
> > supported and easy.
> 
> Thank you for the hints but they do not scale well in reality and the
> restrictions LAYERSERIES_COMPAT imposes on the rest of the components simply
> resembles me the "rule of diversity"[0] from the Art of Unix programming.
> 
> [0]
> https://www.linuxtopia.org/online_books/programming_books/art_of_unix_programmin
> g/ch01s06_15.html

So you're saying we're showing an "unhealthy form of arrogance". Thanks.

I did mention you can bypass and do creative things with the checks. I don't
particularly want to spell it out as I don't want to encourage it or see it in
widespread use but someone else has also mentioned more directly how it can be
done.

The answer is still no, we're not changing that default as it does help end
users a lot. You can avoid the check if you know what you're doing.

Cheers,

Richard



