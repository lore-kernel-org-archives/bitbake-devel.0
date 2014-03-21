Return-Path: <olof.johansson@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id 5100B6F9C2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 21 Mar 2014 08:27:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id 0B5822E2A7;
	Fri, 21 Mar 2014 09:27:25 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id dn2JMLu24t+c; Fri, 21 Mar 2014 09:27:24 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id 5BB4D2E370;
	Fri, 21 Mar 2014 09:27:24 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 1ADB2B75;
	Fri, 21 Mar 2014 09:27:24 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id 0FC839E1;
	Fri, 21 Mar 2014 09:27:24 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by thoth.se.axis.com (Postfix) with ESMTP id 0D9D534005;
	Fri, 21 Mar 2014 09:27:24 +0100 (CET)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.3.342.0; Fri, 21 Mar 2014
	09:27:23 +0100
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id CD9829C29D; 
	Fri, 21 Mar 2014 09:27:23 +0100 (CET)
Date: Fri, 21 Mar 2014 09:27:23 +0100
From: Olof Johansson <olof.johansson@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20140321082723.GC16597@axis.com>
References: <cover.1392908060.git.pkj@axis.com>
	<c7f06c48293a2d7edc3894fe5259a8704afd1e17.1392908060.git.pkj@axis.com>
	<1393068245.5181.8.camel@ted> <20140320150345.GB951@axis.com>
	<1395328459.3808.180.camel@ted>
MIME-Version: 1.0
In-Reply-To: <1395328459.3808.180.camel@ted>
User-Agent: Mutt/1.5.23 (2014-03-12)
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
X-List-Received-Date: Fri, 21 Mar 2014 08:27:34 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Thanks for you quick reply,

On 14-03-20 16:14 +0100, Richard Purdie wrote:
> The log helps immensely since it shows its "Failure expanding variable
> do_patch" so its not running do_patch, it is trying to expand the
> variable for some reason when writing the rpm in do_package_write_rpm. 
> 
> Are you generating some kind of srpm differently from the normal
> usecases?

No we don't, as far as I know (is there something I should look
for?). If this isn't something we are doing, what makes it a
problem for us is the fetching of kernel sources from git over
ssh with key authentication. Not sure how common that is.

-- 
olofjn

