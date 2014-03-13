Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 0FEF16F7CF
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 13 Mar 2014 10:11:29 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 13 Mar 2014 03:06:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,646,1389772800"; d="scan'208";a="471528897"
Received: from unknown (HELO peggleto-mobl5.ger.corp.intel.com)
	([10.252.120.214])
	by orsmga001.jf.intel.com with ESMTP; 13 Mar 2014 03:11:16 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: "Damian, Alexandru" <alexandru.damian@intel.com>
Date: Thu, 13 Mar 2014 10:11:14 +0000
Message-ID: <1433949.4mLA2GKP3u@peggleto-mobl5.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.12.3 (Linux/3.13.6-200.fc20.x86_64; KDE/4.12.3; x86_64; ; )
In-Reply-To: <CAJ2CSBv4rwENCu1q7RFFBV8Fr3y8sZS2RX74ZSNd6fj8DKnvKQ@mail.gmail.com>
References: <1394631711-1083-1-git-send-email-alexandru.damian@intel.com>
	<CAJTo0LY3oh5S2w1QxsGWBuYf1OUJbUBtakOWDGvRHVtafzYDvQ@mail.gmail.com>
	<CAJ2CSBv4rwENCu1q7RFFBV8Fr3y8sZS2RX74ZSNd6fj8DKnvKQ@mail.gmail.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] toaster: fix timezone detection
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
X-List-Received-Date: Thu, 13 Mar 2014 10:11:30 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 12 March 2014 18:49:02 Damian, Alexandru wrote:
> This is a Debian-ism :(

You say that, but the Fedora 20 install I have here (a) doesn't have TZ and 
(b) has /etc/localtime -> ../usr/share/zoneinfo/Europe/London. On my CentOS 
6.5 machine (possibly irrelevant for Toaster, but...) TZ is also unset but 
/etc/localtime is just a plain copy of some timezone file rather than a 
symlink. Older RH-style systems such as CentOS 6 have a ZONE value in 
/etc/sysconfig/clock but Fedora appears to have eliminated this file.

Given that, I don't think this is a complete fix.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

