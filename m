Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 1D5456FA40
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 22 Mar 2014 10:12:45 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s2MACXR8009905; Sat, 22 Mar 2014 10:12:33 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Zi_eUVJGmdh6; Sat, 22 Mar 2014 10:12:33 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s2MACT4E009901
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sat, 22 Mar 2014 10:12:32 GMT
Message-ID: <1395483143.24232.16.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Olof Johansson <olof.johansson@axis.com>
Date: Sat, 22 Mar 2014 10:12:23 +0000
In-Reply-To: <20140321082723.GC16597@axis.com>
References: <cover.1392908060.git.pkj@axis.com>
	<c7f06c48293a2d7edc3894fe5259a8704afd1e17.1392908060.git.pkj@axis.com>
	<1393068245.5181.8.camel@ted> <20140320150345.GB951@axis.com>
	<1395328459.3808.180.camel@ted> <20140321082723.GC16597@axis.com>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: Peter Kjellerstedt <pkj@axis.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 1/1] bitbake: Disable pseudo in runfetchcmd()
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
X-List-Received-Date: Sat, 22 Mar 2014 10:12:49 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2014-03-21 at 09:27 +0100, Olof Johansson wrote:
> On 14-03-20 16:14 +0100, Richard Purdie wrote:
> > The log helps immensely since it shows its "Failure expanding variable
> > do_patch" so its not running do_patch, it is trying to expand the
> > variable for some reason when writing the rpm in do_package_write_rpm. 
> > 
> > Are you generating some kind of srpm differently from the normal
> > usecases?
> 
> No we don't, as far as I know (is there something I should look
> for?). If this isn't something we are doing, what makes it a
> problem for us is the fetching of kernel sources from git over
> ssh with key authentication. Not sure how common that is.

Are you using the archiver classes?

I'm wondering if

http://git.yoctoproject.org/cgit.cgi/poky/commit/?id=2c7d20ce3849aba84e0552f0fc4bde649d96faa9

might resolve the issue.  Somehow you're referencing do_patch in the rpm
write task and I'd like to figure out how. We should not be hitting the
network during anything other than do_fetch...

Cheers,

Richard



