Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB90C7EE2D
	for <webhook@archiver.kernel.org>; Thu, 25 May 2023 12:57:19 +0000 (UTC)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
 by mx.groups.io with SMTP id smtpd.web11.10874.1685019436839915179
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 25 May 2023 05:57:17 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@linaro.org header.s=google header.b=Z/aAwzo0;
 spf=pass (domain: linaro.org, ip: 209.85.167.43, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-4f4c264f6c6so2385593e87.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 25 May 2023 05:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685019435; x=1687611435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rR3PpKuwSRuNzCBcdzwiBQQxmQpoObZZ4aJ5FCAd0lg=;
        b=Z/aAwzo0xHF23wG7gE5AT9FTts/vPNnU0xjCodIh71FzUENrwaWNIroJJe0WlodlBS
         7evfXgDhESUyPw2jdFYnyJ6CmAdVL0Udo1HBJB0frgbzKZlddDQsCIVXt1AByL/oLN+k
         afZdij64fDHQRxeNkP7y+PXYZiR0IK/qa9TRKfVwfLVS5tBObEYc9ZnP+SszLInLmQgi
         mDQIq+8s7LmvMy1/0C9F50KS9TJtmqFXLAqicbQE/fuJ0VvrTRJ0UcLlaJSh9sB/ntAF
         m6qlcjtImnnbM0ai0ga5tf/mSzg/DUxXuXIPWxHUrJgLOqBL0gslLwgCkv8Mmozck/bv
         IhRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685019435; x=1687611435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rR3PpKuwSRuNzCBcdzwiBQQxmQpoObZZ4aJ5FCAd0lg=;
        b=AxI7WV7OS58W1GRU2066WNNYEiC1HdK3C9y1JpM2so828ChDWsnqDz3pF3bZD/t9Cm
         bGUxpzYTifGDyl60wGC7+tS4z2IeY+RNJabAdrqd8kirLqgihAd2ax8u+DfNBieKKto0
         duOU5Wt7VvsqftUwFV8A1kV3bRgv9dXTmJD7ErvBxNjkRmG3QDm26V4Yf/5cXLQJtPd4
         Yhgzdcnl3Kp7FY5KUupzFP7xb5EfQkC5lcFPMcAhLMJBnmhIoWjYWFIDbeT1prrTsWfZ
         Fj96Xx0XrByHgn0btpysAFSpIHc0ml4jQV3fkTD1cX1xNySOZnBYH5mLC66Dk45y6JKN
         sOQg==
X-Gm-Message-State: AC+VfDwGGyhsTM+Ka8xx8IQMdU9i5Hjldo+bqR7w2BaadVnbQWgk2K//
	232rvt5xYPYtQpkfm1yzZJtUOQ==
X-Google-Smtp-Source: ACHHUZ5vg8li2dk+Qqa+7HvA3TSDxfOVJ3aiWFZJwu/XtUp7CWJbDL0I5DQ90P8dv1NWAdbGyFiDew==
X-Received: by 2002:ac2:4465:0:b0:4b5:9b8f:cc82 with SMTP id y5-20020ac24465000000b004b59b8fcc82mr5350747lfl.0.1685019434899;
        Thu, 25 May 2023 05:57:14 -0700 (PDT)
Received: from nuoska (dsl-olubng11-54f814-94.dhcp.inet.fi. [84.248.20.94])
        by smtp.gmail.com with ESMTPSA id q25-20020ac25159000000b004f4c3feb9fbsm208743lfd.61.2023.05.25.05.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 05:57:14 -0700 (PDT)
Date: Thu, 25 May 2023 15:57:12 +0300
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
Cc: Alexander Kanavin <alex.kanavin@gmail.com>,
	Michal Sieron <michalwsieron@gmail.com>,
	bitbake-devel@lists.openembedded.org,
	Mateusz Marciniec <mateuszmar2@gmail.com>
Subject: Re: [bitbake-devel] [PATCH] bitbake: Add task timeout support
Message-ID: <ZG9bKB8yLRMKqZYT@nuoska>
References: <20230525102105.1480610-1-michalwsieron@gmail.com>
 <ZG88JxkZkP4z3kR5@nuoska>
 <CANNYZj8HQvGOFCx_jLXPBhcSCgGdF5j8=oBvKFU42btQoZNT=w@mail.gmail.com>
 <CAJkqNs2iyuVXRU-Wva+9pC58XixbM5YPC6c8hfgNuDY+9aYaRg@mail.gmail.com>
 <CANNYZj_PG2e4tk5u4TWj3utBsE1cnTArgPmB1n9893j3JnrQ4g@mail.gmail.com>
 <CAJkqNs33qZDkgJGgFh5a9CZ7wZFZqvVGPDmZnKruP5g_7MRBNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJkqNs33qZDkgJGgFh5a9CZ7wZFZqvVGPDmZnKruP5g_7MRBNw@mail.gmail.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 25 May 2023 12:57:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14814

Hi,

On Thu, May 25, 2023 at 02:13:10PM +0200, Tomasz Dziendzielski wrote:
> >Yocto has a download cache mechanism, so you should not have to fetch
> >more than once. Are you throwing away that cache between builds?
> 
> Do you mean the DL_DIR or something else as cache mechanism? We do keep
> DL_DIR between builds, but we're talking about cases where there was a
> change in the repository.
> 
> >the actual problem is slow gerrit/artifactory instances, not
> >stuck fetch tasks
> Totally agree, but we're not able to fix the slow gerrit/artifactory in a
> short term.
> 
> >The idea of 'retrying' the fetch
> Well, it's  not like I'm saying this as a solution, usually we just
> disable jobs until the slowness is gone. But isn't that what we already do
> with wget in bitbake?
> "wget -t 2 -T 30" from bitbake/lib/bb/fetch2/wget.py, where -t is tries,
> and -T is timeout
> Problem is that we get the slowness for git repositories and git does not
> support such a thing.

git uses curl, can't we shorten the timeouts or even add retries there? Maybe even
specific ones for the lfs support?

I've also seen a lot of problematic artifactory and gerrit instances, in addition
to maven, npm etc...

Cheers,

-Mikko

