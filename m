Return-Path: <alexander.kanavin@linux.intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by mail.openembedded.org (Postfix) with ESMTP id 11D337016E
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 17 Oct 2017 11:29:30 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga104.jf.intel.com with ESMTP; 17 Oct 2017 04:29:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.43,390,1503385200"; d="scan'208";a="1206687555"
Received: from kanavin-desktop.fi.intel.com (HELO [10.237.68.161])
	([10.237.68.161])
	by fmsmga001.fm.intel.com with ESMTP; 17 Oct 2017 04:29:31 -0700
To: David Vincent <freesilicon@gmail.com>, bitbake-devel@lists.openembedded.org
References: <20171017112748.10968-1-freesilicon@gmail.com>
From: Alexander Kanavin <alexander.kanavin@linux.intel.com>
Message-ID: <612b6e16-2db3-4e33-45fa-e03cb6d26dc1@linux.intel.com>
Date: Tue, 17 Oct 2017 14:26:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20171017112748.10968-1-freesilicon@gmail.com>
Subject: Re: [PATCH] fetch/git: fix per-branch unpacking
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
X-List-Received-Date: Tue, 17 Oct 2017 11:29:31 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 10/17/2017 02:27 PM, David Vincent wrote:
> Create branches for each user-supplied name when running checkout and
> set start point of branch to the resolved revision.

Can you provide an example of how this should be used please (in the 
commit message)?

Alex

