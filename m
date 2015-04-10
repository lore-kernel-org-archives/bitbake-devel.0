Return-Path: <akuster808@gmail.com>
Received: from mail-pd0-f173.google.com (mail-pd0-f173.google.com
	[209.85.192.173])
	by mail.openembedded.org (Postfix) with ESMTP id 7B4306E277
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Apr 2015 17:01:12 +0000 (UTC)
Received: by pdbnk13 with SMTP id nk13so28338805pdb.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Apr 2015 10:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:date:from:user-agent:mime-version:to:subject:references
	:in-reply-to:content-type:content-transfer-encoding;
	bh=Xt+aI0Qe5m7oqgLUQxYrrfaiLJEgFUgRVWLFAb3DTlA=;
	b=fdps+Xq2NDQjGC1nC34iYvp+aGVavZRi0SdsDX71MhhSGSQfat2vAtnHI8js3qiKyI
	9bEmLSCPBkHAZocfaJ2QShe+wrZLTjycLkZoAXtuduGc0jauqxpXVGATvC2Sqxg3dc8D
	kQbDQvifSZl1ESBTqgfgcZtOuhjjUCotE8l0kxJRv1vfhhc5ZKwPWU5yYd9NxHOtSNe/
	E0n1kKI7A2AzMXIqmZenDI2CnRTN+p6xlqJ+o1yFakqhTyRFNqYAiYJyS1+1LN7qSXqT
	RoIQEZQDYGakVMHhqv3lnhUqEzxaL2G9gM8wBh9ee7e0HTKxOcfRlKUU1s0Uq4M9jJRw
	Lt2Q==
X-Received: by 10.70.55.41 with SMTP id o9mr4305424pdp.80.1428685273417;
	Fri, 10 Apr 2015 10:01:13 -0700 (PDT)
Received: from ?IPv6:2601:c:a700:3ba7:586e:6bf6:7756:bf6e?
	([2601:c:a700:3ba7:586e:6bf6:7756:bf6e])
	by mx.google.com with ESMTPSA id ll2sm2810729pbc.11.2015.04.10.10.01.11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 Apr 2015 10:01:11 -0700 (PDT)
Message-ID: <552801CC.60300@gmail.com>
Date: Fri, 10 Apr 2015 10:01:00 -0700
From: akuster808 <akuster808@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To: Alex DAMIAN <alexandru.damian@intel.com>, 
	bitbake-devel@lists.openembedded.org
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
X-List-Received-Date: Fri, 10 Apr 2015 17:01:12 -0000
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Alex,

thanks, I will be stage thiese for dizzy-next

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

