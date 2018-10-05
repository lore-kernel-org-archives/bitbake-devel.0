Return-Path: <stefan@agner.ch>
Received: from mail.kmu-office.ch (mail.kmu-office.ch [178.209.48.109])
	by mail.openembedded.org (Postfix) with ESMTP id B6DFA79357
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  5 Oct 2018 08:39:15 +0000 (UTC)
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
	by mail.kmu-office.ch (Postfix) with ESMTPSA id B8C925C1357;
	Fri,  5 Oct 2018 10:39:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
	t=1538728755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=2XkicwG3hIP8yr+cW/1sC+ugGGmdkyMA7jSSbLq3Vqw=;
	b=ydniYJtEOk/s2EVF+pNDYxAiQ2EamHTuVfSarJF3D14jwy4KHKMtg3pbeUzzWgW8Yx+ipe
	7NaZagth2lizvXhyoA9Jbt++YqXGT3/fw6Q3G1y1KtV0xv9VTIwlA9+sLImrKcOZKKAFpx
	q9QUzhTnrQkjYoPowIA3XC0zOSdv9GA=
MIME-Version: 1.0
Date: Fri, 05 Oct 2018 10:39:15 +0200
From: Stefan Agner <stefan@agner.ch>
To: mark.hatle@windriver.com
In-Reply-To: <CAAaKDhF0T6r432bFFDNA=sxU63Axwus83qALpxWFJsmNM+d=PQ@mail.gmail.com>
References: <bfa936254124b13689c89dcee2a4e427@agner.ch>
	<5116fcfb-f5b2-dbf3-afd7-ccbfb98e041d@windriver.com>
	<CAAaKDhF0T6r432bFFDNA=sxU63Axwus83qALpxWFJsmNM+d=PQ@mail.gmail.com>
Message-ID: <66cb8f3d385389e2b91238687d2db984@agner.ch>
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
X-List-Received-Date: Fri, 05 Oct 2018 08:39:16 -0000
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Mark,

On 04.10.2018 20:51, Ricardo Salveti wrote:
> On Thu, Oct 4, 2018 at 1:47 PM Mark Hatle <mark.hatle@windriver.com> wrote:
>>
>> On 10/4/18 11:08 AM, Stefan Agner wrote:
>> > [resend, this time with me being subscriber of bitbake-devel]
>> >
>> > Hi,
>> >
>> > It seems that 9c6b39adf978 ("fetch2/gitsm.py: Rework the git submodule fetcher") broke git submodules in some cases. My particular case is aktualizr from meta-updater (https://github.com/advancedtelematic/meta-updater). Fetching aktualizr reliably fails for me now:
>> >
>> > ERROR: aktualizr-1.0+gitAUTOINC+a94a15e31f-7 do_unpack: Fetcher failure: Submodule tests/tuf-test-vectors does not exist in /home/ags/oe/downloads/git2/github.com.advancedtelematic.aktualizr/modules/tests/tuf-test-vectors or
>> > /home/ags/oe/build-colibri-imx7/tmp-oe/work/armv7at2hf-neon-lmp-linux-gnueabi/aktualizr/1.0+gitAUTOINC+a94a15e31f-7/git/.git/modules/tests/tuf-test-vectors.
>> > ERROR: aktualizr-1.0+gitAUTOINC+a94a15e31f-7 do_unpack: Function failed: base_do_unpack
>> > ERROR: Logfile of failure stored in: /home/ags/oe/build-colibri-imx7/tmp-oe/work/armv7at2hf-neon-lmp-linux-gnueabi/aktualizr/1.0+gitAUTOINC+a94a15e31f-7/temp/log.do_unpack.35143
>> > ERROR: Task (/home/ags/oe/build-colibri-imx7/conf/../../layers/meta-updater/recipes-sota/aktualizr/aktualizr_git.bb:do_unpack) failed with exit code '1'
>> >
>> > Any idea what that could be?
>>
>> See the mailing list archives (or master-next branch).  There are a small series
>> of pending patches.  Please try these.
>>
>> 3 from Laurent Bonnans
>> 1 from me
> 
> Tested with latest bitbake from master-next and latest aktualizr from
> meta-updater and it seems functional again, looks like the patches
> from Laurent are already enough (up to the checkout submodules
> recursively).
> 
> Trying a completely clean build now to see if there are any other regressions.
> 

Tried todays bitbake master, which is fd9893c338df ("gitsm: Allow relative URIs when fetching"), containing the four commits mentioned above.

On my setup, building aktualizr, this fails to fetch source ref a94a15e31f3b973966b1afc9081fc1b17a3b9d48, while it works for a newer ref 512ad74c0b5339ca7775d8c9461b565a9e6ff5b3 (which presumably is what Ricardo tried).

This is a rather minimal recipe to reproduce the fetcher issue:

SUMMARY = "Aktualizr SOTA Client"
DESCRIPTION = "SOTA Client application written in C++"
HOMEPAGE = "https://github.com/advancedtelematic/aktualizr"
SECTION = "base"
LICENSE = "MPL-2.0"
LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=9741c346eef56131163e13b9db1241b3"

PV = "1.0+git${SRCPV}"
PR = "7"

SRC_URI = " \
  gitsm://github.com/advancedtelematic/aktualizr;branch=${BRANCH} \
  "
SRCREV = "a94a15e31f3b973966b1afc9081fc1b17a3b9d48"
BRANCH ?= "master"

S = "${WORKDIR}/git"

inherit cmake

--
Stefan

