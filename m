Return-Path: <anibal.limon@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 9AFB665CBD
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jul 2015 19:19:21 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga101.fm.intel.com with ESMTP; 20 Jul 2015 12:19:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,509,1432623600"; d="scan'208";a="732277489"
Received: from alimon-thinkpad-w540.zpn.intel.com (HELO [10.219.5.54])
	([10.219.5.54])
	by orsmga001.jf.intel.com with ESMTP; 20 Jul 2015 12:19:21 -0700
Message-ID: <55AD49BD.5070703@linux.intel.com>
Date: Mon, 20 Jul 2015 14:19:25 -0500
From: =?UTF-8?B?QW7DrWJhbCBMaW3Ds24=?= <anibal.limon@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <1436920259-31969-1-git-send-email-anibal.limon@linux.intel.com>
In-Reply-To: <1436920259-31969-1-git-send-email-anibal.limon@linux.intel.com>
Cc: alexander.kanavin@linux.intel.com
Subject: Re: [PATCH 0/4] fetch2 latest_versionstring improvements
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
X-List-Received-Date: Mon, 20 Jul 2015 19:19:24 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

ping...

On 14/07/15 19:30, Aníbal Limón wrote:
> Changes return of latest_versionstring method now returns current revision
> in SCM's like git.
>
> [YOCTO #7605]
>
> Aníbal Limón (4):
>    fetch2/git.py: latest_versionstring search in all tags
>    fetch2/git.py: latest_versionstring now returns (version, revision)
>    fetch2/wget.py: latest_versionstring now returns (version, revision)
>    tests/fetch.py: Updated test name FetchMethodTest ->
>      FetchLatestVersionTest
>
>   lib/bb/fetch2/git.py  | 20 +++++++++++++-------
>   lib/bb/fetch2/wget.py | 12 ++++++------
>   lib/bb/tests/fetch.py |  8 +++++---
>   3 files changed, 24 insertions(+), 16 deletions(-)
>


