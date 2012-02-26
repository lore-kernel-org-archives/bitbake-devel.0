Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1S1c69-0002gf-5x for bitbake-devel@lists.openembedded.org;
	Sun, 26 Feb 2012 12:17:01 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1QB8bAC011950;
	Sun, 26 Feb 2012 11:08:37 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 11863-01; Sun, 26 Feb 2012 11:08:33 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1QB8U6e011944
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 26 Feb 2012 11:08:31 GMT
Message-ID: <1330254511.13788.61.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>
Date: Sun, 26 Feb 2012 11:08:31 +0000
In-Reply-To: <cover.1330245845.git.liezhi.yang@windriver.com>
References: <cover.1330245845.git.liezhi.yang@windriver.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/3] V5 Disk space monitoring
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
X-List-Received-Date: Sun, 26 Feb 2012 11:17:01 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2012-02-26 at 16:48 +0800, Robert Yang wrote:
> Hi Richard,
> 
> Thank you very much for your detailed review, here is V5,
> please take your review.
> 
> Changes:
> 
> * Add the patch "Fix finish_now when no running task" which is from you.
> 
> * Change the code as you suggested.
> 
> * Change the default disk interval value from "10M,50" to "50M,5K",
>   this seems a reasonable value during the testing(not too many or
>   few warnings).
> 
> * Add more explanations in local.conf.sample
> 
> // Robert
> 
> The following changes since commit 2ff96d664e8e003f64de42187fce9ad0f9646070:
> 
>   crumbs: add back progress implementation for depexp (2012-02-25 11:55:45 +0000)
> 
> are available in the git repository at:
>   git://git.pokylinux.org/poky-contrib robert/disk-space-monitor
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=robert/disk-space-monitor
> 
> Robert Yang (3):
>   Fix finish_now when no running task
>   Disk space monitoring
>   Add config sample for disk space monitoring

Merged to master, thanks. I applied the config sample to
local.conf.sample.extended though.

Cheers,

Richard



