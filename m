Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1S1ajx-0001BP-Hi
	for bitbake-devel@lists.openembedded.org;
	Sun, 26 Feb 2012 10:50:01 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q1Q9fadM024137
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 26 Feb 2012 01:41:36 -0800 (PST)
Received: from [128.224.162.196] (128.224.162.196) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Sun, 26 Feb 2012 01:41:35 -0800
Message-ID: <4F49FE4E.4060903@windriver.com>
Date: Sun, 26 Feb 2012 17:41:34 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:9.0) Gecko/20111229 Thunderbird/9.0
MIME-Version: 1.0
To: <bitbake-devel@lists.openembedded.org>
References: <1330185749.13788.44.camel@ted>
In-Reply-To: <1330185749.13788.44.camel@ted>
Subject: Re: [PATCH] bitbake/runqueue: Ensure finish_now() sets the runqueue state consistently
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
X-List-Received-Date: Sun, 26 Feb 2012 09:50:01 -0000
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit


Hi Richard:

I have included this patch to the "V5 Disk space monitoring" as you suggested,
I have tested it, it worked well.

// Robert

On 02/26/2012 12:02 AM, Richard Purdie wrote:
> If we call finish_now(True), rq.state is not updated to match. This
> makes the behaviour of finish_now(False) and finish_now(True) consistent
> so both leave rq.state consistently.
>
> Signed-off-by: Richard Purdie<richard.purdie@linuxfoundation.org>
>
> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
> index c24841f..26a0f85 100644
> --- a/bitbake/lib/bb/runqueue.py
> +++ b/bitbake/lib/bb/runqueue.py
> @@ -1060,6 +1060,13 @@ class RunQueueExecute:
>           for pipe in self.build_pipes:
>               self.build_pipes[pipe].read()
>
> +        if len(self.failed_fnids) != 0:
> +            self.rq.state = runQueueFailed
> +            return
> +
> +        self.rq.state = runQueueComplete
> +        return
> +
>       def finish(self):
>           self.rq.state = runQueueCleanUp
>
>
>
>
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
>


