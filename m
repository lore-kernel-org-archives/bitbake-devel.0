Return-Path: <ross.burton@intel.com>
X-Greylist: delayed 426 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 22 Nov 2019 17:08:47 UTC
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by mail.openembedded.org (Postfix) with ESMTP id B8C7C7FCD2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Nov 2019 17:08:47 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	22 Nov 2019 09:01:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,230,1571727600"; d="scan'208";a="232720213"
Received: from unknown (HELO blackadder.local) ([10.252.49.82])
	by fmsmga004.fm.intel.com with ESMTP; 22 Nov 2019 09:01:41 -0800
To: bitbake-devel@lists.openembedded.org
References: <20191114142131.29829-1-git@andred.net>
From: Ross Burton <ross.burton@intel.com>
Organization: Intel Corporation (UK) Ltd. - Co. Reg. #1134945 - Pipers Way,
	Swindon SN3 1RJ
Message-ID: <83d558f5-b153-b3ca-d4b7-eca7b37e78c3@intel.com>
Date: Fri, 22 Nov 2019 17:01:41 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:60.0)
	Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191114142131.29829-1-git@andred.net>
Subject: Re: [master][PATCH] fetch2/wget: support releases from private github repositories
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
X-List-Received-Date: Fri, 22 Nov 2019 17:08:47 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

On 14/11/2019 14:21, André Draszik wrote:
> The wget / http fetcher currently doesn't support fetching
> assets attached to releases on private GitHub repositories,
> i.e. release artefacts like
>      https://github.com/<user>/<project>/releases/download/v1.0.0/asset1.txt
> 
> Those are special, in that HTTP basic auth is not used / possible
> on the URL as seen in the GitHub UI, but instead the GitHub API
> must be used for downloading (which does support HTTP basic auth)
> where the URL will be different.
> 
> To be able to access the GitHub API, opportunistic authentication
> (auth-no-challenge) needs to be enabled. Then the API needs to
> be queried for the real URL of the file to be downloaded, and
> finally application/octet-stream must be specified explicitly.
> 
> Note that there is a slight difference in the location of the
> REST API endpoints between GitHub.com and GitHub Enterprise.
> 
>      https://developer.github.com/v3/repos/releases/
>      https://developer.github.com/enterprise/2.19/v3/enterprise-admin/
> 
> As it's impossible to determine if a repository is on GitHub
> or not (considering GitHub Enterprise), and even more so if a
> repository is private or not, a new flag is introduced that
> should be set to "1" - "github_private_asset", e.g.

That's a lot of "special" and "unfortunately" and "but", adding a 
site-specific option and a non-trivial site-specific chunk of code to 
the otherwise generic HTTP fetcher.

I'd suggest implementing this as a new fetcher instead of shoe-horning 
it into the wget fetcher.  Then you can do something like githubasset:// 
in SRC_URI and the fetcher can do the right thing instead of jumping 
through hoops and guessing.

Ross

