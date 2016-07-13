Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 7F8CE6067C
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Jul 2016 22:44:01 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga102.jf.intel.com with ESMTP; 13 Jul 2016 15:44:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,359,1464678000"; d="scan'208";a="733834909"
Received: from apbalanx-mobl.ccr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.177.79])
	by FMSMGA003.fm.intel.com with ESMTP; 13 Jul 2016 15:43:59 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 14 Jul 2016 10:43:56 +1200
Message-ID: <3820835.WMpdxrdKEt@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.10 (Linux/4.5.7-202.fc23.x86_64; KDE/4.14.20; x86_64; ;
	)
In-Reply-To: <570DE536.9020701@mlbassoc.com>
References: <570DE199.3010802@mlbassoc.com>
	<CAMKF1soC0Yy13GyVVoe3KY3SjP26MvrHSbr3WS6x=dRW0uy=0Q@mail.gmail.com>
	<570DE536.9020701@mlbassoc.com>
MIME-Version: 1.0
Cc: Gary Thomas <gary@mlbassoc.com>
Subject: Re: Analyzing dependencies
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
X-List-Received-Date: Wed, 13 Jul 2016 22:44:01 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wed, 13 Apr 2016 08:20:38 Gary Thomas wrote:
> On 2016-04-13 08:08, Khem Raj wrote:
> > Use any program that reads dotty files
> 
> Know of any interactive ones that let you explore like the 'depexp'?

It's not quite like that but FYI I have found "xdot" useful for viewing dot 
files - it performs well with reasonably large graphs (though still struggles 
with the bitbake -g task graph unfortunately).

  https://github.com/jrfonseca/xdot.py

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

