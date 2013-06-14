Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 303BE60825
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Jun 2013 16:11:06 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r5EGGa6D001326; Fri, 14 Jun 2013 17:16:36 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id IKzGVyxdoaPN; Fri, 14 Jun 2013 17:16:36 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r5EGGXJ5001322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Fri, 14 Jun 2013 17:16:34 +0100
Message-ID: <1371226241.20823.85.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Chris Larson <clarson@kergoth.com>
Date: Fri, 14 Jun 2013 17:10:41 +0100
In-Reply-To: <CABcZANm=WTC9e5QLepdt7im0mY++_g9a3fk0xvmJx3sKxpKp4w@mail.gmail.com>
References: <1370009954-14292-1-git-send-email-bogdan.a.marinescu@intel.com>
	<CABcZANm=WTC9e5QLepdt7im0mY++_g9a3fk0xvmJx3sKxpKp4w@mail.gmail.com>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] bitbake: add event masks
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
X-List-Received-Date: Fri, 14 Jun 2013 16:11:06 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2013-05-31 at 09:51 -0700, Chris Larson wrote:
> On Fri, May 31, 2013 at 7:19 AM, Bogdan Marinescu
> <bogdan.a.marinescu@intel.com> wrote:
>         Add more arguments to an "addhandler" command. Each argument
>         (after the
>         first one, which is the name of the handler) is the name of an
>         event class
>         that the handler wants to be notified on. "*" is a shortcut
>         for "listen
>         to all events". This changes the current behaviour of bitbake,
>         which is
>         to broadcast all events to all listeners; instead, only the
>         handlers
>         that registered themselves to an event with "addhandler" will
>         receive
>         that event. This should improve performance, although only
>         performance
>         measurements will be confirm or deny this claim.
>         This is part of the fix for YOCTO #3812, but implements
>         filtering only
>         for class event handlers; the other part (events filter for
>         UIs) will be
>         the subject of a different patch.
>         
>         Signed-off-by: Bogdan Marinescu <bogdan.a.marinescu@intel.com>
> 
> Wouldn't it be simpler, as well as less invasive to the file format,
> to add an 'event' or 'events' flag to the handler which indicates what
> events it wishes to handle?

Agreed, FWIW I reworked this and merged it. Since we were messing around
with the bitbake minimum version in OE anyway, it seemed a good
opportunity.

Cheers,

Richard



