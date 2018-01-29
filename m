Return-Path: <alexander.kanavin@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 8E64A786C0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Jan 2018 07:14:53 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	28 Jan 2018 23:14:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,429,1511856000"; d="scan'208";a="13714640"
Received: from kanavin-desktop.fi.intel.com (HELO [10.237.68.161])
	([10.237.68.161])
	by fmsmga007.fm.intel.com with ESMTP; 28 Jan 2018 23:14:53 -0800
To: DUSHYANT KUMAR Singh <dushyantkumars94@gmail.com>,
	bitbake-devel@lists.openembedded.org
References: <CAFrFSW7+XYeZG9DzB1JyVgsg0gEYbFU7HQ+j0L44=jTnG2m0gA@mail.gmail.com>
From: Alexander Kanavin <alexander.kanavin@linux.intel.com>
Message-ID: <df2b2c31-ac22-e479-0c5f-c5230ef07dd2@linux.intel.com>
Date: Mon, 29 Jan 2018 09:09:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAFrFSW7+XYeZG9DzB1JyVgsg0gEYbFU7HQ+j0L44=jTnG2m0gA@mail.gmail.com>
Subject: Re: Regarding the bitbake tool
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
X-List-Received-Date: Mon, 29 Jan 2018 07:14:53 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 01/28/2018 10:41 AM, DUSHYANT KUMAR Singh wrote:

> Please give me some hints regarding this so that I can solve this issue.

Do not do software development as a root user, it's unsafe. Create a 
normal user and use root only for things that require root.

In this case, simply repeat the quickstart guide steps as a regular user


Alex

