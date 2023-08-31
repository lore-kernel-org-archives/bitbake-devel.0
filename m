Return-Path: <mikko.rapeli@linaro.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FD4C83F10
	for <webhook@archiver.kernel.org>; Thu, 31 Aug 2023 11:30:35 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
 by mx.groups.io with SMTP id smtpd.web11.14476.1693481427485066376
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 31 Aug 2023 04:30:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linaro.org header.s=google header.b=BkgMNJQK;
 spf=pass (domain: linaro.org, ip: 209.85.167.45, mailfrom: mikko.rapeli@linaro.org)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-4ff09632194so1379319e87.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 31 Aug 2023 04:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693481425; x=1694086225; darn=lists.openembedded.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BFvoKos4+QT7zgZYgp1lYricjSUCeg0h5IGqCj24WvE=;
        b=BkgMNJQKTdG6cpOLwkS14I7RhKhSKlKIm3tOZJEk7D6k4lUl8Ji15fReAyh79+WB/6
         NRFicbg/n7mEjdXyah0/mgpFMPL3HkbA6K0vIw4X7q4iEuQf3fHO82yk0s8asuTlrYk2
         3zrOJR9M1M3BcakvmWlvx1Cgn3szfuXkDxgL2FAy+uyTcqeS6CJ4MMEivJea2mF4tT2+
         QTsaYMjTQf1m13m1FMqCE9lYTTwAOLdCQsFEtD0VIEfIGUNYnHNh5blbB+YFwrPTc1at
         Rr3eXhAz7ghtVwyQnbvpB0Hx+j1IGf58bUeizTg7xYGlLz24Y8zPRBTKD8+ICZb8kaM/
         Mbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693481425; x=1694086225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFvoKos4+QT7zgZYgp1lYricjSUCeg0h5IGqCj24WvE=;
        b=Mw+2on3FY5hXErFV8NbUXNGA9K6427HXss5VFYaxR5IP1VhLpnPTYz2WCJIraSJwhC
         ESYrPEusiQ9XmJIGSfPHzsmpT+P1fTFZ7VB4DEM6DbW2MxvEbpV8eIOnCD/d/1T4CK6n
         pLJUzAQx3o3ug62CpP4352LQHN0BIqT/liOZN8TVA+3SKuj/Sgj+3QS1jWvJQXGE23Ru
         JsPvu0a1AK7s3R7pSSFweE6hBgDa/fkZOzwwJliorIgQcFpLOSHM8o3E7reFTHzDGdZJ
         8SO05u3sOWB62TSXdK5BPnh+ZmEWkcEWB2itgUHJUrpebF23s9j+A8mrRtoz4At5WMYK
         1KqA==
X-Gm-Message-State: AOJu0YwckDrsPz07gRTMv2LHhRNKgSe2F7DAcHMh6sZILqKPmIRzsRXQ
	sxnsIovhDKKN3U/j710LMUWkCDEB9dtKaLp/jY4=
X-Google-Smtp-Source: AGHT+IGqjI9xDRCac0UceOFqt0vX824kkW2ND802Eyvjb1SIbpQLtxWx8Z1R8xbNpYBRFWRj2A0SOw==
X-Received: by 2002:a05:6512:788:b0:4f9:596d:c803 with SMTP id x8-20020a056512078800b004f9596dc803mr3597303lfr.53.1693481425323;
        Thu, 31 Aug 2023 04:30:25 -0700 (PDT)
Received: from nuoska (dsl-olubng11-54f814-94.dhcp.inet.fi. [84.248.20.94])
        by smtp.gmail.com with ESMTPSA id w3-20020ac24423000000b004fe84fde6cesm221108lfl.31.2023.08.31.04.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 04:30:24 -0700 (PDT)
From: Mikko Rapeli <mikko.rapeli@linaro.org>
X-Google-Original-From: Mikko Rapeli <builder@linaro.org>
Date: Thu, 31 Aug 2023 14:30:22 +0300
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH] command: Avoid time intensive
 distractions for ping
Message-ID: <ZPB5zs4on6u4mOgd@nuoska>
References: <20230830213303.2043607-1-richard.purdie@linuxfoundation.org>
 <ZPBUpN6GaATE+zbz@nuoska>
 <90096957449e6a35b3f2b349cb07132e0ef6a951.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90096957449e6a35b3f2b349cb07132e0ef6a951.camel@linuxfoundation.org>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 31 Aug 2023 11:30:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14996

Hi,

On Thu, Aug 31, 2023 at 09:56:33AM +0100, Richard Purdie wrote:
> On Thu, 2023-08-31 at 11:51 +0300, Mikko Rapeli wrote:
> > Hi,
> > 
> > On Wed, Aug 30, 2023 at 10:33:03PM +0100, Richard Purdie wrote:
> > > We noticed some users were seeing very slow ping response times which
> > > caused 'server timeout' issues. There were some function calls in runCommand
> > > which could be slow such as the inotify callback processing.
> > 
> > I guess the error looks like:
> > 
> > Timeout while waiting for a reply from the bitbake server (60s)
> > 
> > and happens right after a succesful build to me when I try to run any bitbake
> > command.
> > 
> > Hope this fixes it. Thanks!
> 
> That is the message however the cause may be different in your case. It
> sounds like the server may be taking a long time to shut down for you
> and it can't connect or start a new one whilst that is happening.
> 
> If you have the bitbake-cookerdaemon log for your case I can see if
> that sheds any light if this doesn't work for you.

(Traceback (most recent call last):
  File "/home/builder/src/base/poky/bitbake/lib/bb/server/process.py", line 292, in main
    self.command_channel_reply.send(self.cooker.command.runCommand(command, self))
  File "/home/builder/src/base/poky/bitbake/lib/bb/server/process.py", line 868, in send
    self._send(obj)
  File "/home/builder/src/base/poky/bitbake/lib/bb/server/process.py", line 847, in _send
    self.writer.send_bytes(obj)
  File "/usr/lib/python3.10/multiprocessing/connection.py", line 200, in send_bytes
    self._send_bytes(m[offset:offset + size])
  File "/usr/lib/python3.10/multiprocessing/connection.py", line 411, in _send_bytes
    self._send(header + buf)
  File "/usr/lib/python3.10/multiprocessing/connection.py", line 368, in _send
    n = write(self._handle, buf)
BrokenPipeError: [Errno 32] Broken pipe
)
4131625 12:21:32.806544 Processing Client
4131625 12:21:32.806635 Disconnecting Client (socket: True)
4131625 12:21:32.807999 No timeout, exiting.
4131625 12:21:32.908254 Exiting (socket: True)
4131625 12:21:32.982669 More than one thread left?: [<_MainThread(MainThread, started 140013699211712)>, <Thread(asyncio_0, started 140012031006272)>]
4131625 12:21:34.433909 Exiting as we could obtain the lock
sys:1: ResourceWarning: unclosed file <_io.TextIOWrapper name='/home/builder/src/base/build/bitbake-cookerdaemon.log' mode='a+' encoding='UTF-8'>

I don't know what else to look for in the log.

Cheers,

-Mikko

