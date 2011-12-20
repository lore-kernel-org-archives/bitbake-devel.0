Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RczeI-0002V3-82 for bitbake-devel@lists.openembedded.org;
	Tue, 20 Dec 2011 14:22:30 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pBKDFMPK029336;
	Tue, 20 Dec 2011 13:15:22 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 28967-02; Tue, 20 Dec 2011 13:15:16 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pBKDF3Vg029320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 20 Dec 2011 13:15:05 GMT
Message-ID: <1324386905.28872.15.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
Date: Tue, 20 Dec 2011 13:15:05 +0000
In-Reply-To: <cover.1323815814.git.josh@linux.intel.com>
References: <cover.1323815814.git.josh@linux.intel.com>
X-Mailer: Evolution 3.2.1- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/2] Hob v1 related fixes
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
X-List-Received-Date: Tue, 20 Dec 2011 13:22:30 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2011-12-13 at 14:45 -0800, Joshua Lock wrote:
> This series works around a couple of issues which I'd like to address for the
> Yocto Edison 1.1.1 release.
> 
> Regards,
> Joshua
> 
> The following changes since commit 71b53a3f0766ca464560a1f6a449f9424fbdf7ae:
> 
>   siggen.py: If both sigs have a variable in it's whitelist then don't say it's changed (2011-12-05 16:17:38 +0000)
> 
> are available in the git repository at:
>   git://github.com/incandescant/bitbake hob
>   https://github.com/incandescant/bitbake/tree/hob
> 
> Joshua Lock (2):
>   ui/crumbs/runningbuild: handle InvalidTask events
>   ui/crumbs/hobprefs: trigger a reparse after changing IMAGE_FSTYPES

Merged to master, thanks.

Richard



