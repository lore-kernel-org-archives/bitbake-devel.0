Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RkfyC-0005rI-Ff for bitbake-devel@lists.openembedded.org;
	Tue, 10 Jan 2012 18:58:48 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q0AHpG92012581;
	Tue, 10 Jan 2012 17:51:16 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 12415-03; Tue, 10 Jan 2012 17:51:12 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q0AHp6ia012575
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 10 Jan 2012 17:51:07 GMT
Message-ID: <1326217869.23315.5.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>
Date: Tue, 10 Jan 2012 17:51:09 +0000
In-Reply-To: <bb164b343a162cee39a0ba2f76a7ffb906bc5381.1326199289.git.liezhi.yang@windriver.com>
References: <cover.1326199289.git.liezhi.yang@windriver.com>
	<bb164b343a162cee39a0ba2f76a7ffb906bc5381.1326199289.git.liezhi.yang@windriver.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/2] V2 Disk space monitoring
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 10 Jan 2012 17:58:48 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-01-10 at 20:45 +0800, Robert Yang wrote:
> * Problems:
> 
>   1) The disk space monitor is running in a sub process of
>      bin/bitbake, so it can't use the same logger as bitbake(or I don't
>      know how to use it, I've tried to use the logger.warn('some
>      information'), but it would print nothing in the subprocess),
>      another solution maybe use an independent logger in the subprocess,
>      but it seems that it doesn't worth because of the two reasons:
>      a) The logger of bin/bitbake can't control the monitor's
>         independent logger
>      b) The monitor doesn't need print many things
> 
>      It would be great if anyone could give me more instructions.

This is an issue unfortunately since its fine to have the warnings about
low space but its not much use unless bitbake can act on the warnings
somehow (stop executing more tasks for example).

I agree with Chris' comments about being able to specify the warning
threshold per directory being monitored too.

So I think before this can merge its going to need some further work. I
can't give pointers to the right way to send log messages from the
subprocess right at the moment. Perhaps you can insert yourself as an
"idle" task into bitbake's "main loop" instead of running as a
subprocess? This would also make it simpler to stop executing more
tasks. There probably should be a way for the user to choose
"immediately abort, no new tasks, show warning" as the options for
running out of space.

Cheers,

Richard



