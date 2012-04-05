Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SFmT7-0003sb-2o for bitbake-devel@lists.openembedded.org;
	Thu, 05 Apr 2012 15:11:17 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q35D24E0025637;
	Thu, 5 Apr 2012 14:02:04 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 25015-05; Thu,  5 Apr 2012 14:01:59 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q35D1scm025631
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 5 Apr 2012 14:01:57 +0100
Message-ID: <1333630913.6300.13.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Joshua Lock <josh@linux.intel.com>
Date: Thu, 05 Apr 2012 14:01:53 +0100
In-Reply-To: <44c725f736689467b237b57d5c2bfe4f7d937bc5.1333499344.git.josh@linux.intel.com>
References: <cover.1333499343.git.josh@linux.intel.com>
	<44c725f736689467b237b57d5c2bfe4f7d937bc5.1333499344.git.josh@linux.intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] lib/bb/ui/hob: exit cleanly if the required pygtk version isn't available
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
X-List-Received-Date: Thu, 05 Apr 2012 13:11:17 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-04-03 at 17:35 -0700, Joshua Lock wrote:
> Hob uses API from pygtk 2.22, therefore check to see whether this
> version is available and exit cleanly if not.
> 
> Signed-off-by: Joshua Lock <josh@linux.intel.com>
> ---
>  lib/bb/ui/hob.py |   13 +++++++++++--
>  1 files changed, 11 insertions(+), 2 deletions(-)

Merged to master, thanks.

Richard



