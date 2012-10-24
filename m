Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TR7Wt-0001CR-5t for bitbake-devel@lists.openembedded.org;
	Wed, 24 Oct 2012 22:26:19 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q9OKClgQ007434;
	Wed, 24 Oct 2012 21:12:47 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 06391-10; Wed, 24 Oct 2012 21:12:42 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q9OKCdLh007428
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 24 Oct 2012 21:12:40 +0100
Message-ID: <1351109559.22340.132.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Bogdan Marinescu <bogdan.a.marinescu@intel.com>
Date: Wed, 24 Oct 2012 21:12:39 +0100
In-Reply-To: <1349955907-6440-1-git-send-email-bogdan.a.marinescu@intel.com>
References: <1349955907-6440-1-git-send-email-bogdan.a.marinescu@intel.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 2/2] Add a button for network tests in the proxy settings
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
X-List-Received-Date: Wed, 24 Oct 2012 20:26:19 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-10-11 at 14:45 +0300, Bogdan Marinescu wrote:
> This patch allows the user to check the network connectivity in
> the "Proxy" page ("Settings" dialog) by adding a button which provides
> this functionality. It also disables retrigerring sanity checks if the
> proxy values are changed, since now the proxy checks are explicit.
> Note that this patch depends on a patch in oe-core
> ("sanity.bbclass: trigger network tests explicitly"). It will
> not work properly if the patch in oe-core is not merged.
> 
> [YOCTO #3026]
> 
> Signed-off-by: Bogdan Marinescu <bogdan.a.marinescu@intel.com>

Merged to master, thanks.

Richard



