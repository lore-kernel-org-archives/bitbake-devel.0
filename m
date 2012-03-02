Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1S3VOn-0000AM-MP for bitbake-devel@lists.openembedded.org;
	Fri, 02 Mar 2012 17:32:06 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q22GNWMo002944;
	Fri, 2 Mar 2012 16:23:32 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 02151-06; Fri,  2 Mar 2012 16:23:27 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q22GNPNG002937
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 2 Mar 2012 16:23:26 GMT
Message-ID: <1330705408.309.11.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Lianhao Lu <lianhao.lu@intel.com>
Date: Fri, 02 Mar 2012 16:23:28 +0000
In-Reply-To: <29a54217de335d06c3c596ab7add22e218590006.1330678346.git.lianhao.lu@intel.com>
References: <cover.1330678346.git.lianhao.lu@intel.com>
	<29a54217de335d06c3c596ab7add22e218590006.1330678346.git.lianhao.lu@intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] bitbake/bitbake-prserv: Set file mode bits "x".
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
X-List-Received-Date: Fri, 02 Mar 2012 16:32:06 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-03-02 at 16:54 +0800, Lianhao Lu wrote:
> [YOCTO #2051] Set 'x' bit to make bitbake-prserv executable.
> 
> Signed-off-by: Lianhao Lu <lianhao.lu@intel.com>
> ---
>  0 files changed, 0 insertions(+), 0 deletions(-)
>  mode change 100644 => 100755 bitbake/bin/bitbake-prserv
> 
> diff --git a/bitbake/bin/bitbake-prserv b/bitbake/bin/bitbake-prserv
> old mode 100644
> new mode 100755

The bitbake repository seemed to be ok, the poky one was not. I've
therefore applied this to poky, thanks.

Richard



