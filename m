Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 823C870644
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Jul 2014 19:08:34 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s6NJ8TxY011595; Wed, 23 Jul 2014 20:08:30 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id FcC5sw8LroxS; Wed, 23 Jul 2014 20:08:29 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s6NJ8MIc011233
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 23 Jul 2014 20:08:24 +0100
Message-ID: <1406142502.22985.128.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Damian, Alexandru" <alexandru.damian@intel.com>
Date: Wed, 23 Jul 2014 20:08:22 +0100
In-Reply-To: <CAJ2CSBuuD9Qv=YdkGmzRY3ev9zJ=cESm_-Bg8BdDTnOvkOm+dQ@mail.gmail.com>
References: <CAJ2CSBuuD9Qv=YdkGmzRY3ev9zJ=cESm_-Bg8BdDTnOvkOm+dQ@mail.gmail.com>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: Paul Eggleton <paul.eggleton@linux.intel.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>,
	"toaster@yoctoproject.org" <toaster@yoctoproject.org>
Subject: Re: Toaster patchset for merging
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 23 Jul 2014 19:08:36 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Wed, 2014-07-23 at 18:16 +0100, Damian, Alexandru wrote:
> Hi Richard,
> 
> 
> Thanks for the test push on master-next.
> 
> 
> I tested master-next and it works fine !
> 
> 
> However, on prompt from Paul, I refactored the patchset to proper
> spell out changes in the commit messages.
> 
> 
> Can you please pull:
> 
> 
> poky-contrib: adamian/20140723-master-next-refactored
> 
> ​
> The final diff between this new branch and master-next is NIL, but the
> commit messages are updated.
> 
Thanks, its merged.

Cheers,

Richard



