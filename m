Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1S6uxN-0003se-Pl for bitbake-devel@lists.openembedded.org;
	Mon, 12 Mar 2012 03:25:53 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2C2H9iv009680;
	Mon, 12 Mar 2012 02:17:09 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 06332-10; Mon, 12 Mar 2012 02:17:05 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q2C2H21X009674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 12 Mar 2012 02:17:03 GMT
Message-ID: <1331518622.15192.10.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
Date: Mon, 12 Mar 2012 02:17:02 +0000
In-Reply-To: <cover.1330734444.git.josh@linux.intel.com>
References: <cover.1330734444.git.josh@linux.intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/6] Hob GUI add persistent tooltips and use custom info icon consistently
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
X-List-Received-Date: Mon, 12 Mar 2012 02:25:54 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-03-02 at 16:39 -0800, Joshua Lock wrote:
> asldlasjd
> 
> The following changes since commit 4a480a052f450c4ee061ab0e60a495a45f140cf9:
> 
>   stderr would previously be appended to stdout, corrupting the result when something was outputed to stderr but exit code was still 0 (non-fatal warning messages). This commit makes the code parse only stdout, but output stderr if an error happened. (2012-03-02 16:17:43 +0000)
> 
> are available in the git repository at:
>   git://github.com/incandescant/bitbake josh/hob
>   https://github.com/incandescant/bitbake/tree/josh/hob
> 
> and as a poky repository at:
>   git://git.yoctoproject.org/poky-contrib josh/hob
>   http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/log/?h=josh/hob
> 
> Joshua Lock (6):
>   crumbs/persistenttooltip: a new Gtk+ widget for use in Hob
>   ui/icons: crop the info icons
>   ui/crumbs/hobwidget: implement HobInfoButton per Hob interaction
>     design
>   ui/crumbs/imageconfigurationpage: make use of the HobInfoButton
>   ui/crumbs/hig: use HobInfoButton in place of gtk.Image with tooltip
>   ui/crumbs/hig: special case stock info icons in CrumbsMesssageDialog

Merged to master, thanks.

Richard



