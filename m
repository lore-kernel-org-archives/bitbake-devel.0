Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1U5FpX-00035k-PJ for bitbake-devel@lists.openembedded.org;
	Tue, 12 Feb 2013 14:23:28 +0100
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r1CDCXC5021984; Tue, 12 Feb 2013 13:13:13 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id J4v9M6XXfm6w; Tue, 12 Feb 2013 13:13:13 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r1CDD6pK021994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Tue, 12 Feb 2013 13:13:09 GMT
Message-ID: <1360674427.30425.4.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Cristiana Voicu <cristiana.voicu@intel.com>
Date: Tue, 12 Feb 2013 13:07:07 +0000
In-Reply-To: <1360663886-9545-1-git-send-email-cristiana.voicu@intel.com>
References: <1360663886-9545-1-git-send-email-cristiana.voicu@intel.com>
X-Mailer: Evolution 3.6.3-1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bitbake & hob: reparse config files, when sanity check updates bblayers.conf
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
X-List-Received-Date: Tue, 12 Feb 2013 13:23:28 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2013-02-12 at 12:11 +0200, Cristiana Voicu wrote:
> I've sent a patch to poky, with some changes in sanity.bbclass. When bblayers.conf
> is updated, it updates also a variable to know when to reparse configuration files.
> This patch contains the changes to reparse conf files, after a sanity check which
> changes bblayers.conf.
> 
> [YOCTO #3213]
> Signed-off-by: Cristiana Voicu <cristiana.voicu@intel.com>
> ---
>  bitbake/lib/bb/cooker.py                    |   14 ++++++++++----
>  bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    4 ++++
>  2 files changed, 14 insertions(+), 4 deletions(-)

Can we rename this variable please, its not well namespaced.
BB_INVALIDCONF would probably be a better name to indicate what the
problem is, not the solution and the BB prefix indicates its something
BitBake is expected to act upon.

Cheers,

Richard




