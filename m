Return-Path: <stefan@agner.ch>
Received: from mail.kmu-office.ch (mail.kmu-office.ch [178.209.48.109])
	by mail.openembedded.org (Postfix) with ESMTP id 4760379A03
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  5 Oct 2018 08:41:53 +0000 (UTC)
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
	by mail.kmu-office.ch (Postfix) with ESMTPSA id D315A5C18D1;
	Fri,  5 Oct 2018 10:41:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
	t=1538728913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=+IfVsH3MiO5e1jBx32BI+/vi5CX/NDHVr2zpbJ5J0o0=;
	b=K248t5QFGA61z9Qrz3shUI713uwLgDD8oHQbo6RXplYGPFikoNtgh3TblYPPwmOuzzK+Qk
	KN156Zx/3Y2doO0o62fN92vha3x/AL/uZfj/szp1/OkvsZfb+DnbRFEl/oXhPVUfD2iBBU
	URadBNLS63Ln0c+i4QcqiJ9vervfu80=
MIME-Version: 1.0
Date: Fri, 05 Oct 2018 10:41:53 +0200
From: Stefan Agner <stefan@agner.ch>
To: "Bonnans, Laurent" <laurent.bonnans@here.com>
In-Reply-To: <bbea5568-6173-516a-51e6-842a367f8375@here.com>
References: <bfa936254124b13689c89dcee2a4e427@agner.ch>
	<69b4b130-96b1-cea3-f4ec-b22e9777397b@here.com>
	<c84e653d352a71888547e5dd1ac06d5b@agner.ch>
	<4184b6d1-6531-5011-4087-61bf5e0fc761@windriver.com>
	<bbea5568-6173-516a-51e6-842a367f8375@here.com>
Message-ID: <6922ce40987e7b68ee9a0358682d68d5@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: git submodule fetcher regression
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
X-List-Received-Date: Fri, 05 Oct 2018 08:41:53 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 05.10.2018 10:38, Bonnans, Laurent wrote:
> Hello Stefan,
> 
> 
> On 10/04/2018 06:58 PM, Mark Hatle wrote:
>> On 10/4/18 11:45 AM, Stefan Agner wrote:
>>> I guess you refer to:
>>> fetch2/gitsm: checkout submodules recursively
>>> fetch2/gitsm: handle submodules nested inside subdirs
>>>
>>> WARNING: aktualizr-1.0+gitAUTOINC+a94a15e31f-7 do_fetch: Failed to fetch URL gitsm://github.com/cajun-rat/HdrHistogram_c;protocol=https;name=third_party/HdrHistogram_c;bareclone=1;nocheckout=1, attempting MIRRORS if available
>>> ERROR: aktualizr-1.0+gitAUTOINC+a94a15e31f-7 do_fetch: Fetcher failure: Unable to find revision 0b778a98c90ce55285cb1cb6fe50e2b25dfd57ae in branch master even from upstream
>>> WARNING: aktualizr-1.0+gitAUTOINC+a94a15e31f-7 do_fetch: Failed to fetch URL gitsm://github.com/advancedtelematic/aktualizr;branch=master, attempting MIRRORS if available
>>> ERROR: aktualizr-1.0+gitAUTOINC+a94a15e31f-7 do_fetch: Fetcher failure for URL: 'gitsm://github.com/cajun-rat/HdrHistogram_c;protocol=https;name=third_party/HdrHistogram_c;bareclone=1;nocheckout=1'. Unable to fetch URL from any source.
>>> ERROR: aktualizr-1.0+gitAUTOINC+a94a15e31f-7 do_fetch: Fetcher failure for URL: 'gitsm://github.com/advancedtelematic/aktualizr;branch=master'. Unable to fetch URL from any source.
>>> ERROR: aktualizr-1.0+gitAUTOINC+a94a15e31f-7 do_fetch: Function failed: base_do_fetch
>>> ERROR: Logfile of failure stored in: /home/ags/oe/build-colibri-imx7/tmp-tordy/work/armv7at2hf-neon-lmp-linux-gnueabi/aktualizr/1.0+gitAUTOINC+a94a15e31f-7/temp/log.do_fetch.41673
>>> ERROR: Task (/home/ags/oe/build-colibri-imx7/conf/../../layers/meta-updater/recipes-sota/aktualizr/aktualizr_git.bb:do_fetch) failed with exit code '1'
>>>
>>> (I am using meta-updater c4902394cc6673b07ad5ee87570e02afbdf7b022 and bitbake master-next as of now)
>>>
>>> I did use -c cleanall before, which hopefully should be sufficient?
> This should be solved in meta-updater 
> 8a44c8a26966d0cb9b57ea1ef4c6f25c2a944dd8 and beyond. I believe it's the 
> same issue reported by Jens Rehsack on Oct 1.
> We had a simple workaround in this case, so we did not investigate the 
> core bitbake issue at that time.
>> If you are still having issues from master-next (bitbake), can you distill down
>> a reproducer recipe?
>>
>> All it takes is a minimal recipe with a SRC_URI line that used to work for you
>> through the do_unpack stage.  (I don't care about anything after do_unpack...)
>>
>> typical reproducer may look like YP Bug 12941:
>>
>> SUMMARY  = "Library to access Blu-Ray disk"
>> SECTION = "misc"
>> HOMEPAGE = "http://videolan.org"
>> LICENSE = "GPLv2"
>> LIC_FILES_CHKSUM="file://COPYING;md5=435ed639f84d4585d93824e7da3d85da"
>>
>> DEPENDS = "libxml2"
>>
>> SRC_URI = "gitsm://git.videolan.org/libbluray.git"
>>
>> SRCREV = "${AUTOREV}"
>>
>>
>> --Mark
>>
>>
> Hello Mark, here is a short reproducer (aktualizr.bb)
> 
> 
> SUMMARY = "Aktualizr SOTA Client"
> DESCRIPTION = "SOTA Client application written in C++"
> HOMEPAGE = "https://github.com/advancedtelematic/aktualizr"
> SECTION = "base"
> LICENSE = "MPL-2.0"
> LIC_FILES_CHKSUM = 
> "file://${S}/LICENSE;md5=9741c346eef56131163e13b9db1241b3"
> 
> PV = "1.0+git${SRCPV}"
> 
> SRC_URI = " \
>    gitsm://github.com/advancedtelematic/aktualizr;branch=${BRANCH} \
>    "
> SRCREV = "79246b930a1b5b6f956b69f74f1f0c62060061df"
> BRANCH ?= "master"
> 
> 
> Then, `aktualizr -c unpack` fails with the same error Stefan described.
> 
> The root cause is this submodule declaration:
> 
> [submodule "third_party/HdrHistogram_c"]
>      path = third_party/HdrHistogram_c
>      url = https://github.com/cajun-rat/HdrHistogram_c
> 
> Which is set to the commit 0b778a98c90ce55285cb1cb6fe50e2b25dfd57ae, 
> current HEAD of the branch `fix-const-cast` but not merged in 
> cajun-rat's master.
> 
> Please let me know if you need more details.
> 
> 
> Also, while investigating these issues, I noticed that `cleanall` now 
> does not remove the fetched submodules like it would be expected. So, 
> running `fetch` again only download the main project and will reuse 
> cached submodules repositories if up to date.

That just raced with my email :-)

Yes that seems to be the issue I see. Thanks Laurent for looking closer into that.

--
Stefan

