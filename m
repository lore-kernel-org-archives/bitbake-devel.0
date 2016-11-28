Return-Path: <patrick.ohly@intel.com>
Received: from mail-oi0-f41.google.com (mail-oi0-f41.google.com
	[209.85.218.41])
	by mail.openembedded.org (Postfix) with ESMTP id 9F25C71B56
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Nov 2016 16:30:15 +0000 (UTC)
Received: by mail-oi0-f41.google.com with SMTP id w63so156570849oiw.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Nov 2016 08:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:organization:mime-version:content-transfer-encoding;
	bh=MsFegMKP4pTZFOpvMHCXUIdkS+NDZh/fRDBUk8W92LY=;
	b=iEAfKSjNOPe9gRAkLdFVBH30JHKDisim18BN2kZ3C4ZswScINzQadrYo7EfyzsV1JC
	gIPMRMwk2vBbNUDcRZKvvZMt4x+pgyBFzc+P/MW4OAj25tiQGjjE50sPwxNzZWkADo2d
	2Byu2qtpCuerR89G736C33qvLA53WxxMxaCgnrfAgiRiiGnEPYd+xTxUGLLyN4UmnjH2
	Zlo9O1eIP8MrtQGh0N1TYN8se/NoJ2p29Sv7nntE3HGU9e0QSV4vOFHY0h8J0m6r0v96
	ozRlLhps6JjHUgMtIuho/B5vzT6cO6vqNVXCsRD+DQ1P0jf40ieaHWK3TeoBPOf9n0Hs
	3ATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:organization:mime-version:content-transfer-encoding;
	bh=MsFegMKP4pTZFOpvMHCXUIdkS+NDZh/fRDBUk8W92LY=;
	b=kPHBJU553odieq1fUbUlnKRBzqfEmDPY+0o7NOuHFX07Qx7R91+5Uk8MA/5oOQpkWv
	+cywiExf9QXWFN+yubFLelC0gPBNbOwcHmtcKcerhSm+HEUssglW6K/uuEcKxLZYywKY
	/l3ilwIcIDExddg9Qzpht2F57eypiOoTBbzFodpWoByLSHdn8/1SEvRhpbJg5UO7bYOj
	BxuBQbDa3gZqKwKAZYuK5KgkM9EodwWKYeQo1ZjSYDZnduHmxwY96K+pdr1u72BRN2UL
	PI3dIhA8DDBYC22d4rGtAwkvD9fmfOITGgxIzzjKhV371CHsoelB6o0AOTtMtW8+CfxZ
	4NXQ==
X-Gm-Message-State: AKaTC00eyvNn5X18nA2ZTSi6qKAzAACWb9OgR0zb91EIc/TXCfWgaA/wNNUa0CDScqrFQcx1
X-Received: by 10.36.156.132 with SMTP id b126mr18474467ite.91.1480350617010; 
	Mon, 28 Nov 2016 08:30:17 -0800 (PST)
Received: from pohly-mobl1 (p5DE8C83A.dip0.t-ipconnect.de. [93.232.200.58])
	by smtp.gmail.com with ESMTPSA id
	j189sm20126656ioe.14.2016.11.28.08.30.15
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 28 Nov 2016 08:30:16 -0800 (PST)
Message-ID: <1480350613.6873.199.camel@intel.com>
From: Patrick Ohly <patrick.ohly@intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Mon, 28 Nov 2016 17:30:13 +0100
In-Reply-To: <1480348730.28508.185.camel@linuxfoundation.org>
References: <90660fc75cc3fedceabef02ac2ade99d7c26fbb2.1480345719.git.patrick.ohly@intel.com>
	<4a82fef918264b2e74022e8ed95cb198f44300c7.1480345719.git.patrick.ohly@intel.com>
	<1480348730.28508.185.camel@linuxfoundation.org>
Organization: Intel GmbH, Dornacher Strasse 1, D-85622 Feldkirchen/Munich
X-Mailer: Evolution 3.12.9-1+b1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 2/4] runqueue.py: monitor disk space at regular time intervals
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 28 Nov 2016 16:30:17 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2016-11-28 at 15:58 +0000, Richard Purdie wrote:
> On Mon, 2016-11-28 at 16:15 +0100, Patrick Ohly wrote:
> >          # For disk space monitor
> > +        # Invoked at regular time intervals via the bitbake
> > heartbeat event
> > +        # while the build is running.
> >          self.dm = monitordisk.diskMonitor(cfgData)
> > +        bb.event.register('_bb_diskmonitor',
> > +                          lambda x: self.dm.check(self) if
> > self.state in [runQueueSceneRun, runQueueRunning, runQueueCleanUp]
> > else False,
> > +                          ('bb.event.HeartbeatEvent',))
> >  
[...]
> Don't we have to unregister this at some point too? Cooker can persist
> across multiple builds (although its not the default).

Indeed, that case will need further work. I hadn't considered that. What
would be a good point to unregister the event handler? Perhaps the
cleanup code after "if (self.state is runQueueComplete or self.state is
runQueueFailed) and self.rqexe" in _execute_runqueue()?

Just for my understanding, is there guaranteed to be only one RunQueue
instance in the cooker process or could there be more than one at the
same time? Can there be more than one event handler with the same name
(the first parameter of bb.event.register)?

Is the non-default case the memory-resident bitbake?

The buildstats.py code I posted for OE-core has a similar issue. It
assumes that files can be opened when the class gets instantiated and
kept open as long as the process runs.

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.




