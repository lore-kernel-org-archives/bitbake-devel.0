Return-Path: <rpjday@crashcourse.ca>
Received: from emporiumvitreum.ca (cpanel4.indieserve.net [199.212.143.9])
	by mail.openembedded.org (Postfix) with ESMTP id DE43A6B43D
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  4 May 2019 20:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:References:
	Message-ID:In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MGiI0Jr7jRBE/tfgv13I0WFVyX10zEPC5UHSQltXNEE=;
	b=NKi7jS34sesHWo1hWeijm6naQ
	QNnIyqr6SYcR1dYQWfW3OqFRgR1cQ9ahWk5QC0woYgaX7VkRiIpJSCKy1li7bVkDuYLfWjD1KHtOF
	6Bf38SFvdbppoNn92jmKwcxk0+Ivm4SnC0tY+gueZpK7zC5SlWENrXgEnTp/kjmsR/XG12kFvCd/K
	FfnD1LV9gxP/5X+zCOYf+cOCnG6NZu8h+hGamNdJ7g+B6GOEj2eKvRbsj4suVcwjB1Pp2roKdaZqU
	NruQBDibAi4UO7g1k5W1H0xhuzG1NXw5vo9VXEr44MJQJYl/Ic6oAF/YpMDqpubJtc7Ra05t18G5K
	OiHxQxYvQ==;
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com
	([174.114.57.56]:33990 helo=localhost.localdomain)
	by cpanel4.indieserve.net with esmtpsa
	(TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.91)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1hN19i-0002bk-AT; Sat, 04 May 2019 16:21:11 -0400
Date: Sat, 4 May 2019 16:21:09 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
In-Reply-To: <b709ed4b38a746f6a20025811435d3e8@XBOX04.axis.com>
Message-ID: <alpine.LFD.2.21.1905041620550.29048@localhost.localdomain>
References: <alpine.LFD.2.21.1905031426110.10665@localhost.localdomain>
	<b709ed4b38a746f6a20025811435d3e8@XBOX04.axis.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse,
	please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id:
	rpjday+crashcourse.ca/only user confirmed/virtual account not
	confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] help: reword "runall" entries to refer to a TASK
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
X-List-Received-Date: Sat, 04 May 2019 20:21:12 -0000
Content-Type: text/plain; charset=US-ASCII

On Sat, 4 May 2019, Peter Kjellerstedt wrote:

> > -----Original Message-----
> > From: bitbake-devel-bounces@lists.openembedded.org <bitbake-devel-
> > bounces@lists.openembedded.org> On Behalf Of Robert P. J. Day
> > Sent: den 3 maj 2019 20:27
> > To: BitBake developer list <bitbake-devel@lists.openembedded.org>
> > Subject: [bitbake-devel] [PATCH] help: reword "runall" entries to refer
> > to a TASK
> >
> > Rewording argument to the word "TASK" should be self-evident.
> >
> > Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
> >
> > ---
> >
> > diff --git a/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
> > b/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
> > index 02058a6f..74b74bff 100644
> > --- a/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
> > +++ b/doc/bitbake-user-manual/bitbake-user-manual-intro.xml
> > @@ -573,10 +573,10 @@
> >                               Writes the event log of the build to a bitbake event
> >                               json file. Use '' (empty string) to assign the name
> >                               automatically.
> > -       --runall=RUNALL       Run the specified task for any recipe in the taskgraph
> > +       --runall=TASK         Run the specified task for any recipe in the taskgraph
> >                               of the specified target (even if it wouldn't otherwise
> >                               have run).
> > -       --runonly=RUNONLY     Run only the specified task within the taskgraph of
> > +       --runonly=TASK        Run only the specified task within the taskgraph of
> >                               the specified targets (and any task dependencies those
> >                               tasks may have).
> >                  </literallayout>
>
> The above information is taken directly from `bitbake -h`. I.e., if you
> want to change it, you should start by updating the bitbake code.

  ah, quite so, will fix.

rday

