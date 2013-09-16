Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id E9AE460648
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Sep 2013 15:20:26 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8GFYQ8Z017756; Mon, 16 Sep 2013 16:34:27 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id HCBx0NXAaKGi; Mon, 16 Sep 2013 16:34:26 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8GFYN9P017735
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Mon, 16 Sep 2013 16:34:24 +0100
Message-ID: <1379344807.32201.5.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Damian, Alexandru" <alexandru.damian@intel.com>
Date: Mon, 16 Sep 2013 16:20:07 +0100
In-Reply-To: <CAJ2CSBtavqusHtJXRkELi2QfTmxp2c5T31AaZ8X1_srsZ0iJ2A@mail.gmail.com>
References: <cover.1379338189.git.alexandru.damian@intel.com>
	<3a7c387d904ea3ea0ad4e493b95bf456a7b10c24.1379338189.git.alexandru.damian@intel.com>
	<389466a059c3e6ba345bec88bb710f9dd3311189.1379338189.git.alexandru.damian@intel.com>
	<1379339207.3484.304.camel@ted>
	<CAJ2CSBtavqusHtJXRkELi2QfTmxp2c5T31AaZ8X1_srsZ0iJ2A@mail.gmail.com>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 6/7] bitbake: event: adding events to allow bbclasses to push custom info
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
X-List-Received-Date: Mon, 16 Sep 2013 15:20:29 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2013-09-16 at 14:56 +0100, Damian, Alexandru wrote:
> On Mon, Sep 16, 2013 at 2:46 PM, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:

> Your explanation in the commit message isn't as detailed as it could
>         be.
>         
>         I'm guessing but I suspect the problem we have is that the
>         event cannot
>         be rebuilt on the other side of an XMLRPC connection without
>         having the
>         event class in a common namespace?
>         
>         This is therefore a hack to allow the event to exist in all
>         the client
>         side namespaces.
> 
> 
> [Alex] Yep, this is an ugly hack.

In future *please* put this kind of information into commit messages.
I'm having a lot of trouble with these patches as the commit messages
don't give me all the information I need to review them.


>  
>         
>         Ideally we should really have an API which allows the classes
>         themselves
>         to declare their event formats and not require adding to
>         event.py every
>         time a new piece of code/event is added.

> 
> [Alex] I would favor a single "GenericEvent" that will take a set of
> defined parameters,
> that would allow "subclassing" at runtime - sort of introspection if
> you will.
> 
> Something like this:
> 
> 
> class GenericInfo(Event):
> 
>     def __init__(self, type, data):
>         Event.__init__(self)
>         self._type = type
>         self._data = data
> 
> with a call like
> 
> 
> bb.event.fire(bb.event.GenericInfo("PackageInfo", pkginfolist),
> e.data)
> 
> 
> the UI handlers / anybody would subscribe to GenericInfo events, 
> and the processing code would look like:
> 
> 
> if isinstance(event, bb.event.GenericInfo):
>     if event._type == "PackageInfo":
>          savePackageInfo(event)
>     elif event._type == "PackageFileSizes":
>         ....
> 

Lets do it but can you:

a) Stop using the underscores please. I know some older events have them
but the data is not internal so lets not persist broken syntax going
forward.
b) Call this MetadataEvent and put in a header comment explaining what
it is and why/when you'd use it.
c) Convert the user of PackageInfo in OE-Core to use the new event if it
is available, falling back to PackageInfo.
d) Update hob to accept the new event

c/d can come later but I do want to see patches for them ultimately.
We'll remove PackageInfo in the 1.6 cycle.

Cheers,

Richard




