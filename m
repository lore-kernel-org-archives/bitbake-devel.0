Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1RYHEl-00051s-GS for bitbake-devel@lists.openembedded.org;
	Wed, 07 Dec 2011 14:08:39 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pB7D1nVE013145;
	Wed, 7 Dec 2011 13:01:49 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 11271-10; Wed,  7 Dec 2011 13:01:45 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id pB7D1cMa013139
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 7 Dec 2011 13:01:39 GMT
Message-ID: <1323262909.30601.13.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>
Date: Wed, 07 Dec 2011 13:01:49 +0000
In-Reply-To: <4EDC3A0B.4060301@windriver.com>
References: <4EDC3A0B.4060301@windriver.com>
X-Mailer: Evolution 3.2.1- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org, "Rifenbark,
	Scott M" <scott.m.rifenbark@intel.com>
Subject: Re: How bitbake works(Draft)
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
X-List-Received-Date: Wed, 07 Dec 2011 13:08:39 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi Robert,

On Mon, 2011-12-05 at 11:27 +0800, Robert Yang wrote:
> Here is a doc about how bitbake works, it may help the bitbake
> newbie to understand how bitbake works, I'm very glad to add it
> to the public bitbake repository as documentation if it is useful.
> please feel free to give you comments.

I like this and I do think we need to improve the bitbake documentation.
We do need to ensure there is some consistent style and format for the
documents though so anything going into the repository really needs to
be added to the existing manual.

I'm also a little concerned that in its current form (listing arguments
to functions), this documentation would be high maintenance. If we could
separate it from the code implementation details a little bit, I think
it would make it less likely to bitrot quite as quickly.

Cheers,

Richard



