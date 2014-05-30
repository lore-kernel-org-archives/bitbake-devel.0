Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id AE35F6FD26
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 30 May 2014 13:42:05 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s4UDg00n008659 for <bitbake-devel@lists.openembedded.org>;
	Fri, 30 May 2014 14:42:00 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id pjgSGDkXX7_0 for <bitbake-devel@lists.openembedded.org>;
	Fri, 30 May 2014 14:42:00 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s4UDfth8008652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 30 May 2014 14:41:57 +0100
Message-ID: <1401457307.31309.36.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 30 May 2014 14:41:47 +0100
In-Reply-To: <1401453143.31309.28.camel@ted>
References: <1401453143.31309.28.camel@ted>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: Re: [PATCH] event: Fix event handlers to raise SkipPackage
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
X-List-Received-Date: Fri, 30 May 2014 13:42:09 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2014-05-30 at 13:32 +0100, Richard Purdie wrote:
> If an event handler triggers a SkipPackage event, we really want that
> event to be received and processed by the higher code levels. Currently
> it was getting caught and ignored which was leading to recipes
> being present when they clearly shouldn't have been.
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> 
> diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
> index e205043..a95db52 100644
> --- a/bitbake/lib/bb/event.py
> +++ b/bitbake/lib/bb/event.py
> @@ -96,6 +96,8 @@ def fire_class_handlers(event, d):
>          if name in _catchall_handlers or name in evt_hmap:
>              try:
>                  execute_handler(name, handler, event, d)
> +            except bb.parse.SkipPackage:
> +                raise
>              except Exception:
>                  continue
>  

I'm just looking at another bug and this try/except Exception doesn't
make sense to me. It basically comes from:

http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/commit/bitbake/lib/bb/event.py?h=rpurdie/t222&id=37cb4cc02b2e2b6c338c5943747e0a1ef15176b3

although the BaseException was changed to an Exception so that
SystemExit would pass through.

The problem is that if a handler like ConfigParsed raises an error
staying "eek stop", the system will merrily swallow it and the build
will continue. Ditto something like an ExpansionError.

Specifically, I really want to do:

http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/commit/?h=rpurdie/t222&id=6fe4e8aee3ac5b3ea9f285eae373c36de46c094e

since actually raising a SystemExit is pretty evil. Most of the build
works fine with this, except for the event handlers and its due to the
above clause. I've long wondered where the problem was but never dug
into it as yet, it now turns out its this.

So is there a good reason to keep that "continue" there or can we remove
this and assume is the handler is raising an exception, its an error?

Chris, any thoughts on what this was aiming to do originally?

Cheers,

Richard



