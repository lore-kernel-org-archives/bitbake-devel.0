Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 06E03601A0
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Dec 2014 18:10:33 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 08 Dec 2014 10:09:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.07,539,1413270000"; d="scan'208";a="634551591"
Received: from apwitke-mobl2.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.30.33])
	by fmsmga001.fm.intel.com with ESMTP; 08 Dec 2014 10:09:23 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Mon, 08 Dec 2014 18:09:22 +0000
Message-ID: <2231153.eUgzP4WL77@peggleto-mobl5.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.3 (Linux/3.17.4-200.fc20.x86_64; KDE/4.14.3; x86_64; ; )
In-Reply-To: <1418060539.22903.24.camel@linuxfoundation.org>
References: <cover.1418034514.git.paul.eggleton@linux.intel.com>
	<bd4a209b8fd5adb0bc35d8a44b57c03aea07f099.1418034514.git.paul.eggleton@linux.intel.com>
	<1418060539.22903.24.camel@linuxfoundation.org>
MIME-Version: 1.0
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
X-List-Received-Date: Mon, 08 Dec 2014 18:10:37 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 08 December 2014 17:42:19 Richard Purdie wrote:
> On Mon, 2014-12-08 at 10:50 +0000, Paul Eggleton wrote:
> > If you don't explicitly specify to use a global variable when doing an
> > assignment, you will be setting a local variable instead, which means
> > this function wasn't working at all. It explains some odd behaviour we
> > have seen in the layer index where event handlers were sometimes
> > bleeding into other contexts where they should not have been.
> > 
> > Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
> > ---
> > 
> >  lib/bb/event.py | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/lib/bb/event.py b/lib/bb/event.py
> > index 9645476..8bc6b80 100644
> > --- a/lib/bb/event.py
> > +++ b/lib/bb/event.py
> > 
> > @@ -55,6 +55,7 @@ def get_class_handlers():
> >      return _handlers
> >  
> >  def set_class_handlers(h):
> > +    global handlers
> > 
> >      _handlers = h
> 
> Er, shouldn't this be _handlers?

Oh dear. Yes, it should. I've fixed that on the branch, but I'll do a bit more 
testing just to make sure it isn't breaking anything since the previous change 
wouldn't have made any impact at all.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

