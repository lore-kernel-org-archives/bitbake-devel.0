Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 4B33F6C850
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Sep 2013 13:47:09 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8GE191F013925; Mon, 16 Sep 2013 15:01:09 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id QOFZka8qw4-B; Mon, 16 Sep 2013 15:01:09 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8GE13tk013893
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Mon, 16 Sep 2013 15:01:04 +0100
Message-ID: <1379339207.3484.304.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alex DAMIAN <alexandru.damian@intel.com>
Date: Mon, 16 Sep 2013 14:46:47 +0100
In-Reply-To: <389466a059c3e6ba345bec88bb710f9dd3311189.1379338189.git.alexandru.damian@intel.com>
References: <cover.1379338189.git.alexandru.damian@intel.com>
	<3a7c387d904ea3ea0ad4e493b95bf456a7b10c24.1379338189.git.alexandru.damian@intel.com>
	<389466a059c3e6ba345bec88bb710f9dd3311189.1379338189.git.alexandru.damian@intel.com>
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
X-List-Received-Date: Mon, 16 Sep 2013 13:47:09 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2013-09-16 at 14:33 +0100, Alex DAMIAN wrote:
> From: Alexandru DAMIAN <alexandru.damian@intel.com>
> 
> We add a new event that will be triggered by the
> package-building class, containing the information
> about the currently built package.
> 
> Adding an event that will passi information about the
> content of each package file that gets built.
> 
> Knotty UI will ignore these events by default.
> 
> Maybe a mechanism for using a single generic event is in order ?
> 
> Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
> ---
>  bitbake/lib/bb/event.py     | 16 ++++++++++++++++
>  bitbake/lib/bb/ui/knotty.py |  2 ++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
> index 67cfcea..7dd9236 100644
> --- a/bitbake/lib/bb/event.py
> +++ b/bitbake/lib/bb/event.py
> @@ -589,6 +589,22 @@ class PackageInfo(Event):
>          Event.__init__(self)
>          self._pkginfolist = pkginfolist
>  
> +class SinglePackageInfo(Event):
> +    """
> +    Single Package Information sent on emit_pkgdata
> +    """
> +    def __init__(self, data):
> +        Event.__init__(self)
> +        self._data = data
> +
> +class PackageFileSizes(Event):
> +    """
> +    Event that contains information about the file sizes contained in a package.
> +    """
> +    def __init__(self, data):
> +        Event.__init__(self)
> +        self._data = data
> +
>  class SanityCheck(Event):
>      """

Your explanation in the commit message isn't as detailed as it could
be. 

I'm guessing but I suspect the problem we have is that the event cannot
be rebuilt on the other side of an XMLRPC connection without having the
event class in a common namespace?

This is therefore a hack to allow the event to exist in all the client
side namespaces.

Ideally we should really have an API which allows the classes themselves
to declare their event formats and not require adding to event.py every
time a new piece of code/event is added.

Presumably there is some change required to OE-Core in order for this
get used to?

Is the PackageFileSizes not contained in the other event data?

I appreciate we allowed PackageInfo in but I didn't like it at the time,
I like it even less now I see we're just going to keep doing this :(.

>      Event to issue sanity check
> diff --git a/bitbake/lib/bb/ui/knotty.py b/bitbake/lib/bb/ui/knotty.py
> index 0211b50..03baa75 100644
> --- a/bitbake/lib/bb/ui/knotty.py
> +++ b/bitbake/lib/bb/ui/knotty.py
> @@ -477,6 +477,8 @@ def main(server, eventHandler, params, tf = TerminalFilter):
>  
>              # ignore
>              if isinstance(event, (bb.event.BuildBase,
> +                                  bb.event.PackageFileSizes,
> +                                  bb.event.SinglePackageInfo,
>                                    bb.event.StampUpdate,
>                                    bb.event.ConfigParsed,
>                                    bb.event.RecipeParsed,


Given the event masking that is now in knotty, do we need to do this?
Can't we remove this block?

Cheers,

Richard



