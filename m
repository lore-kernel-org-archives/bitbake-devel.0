Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SW1kP-00089Z-0M for bitbake-devel@lists.openembedded.org;
	Sun, 20 May 2012 10:44:17 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4K8XuGJ010560;
	Sun, 20 May 2012 09:33:56 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 03358-08; Sun, 20 May 2012 09:33:52 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4K8XkcJ010554
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 20 May 2012 09:33:47 +0100
Message-ID: <1337502826.28145.23.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "An, LimingX L" <limingx.l.an@intel.com>
Date: Sun, 20 May 2012 09:33:46 +0100
In-Reply-To: <E5BAA81A5E0FB344B2B234D4FBAC45DC0FCDC64D@SHSMSX102.ccr.corp.intel.com>
References: <cover.1334359238.git.josh@linux.intel.com>
	<1334398981.7309.98.camel@ted>
	<E5BAA81A5E0FB344B2B234D4FBAC45DC0FCDC64D@SHSMSX102.ccr.corp.intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 0/4] Replace HobNotebook with gtk.Notebook, comments invited
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
X-List-Received-Date: Sun, 20 May 2012 08:44:17 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-05-10 at 06:31 +0000, An, LimingX L wrote:
> Hi Richard,
> 
> There are still some issues in these patches, but I think we can check
> in first and I also have some fixes which depends on the check-in. I
> will submit the patches to fix them as long as they are pulled in.
> 
> Please to review. Thanks!

I've merged this, please send the other fixes for review.

Cheers,

Richard



