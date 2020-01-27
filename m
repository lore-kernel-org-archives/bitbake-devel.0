Return-Path: <adrian.ambrozewicz@linux.intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by mail.openembedded.org (Postfix) with ESMTP id 983347FD3C
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 27 Jan 2020 08:56:14 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	27 Jan 2020 00:56:15 -0800
X-IronPort-AV: E=Sophos;i="5.70,369,1574150400"; d="scan'208";a="276856749"
Received: from aambroze-mobl1.ger.corp.intel.com (HELO [10.102.85.150])
	([10.102.85.150])
	by fmsmga003-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
	27 Jan 2020 00:56:14 -0800
To: Andre McCurdy <armccurdy@gmail.com>
References: <4bee3ba1-3608-5598-b168-1e6009bdc986@linux.intel.com>
	<CANNYZj8CRSC3V8K08-dpEmGg5zbY9N4jiJPQhia04d7NRKiTEw@mail.gmail.com>
	<b64ada55-a892-09a5-13b2-f76e2b0507d1@linux.intel.com>
	<a4d78a27-50e6-ee87-bcd7-71694b7da60f@linux.intel.com>
	<CANNYZj8S5A1qKy8m_=pPfP_Hbqs7qzYqE-rwMf+DGE0ivnBxpA@mail.gmail.com>
	<4fef2d1e-5fcc-5143-5cf9-cac5ea30b442@linux.intel.com>
	<f9dbd756-6bed-d3ec-f3db-8b2da765b99f@linux.intel.com>
	<CAJ86T=V7P6-oXp6HSw2c31ObBRBQOqU=esetXK7cZkD-8vaXEA@mail.gmail.com>
From: =?UTF-8?Q?Adrian_Ambro=c5=bcewicz?= <adrian.ambrozewicz@linux.intel.com>
Message-ID: <2f960b35-19a2-9360-701a-5d5f033b8806@linux.intel.com>
Date: Mon, 27 Jan 2020 09:56:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
	Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAJ86T=V7P6-oXp6HSw2c31ObBRBQOqU=esetXK7cZkD-8vaXEA@mail.gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: devtool hardcodes using 'git' patchtool which causes errors
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
X-List-Received-Date: Mon, 27 Jan 2020 08:56:14 -0000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

I was not aware of patchdir option, so kudos for you. Will keep that in 
mind, thanks!

W dniu 1/25/2020 o 07:34, Andre McCurdy pisze:
> On Thu, Jan 23, 2020 at 2:03 AM Adrian Ambrożewicz
> <adrian.ambrozewicz@linux.intel.com> wrote:
>>
>> I've tried yet another approach, leveraging that this project is built
>> using cmake and it worked! I know it's not a generic fix, but it looks
>> like in bitbake nothing is really generic...
> 
> An alternative approach (perhaps the official generic solution?) may
> be to use S="${WORKDIR}/git/project_dir", (re)create your patches from
> the top level of the git repo without any extra strip levels etc and
> then specify "patchdir" for each patch in SRC_URI, e.g. in your case
> patchdir would be set to ".." in order to apply patches from the
> directory one level above ${S}.
> 
> SRC_URI += "file://mychanges.patch;patchdir=.."
> 

