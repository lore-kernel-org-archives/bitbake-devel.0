Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Stbjd-0004bZ-Cd for bitbake-devel@lists.openembedded.org;
	Tue, 24 Jul 2012 11:48:57 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q6O9bQZN029165;
	Tue, 24 Jul 2012 10:37:26 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 28768-02; Tue, 24 Jul 2012 10:37:21 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q6O9bGXh029159
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 24 Jul 2012 10:37:18 +0100
Message-ID: <1343122636.22222.1.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: nitin.a.kamble@intel.com
Date: Tue, 24 Jul 2012 10:37:16 +0100
In-Reply-To: <6af334f77b2e8bdbcc536fe777c57e4ac646f71b.1342635547.git.nitin.a.kamble@intel.com>
References: <cover.1342635547.git.nitin.a.kamble@intel.com>
	<6af334f77b2e8bdbcc536fe777c57e4ac646f71b.1342635547.git.nitin.a.kamble@intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] bitbake wget fetcher: add parameter: downloadfilename
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
X-List-Received-Date: Tue, 24 Jul 2012 09:48:57 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-07-18 at 17:39 -0700, nitin.a.kamble@intel.com wrote:
> From: Nitin A Kamble <nitin.a.kamble@intel.com>
> 
> this allows wget fetcher to store the downloaded file in a specified custom filename in ${DL_DIR}
> 
> Exmaple:
> SRC_URI = "https://edc.intel.com/Download.aspx?id=6190;downloadfilename=LIN_IEMGD_1_14_GOLD_2443.tgz"
> 
> This fixes bug:
> [YOCTO #2570]
> 
> Signed-off-by: Nitin A Kamble <nitin.a.kamble@intel.com>
> ---
>  bitbake/lib/bb/fetch2/wget.py |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)

Merged to master, thanks.

Richard



