Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 3C775719EE
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Nov 2016 16:43:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	uA2GhWOp025620; Wed, 2 Nov 2016 16:43:32 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id FSPVSnLvCWzW; Wed,  2 Nov 2016 16:43:32 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	uA2GhS43025615
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 2 Nov 2016 16:43:29 GMT
Message-ID: <1478105008.23123.66.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Christopher Larson <clarson@kergoth.com>
Date: Wed, 02 Nov 2016 16:43:28 +0000
In-Reply-To: <CABcZANkNPT+wqHMkUE3z0N_0R=QWYrfPDzU1R+qw31N_WjHdnw@mail.gmail.com>
References: <1478099253.23123.63.camel@linuxfoundation.org>
	<CABcZANkNPT+wqHMkUE3z0N_0R=QWYrfPDzU1R+qw31N_WjHdnw@mail.gmail.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] siggen: Ensure taskhash mismatches don't override existing data
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
X-List-Received-Date: Wed, 02 Nov 2016 16:43:39 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2016-11-02 at 08:46 -0700, Christopher Larson wrote:
> 
> On Wed, Nov 2, 2016 at 8:07 AM, Richard Purdie <richard.purdie@linuxf
> oundation.org> wrote:
> > We recalculate the taskhash to ensure the version we have matches
> > what we think it should be. When we write out a sigdata file, use
> > the calculated value so that we don't overwrite any existing file.
> > This leaves any original taskhash sigdata file intact to allow a
> > debugging comparison.
> > 
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > 
> Thanks, I ran into this trying to diagnose a mismatch with our
> automated builds a while back. These patches should make those a lot
> easier to debug.

Otavio gave me a reproducible test case which was nearly impossible to
debug with the codebase the way it was. I've been beating it up until
it actually gave good debug output which could be used to debug the
problem. Hopefully it works better than before, which wouldn't take
much. Still not 100% happy with it but it has to be better than it
was...

I'd love to find a way to always write out the sigbasedata but it uses
far too much time and slows down parsing too much :(.

Cheers,

Richard

