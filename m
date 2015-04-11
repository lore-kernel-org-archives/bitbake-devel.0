Return-Path: <akuster808@gmail.com>
Received: from mail-pa0-f50.google.com (mail-pa0-f50.google.com
	[209.85.220.50])
	by mail.openembedded.org (Postfix) with ESMTP id 4022160017
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 11 Apr 2015 01:47:58 +0000 (UTC)
Received: by pabtp1 with SMTP id tp1so38247513pab.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Apr 2015 18:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:date:from:user-agent:mime-version:to:subject:references
	:in-reply-to:content-type:content-transfer-encoding;
	bh=t8VYnrMn6GqQ78xCqVumxBLD3DQUbHOwP3pJzOtQMbY=;
	b=KDSO1fXw/F8wRE9zbJxCpGfIT0H5nTNs4YvvNFXA0Jhbg1A/rG8kWucobnf0W53Zvk
	bHq78L0WGNPEm6+HhA22JMYDYuUWLF/DRDXGBAivAWuqFI/hsUiJUwrsx4o+OOxYyRm4
	JtKbD+a0E4fsLAtXcep3lof8G6tQSTVRawssPlhZ7/UAIV5apOYQ8XsaN2NbRmIXcVG+
	9KRadXQmIjYH59IAOsD+W4Ttdr/HnU60Q2T95oUhl0PUWcQKlxzn8WMdMs93IzcibNL/
	7imzvNL9C7oFoIhWNL0NPx+pIOsKD500s7Z9zKKCjpmOWC4Q03ZFA1I7EClwFhuK6puj
	oqxg==
X-Received: by 10.70.134.198 with SMTP id pm6mr7387548pdb.17.1428716880142;
	Fri, 10 Apr 2015 18:48:00 -0700 (PDT)
Received: from ?IPv6:2601:c:a700:3ba7:586e:6bf6:7756:bf6e?
	([2601:c:a700:3ba7:586e:6bf6:7756:bf6e])
	by mx.google.com with ESMTPSA id he9sm314994pbc.7.2015.04.10.18.47.58
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 Apr 2015 18:47:58 -0700 (PDT)
Message-ID: <55287D4B.9090602@gmail.com>
Date: Fri, 10 Apr 2015 18:47:55 -0700
From: akuster808 <akuster808@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <1428677827-12371-1-git-send-email-alexandru.damian@intel.com>
In-Reply-To: <1428677827-12371-1-git-send-email-alexandru.damian@intel.com>
Subject: Re: [dizzy 0/7] inotify patchset back-port
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
X-List-Received-Date: Sat, 11 Apr 2015 01:48:02 -0000
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit


Is there a [dizzy 1/7] ?

- armin
On 04/10/2015 07:57 AM, Alex DAMIAN wrote:
> From: Alexandru DAMIAN <alexandru.damian@intel.com>
>
>
> Hello,
>
> This is the backport of the inotify patchset that allows the bitbake
> server to read files (configuration and recipes) modified while it is running.
>
> This backport allows proper Toaster experience for Yocto Project 1.7 Dizzy users.
>
> I've tested this patch both functionally and performance-wise, and I could not
> find any obvious bugs.
>
> Thank you,
> Alex
>
> Alexandru DAMIAN (1):
>    cooker: read file watches on server idle
>
> Richard Purdie (6):
>    bitbake: Add pyinotify to lib/
>    cooker/cache/parse: Implement pyinofity based reconfigure
>    cooker: Fix pyinotify handling of ENOENT issues
>    cooker: Further optimise pyinotify
>    cooker: Improve pyinotify performance
>    cooker/server: Fix up 100% CPU usage at idle
>
>   lib/bb/cache.py          |    5 +-
>   lib/bb/cooker.py         |   79 +-
>   lib/bb/parse/__init__.py |    5 +
>   lib/bb/server/process.py |    3 +
>   lib/bb/server/xmlrpc.py  |    3 +
>   lib/pyinotify.py         | 2416 ++++++++++++++++++++++++++++++++++++++++++++++
>   6 files changed, 2508 insertions(+), 3 deletions(-)
>   create mode 100644 lib/pyinotify.py
>

