Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1T9wMy-0003Ks-QE for bitbake-devel@lists.openembedded.org;
	Fri, 07 Sep 2012 13:05:05 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q87Aqdu8028233;
	Fri, 7 Sep 2012 11:52:39 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 27749-04; Fri,  7 Sep 2012 11:52:34 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q87AqUca028227
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 7 Sep 2012 11:52:31 +0100
Message-ID: <1347015150.7493.47.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Kang Kai <kai.kang@windriver.com>
Date: Fri, 07 Sep 2012 11:52:30 +0100
In-Reply-To: <cover.1346121294.git.kai.kang@windriver.com>
References: <cover.1346121294.git.kai.kang@windriver.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: Re: [PATCH 0/3 V2] hob2: remove hard-coded image types map
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
X-List-Received-Date: Fri, 07 Sep 2012 11:05:05 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-08-28 at 10:47 +0800, Kang Kai wrote:
> Hi Richard,
> 
> This is V2 for Yocto 2795.
> 
> Just add variable IMAGE_EXTENSION_live as you suggest, other image types are the same with the real image name extension names.
> 
> Add update the hob code accordingly.
> 
> Regards,
> Kai
> 
> The following changes since commit b4c5725af4cd85d5644f0373e2674e903c4eab2b:
> 
>   yocto-bsp: add missing xserver-xf86-config .bbappend for qemu (2012-08-25 14:47:07 +0100)
> 
> are available in the git repository at:
>   git://git.pokylinux.org/poky-contrib kangkai/hob2
>   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=kangkai/hob2
> 
> Kang Kai (3):
>   hob2: remove the hard-coded images map
>   hob2: remove class hcc
>   image_types.bbclass: add variable for Hob

Merged to master, thanks.

Richard



