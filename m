Return-Path: <jason.wessel@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 6E9D16BB90
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Aug 2013 20:11:47 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id r7RKBjCe017891
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 27 Aug 2013 13:11:45 -0700 (PDT)
Received: from [172.25.32.37] (172.25.32.37) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.2.342.3;
	Tue, 27 Aug 2013 13:11:45 -0700
Message-ID: <521D07FF.9000507@windriver.com>
Date: Tue, 27 Aug 2013 15:11:43 -0500
From: Jason Wessel <jason.wessel@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:17.0) Gecko/20130308 Thunderbird/17.0.4
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <1377346040.6762.186.camel@ted>
In-Reply-To: <1377346040.6762.186.camel@ted>
X-Enigmail-Version: 1.5.2
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] process: Improve exit handling and hangs
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
X-List-Received-Date: Tue, 27 Aug 2013 20:11:48 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On 08/24/2013 07:07 AM, Richard Purdie wrote:
> It turns out we have a number of different ways the process server termination can
> hang. If we call cancel_join_thread() on the event queue, it means that it can be left
> containing partial data. This means the reading of the event queue in the terminate()
> function can hang, the timeout and block parameters to Queue.get() don't make any
> difference.
>
> Equally, if we don't call cancel_join_thread(), the join_thread in terminate()
> will hang giving a different deadlock.
>
> The best solution I could find is to loop over the process is_alive() after requesting
> it stops,  trying to join the thread and if that fails, try and flush the event
> queue again.
>
> It wasn't clear what difference a force option should make in this case, we're
> gracefully trying to empty queues and shut down regardless of whether its a SIGTERM
> so I've simply removed the force option.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>
> Jason: Not sure if this or the other patch will help the hang you are
> seeing or not but they seem like good changes regardless and fix real
> world issues.


Certainly the behavior is a bit better with your additional patches, but it is not the root of the problem.  I have tested your patches in the heavy load situations where we have observed all the hangs.

I'll send a patch separately along with an explanation of the root cause of the hangs in the PR Server.

As for your patches, I have reviewed and tested them:  Acked-by: Jason Wessel <jason.wessel@windriver.com>

Cheers,
Jason.


