Return-Path: <twoerner@gmail.com>
Received: from mail-ig0-f179.google.com (mail-ig0-f179.google.com
	[209.85.213.179])
	by mail.openembedded.org (Postfix) with ESMTP id 10EDD6E268
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Apr 2015 13:46:27 +0000 (UTC)
Received: by igblo3 with SMTP id lo3so60310857igb.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Apr 2015 06:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:date:from:user-agent:mime-version:to:subject:references
	:in-reply-to:content-type:content-transfer-encoding;
	bh=cMEkYMcO1VW4Yz1TBdbnVp6h7I246maHD1ULUQKH+F0=;
	b=Kz450Kpiy4bLpFJoYJElYiEZOQZhUAwLiTwMjx1KI4QaFcuYvOLjD7L1VjYcW66iil
	OaivYnyBId6hSggYtHpjKoAuILU/tDgofKG0DWZMApn3QcyiT0v5U+Wi9tTT0ea723pf
	qMBjAJpFx7L2CbAs6jJi/EdbylINZCKPFjdx2C9KvAvr+eFgG2LQEUFhIAw/sI0SKGAP
	svXjj66KosFdp3+jNeO5Kq1kOalnQjX1pKbJpDScApS29fcD78YWo29XzpyNaiMu/I0v
	52J4O4g4OpCXP1rvQzOikalGZsc+8E5kf/+7Yusg7AtU8MkPMugP9GZrGoUeFUuUTwZd
	f6PA==
X-Received: by 10.50.30.202 with SMTP id u10mr20949697igh.28.1429537588064;
	Mon, 20 Apr 2015 06:46:28 -0700 (PDT)
Received: from [192.168.141.83] ([66.49.191.189])
	by mx.google.com with ESMTPSA id
	p196sm8455938iop.15.2015.04.20.06.46.24
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 20 Apr 2015 06:46:27 -0700 (PDT)
Message-ID: <5535032B.4000007@gmail.com>
Date: Mon, 20 Apr 2015 09:46:19 -0400
From: Trevor Woerner <twoerner@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To: Paul Eggleton <paul.eggleton@linux.intel.com>, 
	bitbake-devel@lists.openembedded.org
References: <cover.1429280244.git.paul.eggleton@linux.intel.com>
	<54b162c649388c63015cdd0d69866d5604303b60.1429280244.git.paul.eggleton@linux.intel.com>
In-Reply-To: <54b162c649388c63015cdd0d69866d5604303b60.1429280244.git.paul.eggleton@linux.intel.com>
Subject: Re: [PATCH 1/1] lib/bb/utils: add safeguard against recursively deleting things we shouldn't
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
X-List-Received-Date: Mon, 20 Apr 2015 13:46:28 -0000
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 15-04-17 10:26 AM, Paul Eggleton wrote:
> Add some very basic safeguard against recursively deleting paths such
> as / and /home in the event of bugs or user mistakes.
>

I liked Nicolas Dechesne's idea of only allowing deletion in paths that 
include TMPDIR or TOPDIR. Is there any reason bitbake would need to 
delete (potentially dangerous) paths anywhere else?

With a list-based approach the list will keep growing indefinitely. 
Inevitably an ex-Solaris person will come along (for example) and have 
their /home directories in /export/home and need a patch for that, etc, 
etc...

