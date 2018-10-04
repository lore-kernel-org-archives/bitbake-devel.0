Return-Path: <stefan@agner.ch>
Received: from mail.kmu-office.ch (mail.kmu-office.ch [178.209.48.109])
	by mail.openembedded.org (Postfix) with ESMTP id D3BC0745C3
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  4 Oct 2018 16:45:32 +0000 (UTC)
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
	by mail.kmu-office.ch (Postfix) with ESMTPSA id 964755C11D6;
	Thu,  4 Oct 2018 18:45:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
	t=1538671532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=h+t1PZfkyWpBmM+yiTgMfzGXJI2i3+H8QnmCnun+03I=;
	b=Sn93BGfRdrjVDwVn54qSlyq6k8WlhXn8US8S0WDPhhTtV1DLFfH3+oXJTnP5+e0gTRw7Ij
	SchBHC1utO2JcihNOl3p7z5Iz6XtmR2mxZCOoHclR63F6+aZjJ3ofIWhiVl28zyPqrmE/g
	+ecYPjfLSnAsWn0EgOXxafkoPJh2t+Y=
MIME-Version: 1.0
Date: Thu, 04 Oct 2018 18:45:32 +0200
From: Stefan Agner <stefan@agner.ch>
To: "Bonnans, Laurent" <laurent.bonnans@here.com>
In-Reply-To: <69b4b130-96b1-cea3-f4ec-b22e9777397b@here.com>
References: <bfa936254124b13689c89dcee2a4e427@agner.ch>
	<69b4b130-96b1-cea3-f4ec-b22e9777397b@here.com>
Message-ID: <c84e653d352a71888547e5dd1ac06d5b@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Cc: ricardo@foundries.io, bitbake-devel@lists.openembedded.org
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
X-List-Received-Date: Thu, 04 Oct 2018 16:45:33 -0000
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Laurent,

On 04.10.2018 18:28, Bonnans, Laurent wrote:
> Hello Stefan,
> 
> On 10/04/2018 06:08 PM, Stefan Agner wrote:
>> Hi,
>>
>> It seems that 9c6b39adf978 ("fetch2/gitsm.py: Rework the git submodule fetcher") broke git submodules in some cases. My particular case is aktualizr from meta-updater (https://github.com/advancedtelematic/meta-updater). Fetching aktualizr reliably fails for me now:
>>
>> ERROR: aktualizr-1.0+gitAUTOINC+a94a15e31f-7 do_unpack: Fetcher failure: Submodule tests/tuf-test-vectors does not exist in /home/ags/oe/downloads/git2/github.com.advancedtelematic.aktualizr/modules/tests/tuf-test-vectors or
>> /home/ags/oe/build-colibri-imx7/tmp-oe/work/armv7at2hf-neon-lmp-linux-gnueabi/aktualizr/1.0+gitAUTOINC+a94a15e31f-7/git/.git/modules/tests/tuf-test-vectors.
>> ERROR: aktualizr-1.0+gitAUTOINC+a94a15e31f-7 do_unpack: Function failed: base_do_unpack
>> ERROR: Logfile of failure stored in: /home/ags/oe/build-colibri-imx7/tmp-oe/work/armv7at2hf-neon-lmp-linux-gnueabi/aktualizr/1.0+gitAUTOINC+a94a15e31f-7/temp/log.do_unpack.35143
>> ERROR: Task (/home/ags/oe/build-colibri-imx7/conf/../../layers/meta-updater/recipes-sota/aktualizr/aktualizr_git.bb:do_unpack) failed with exit code '1'
>>
>> Any idea what that could be?
>>
>> --
>> Stefan
> 
> We also noticed the problem and supplied a fix to the bitbake-devel 
> mailing list (actually, there were two separate issues in our case). The 
> commits are currently sitting in master-next branches of bitbake and 
> poky and should, in all likelihood, move to master soon.

I guess you refer to:
fetch2/gitsm: checkout submodules recursively
fetch2/gitsm: handle submodules nested inside subdirs

WARNING: aktualizr-1.0+gitAUTOINC+a94a15e31f-7 do_fetch: Failed to fetch URL gitsm://github.com/cajun-rat/HdrHistogram_c;protocol=https;name=third_party/HdrHistogram_c;bareclone=1;nocheckout=1, attempting MIRRORS if available
ERROR: aktualizr-1.0+gitAUTOINC+a94a15e31f-7 do_fetch: Fetcher failure: Unable to find revision 0b778a98c90ce55285cb1cb6fe50e2b25dfd57ae in branch master even from upstream
WARNING: aktualizr-1.0+gitAUTOINC+a94a15e31f-7 do_fetch: Failed to fetch URL gitsm://github.com/advancedtelematic/aktualizr;branch=master, attempting MIRRORS if available
ERROR: aktualizr-1.0+gitAUTOINC+a94a15e31f-7 do_fetch: Fetcher failure for URL: 'gitsm://github.com/cajun-rat/HdrHistogram_c;protocol=https;name=third_party/HdrHistogram_c;bareclone=1;nocheckout=1'. Unable to fetch URL from any source.
ERROR: aktualizr-1.0+gitAUTOINC+a94a15e31f-7 do_fetch: Fetcher failure for URL: 'gitsm://github.com/advancedtelematic/aktualizr;branch=master'. Unable to fetch URL from any source.
ERROR: aktualizr-1.0+gitAUTOINC+a94a15e31f-7 do_fetch: Function failed: base_do_fetch
ERROR: Logfile of failure stored in: /home/ags/oe/build-colibri-imx7/tmp-tordy/work/armv7at2hf-neon-lmp-linux-gnueabi/aktualizr/1.0+gitAUTOINC+a94a15e31f-7/temp/log.do_fetch.41673
ERROR: Task (/home/ags/oe/build-colibri-imx7/conf/../../layers/meta-updater/recipes-sota/aktualizr/aktualizr_git.bb:do_fetch) failed with exit code '1'

(I am using meta-updater c4902394cc6673b07ad5ee87570e02afbdf7b022 and bitbake master-next as of now)

I did use -c cleanall before, which hopefully should be sufficient?

--
Stefan

