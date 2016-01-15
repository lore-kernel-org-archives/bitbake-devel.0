Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 21EAD60767
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 15 Jan 2016 15:05:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u0FF4x2l028321; Fri, 15 Jan 2016 15:04:59 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id wVP_UGRQ5JNQ; Fri, 15 Jan 2016 15:04:59 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u0FF4sQV028317
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 15 Jan 2016 15:04:56 GMT
Message-ID: <1452870294.28375.167.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>, Olof Johansson
	<olofjn@axis.com>, Andre McCurdy <armccurdy@gmail.com>, bitbake-devel
	<bitbake-devel@lists.openembedded.org>
Date: Fri, 15 Jan 2016 15:04:54 +0000
In-Reply-To: <36fc0893749647d8aeef0cc8cfd68435@XBOX02.axis.com>
References: <1452172732.7598.114.camel@linuxfoundation.org>
	<CAJ86T=Xb6HHZm0BaqtGeCUknP1_dTy6t1L7LtZru9F+=j-BmSg@mail.gmail.com>
	<1452723582.28375.118.camel@linuxfoundation.org>
	<90f0d7cacc2743e58535b16f6fe316bd@XBOX02.axis.com>
	<1452785159.28375.135.camel@linuxfoundation.org>
	<CAJ86T=X9LU04NhjnaLtq+G7WSE6=9t2yiNF2MiuDrnn+M5exLQ@mail.gmail.com>
	<20160114170752.GH31212@axis.com>
	<36fc0893749647d8aeef0cc8cfd68435@XBOX02.axis.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: Re: [PATCH] fetch/git: Change to use clearer ssh url syntax for broken servers
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
X-List-Received-Date: Fri, 15 Jan 2016 15:05:04 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2016-01-14 at 17:50 +0000, Peter Kjellerstedt wrote:
> > -----Original Message-----
> > From: Olof Johansson
> > Sent: den 14 januari 2016 18:08
> > To: Andre McCurdy; Richard Purdie; bitbake-devel
> > Cc: Peter Kjellerstedt
> > Subject: Re: [bitbake-devel] [PATCH] fetch/git: Change to use
> > clearer
> > ssh url syntax for broken servers
> > 
> > On 16-01-14 08:51 -0800, Andre McCurdy wrote:
> > > > I'm not sure there is one other than special casing bitbucket
> > > > urls
> > in
> > > > the fetcher.
> > > 
> > > But I don't think there is any problem with BitBucket. The
> > > original
> > > bug report was caused by trying to use a URL with a ':' between
> > > the
> > > host and the repo path. A URL like that does not work when
> > > prefixed
> > by
> > > ssh://, it's the same for GitHub URLs too.
> > 
> > Indeed, the reported URL is not an RFC 3986 comformant URI. While
> > 
> >   ssh://example.com:/username/project.git
> > 
> > would be a kind of valid URI (the RFC doesn't forbid having an
> > empty port, see section 3.2.3), not having a path delimiter at
> > all however is not allowed. And fixing this by breaking RFC
> > comformant use cases is very suprising to me.
> > 
> > --
> > olofjn
> 
> I have now looked at the ticket [YOCTO #8864] and actually created an
> account on bitbucket.org to actually verify what is happening, and I 
> can only come to the conclusion that the ticket is gibberish. I have 
> tried the following two URL:s with bitbucket.org, and they both work 
> as expected:
> 
> git@bitbucket.org:Saur2000/test1.git
> ssh://git@bitbucket.org/Saur2000/test1.git
> 
> The real error to the SRC_URI given in the ticket:
> 
> SRC_URI = "git
> ://git@bitbucket.org:<username>/<repository>.git;rev=foo"
> 
> is that it is missing the protocol argument. Changing it to:
> 
> SRC_URI = "git
> ://git@bitbucket.org/<username>/<repository>.git;protocol=ssh;rev=foo
> "
> 
> should make everything work as expected.
> 
> The ticket author obviously did not realize that the git:// scheme 
> used in the SRC_URI is for BitBake and not for Git, and that when 
> the protocol=ssh argument is added, then the rest of the URI must 
> be changed to match the syntax expected by an ssh:// URI even though 
> the scheme in SRC_URI is git://.

I have also double checked this and I agree, the bitbucket servers do
now seem to work as you'd expect.

I swear I had problems originally but I can't figure out what those
were so I will revert the patch.

My point about improving the selftests if there are url formats you
depend upon stands though.

Cheers,

Richard


