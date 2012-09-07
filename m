Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1T9waF-0003iE-Pu for bitbake-devel@lists.openembedded.org;
	Fri, 07 Sep 2012 13:18:48 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q87B6Knw028371;
	Fri, 7 Sep 2012 12:06:20 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 27749-07; Fri,  7 Sep 2012 12:06:16 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q87B6B0C028364
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 7 Sep 2012 12:06:12 +0100
Message-ID: <1347015972.7493.54.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Bogdan Marinescu <bogdan.a.marinescu@intel.com>
Date: Fri, 07 Sep 2012 12:06:12 +0100
In-Reply-To: <1346839885-29038-1-git-send-email-bogdan.a.marinescu@intel.com>
References: <1346839885-29038-1-git-send-email-bogdan.a.marinescu@intel.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] [HOB] Save toolchain in settings
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
X-List-Received-Date: Fri, 07 Sep 2012 11:18:48 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-09-05 at 13:11 +0300, Bogdan Marinescu wrote:
> Toolchain was not saved in the settings dialog ("Output" tab).
> 
> [YOCTO #2695]
> 
> Signed-off-by: Bogdan Marinescu <bogdan.a.marinescu@intel.com>
> ---
>  bitbake/lib/bb/ui/crumbs/hig.py |    1 +
>  1 file changed, 1 insertion(+)

Merged to master, thanks (but please put a prefix in the commit summary
like "crumbs/hig:" so people can easily see which piece the patch
changes in future, I tweaked this one).

Cheers,

Richard



