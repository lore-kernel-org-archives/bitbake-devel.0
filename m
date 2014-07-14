Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 9271C7023E
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 14 Jul 2014 11:24:05 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 14 Jul 2014 04:18:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.01,657,1400050800"; d="scan'208";a="572763801"
Received: from snaufer-mobl1.gar.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.121.80])
	by orsmga002.jf.intel.com with ESMTP; 14 Jul 2014 04:24:05 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: "Rifenbark, Scott M" <scott.m.rifenbark@intel.com>,
	"Robert P. J. Day" <rpjday@crashcourse.ca>
Date: Mon, 14 Jul 2014 12:24:02 +0100
Message-ID: <2465679.y5U0thETEa@peggleto-mobl5.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.13.2 (Linux/3.15.4-200.fc20.x86_64; KDE/4.13.2; x86_64; ; )
In-Reply-To: <41DEA4B02DBDEF40A0F3B6D0DDB1237983FB688C@ORSMSX101.amr.corp.intel.com>
References: <alpine.LFD.2.11.1407080725470.32352@localhost>
	<41DEA4B02DBDEF40A0F3B6D0DDB1237983FB688C@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: how much effort is going into updating bitbake user	manual?
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
X-List-Received-Date: Mon, 14 Jul 2014 11:24:07 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 08 July 2014 11:44:51 Rifenbark, Scott M wrote:
> Robert P. J. Day wrote:
> > case in point -- there are at least some BB variables that aren't listed
> > in the glossary, such as PARALLEL_MAKE. i'm making a list of these, but i
> > know that the yocto project also has a massive reference manual which
> > includes a variable glossary. so where should i concentrate my efforts?
> > personally, if something is BB-specific, i'd rather it go into the BB user
> > manual.
>
> If it is BB-specific then it definitely goes in the BB-manual

Right; and in the case of PARALLEL_MAKE, that variable is not understood by 
BitBake itself - its implementation is in the OE metadata.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

