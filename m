Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TbE0U-0005SH-Ie for bitbake-devel@lists.openembedded.org;
	Wed, 21 Nov 2012 18:22:38 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qALH8WHX017529;
	Wed, 21 Nov 2012 17:08:32 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 12353-07; Wed, 21 Nov 2012 17:08:27 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qALH8Mgq017522
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 21 Nov 2012 17:08:25 GMT
Message-ID: <1353517701.10459.18.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Chris Larson <clarson@kergoth.com>
Date: Wed, 21 Nov 2012 17:08:21 +0000
In-Reply-To: <CABcZAN=G7OB-SE5py+oDGRc4_OyjP3DBvOfKMMFwWLFzpiKeOQ@mail.gmail.com>
References: <1353489690.10459.0.camel@ted>
	<CABcZAN=G7OB-SE5py+oDGRc4_OyjP3DBvOfKMMFwWLFzpiKeOQ@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] server/process.py: Change timeout error handling
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 21 Nov 2012 17:22:38 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2012-11-21 at 09:31 -0700, Chris Larson wrote:
> On Wed, Nov 21, 2012 at 2:21 AM, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
>         In normal usage, we never hit the timeout issue. If we do, it
>         becomes obvious
>         that the current error handling is not good enough. The
>         request may have made it
>         to the server and the answer will get queued. This means the
>         next command may get
>         the return value from the previous command with suitably
>         puzzling results.
>         
>         Without rewriting large sections of code, its not possible to
>         avoid this problem.
>         It is better to increase the timeout to several seconds giving
>         the server a chance
>         to respond and if it does timeout, hard exit since recovery is
>         not possible with the
>         code base today.
>         
>         I'd be happy to see the structure of this code improved but
>         this quick fix at least
>         stops corrupted builds from happening which has to be a good
>         thing.

>         Signed-off-by: Richard Purdie
>         <richard.purdie@linuxfoundation.org>
> 
> 
> This code is run in UI context, not server context, no? So the UI
> should be checking the return of runCommand, seeing the error, and
> aborting itself in whatever clean fashion is appropriate, rather than
> the rather less so immediate sys.exit. Given that, I don't really see
> how switching to bb.fatal here is buying us much. If we truly want
> that error path to be different from that of other command failures,
> then I would think that raising an appropriate exception (e.g.
> something other than SystemExit) would be better.

The issue is that after this particular failure, any further runCommand
is going to go badly wrong. "Timeout" would imply you could retry and in
this case as described above, you cannot (which I agree sucks).

So I think exiting in this case isn't such a bad thing although I'm less
than happy about it. The only thing the UI could do is throw an error
and exit.

Cheers,

Richard




