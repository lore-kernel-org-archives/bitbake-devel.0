Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id AABE060881
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 30 May 2013 17:12:03 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 30 May 2013 10:09:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.87,772,1363158000"; d="scan'208";a="322029334"
Received: from unknown (HELO helios.localnet) ([10.252.121.172])
	by orsmga001.jf.intel.com with ESMTP; 30 May 2013 10:11:57 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: "William M.A. Traynor" <wmat@alphatroop.com>
Date: Thu, 30 May 2013 18:11:56 +0100
Message-ID: <3360241.lzjhbPNm27@helios>
Organization: Intel Corporation
User-Agent: KMail/4.10.2 (Linux/3.8.0-22-generic; KDE/4.10.2; i686; ; )
In-Reply-To: <CAGfZjq7x_OAHRw-_S8Rm0mZRa793dmnp36mpPCbTw18zvNKhEA@mail.gmail.com>
References: <CAGfZjq7x_OAHRw-_S8Rm0mZRa793dmnp36mpPCbTw18zvNKhEA@mail.gmail.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Hello World example for BitBake Manual
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
X-List-Received-Date: Thu, 30 May 2013 17:12:03 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 29 May 2013 13:28:11 William M.A. Traynor wrote:
> In researching and trying to work through a Hello World example for
> inclusion in the BitBake Manual, I've been able to reproduce the
> examples described in the following thread:
> http://www.mail-archive.com/yocto@yoctoproject.org/msg09347.html

I think this example is generic enough for the documentation.
 
> and in the following blog post:
> http://hambedded.org/blog/2012/11/24/from-bitbake-hello-world-to-an-image/

This however, whilst it is a very detailed and well written explanation, goes 
a bit further and is trying to put something together that's moving a bit 
towards what OE does, as an aid to explain how OE works (e.g. the introduction 
of an "autotools.bbclass"). I'm not sure this is really appropriate for the 
Bitbake manual IMHO. You could draw inspiration from parts of it though.

> Does anyone have sufficient knowledge of each of these examples to
> comment whether they're "generic" enough for the manual?  I'm trying
> my best to keep content as generic as possible, but it's proving to be
> a struggle at times.
>
> Specifically, I'm finding that it's possible to be to generic, and
> thereby not adequately demonstrate the power of the tool.

I know, it can be tricky. If you have specific areas you'd like help on then 
I'm more than happy to help though.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

