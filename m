Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1U9ysF-0003Vm-9O for bitbake-devel@lists.openembedded.org;
	Mon, 25 Feb 2013 15:18:09 +0100
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r1PE8Yng018023; Mon, 25 Feb 2013 14:08:34 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id yQ1p38RuwsNc; Mon, 25 Feb 2013 14:08:34 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r1PE8NAB018019
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Mon, 25 Feb 2013 14:08:29 GMT
Message-ID: <1361800868.25338.79.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Trevor Woerner <twoerner@gmail.com>
Date: Mon, 25 Feb 2013 06:01:08 -0800
In-Reply-To: <CAHUNapR3-Z57mPUScW6TnptFbawE3y=+bCcpnTVVfAy-2KjwjA@mail.gmail.com>
References: <CALbNGRRDr+6vLtJRDgRi1NbO+s0sUB5TLT7uTck5L5La6xfDQw@mail.gmail.com>
	<CABcZANn3JbnhTEEP85K5bxXQd9ipYmuP9-bqMizpw+z9R3HhiQ@mail.gmail.com>
	<CAPhnLPCYxVk8F72Tv=PJo2OQJQmMdN0RKXNmTj_JeVy+7VJ+qA@mail.gmail.com>
	<CAPhnLPBwwM84Pu25od0pLr2446-RSbGsDHQbayQE3g+xNV2tkw@mail.gmail.com>
	<CALbNGRSioFk7F3W9yp_VbHz6sXP-LjUtg0DqJorZmyHt_+J2sw@mail.gmail.com>
	<CABxcv=kdCzvj=Z4GDtYC4P-az9LnT5VhrspRrZq8p568uPo9QA@mail.gmail.com>
	<CALbNGRSZeOC0Tyv1-x6og6g+HOD148PUdCWcONYBE_YUQ7FASA@mail.gmail.com>
	<CAHUNapR3-Z57mPUScW6TnptFbawE3y=+bCcpnTVVfAy-2KjwjA@mail.gmail.com>
X-Mailer: Evolution 3.6.3-1 
Mime-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [meta-ti] trouble during parsing
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
X-List-Received-Date: Mon, 25 Feb 2013 14:18:11 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2013-02-25 at 08:44 -0500, Trevor Woerner wrote:
> If the purpose of the ls-remote is to match a tag with a hash,
> wouldn't it be easier to just:
> 
>     cat .git/refs/tags/<tagid>
> 
> ?

If the git clone hasn't happened yet, this doesn't work.

> And if the purpose of knowing the tagid is to use that version of the
> code, wouldn't it be easier to just:
> 
>     git checkout <tagid>

That isn't the only purpose.

Cheers,

Richard



