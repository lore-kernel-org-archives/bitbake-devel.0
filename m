Return-Path: <alexander.kanavin@linux.intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by mail.openembedded.org (Postfix) with ESMTP id 73DC972F91
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  2 Oct 2017 16:10:29 +0000 (UTC)
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
	by orsmga104.jf.intel.com with ESMTP; 02 Oct 2017 09:10:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.42,470,1500966000"; d="scan'208";a="158438394"
Received: from kanavin-desktop.fi.intel.com (HELO [10.237.68.161])
	([10.237.68.161])
	by fmsmga006.fm.intel.com with ESMTP; 02 Oct 2017 09:10:29 -0700
To: akuster <akuster@mvista.com>, leonardo.sandoval.gonzalez@linux.intel.com, 
	bitbake-devel@lists.openembedded.org
References: <20171002153849.24922-1-leonardo.sandoval.gonzalez@linux.intel.com>
	<20171002153849.24922-3-leonardo.sandoval.gonzalez@linux.intel.com>
	<324e7e99-7b13-5e30-36a2-4814be8f7b5b@mvista.com>
From: Alexander Kanavin <alexander.kanavin@linux.intel.com>
Message-ID: <f755d561-8d66-2918-e218-fee685ba62f6@linux.intel.com>
Date: Mon, 2 Oct 2017 19:06:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <324e7e99-7b13-5e30-36a2-4814be8f7b5b@mvista.com>
Subject: Re: [PATCH 3/3] README: new readme file including main aspects of the project
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
X-List-Received-Date: Mon, 02 Oct 2017 16:10:29 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 10/02/2017 07:02 PM, akuster wrote:
> 

> Is there any value in providing a sample command:
> 
> git send-patch -M -1 --subject-prefix=Bitbake][PATCH --to
> bitbake-devel@lists.openembedded.org

ak@kanavin-desktop:~/development/poky/meta$ git send-patch
git: 'send-patch' is not a git command. See 'git --help'.


Should be 'git send-email'.

Alex

