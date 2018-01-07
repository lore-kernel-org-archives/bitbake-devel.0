Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 377AD7884F
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  7 Jan 2018 12:10:29 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	w07C8R2K014646
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Sun, 7 Jan 2018 12:08:28 GMT
Message-ID: <1515326907.29722.28.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Jair Gonzalez <jair.de.jesus.gonzalez.plascencia@linux.intel.com>,
	bitbake-devel@lists.openembedded.org
Date: Sun, 07 Jan 2018 12:08:27 +0000
In-Reply-To: <005001d3706a$ea82c7c0$bf885740$@linux.intel.com>
References: <005001d3706a$ea82c7c0$bf885740$@linux.intel.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: Re: [selftest][PATCH V1 0/5] QA: Extend unit tests for event module
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
X-List-Received-Date: Sun, 07 Jan 2018 12:10:30 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi Jair,

I finally got to this. Its basically ok but I don't like the data
attribute being set to "None". I've dropped that bit and will remove
the getCfg and setCfg pieces instead as I don't think we're using them
anywhere. I have that queued in master-next.

Sorry about the delay in getting to this.

Cheers,

Richard



On Fri, 2017-12-08 at 15:24 -0600, Jair Gonzalez wrote:
> Hello,
> 
> Have you been able to review this series of patches? It's being
> tracked on
> bug 10773.
> 
> Please let me know if you have any doubts or comments about it.
> 
> Regards,
> Jair Gonzalez
> 
> > 
> > -----Original Message-----
> > From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
> > devel-
> > bounces@lists.openembedded.org] On Behalf Of Jair Gonzalez
> > Sent: Thursday, August 17, 2017 3:41 PM
> > To: bitbake-devel@lists.openembedded.org
> > Subject: [bitbake-devel] [selftest][PATCH V1 0/5] QA: Extend unit
> > tests
> for event
> > 
> > module
> > 
> > Included on V1:
> > 
> >   This patch-set extends the unit test module for bitbake event
> >   including increased coverage for event filtering features and
> >   testing of public interfaces of event and helper classes. It
> >   also includes two small fixes for issues found during the unit
> >   test development.
> > 
> > [YOCTO #10773]
> > 
> > The following changes since commit
> > 6016ec177af2406cacfeb3276dfcb8bfc3df8fce:
> > 
> >   poky.conf: Enable vulkan by default (2017-08-16 00:04:39 +0100)
> > 
> > are available in the git repository at:
> > 
> >   git://git.yoctoproject.org/poky-contrib jairglez/bbevent_extended
> >   http://git.yoctoproject.org/cgit.cgi/poky-
> > contrib/log/?h=jairglez/bbevent_extended
> > 
> > Jair Gonzalez (5):
> >   bitbake: tests: Include tests for event filtering features
> >   bitbake: tests: Add test for bb.event.worker_fire
> >   bitbake: tests: Remove empty assignments from event tests
> >   bitbake: tests: Initialize data attribute on BuildBase event
> >   bitbake: tests: Add event classes test class
> > 
> >  lib/bb/event.py       |   1 +
> >  lib/bb/tests/event.py | 646
> > +++++++++++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 634 insertions(+), 13 deletions(-)
> > 
> > --
> > 2.7.4
> > 
> > --
> > _______________________________________________
> > bitbake-devel mailing list
> > bitbake-devel@lists.openembedded.org
> > http://lists.openembedded.org/mailman/listinfo/bitbake-devel

