Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 8F3656B0CE;
	Wed, 21 Aug 2013 16:19:38 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r7LGVNsu003344; Wed, 21 Aug 2013 17:31:24 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id EjEyw8s2H__5; Wed, 21 Aug 2013 17:31:23 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r7LGVIdi003340
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Wed, 21 Aug 2013 17:31:19 +0100
Message-ID: <1377101961.25999.121.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Chris Larson <clarson@kergoth.com>
Date: Wed, 21 Aug 2013 17:19:21 +0100
In-Reply-To: <CABcZANnt4v4LoM+HnK_=6VMDgSCFR7qGfciMdpXxSQ+Gc4HBEA@mail.gmail.com>
References: <1377095185.25999.116.camel@ted>
	<CABcZANnt4v4LoM+HnK_=6VMDgSCFR7qGfciMdpXxSQ+Gc4HBEA@mail.gmail.com>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	poky <poky@lists.yoctoproject.org>,
	openembedded-core <openembedded-core@lists.openembedded.org>
Subject: Re: Bitbake in server mode
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
X-List-Received-Date: Wed, 21 Aug 2013 16:19:41 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2013-08-21 at 08:56 -0700, Chris Larson wrote:
> 
> On Wed, Aug 21, 2013 at 7:26 AM, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
>         Known issues:
>         
>         a) Parsing is slower. Probably due to all the debug messages
>         going over
>         the IPC/xmlrpc. UI event filtering should fix it.
>         b) Something is causing a cache reparse initially. Need to
>         figure out
>         what. Maybe the BBSERVER variable itself?
>         
>         This is still development so I'd not recommend everyone use
>         this for
>         production just yet but it gives some nice insight into what
>         the future
>         holds!
>         
>         We should be able to make bitbake in this mode much more
>         responsive to
>         commands since there is no cache overhead.
> 
> I expect the obvious question to be, what happens if a recipe is
> altered between starting the server and running a command :)

I should have been clearer, it will reparse, the normal cache checks
take effect, it just doesn't have to unpickle cache bits from disk which
is where the time is taken.

What happens if you edit recipes whilst bitbake is running a command? Do
not do that, just like today!

Cheers,

Richard







