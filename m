Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SouZv-0004PN-O0 for bitbake-devel@lists.openembedded.org;
	Wed, 11 Jul 2012 12:55:31 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q6BAiK9v002984;
	Wed, 11 Jul 2012 11:44:20 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 01796-08; Wed, 11 Jul 2012 11:44:16 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q6BAiAoV002978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 11 Jul 2012 11:44:11 +0100
Message-ID: <1342003451.7934.8.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: wenzong.fan@windriver.com
Date: Wed, 11 Jul 2012 11:44:11 +0100
In-Reply-To: <05c49df922dac41a9d86377c1400ae2ef58fe4ae.1341977062.git.wenzong.fan@windriver.com>
References: <cover.1341977062.git.wenzong.fan@windriver.com>
	<05c49df922dac41a9d86377c1400ae2ef58fe4ae.1341977062.git.wenzong.fan@windriver.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] bitbake: Abort build if runtime dependency conflict
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
X-List-Received-Date: Wed, 11 Jul 2012 10:55:32 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-07-11 at 11:28 +0800, wenzong.fan@windriver.com wrote:
> From: Wenzong Fan <wenzong.fan@windriver.com>
> 
> Currently if there are multiple preferred providers available for
> a runtime dependency, bitbake will print an Error message and let
> the build go on. Anyways the build should abort while any Errors
> occured.
> 
> [YOCTO #2734]
> 
> Signed-off-by: Wenzong Fan <wenzong.fan@windriver.com>
> ---
>  bitbake/lib/bb/providers.py |    2 ++
>  bitbake/lib/bb/taskdata.py  |    3 ++-
>  2 files changed, 4 insertions(+), 1 deletions(-)

Merged to master, thanks.

Richard



