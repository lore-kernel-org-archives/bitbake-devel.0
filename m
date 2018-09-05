Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 489DE74765
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  5 Sep 2018 17:03:52 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-10) with ESMTPSA id
	w85H3oCU014003
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NOT); Wed, 5 Sep 2018 18:03:51 +0100
Message-ID: <8eb599c34c4567278dedb14eefa53d17fd3579b0.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Joshua Watt
	<jpewhacker@gmail.com>, bitbake-devel@lists.openembedded.org
Date: Wed, 05 Sep 2018 18:03:50 +0100
In-Reply-To: <e6d788b6c5cc824bb8cf98f2d8bb66b6a1b7a367.camel@linuxfoundation.org>
References: <20180821140416.10764-1-JPEWhacker@gmail.com>
	<c18b7f96-8809-0224-b419-2fff12994680@prevas.dk>
	<e6d788b6c5cc824bb8cf98f2d8bb66b6a1b7a367.camel@linuxfoundation.org>
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 0.100.1 at dan
X-Virus-Status: Clean
Subject: Re: [PATCH] daemonize: Flush stdio on exit
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
X-List-Received-Date: Wed, 05 Sep 2018 17:03:52 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2018-08-24 at 07:57 +0100, Richard Purdie wrote:
> On Wed, 2018-08-22 at 15:33 +0200, Rasmus Villemoes wrote:
> > Well, that's of course better than not getting the output, but
> > there's then the issue of double printing: The intermediate child
> > does _exit(), but the grandparent may have had stuff in the stdio
> > buffers before the very first fork(), and that content would be
> > inherited down to the grandchild. So I think you should (also)
> > explicitly flush stdout and stderr before the first fork().
> 
> You're correct, we should do that. I was thinking we did flush things
> before forking but looking at the code I'm thinking of the fork()
> call
> in bitbake-worker, not the one in daemonize.py.
> 
> I'd happily take a patch if someone wants to work one up!

I fixed this whilst looking at the other logging/buffer issues.

Cheers,

Richard

