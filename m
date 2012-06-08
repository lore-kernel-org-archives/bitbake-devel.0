Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1ScxJP-00046w-DJ for bitbake-devel@lists.openembedded.org;
	Fri, 08 Jun 2012 13:25:03 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q58BEWGb014817;
	Fri, 8 Jun 2012 12:14:32 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 14673-02; Fri,  8 Jun 2012 12:14:28 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q58BENIw014811
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 8 Jun 2012 12:14:24 +0100
Message-ID: <1339154065.30460.6.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Kang Kai <kai.kang@windriver.com>
Date: Fri, 08 Jun 2012 12:14:25 +0100
In-Reply-To: <cover.1338976258.git.kai.kang@windriver.com>
References: <cover.1338976258.git.kai.kang@windriver.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org, zhenfeng.zhao@windriver.com
Subject: Re: [PATCH 0/6] V2 hob2: some tweak and add a standalone deploy image tool
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
X-List-Received-Date: Fri, 08 Jun 2012 11:25:03 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-06-06 at 17:52 +0800, Kang Kai wrote:
> Hi Darren,
> 
> Thanks for your detailed reivew.
> 
> V2 update:
> 1. break up the commit about hig.py 
> 2. some text tweak 
> 3. remove the gtk version check
> 4. rename the standalone tool
> 
> V1:
> These 2 patches try to add a standalone deploy image tool using current codes. 
> It should be launched by run the absolute path to bitbake/bin/bitbake-deployimage,
> I'll add a shell script to wrap it under script directory.
> 
> Regards,
> Kai
> The following changes since commit de4cdfd6bc1280ac7ac0559b87734d26294ef773:
> 
>   documentation/kernel-manual/kernel-how-to.xml: Updated to kernel 3.4 (2012-05-31 21:16:55 +0100)
> 
> are available in the git repository at:
>   git://git.pokylinux.org/poky-contrib kangkai/distro
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=kangkai/distro
> 
> Kang Kai (6):
>   ui/crumbs/utils.py: import module bb
>   ui/crumbs/hig.py: fix run time error
>   ui/crumbs/hig.py: remove extra spaces
>   ui/crumbs/hig.py: check deploy process return value
>   hob2: update DeployImageDialog for seperated tool
>   hob2: create a standalone deploy image tool

Merged to master, thanks.

Richard



