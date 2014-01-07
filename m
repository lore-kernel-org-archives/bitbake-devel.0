Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 01DE26C744
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 Jan 2014 13:41:18 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s07Df5Qf002646; Tue, 7 Jan 2014 13:41:06 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id itAW8-kpzPLX; Tue,  7 Jan 2014 13:41:05 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s07Df0p9002639
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 7 Jan 2014 13:41:02 GMT
Message-ID: <1389102055.6899.25.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Olof Johansson <olof.johansson@axis.com>
Date: Tue, 07 Jan 2014 13:40:55 +0000
In-Reply-To: <20140107103602.GP31548@axis.com>
References: <1388886808-25624-1-git-send-email-andrei@gherzan.ro>
	<20140107103602.GP31548@axis.com>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bitbake: bb.fetch2.git: Fix _latest_revision function while using tags
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
X-List-Received-Date: Tue, 07 Jan 2014 13:41:19 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2014-01-07 at 11:36 +0100, Olof Johansson wrote:
> On 14-01-05 02:53 +0100, Andrei Gherzan wrote:
> > When getting the revision we must take into consideration if the name we are
> > looking for is a tag and in that case we need the dereferenced commit ID in
> > order to check for it existance in a specific branch.
> > 
> > So first search for the reference^{} commit ID and only if that returns nothing
> > get the name as it is.
> 
> I think this is the same issue I've tried to solve in a patch i
> sent in December (subject: bb.fetch2.git: support resolving both
> tags and branches). I haven't heard anything about it yet though.

I put this off as I wanted to spend some time and see if we couldn't
come up with something simpler. Andrei's patch is simpler, the question
is whether it covers all the cases and whether we even need the fallback
code?

I've merged the nobranch code since its clear there are cases when that
is the right thing to do and its a seperate issue to this.

Cheers,

Richard




