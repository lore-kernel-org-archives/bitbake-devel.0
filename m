Received: from kernel.crashing.org (kernel.crashing.org [76.164.61.194])
 by mx.groups.io with SMTP id smtpd.web10.1159.1630526143983676322
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Sep 2021 12:55:44 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=permerror, err=syntax error for token:  (domain: kernel.crashing.org, ip: 76.164.61.194, mailfrom: mark.hatle@kernel.crashing.org)
Received: from Marks-MacBook-Pro-16.local ([76.164.61.198])
	(authenticated bits=0)
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 181JtBct018128
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
	Wed, 1 Sep 2021 14:55:41 -0500
Subject: Re: [bitbake-devel] [PATCH 0/1] RFC Bug in PREMIRROR
To: Vishal Patel <vishal.patel@xilinx.com>,
        bitbake-devel@lists.openembedded.org
Cc: mark.hatle@xilinx.com
References: <20210901194456.2642587-1-vishal.patel@xilinx.com>
From: "Mark Hatle" <mark.hatle@kernel.crashing.org>
Message-ID: <4d731952-4626-2285-3ca2-a16ad24c2446@kernel.crashing.org>
Date: Wed, 1 Sep 2021 14:55:11 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210901194456.2642587-1-vishal.patel@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 9/1/21 2:44 PM, Vishal Patel wrote:
> I think we found a bug in the PREMIRROR system where if both a remote and local
> PREMIRROR is defined, as well as BB_NO_NETWORK = '1', the system will fail with
> 
> bb.fetch2.NetworkAccess: Network access disabled through BB_NO_NETWORK (or set indirectly due to use of BB_FETCH_PREMIRRORONLY)
> 
> instead of trying the next PREMIRROR which is a local file:// based one.
> The attached patch only adds a test case for the issue, but does not fix the problem.
> If anyone can point me to where to fix the problem, I can work on this.

What we're attempting to do is specify both a network and local disk premirror
location.  The network one seems to get added in the list first (for whatever
reason), but it never falls back to the disk version.

As the patch shows:

PREMIRROR = "http://.*/.* http://downloads.yoctoproject.org/releases/bitbake \n
http://.*/.* file://%s/test-file.tar.gz \n"

appears to fail when it gets to the first one, and never tries the second entry.

> Vishal Patel (1):
>   tests/fetch.py: Add test case to verify PREMIRROR with mix of remote
>     and local
> 
>  lib/bb/tests/fetch.py | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> --
> 2.25.1
> 
> This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.

BTW we apologize for the footer, it shouldn't have been on this and the
associate patch email.  We're working to get this removed in future conversations.

