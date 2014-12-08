Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 86B43723C6
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Dec 2014 20:58:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	sB8KvR2N015692; Mon, 8 Dec 2014 20:57:27 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 3HryMPW61fi7; Mon,  8 Dec 2014 20:57:27 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	sB8KvBij015674
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 8 Dec 2014 20:57:22 GMT
Message-ID: <1418072268.22903.27.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Date: Mon, 08 Dec 2014 20:57:48 +0000
In-Reply-To: <1418060539.22903.24.camel@linuxfoundation.org>
References: <cover.1418034514.git.paul.eggleton@linux.intel.com>
	<bd4a209b8fd5adb0bc35d8a44b57c03aea07f099.1418034514.git.paul.eggleton@linux.intel.com>
	<1418060539.22903.24.camel@linuxfoundation.org>
X-Mailer: Evolution 3.12.7-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 4/4] event: fix resetting class handlers object
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
X-List-Received-Date: Mon, 08 Dec 2014 20:58:11 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2014-12-08 at 17:42 +0000, Richard Purdie wrote:
> On Mon, 2014-12-08 at 10:50 +0000, Paul Eggleton wrote:
> > If you don't explicitly specify to use a global variable when doing an
> > assignment, you will be setting a local variable instead, which means
> > this function wasn't working at all. It explains some odd behaviour we
> > have seen in the layer index where event handlers were sometimes
> > bleeding into other contexts where they should not have been.
> > 
> > Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
> > ---
> >  lib/bb/event.py | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/lib/bb/event.py b/lib/bb/event.py
> > index 9645476..8bc6b80 100644
> > --- a/lib/bb/event.py
> > +++ b/lib/bb/event.py
> > @@ -55,6 +55,7 @@ def get_class_handlers():
> >      return _handlers
> >  
> >  def set_class_handlers(h):
> > +    global handlers
> >      _handlers = h
> 
> Er, shouldn't this be _handlers?

I put the patch in master-next and tweaked this.

Cheers,

Richard


