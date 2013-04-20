Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1UTSgG-0005mT-46 for bitbake-devel@lists.openembedded.org;
	Sat, 20 Apr 2013 09:57:58 +0200
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r3K7eqNj031877; Sat, 20 Apr 2013 08:40:52 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 2I9T36MIQxE8; Sat, 20 Apr 2013 08:40:52 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r3K7ekvd031867
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Sat, 20 Apr 2013 08:40:48 +0100
Message-ID: <1366443597.10502.140.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Purcareata Bogdan-B43198 <B43198@freescale.com>
Date: Sat, 20 Apr 2013 08:39:57 +0100
In-Reply-To: <E7E317BD5B5D764682EEAC13B01676E2650BB2@039-SN2MPN1-021.039d.mgd.msft.net>
References: <E7E317BD5B5D764682EEAC13B01676E2650BB2@039-SN2MPN1-021.039d.mgd.msft.net>
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
Mime-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: bitbake clean / cleanall / cleansstate not working
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
X-List-Received-Date: Sat, 20 Apr 2013 07:58:00 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2013-04-17 at 09:42 +0000, Purcareata Bogdan-B43198 wrote:
> Hello,
> 
> I am using Yocto with BB_VERSION = "1.18.0" and the commands in the subject do not seem to work - they don't do anything. The image has the packages built.
> 
> $ bitbake -c cleanall gcc
> [ ... ]
> NOTE: Tasks Summary: Attempted 3 tasks of which 0 didn't need to be rerun and all succeeded.
> 
> $ bitbake -c clean gcc
> [ ... ]
> NOTE: Tasks Summary: Attempted 1 tasks of which 0 didn't need to be rerun and all succeeded.
> 
> $ bitbake -c cleansstate gcc
> [ ... ]
> NOTE: Tasks Summary: Attempted 2 tasks of which 0 didn't need to be rerun and all succeeded.
> 
> The information in [ ... ] is not really relevant. I just wanted to
> give the output message. I know the error description is vague, but so
> is this behavior. I don't know what it could be further related to.

What exactly are you trying to clean? The above messages say it ran 1, 2
or 3 tasks and they all succeeded.

Keep in mind there are several "gcc" components such as gcc-cross,
gcc-cross-initial and so on. "gcc" is the one used on target.

Cheers,

Richard



