Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 689A1731CF
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 31 Jan 2016 17:54:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u0VHpCdM022287; Sun, 31 Jan 2016 17:54:10 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id JC6uB1CoOF_f; Sun, 31 Jan 2016 17:54:10 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u0VHs4jf022315
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 31 Jan 2016 17:54:05 GMT
Message-ID: <1454262844.27087.30.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Christopher Larson <clarson@kergoth.com>
Date: Sun, 31 Jan 2016 17:54:04 +0000
In-Reply-To: <CABcZAN=+4HozZSOcHEC0yD_5j3w9C=SEwyz1RpT_W12Htj1OiQ@mail.gmail.com>
References: <1454065730.10340.64.camel@linuxfoundation.org>
	<CABcZAN=+4HozZSOcHEC0yD_5j3w9C=SEwyz1RpT_W12Htj1OiQ@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] bitbake: Set process names to be meaninful
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
X-List-Received-Date: Sun, 31 Jan 2016 17:54:11 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Sun, 2016-01-31 at 10:03 -0700, Christopher Larson wrote:
> On Fri, Jan 29, 2016 at 4:08 AM, Richard Purdie <
> richard.purdie@linuxfoundation.org> wrote:
> > This means that when you view the process tree, the processes
> > have meaningful names, aiding debugging:
> > 
> > Applies to parse threads, PR Server, cooker, the workers and
> > execution
> > threads, working within the 16 character limit as best we can.
> > 
> > Needed to tweak the bitbake-worker magic values to tell the
> > workers apart.
> > 
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > 
> This is nice, but shouldn't we at least include 'bitbake' somewhere
> in the process names? Will this interfere with the ability to use
> pkill/killall to kill bitbake processes in cases where it's
> necessary?

I thought I'd checked this and that killall was working off the output
in ps which was based off argv[0] and was unchanged. Checking again
just now shows that isn't correct.

I guess the question is where to include "bitbake". We're short of
space already for the worker processes for example. Perhaps if we just
included bitbake for the cooker and UI?

Cheers,

Richard

