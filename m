Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id D7B0F6C8EE
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 Jan 2014 15:02:50 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s07F2bH7006163; Tue, 7 Jan 2014 15:02:38 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id UbXgyil-vDAd; Tue,  7 Jan 2014 15:02:37 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s07F2VLE006151
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 7 Jan 2014 15:02:33 GMT
Message-ID: <1389106946.6899.38.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Olof Johansson <olof.johansson@axis.com>
Date: Tue, 07 Jan 2014 15:02:26 +0000
In-Reply-To: <20140107144635.GA5566@axis.com>
References: <1388886808-25624-1-git-send-email-andrei@gherzan.ro>
	<20140107103602.GP31548@axis.com> <1389102055.6899.25.camel@ted>
	<20140107144635.GA5566@axis.com>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
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
X-List-Received-Date: Tue, 07 Jan 2014 15:02:51 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2014-01-07 at 15:46 +0100, Olof Johansson wrote:
> I agree with your reasoning with regards to not needing a
> fallback for Andrei's patch, but my patch tries to first resolve
> refs/tags/<tag> (fully qualified) and then falls back to try
> refs/heads/<branch>. The reason for this is that ls-remote will
> return things like refs/heads/lalala/<tag> if you only do
> ls-remote <tag>.

Can we somehow anchor the expression instead e.g. refs/*/<xxx>^{}

> My attempt was also to break out the tasks into simple,
> atomic(-ish) functions that would later be easier to write unit
> tests for. You complained on IRC that changes to the fetcher
> usually comes back to bite you. I believe increased unit test
> coverage on low level functions, as a compliment to the existing
> more high level suite, can be beneficial in this regard.

I believe that my complaint could also be addressed by ensuring the high
level tests had more coverage of the variety of supported use cases. In
this case a range of tags of differing types, branches and hanging
commits would have helped ensure the changes to the fetcher didn't break
things.

I'm less keen on forcing an atom like set of functions on the fetcher
just for the purposes of the test suite. Sorry I was unclear on that, I
guess different people have different understandings of what increased
coverage would mean.

> Also, if you are holding things off, I would really appreciate
> you letting us know so that we can make appropriate workarounds
> if needed (as in this case, where we have had to supsend testing
> on master :-().

Well, it wasn't a conscious decision so much as the holidays came along
and I ran out of time to look at it. I'm trying to get this resolved now
since obviously various people are hitting the problem cases.

Cheers,

Richard


