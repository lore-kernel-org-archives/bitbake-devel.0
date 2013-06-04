Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 4CC836065C
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Jun 2013 10:33:45 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r54AcVVJ005367; Tue, 4 Jun 2013 11:38:31 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id jgGNqGkDCmAt; Tue,  4 Jun 2013 11:38:31 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r54AcPau005340
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Tue, 4 Jun 2013 11:38:27 +0100
Message-ID: <1370342009.1640.8.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Peter Seebach <peter.seebach@windriver.com>
Date: Tue, 04 Jun 2013 11:33:29 +0100
In-Reply-To: <20130531113235.2bd2df62@e6410-2>
References: <1369799698-1417-1-git-send-email-mark.hatle@windriver.com>
	<1369985383.14887.341.camel@ted> <20130531113235.2bd2df62@e6410-2>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] cooker.py: Remove explicit build targets from the ignored list
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 04 Jun 2013 10:33:45 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2013-05-31 at 11:32 -0500, Peter Seebach wrote:
> On Fri, 31 May 2013 08:29:43 +0100
> Richard Purdie <richard.purdie@linuxfoundation.org> wrote:
> 
> > I'm not sure this is the right thing to do, the reason being
> > determinism. I don't expect different results for X in the different
> > cases:
> > 
> > bitbake X Y
> > 
> > bitbake X
> > 
> > (assuming Y is ASSUME_PROVIDED)
> > 
> > For example, X will rebuild between these two commands since the sstate
> > and task checksums will be different between the two. This really needs
> > more thought to make a consistent user experience...
> 
> Hmm. I don't *normally* expect different results, but might if the first one
> produced a diagnostic: "Warning: Y is in ASSUME_PROVIDED. Rebuilding Y will
> produce different versions of anything which depends on Y."
> 
> Paul's suggestion that we just print a diagnostic for anything which is in
> both targets and ASSUME_PROVIDED might well do, too.

I'll certainly take a patch for that.

>  Although it might be nice
> to have a reasonably straight forward command-line way to express "no, really,
> I want you to build Y" which doesn't require config file action.

Agreed, however we need to get the user interaction right here.
Currently the user doesn't expect for example that the configuration
files change from under them. In future this may well be something we do
(along with informing the user what happened). Users tend not to read
information though :/.

Cheers,

Richard





