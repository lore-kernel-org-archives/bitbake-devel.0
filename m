Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F4DC71153
	for <webhook@archiver.kernel.org>; Mon,  4 Sep 2023 06:47:11 +0000 (UTC)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
 by mx.groups.io with SMTP id smtpd.web10.42640.1693810028848562381
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 03 Sep 2023 23:47:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=iKlqryW3;
 spf=pass (domain: linaro.org, ip: 209.85.167.50, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50078eba7afso1750801e87.0
        for <bitbake-devel@lists.openembedded.org>; Sun, 03 Sep 2023 23:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693810027; x=1694414827; darn=lists.openembedded.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wMJFmu8I8LTHCZ1nj3NneK4XGyaPYnl6ZqTeno0x2RM=;
        b=iKlqryW35vFiBGNTRq8kGNbHAb9B2LAeik1PJR2N1gmSJgtxQYAeU/3lXo3OOM8DWC
         VZsp/lQgyOHHCmWw8zMGr9Cum7krG+BinaojCAu8bN/touNLewi/dZlsDxhQQSWKnXvp
         5KbClEfdLbGYrBqkZ+CCOvqCAL6ZmeGCBQ4mMMMCYvzzvPf/c8THXn7QdyWfOxFDBjRn
         CcGSF81eQBotomkXzjT1afoKV7P8/vi26HpU40pSoQvuS8wLHit84zmeOGnjXQ2IrWTe
         lj8REVJJkdYGPQChqsNcjkxqFKP22k+XOE3/rIisqtgnxK69zSKlYOxmu4pybZNo+WqC
         U5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693810027; x=1694414827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMJFmu8I8LTHCZ1nj3NneK4XGyaPYnl6ZqTeno0x2RM=;
        b=eaDsj0J01vNJj9kbI1/+PU3wV4b3ybgDRlBKXtkjBraomNkBwp3EVOV9WICPZfPrJC
         l6vzfW0i2RzfwTCOpYK3aN/YjzxL38WFgl5tMil73C1Nuj3MubHMB2MySGw/e3QlOFpe
         RAINb1P/t/TEoToD/FIXcjeYoNiyXb9tkwNu1VMsKHJZKKVe/+ALQ4qvduPnILsjIJQD
         tNrklv4nwrq2yJB/THG1pKsNEYsVw4hI2jr/KQ+x+Q2DdGV/xRXczWBq0fhmOXGcMFR9
         EXTjxz3nqncIOMw121RfpAp/s6mTGuFdqWNi80gPV9pEp7SsbakqkcIm2eg5AeK8sJt0
         NRzw==
X-Gm-Message-State: AOJu0YwvgFpTsYIjb9yXxF1WMLZMqpfMoAx8ONTqOz2HLW14JqSfOLlW
	KD3zLXrQQ9c5Y/UtEK2/jAKM0g==
X-Google-Smtp-Source: AGHT+IGxHVCIYVViXzO5vaCLt3U42xYQr6IPxY9mighhukZ2j5zpuZLx+zbd7AOYnpIPMrK3O666Kw==
X-Received: by 2002:ac2:4f05:0:b0:4fb:8616:7a03 with SMTP id k5-20020ac24f05000000b004fb86167a03mr5876300lfr.4.1693810026843;
        Sun, 03 Sep 2023 23:47:06 -0700 (PDT)
Received: from nuoska (dc7g6tyjby-d304c4945t-3.rev.dnainternet.fi. [2001:14ba:16cb:a800:e107:c77f:6058:ee33])
        by smtp.gmail.com with ESMTPSA id x18-20020a19f612000000b004fe37339f8esm1556193lfe.149.2023.09.03.23.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 23:47:06 -0700 (PDT)
Date: Mon, 4 Sep 2023 09:47:04 +0300
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH] command: Avoid time intensive
 distractions for ping
