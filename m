Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id CD7C16013D
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Mar 2015 08:59:47 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 20 Mar 2015 01:59:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.11,435,1422950400"; d="scan'208";a="701555117"
Received: from fmarott-mobl10.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.10.101])
	by orsmga002.jf.intel.com with ESMTP; 20 Mar 2015 01:59:47 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Date: Fri, 20 Mar 2015 08:59:45 +0000
Message-ID: <2428587.0qHGqDTWeo@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.4 (Linux/3.18.9-200.fc21.x86_64; KDE/4.14.4; x86_64; ; )
In-Reply-To: <alpine.LFD.2.11.1503110447450.28973@localhost>
References: <alpine.LFD.2.11.1503110447450.28973@localhost>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: what happens if i set up a class function for exporting, but don't export?
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
X-List-Received-Date: Fri, 20 Mar 2015 08:59:48 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 11 March 2015 04:50:14 Robert P. J. Day wrote:
>   reading bitbake user manual, section 3.4.5, "Flexible Inheritance
> for Class Functions", and i know how it works, but what happens if
> you're writing a .bbclass file, define a function with the format such
> that it's ready for exporting:
> 
>   <classname>_<functionmame>
> 
> but subsequently don't export it with EXPORT_FUNCTIONS? by what name
> will it still be available to inheriting files?

Whether EXPORT_FUNCTIONS is used or not, the function will always be callable 
as <classname>_<functionname> (since that's how you have defined it).

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

