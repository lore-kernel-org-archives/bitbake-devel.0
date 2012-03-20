Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SA0HW-0002m2-Uk for bitbake-devel@lists.openembedded.org;
	Tue, 20 Mar 2012 15:43:27 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2KEYXAC010993;
	Tue, 20 Mar 2012 14:34:33 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 09853-08; Tue, 20 Mar 2012 14:34:29 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2KEYNgl010987
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 20 Mar 2012 14:34:24 GMT
Message-ID: <1332254065.9740.92.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
Date: Tue, 20 Mar 2012 14:34:25 +0000
In-Reply-To: <cover.1332202341.git.josh@linux.intel.com>
References: <cover.1332202341.git.josh@linux.intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/6] Hob tweaks
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
X-List-Received-Date: Tue, 20 Mar 2012 14:43:27 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2012-03-19 at 17:18 -0700, Joshua Lock wrote:
> Here's a series of patches to polish the Hob GUI: some minor tweaks to remove
> redundant calls and API, a couple of HIG related tweaks to buttons, a change to
> the persistenttooltip to try and match the close position of the window manager
> (i.e. running under Unity on Ubuntu the close button on the persistent tooltip
> will appear on the left) and finally a change to the layer dialogue implementation
> so that it more closely matches the interaction design (this is still pending
> some designer feedback on visuals and whether to remove some labels but they can
> easily be implemented as iterative patches on top of these).
> 
> Cheers,
> 
> Joshua
> 
> The following changes since commit 5a1e62a8cdd4f0253b0dc59046b3b4c3186af461:
> 
>   bitbake/fetch2: Fix typo which broke use of tarballs (2012-03-16 23:44:08 +0000)
> 
> are available in the git repository at:
>   git://github.com/incandescant/bitbake josh/hob
>   https://github.com/incandescant/bitbake/tree/josh/hob
>   git://git.yoctoproject.org/poky-contrib josh/hob
>   http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/log/?h=josh/hob
> 
> Joshua Lock (6):
>   ui/crumbs/hig: use close rather than OK for dismis button
>   ui/crumbs: remove unused return value from append_toolbar_button
>   ui/crumbs/hobpage: no need to force a Toolbar button type
>   ui/crumbs/persistenttooltip: try to reflect WM close button position
>   ui/crumbs/builder: remove OK/Cancel buttons on Layer dialog. Use
>     Close.
>   ui/crumbs/hig: make the layer selection dialogue more closely match
>     design

I've merged the first four, the last two seemed to be being discussed...

Cheers,

Richard



