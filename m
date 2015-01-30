Return-Path: <akuster808@gmail.com>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
	[209.85.220.43])
	by mail.openembedded.org (Postfix) with ESMTP id E117760132
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 30 Jan 2015 16:04:14 +0000 (UTC)
Received: by mail-pa0-f43.google.com with SMTP id eu11so53898786pac.2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 30 Jan 2015 08:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:date:from:user-agent:mime-version:to:subject:references
	:in-reply-to:content-type:content-transfer-encoding;
	bh=U9nFYofFFCJIy3SVUkvmaKgvNmOIb41x46PZEkeJTJQ=;
	b=obPlWC+D7NbILM9+2PyILYnxMYJ8175mEnid3gXkjeXax3X+ido3sn2PrswoxpGz3o
	jQnnb6CzlY2p/ZJBJwdIFKqV+A42UyYkIo/JHNd5V5EB1clssd1RqpHuGfjAMmkegkCk
	CjI2WO73hYriW/BOqlIw19NJbxkypKuFAZIZjnr9ZFxtD38+pC99UQXRigdnQbLXnUSs
	6WT7mg5NZ2XR477GRISvU4LPOMnkr/Ub0m+qFVu8C1vN+oQrifibY2I/vHpvoCXGa0cd
	nxmLLLzBH/kTf24QJFTnLx9rs7jBKBtdBYjG8Bzr4TGvbDFVoEb6VUAs3LFq2z+dOI/I
	zJuw==
X-Received: by 10.68.136.194 with SMTP id qc2mr10013862pbb.92.1422633855724;
	Fri, 30 Jan 2015 08:04:15 -0800 (PST)
Received: from ?IPv6:2601:c:a700:272f:eda6:338:1977:847?
	([2601:c:a700:272f:eda6:338:1977:847])
	by mx.google.com with ESMTPSA id c9sm11198268pdj.52.2015.01.30.08.04.13
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 30 Jan 2015 08:04:14 -0800 (PST)
Message-ID: <54CBAB7A.5030407@gmail.com>
Date: Fri, 30 Jan 2015 08:04:10 -0800
From: akuster808 <akuster808@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <cover.1422627985.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1422627985.git.alexandru.damian@intel.com>
Subject: Re: [PATCH 0/2] Toaster patchset
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
X-List-Received-Date: Fri, 30 Jan 2015 16:04:16 -0000
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

does Dizzy need this?

- Armin

On 01/30/2015 06:28 AM, Alex DAMIAN wrote:
> From: Alexandru DAMIAN <alexandru.damian@intel.com>
>
> Hi,
>
> This is a small patchset for toaster for fixing the startup sequence, and some build issues.
>
> It has been reviewed on toaster mailing list, can you please pull when you can ?
>
> Cheers,
> Alex
>
> The following changes since commit 9facf3604759b00e8fe99f929353d46f8b8ba5cb:
>
>    data_smart: Don't use mutable objects as default args (2015-01-29 22:10:53 +0000)
>
> are available in the git repository at:
>
>    git://git.yoctoproject.org/poky-contrib adamian/20150130-submission-bb
>    http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20150130-submission-bb
>
> Alexandru DAMIAN (2):
>    toaster: update texts for the startup sequence
>    toaster: new layer checkout logic
>
>   bin/toaster                                        |   6 +-
>   lib/toaster/bldcontrol/bbcontroller.py             |  13 ++-
>   lib/toaster/bldcontrol/localhostbecontroller.py    | 107 +++++++++++++++------
>   .../management/commands/checksettings.py           |  21 ++--
>   .../bldcontrol/management/commands/loadconf.py     |   2 +-
>   .../bldcontrol/management/commands/runbuilds.py    |   7 +-
>   lib/toaster/bldcontrol/sshbecontroller.py          |  58 +----------
>   7 files changed, 110 insertions(+), 104 deletions(-)
>

