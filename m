Return-Path: <philip.lorenz@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD45CC369DC
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 06:12:44 +0000 (UTC)
Received: from esa3.hc324-48.eu.iphmx.com (esa3.hc324-48.eu.iphmx.com [207.54.68.121])
 by mx.groups.io with SMTP id smtpd.web10.10361.1745907159676399992
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Apr 2025 23:12:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=HLfcEgKy;
 spf=pass (domain: bmw.de, ip: 207.54.68.121, mailfrom: prvs=207d80f5d=philip.lorenz@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1745907159; x=1777443159;
  h=message-id:date:mime-version:subject:to:references:cc:
   from:in-reply-to:content-transfer-encoding;
  bh=Y3WxLhwU3U2UutGCuJcgUUqpW8aOmy8Dxy6wRkq5MR8=;
  b=HLfcEgKygMOsGzav2TzpXDCkgyChHjcMjvofNrlLeKSZvQZa5vII/Mnq
   GEcb1Q5h8Df4lynCkjKL9Q9zcjhV9Fvg9drTuc5QfTYbIuKjfZfEPhl1+
   pTH0YkHC6X/Yw98bmZH3VOwGj2K0PE91R/xuiX7xOujOWD4gh3p5aUuBO
   A=;
X-CSE-ConnectionGUID: kb2jTjVURmi9Cv2zEux/8Q==
X-CSE-MsgGUID: HdXRsk5/Rby7CVMNXMGHeQ==
Received: from esagw6.bmwgroup.com (HELO esagw6.muc) ([160.46.252.49]) by
 esa3.hc324-48.eu.iphmx.com with ESMTP/TLS; 29 Apr 2025 08:12:37 +0200
Received: from esabb3.muc ([160.50.100.30])  by esagw6.muc with ESMTP/TLS;
 29 Apr 2025 08:12:36 +0200
Received: from smucmp19d.bmwgroup.net (HELO smucmp19d.europe.bmw.corp)
 ([10.30.13.170]) by esabb3.muc with ESMTP/TLS; 29 Apr 2025 08:12:37 +0200
Received: from [10.242.8.29] (10.30.85.215) by smucmp19d.europe.bmw.corp
 (2a03:1e80:a15:58f::205d) with Microsoft SMTP Server (version=TLS;
 Tue, 29 Apr 2025 08:12:36 +0200
X-CSE-ConnectionGUID: LBvGCfVAS3K+94fBV2nB0A==
X-CSE-MsgGUID: I1hkVesKR0awI6Lpjxoezg==
X-CSE-ConnectionGUID: nmS6I85zSD2lsn6VwejJ/w==
X-CSE-MsgGUID: yiXLxKF/QMK/GgEOodxAmQ==
Message-ID: <c1b8195e-6d50-493a-8eef-cf8c3ba6af1d@bmw.de>
Date: Tue, 29 Apr 2025 08:12:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] Fix gitsm LFS support
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <20250425144138.4089681-1-philip.lorenz@bmw.de>
 <D9IEUL8C31XI.2888IIXIFIPAW@bootlin.com>
 <3c8bcef0df736c09d12970cb8cab08c003065839.camel@linuxfoundation.org>
CC: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	<bitbake-devel@lists.openembedded.org>
From: Philip Lorenz <philip.lorenz@bmw.de>
In-Reply-To: <3c8bcef0df736c09d12970cb8cab08c003065839.camel@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: smucmp17d.europe.bmw.corp (2a03:1e80:a15:58f::1:66) To
 smucmp19d.europe.bmw.corp (2a03:1e80:a15:58f::205d)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Apr 2025 06:12:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17581

Hi Richard,

On 28.04.25 23:09, Richard Purdie wrote:
> On Mon, 2025-04-28 at 18:25 +0200, Mathieu Dubois-Briand wrote:
>> On Fri Apr 25, 2025 at 4:41 PM CEST, Philip Lorenz wrote:
>>> This patch series fixes a number of issues we observed when using the
>>> gitsm fetcher in conjunction with git-lfs.
>>>
>>> I'd like to highlight two patches in this series:
>>> * 0004-fetch2-Simplify-git-LFS-detection: I could not come up with a
>>>    good reason on why the code so far preferred the content of
>>>   `.gitattributes` on the repository's branch instead of always
>>>    considering the state of the target revision. Please let me know
>>>    if there's something I didn't take into account.
>>> * 0005-fetch2-Use-git-lfs-fetch-to-download-objects.patch: I could not
>>>    replicate the `git-lfs fetch` behaviour in versions going back to
>>>    2.13.2 released in 2021. This leads me to believe that the issue
>>>    leading to this workaround is no longer in place. However, if anyone
>>>    remembers the actual issue / versions involved I can also retest to
>>>    confirm that there are no regression.
>>>
>>> ---
>> Hi Philip,
>>
>> Thanks for the new version.
>>
>> It works much better than previously. I still have some issues with
>> bitbake selftests on my branch:
>>
>> ERROR: test_lfs_enabled_not_installed (bb.tests.fetch.GitLfsTest.test_lfs_enabled_not_installed)
>> ----------------------------------------------------------------------
>> Traceback (most recent call last):
>>    File "/srv/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/tests/fetch.py", line 2528, in test_lfs_enabled_not_installed
>>      fetcher.download()
>>      ~~~~~~~~~~~~~~~~^^
>>    File "/srv/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/bb/fetch2/__init__.py", line 1929, in download
>>      raise FetchError("Unable to fetch URL from any source.", u)
>> bb.fetch2.FetchError: Fetcher failure for URL: 'git:///tmp/bitbake-fetch-m30azy7_/gitsource;protocol=file;lfs=1;branch=master'. Unable to fetch URL from any source.
>>
>> Stdout:
>> Cloning into bare repository '/tmp/bitbake-fetch-m30azy7_/download/git2/tmp.bitbake-fetch-m30azy7_.gitsource'...
>> remote: Enumerating objects: 3, done.
>> remote: Counting objects: 100% (3/3), done.
>> remote: Total 3 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
>> Receiving objects:  33% (1/3)
>> Receiving objects: 100% (3/3), done.
>> Failed to fetch URL git:///tmp/bitbake-fetch-m30azy7_/gitsource;protocol=file;lfs=1;branch=master, attempting MIRRORS if available
>> Fetcher failure: Repository file:///tmp/bitbake-fetch-m30azy7_/gitsource has LFS content, install git-lfs on host to download (or set lfs=0 to ignore it)
>> Failed to fetch URL git:///tmp/bitbake-fetch-m30azy7_/gitsource;protocol=file;lfs=1;branch=master, attempting MIRRORS if available
>> Fetcher failure: Repository file:///tmp/bitbake-fetch-m30azy7_/gitsource has LFS content, install git-lfs on host to download (or set lfs=0 to ignore it)
>>
>> https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/builds/1440/steps/12/logs/stdio
> My bitbake master-next branch has a fix for this. We need to mark an
> additional test as requiring git-lfs...
>
> I've tested it and it works, I just need to clean up the patch and send
> it which I didn't get to yet.
>
Are you referring to [1]? I had a brief look based on Mathieu's comment 
and the test case will need to be split into two parts (one which can be 
executed even when git-lfs isn't on the host, the second requiring 
git-lfs to be installed so the download step can happen before 
continuing correct behaviour during unpack). I'll send an update series 
today after actually executing all test cases in all test environments 
later today.

Philip


[1] 
https://git.openembedded.org/bitbake/commit/?h=master-next&id=3a219c691e37ec2f8d26e8de302616a3f94efee2

-- 
Philip Lorenz
BMW Car IT GmbH, Software-Plattform, -Integration Connected Company, Lise-Meitner-Straße 14, 89081 Ulm
-------------------------------------------------------------------------
BMW Car IT GmbH
Management: Chris Brandt, Michael Böttrich, Christian Salzmann
Domicile and Court of Registry: München HRB 134810
-------------------------------------------------------------------------