Message-ID: <ZPV9aKltBIlkR3U/@nuoska>
References: <20230830213303.2043607-1-richard.purdie@linuxfoundation.org>
 <ZPBUpN6GaATE+zbz@nuoska>
 <90096957449e6a35b3f2b349cb07132e0ef6a951.camel@linuxfoundation.org>
 <ZPB5zs4on6u4mOgd@nuoska>
 <6ea4d70d5bf116b389b7acbbe8825c55762d931d.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ea4d70d5bf116b389b7acbbe8825c55762d931d.camel@linuxfoundation.org>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 04 Sep 2023 06:47:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15006

Hi,

On Thu, Aug 31, 2023 at 01:01:30PM +0100, Richard Purdie wrote:
> On Thu, 2023-08-31 at 14:30 +0300, Mikko Rapeli wrote:
> > Hi,
> > 
> > On Thu, Aug 31, 2023 at 09:56:33AM +0100, Richard Purdie wrote:
> > > On Thu, 2023-08-31 at 11:51 +0300, Mikko Rapeli wrote:
> > > > Hi,
> > > > 
> > > > On Wed, Aug 30, 2023 at 10:33:03PM +0100, Richard Purdie wrote:
> > > > > We noticed some users were seeing very slow ping response times which
> > > > > caused 'server timeout' issues. There were some function calls in runCommand
> > > > > which could be slow such as the inotify callback processing.
> > > > 
> > > > I guess the error looks like:
> > > > 
> > > > Timeout while waiting for a reply from the bitbake server (60s)
> > > > 
> > > > and happens right after a succesful build to me when I try to run any bitbake
> > > > command.
> > > > 
> > > > Hope this fixes it. Thanks!
> > > 
> > > That is the message however the cause may be different in your case. It
> > > sounds like the server may be taking a long time to shut down for you
> > > and it can't connect or start a new one whilst that is happening.
> > > 
> > > If you have the bitbake-cookerdaemon log for your case I can see if
> > > that sheds any light if this doesn't work for you.
> > 
> > (Traceback (most recent call last):
> >   File "/home/builder/src/base/poky/bitbake/lib/bb/server/process.py", line 292, in main
> >     self.command_channel_reply.send(self.cooker.command.runCommand(command, self))
> >   File "/home/builder/src/base/poky/bitbake/lib/bb/server/process.py", line 868, in send
> >     self._send(obj)
> >   File "/home/builder/src/base/poky/bitbake/lib/bb/server/process.py", line 847, in _send
> >     self.writer.send_bytes(obj)
> >   File "/usr/lib/python3.10/multiprocessing/connection.py", line 200, in send_bytes
> >     self._send_bytes(m[offset:offset + size])
> >   File "/usr/lib/python3.10/multiprocessing/connection.py", line 411, in _send_bytes
> >     self._send(header + buf)
> >   File "/usr/lib/python3.10/multiprocessing/connection.py", line 368, in _send
> >     n = write(self._handle, buf)
> > BrokenPipeError: [Errno 32] Broken pipe
> > )
> > 4131625 12:21:32.806544 Processing Client
> > 4131625 12:21:32.806635 Disconnecting Client (socket: True)
> > 4131625 12:21:32.807999 No timeout, exiting.
> > 4131625 12:21:32.908254 Exiting (socket: True)
> > 4131625 12:21:32.982669 More than one thread left?: [<_MainThread(MainThread, started 140013699211712)>, <Thread(asyncio_0, started 140012031006272)>]
> > 4131625 12:21:34.433909 Exiting as we could obtain the lock
> > sys:1: ResourceWarning: unclosed file <_io.TextIOWrapper name='/home/builder/src/base/build/bitbake-cookerdaemon.log' mode='a+' encoding='UTF-8'>
> > 
> > I don't know what else to look for in the log.
> 
> What happened before that?
> 
> The pipe error was the server trying to reply to the client but the
> client was gone. We should be able to see the command running before
> that and if it was a ping or not and the timestamps?

bitbake is quite sensitive to IO on my Ubuntu 22.04 build machine
with zfs. This is how I trigger this reliably:

$ mv tmp foo ; rm -rf foo & bitbake image
[1] 2709733
Timeout while waiting for a reply from the bitbake server (60s)

I have rm_work enabled so tmp is not that big except for the deployed files.

Cheers,

-Mikko

