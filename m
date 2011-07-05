Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Qe4vy-0004PI-Dt for bitbake-devel@lists.openembedded.org;
	Tue, 05 Jul 2011 14:40:58 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p65Cb8P6031088;
	Tue, 5 Jul 2011 13:37:08 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 30583-08; Tue,  5 Jul 2011 13:37:04 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p65Cb1mw031082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 5 Jul 2011 13:37:02 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Dexuan Cui <dexuan.cui@intel.com>
In-Reply-To: <4a14b4fcab45d1768dfc31c9de3f2efb9fe93279.1309619557.git.dexuan.cui@intel.com>
References: <cover.1309619557.git.dexuan.cui@intel.com>
	<4a14b4fcab45d1768dfc31c9de3f2efb9fe93279.1309619557.git.dexuan.cui@intel.com>
Date: Tue, 05 Jul 2011 13:36:30 +0100
Message-ID: <1309869391.20015.695.camel@rex>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1][v3] bitbake/cooker, bitbake-layers: show the .bbappend files that matches no existing .bb recipe
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
X-List-Received-Date: Tue, 05 Jul 2011 12:40:58 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sat, 2011-07-02 at 23:15 +0800, Dexuan Cui wrote:
> This patch moves the logic of show_appends_with_no_recipes from bitbake-layers
> into bitbake. By default, a fatal message is printed; we can also define a variable
> BB_DANGLINGAPPENDS_WARNONLY to make the message only a warning(the variables
> could be defined in conf/local.conf with a value "yes", "true" or "1").
> 
> Signed-off-by: Dexuan Cui <dexuan.cui@intel.com>
> ---
>  bitbake/bin/bitbake-layers |   21 +--------------------
>  bitbake/lib/bb/cooker.py   |   22 ++++++++++++++++++++++
>  2 files changed, 23 insertions(+), 20 deletions(-)

Merged to master, thanks.

Richard



