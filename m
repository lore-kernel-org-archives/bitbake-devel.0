Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 9697F6C921
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Jan 2014 18:05:52 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s0MI5ev8010005; Wed, 22 Jan 2014 18:05:41 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id o1St86M28178; Wed, 22 Jan 2014 18:05:40 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s0MI5Z30009991
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 22 Jan 2014 18:05:37 GMT
Message-ID: <1390413929.17424.44.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Chris Larson <clarson@kergoth.com>
Date: Wed, 22 Jan 2014 18:05:29 +0000
In-Reply-To: <CABcZANnuhcDYMcsrC=2NUxv9q=EqUYqK0uDqi+=bwE+0y71u4g@mail.gmail.com>
References: <1390343512.874.124.camel@ted>
	<CABcZANnuhcDYMcsrC=2NUxv9q=EqUYqK0uDqi+=bwE+0y71u4g@mail.gmail.com>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] runqueue: Only attempt to print closest matching task if there is a match
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
X-List-Received-Date: Wed, 22 Jan 2014 18:05:53 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2014-01-22 at 09:16 -0700, Chris Larson wrote:
> On Tue, Jan 21, 2014 at 3:31 PM, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
>         +            if len(matches):
> 
> Minor quibble, this could almost be considered an antipattern in
> python :) Whenever you see yourself doing this, you're almost always
> better off removing the len(). Python can test if a container is
> empty.

Sorry, I do know this too :/.

It started life as a len(x) > 1, then when I fixed something else I
didn't properly simplify it.

Cheers,

Richard



