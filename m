Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SwwXl-0002Ob-Ej for bitbake-devel@lists.openembedded.org;
	Thu, 02 Aug 2012 16:38:29 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q72EQodB008790;
	Thu, 2 Aug 2012 15:26:50 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 05174-04; Thu,  2 Aug 2012 15:26:46 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q72EQgcr008784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 2 Aug 2012 15:26:43 +0100
Message-ID: <1343917603.9756.75.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Kang Kai <kai.kang@windriver.com>
Date: Thu, 02 Aug 2012 15:26:43 +0100
In-Reply-To: <cover.1343378110.git.kai.kang@windriver.com>
References: <cover.1343378110.git.kai.kang@windriver.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: Re: [PATCH 0/2] V3: hob check disk size
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
X-List-Received-Date: Thu, 02 Aug 2012 14:38:29 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-07-27 at 16:38 +0800, Kang Kai wrote:
> Hi Richard,
> 
> In V3 I fire the event DiskFull in diskMonitor.check() as your commented.
> 
> Thanks,
> Kai
> 
> The following changes since commit 0ffb02eec2beaea27ff0ec9d3d31b0a09e675a4c:
> 
>   documentation: Updated the h6 style to use a larger font (2012-07-24 10:35:34 +0100)
> 
> are available in the git repository at:
>   git://git.pokylinux.org/poky-contrib kangkai/hob-check-size
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=kangkai/hob-check-size
> 
> Kang Kai (2):
>   monitordisk: fire event DISKFULL when terminate build
>   hob: deal event DiskFull

Looks much cleaner, thanks for the changes. Merged to master, thanks.

Richard



