Return-Path: <ross.burton@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id EDA5779C7C
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Dec 2019 15:38:54 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	23 Dec 2019 07:38:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,348,1571727600"; d="scan'208";a="242244093"
Received: from ansethi-mobl.ger.corp.intel.com (HELO rburton-mac01.local)
	([10.252.36.195])
	by fmsmga004.fm.intel.com with ESMTP; 23 Dec 2019 07:38:55 -0800
To: bitbake-devel@lists.openembedded.org
References: <20191114142131.29829-1-git@andred.net>
	<20191220100831.33196-1-git@andred.net>
From: Ross Burton <ross.burton@intel.com>
Organization: Intel Corporation (UK) Ltd. - Co. Reg. #1134945 - Pipers Way,
	Swindon SN3 1RJ
Message-ID: <62314784-83d5-52b7-9401-1a3733e9abeb@intel.com>
Date: Mon, 23 Dec 2019 15:38:54 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:60.0)
	Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191220100831.33196-1-git@andred.net>
Subject: Re: [master][PATCH v2] fetch2/githubprivate: new fetcher for private github repositories
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
X-List-Received-Date: Mon, 23 Dec 2019 15:38:55 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

On 20/12/2019 10:08, André Draszik wrote:
> -        elif self.type not in ["http", "https", "ftp", "ftps", "sftp", "s3"]:
> +        elif self.type not in ["http", "https", "ftp", "ftps", "githubprivate", "sftp", "s3"]:

I hate these lines.  I wonder if the fetcher class itself can have a 
md5_expected boolean field that can be used instead.

> +class Githubprivate(Wget):

It's too near Christmas to review this properly but that looks *a lot* 
neater!

Ross

