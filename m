Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TR7W0-00019A-9I for bitbake-devel@lists.openembedded.org;
	Wed, 24 Oct 2012 22:25:24 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q9OKBher007405;
	Wed, 24 Oct 2012 21:11:43 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 06617-05; Wed, 24 Oct 2012 21:11:39 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q9OKBYft007399
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 24 Oct 2012 21:11:34 +0100
Message-ID: <1351109494.22340.129.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Cristiana Voicu <cristiana.voicu@intel.com>
Date: Wed, 24 Oct 2012 21:11:34 +0100
In-Reply-To: <1350462347-25888-1-git-send-email-cristiana.voicu@intel.com>
References: <1350462347-25888-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] hob/builddetailspage: set "Log" page as default
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
X-List-Received-Date: Wed, 24 Oct 2012 20:25:24 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-10-17 at 11:25 +0300, Cristiana Voicu wrote:
> - when you do a build you should see "Log" page, not
> "Build configuration" page
> 
> [YOCTO #2569]
> 
> Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>

Merged to master, thanks.

Richard



