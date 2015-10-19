Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 3778E7705F
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 19 Oct 2015 11:39:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t9JBdmCJ027814; Mon, 19 Oct 2015 12:39:48 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id qOKnpsMCsOrb; Mon, 19 Oct 2015 12:39:48 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t9JBdbvU027807
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 19 Oct 2015 12:39:48 +0100
Message-ID: <1445254777.17974.95.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Barros Pena, Belen" <belen.barros.pena@intel.com>
Date: Mon, 19 Oct 2015 12:39:37 +0100
In-Reply-To: <D24A84FE.68625%belen.barros.pena@intel.com>
References: <1444555346.14364.24.camel@linuxfoundation.org>
	<CA+1hgUj5Lty=V_jSWE1YA2CPJuaY5-PAoj+P8gEtzSKDN5gVjA@mail.gmail.com>
	<1445011191.17974.34.camel@linuxfoundation.org>
	<D24A84FE.68625%belen.barros.pena@intel.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] cooker: Ensure BB_CONSOLE remains correct over server resets
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
X-List-Received-Date: Mon, 19 Oct 2015 11:39:54 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2015-10-19 at 10:32 +0000, Barros Pena, Belen wrote:
> 
> On 16/10/2015 16:59, "bitbake-devel-bounces@lists.openembedded.org on
> behalf of Richard Purdie" <bitbake-devel-bounces@lists.openembedded.org on
> behalf of richard.purdie@linuxfoundation.org> wrote:
> 
> >On Fri, 2015-10-16 at 16:57 +0100, Smith, Elliot wrote:
> >> Thanks for these, Richard.
> >>
> >> On 11 October 2015 at 10:22, Richard Purdie
> >> <richard.purdie@linuxfoundation.org> wrote:
> >>         The console log data is written to is created at console
> >>         initialisation
> >>         time and does not change over reset events. This ensures the
> >>         BB_CONSOLELOG value is correct over such resets by preserving
> >>         it.
> >>
> >> I've put your three patches on top of master and ran a few builds.

When you say "ran a few builds", was this with toaster? I'd like to
double check we are seeing the right behaviour but it depends how you
actually ran the builds as to whether this was the right result.

>  The
> >> result is that all of the logs for those builds are going into a
> >> single timestamped file. Before, they went to separate files. Is this
> >> intentional, or was the old behaviour incorrect? (Ideally, toaster
> >> needs a separate log file for each build.)
> >> 
> >It should generate one log file for each "session". A session would be
> >one logfile for all bitbake memory resident transactions and a log file
> >for each commandline transaction.
> >
> >It is a "console log", not an individual build log.
> 
> Mmmm, for Toaster we need an individual build log, not a console log :/

Since toaster records all the log information, is it not able to compute
an individual build log from that data?

The reason I'm reluctant to just add some kind of "build log"
functionality to bitbake is that at the commandline level, I think it
would mislead people. In theory, a "build" would be the output between
BuildStarted and BuildCompleted, the question is then what happens to
the output before and after these events.

Cheers,

Richard




