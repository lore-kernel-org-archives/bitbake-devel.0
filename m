Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SWNd9-0007C7-F0 for bitbake-devel@lists.openembedded.org;
	Mon, 21 May 2012 10:06:15 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4L7u5oT018613;
	Mon, 21 May 2012 08:56:05 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 18004-01; Mon, 21 May 2012 08:56:01 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4L7ttx5018607
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 21 May 2012 08:55:56 +0100
Message-ID: <1337586954.11345.601.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Dongxiao Xu <dongxiao.xu@intel.com>
Date: Mon, 21 May 2012 08:55:54 +0100
In-Reply-To: <00949d15d6a5109294db49986497ac19df93f73b.1337060999.git.dongxiao.xu@intel.com>
References: <cover.1337060999.git.dongxiao.xu@intel.com>
	<00949d15d6a5109294db49986497ac19df93f73b.1337060999.git.dongxiao.xu@intel.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/2] Hob: Add filter for images listed in image combo
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
X-List-Received-Date: Mon, 21 May 2012 08:06:15 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-05-15 at 13:52 +0800, Dongxiao Xu wrote:
> Define IMAGE_WHITE_PATTERN variable to indicate which image is allowed
> to be displayed in image combobox.
> 
> Define IMAGE_BLACK_PATTERN variable to indicate which image is NOT
> allowed to be displayed in image combobox.
> 
> This fixes [YOCTO #1581]

We need to namespace these with "BB" to indicate they're bitbake
variables, BBUI might be better again.

Cheers,

Richard



