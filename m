Return-Path: <mark.hatle@kernel.crashing.org>
Received: from kernel.crashing.org (kernel.crashing.org [76.164.61.194])
	by mail.openembedded.org (Postfix) with ESMTP id 207207F822
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 22 Dec 2019 18:53:15 +0000 (UTC)
Received: from Marks-MacBook-Pro-16.local ([76.164.61.198])
	(authenticated bits=0)
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id xBMIr56t007145
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NO); Sun, 22 Dec 2019 12:53:14 -0600
To: Konrad Weihmann <kweihmann@outlook.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
References: <AM4PR05MB3380452CB92A3A59408226A0A82F0@AM4PR05MB3380.eurprd05.prod.outlook.com>
From: Mark Hatle <mark.hatle@kernel.crashing.org>
Message-ID: <708bc336-ff40-143c-5218-9acfd2dccab0@kernel.crashing.org>
Date: Sun, 22 Dec 2019 12:53:05 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
	Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <AM4PR05MB3380452CB92A3A59408226A0A82F0@AM4PR05MB3380.eurprd05.prod.outlook.com>
Subject: Re: Bitbake exception when recipe path contains a blank
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
X-List-Received-Date: Sun, 22 Dec 2019 18:53:16 -0000
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit

It's a known issue, spaces are not allowed in path names.

There should already be checks without OE for this, but I'm guessing that this
is firing before those checks (or those checks are incomplete.)

I believe this is in sanity.bbclass, "chcek_sanity_everybuild" function, about
line 837 in the current master.

The check appears to only be scanning 'oeroot'.  Perhaps a new check for the
layers either inside of the sanity (if it's run early enough) or in bitbake
itself is needed.

Note, the big below should likely get fixed.  Any time the system throws an
exception like this, I'd consider it a bug.

--Mark

On 12/22/19 8:29 AM, Konrad Weihmann wrote:
> Hi All,
> 
> I experienced a strange issue recently - currently I'm using bitbake 
> 1.44.0 as it comes with Yocto:zeus-release, but it really doesn't 
> matter, as the underlying code didn't change within the last few years.
> 
> I created a recipe (nothing special, just some files and some compiler 
> instructions).
> Important is that SRC_URI contains at least one file://-entry.
> 
> When I tried to run the recipe build crashed with the following exception
> 
>    File "/build/poky/bitbake/lib/bb/checksum.py", line 103, in 
> FileChecksumCache.get_checksums(filelist='/build/meta-something/test-recipe 
> /test-recipe/mydistro/a.file:False ', pn='test-recipe'):
> 
>               for pth in filelist.split():
>      >            exist = pth.split(":")[1]
>                   if exist == "False":
> IndexError: list index out of range
> 
> A look at the filelist argument shows a strange first item (missing ':').
> 
> After some debugging it went done to that the path to the recipe was
> 
> "/build/meta-something /test-recipe" instead of 
> "/build/meta-something/test-recipe".
> 
> After removing the blank in the path, everything went well.
> 
> Maybe that's one for the initial parsing to issue a warning, that the 
> path to a recipe is corrupted.
> 
> Does anyone encountered that before? Any thoughts on how and where to 
> fix this?
> 
> Regards
> 
> Konrad
> 
> 

