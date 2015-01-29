Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (mail.mlbassoc.com [65.100.170.105])
	by mail.openembedded.org (Postfix) with ESMTP id 581EF606B9
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 29 Jan 2015 15:39:39 +0000 (UTC)
Received: by mail.chez-thomas.org (Postfix, from userid 1998)
	id A1292F811DA; Thu, 29 Jan 2015 08:39:40 -0700 (MST)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on
	hermes.chez-thomas.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=4.0 tests=ALL_TRUSTED,BAYES_00,
	DNS_FROM_AHBL_RHSBL autolearn=no version=3.3.2
Received: from [192.168.1.114] (zeus [192.168.1.114])
	by mail.chez-thomas.org (Postfix) with ESMTP id CA5FDF811DA;
	Thu, 29 Jan 2015 08:39:39 -0700 (MST)
Message-ID: <54CA545A.4060007@mlbassoc.com>
Date: Thu, 29 Jan 2015 08:40:10 -0700
From: Gary Thomas <gary@mlbassoc.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <CAGpdKULqOhkU1YqEKrm1Yc9vPN4+SStAv=woPMi=Ey6CzwCTrQ@mail.gmail.com>
	<1915662.1K5ZXqbggV@peggleto-mobl5.ger.corp.intel.com>
In-Reply-To: <1915662.1K5ZXqbggV@peggleto-mobl5.ger.corp.intel.com>
Subject: Re: Bitbake inherit graph
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
X-List-Received-Date: Thu, 29 Jan 2015 15:39:40 -0000
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 2015-01-29 07:51, Paul Eggleton wrote:
> On Thursday 29 January 2015 13:47:12 Roman Savchenko wrote:
>> How can I build inherit graph?
>
> Can you explain what you're looking for exactly? BitBake can produce (very
> large) task, PN and package graphs in .dot format with the -g option, but I'm
> not sure that that's what you're asking for.

Don't forget about the dependency explorer for a nice graphical
view of this data:
   $ bitbake <package> -g -u depexp

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------

