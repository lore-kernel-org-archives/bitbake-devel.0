Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 0765B65C7B
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Jan 2015 10:34:00 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga102.jf.intel.com with ESMTP; 23 Jan 2015 02:30:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.09,453,1418112000"; d="scan'208";a="666401605"
Received: from vvatula-mobl2.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.22.114])
	by fmsmga002.fm.intel.com with ESMTP; 23 Jan 2015 02:33:59 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Fri, 23 Jan 2015 10:33:58 +0000
Message-ID: <3577015.nPVb6vKuGn@peggleto-mobl5.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.3 (Linux/3.17.8-200.fc20.x86_64; KDE/4.14.3; x86_64; ; )
In-Reply-To: <1421938639.19798.17.camel@linuxfoundation.org>
References: <1421938639.19798.17.camel@linuxfoundation.org>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Lifecycle issues in Bitbake
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
X-List-Received-Date: Fri, 23 Jan 2015 10:34:08 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Richard,

On Thursday 22 January 2015 14:57:19 Richard Purdie wrote:
> Looking at and thinking about:
> 
> https://bugzilla.yoctoproject.org/show_bug.cgi?id=5187
> 
> We have several issues. Firstly, DATE and TIME are locked in stone when
> the base configuration is parsed. This may cause images to overwrite
> previous versions for example if DATE and TIME are not re-evaluated. We
> could fix this by specifically setting DATE and TIME in bitbake at
> BuildStart?

We could certainly do this. Another mechanism I did think about was to have 
some way of indicating to BitBake that on buildstart the value should be reset 
to the immediate evaluation of an expression; perhaps a varflag. At least that 
way we could handle other such variables, although it's conceivable that 
having built-in DATE and TIME in BitBake wouldn't be the worst thing in the 
world.
 
> Secondly, there is one cooker log file opened for the duration of the
> cooker lifecycle. This is a cooker log, not a log of each build so that
> is perhaps not surprising (and is the core problem in the above bug).
> There is no overwriting of the log file, it just keeps growing with each
> build.
> 
> We could trigger knotty to write out build specific log files based on
> the BuildStart/Finish events?

Yes I think we should do this.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

