Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 983176FD5C
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Jun 2014 14:56:33 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 18 Jun 2014 07:51:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,501,1400050800"; d="scan'208";a="530480545"
Received: from tlankage-mobl.gar.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.120.87])
	by orsmga001.jf.intel.com with ESMTP; 18 Jun 2014 07:56:05 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Date: Wed, 18 Jun 2014 15:56:03 +0100
Message-ID: <1413867.iP4Nqeb177@peggleto-mobl5.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.12.5 (Linux/3.14.7-200.fc20.x86_64; KDE/4.12.5; x86_64; ; )
In-Reply-To: <alpine.LFD.2.11.1406180835440.24706@localhost>
References: <alpine.LFD.2.11.1406180835440.24706@localhost>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] bitbake-user-manual-intro.xml: Semantic cleanup, clarifications.
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
X-List-Received-Date: Wed, 18 Jun 2014 14:56:40 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 18 June 2014 08:38:04 Robert P. J. Day wrote:
> @@ -413,6 +414,18 @@
>                      you have a directory entitled
>                      <filename>bitbake-1.17.0</filename>.
>                      </para></listitem>
> +                <listitem><para><emphasis>Using the BitBake that comes with
> your build checkout:</emphasis> +                    A final possibility
> for getting a copy of BitBake is that it +                    already comes
> with your checkout of a larger Bitbake-based build system, +               
>     such as Poky or Yocto Project. Rather than manually checking out +     
>               individual layers and gluing them together yourself, you can
> check +                    out an entire build system such as Poky with
> something like: +                    <literallayout class='monospaced'>
> +     $ git clone git://git.yoctoproject.org/poky
> +                    </literallayout>
> +                    where that checkout will already include a version of
> BitBake which +                    has been thoroughly tested for
> compatibility with the other components. +                   
> </para></listitem>
>              </itemizedlist>
>          </para>
>      </section>

Ignoring the mangling that my email client has done, I'm hesitant about the 
latter change. I appreciate the intention and what you've added isn't 
incorrect per se, but the pointer to actually check out poky might be a bit 
too much - I'd rather see a pointer to a different document (perhaps the Yocto 
Project Quick Start guide?). Additionally poky doesn't completely free you 
from fetching and incorporating individual layers, just OE-Core / meta-yocto / 
meta-yocto-bsp.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

