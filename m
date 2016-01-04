Return-Path: <mark.hatle@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id CA2827317E
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  4 Jan 2016 20:35:43 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id u04KZh66002916
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK);
	Mon, 4 Jan 2016 12:35:43 -0800
Received: from Marks-MacBook-Pro.local (172.25.36.231) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.248.2; Mon, 4 Jan 2016 12:35:43 -0800
To: Juro Bystricky <juro.bystricky@intel.com>,
	<bitbake-devel@lists.openembedded.org>
References: <1451933503-25881-1-git-send-email-juro.bystricky@intel.com>
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
Message-ID: <568AD79D.80307@windriver.com>
Date: Mon, 4 Jan 2016 14:35:41 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:38.0)
	Gecko/20100101 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <1451933503-25881-1-git-send-email-juro.bystricky@intel.com>
Cc: richard.purdie@intel.com
Subject: Re: [PATCH 0/1] Add support for 7-Zip compressed files
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
X-List-Received-Date: Mon, 04 Jan 2016 20:35:44 -0000
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit

On 1/4/16 12:51 PM, Juro Bystricky wrote:
> 7-Zip offers substantially better compression than other compression
> formats. In fact, 7-Zip explicitly claims it provides the best compression ratio.
> To quickly test the claim, I compressed a gcc 5.2 538.8 MB tree snapshot in various ways:
> 
> tar.bz2: 114.0 MB
> tar.gz:  112.4 MB
> tar.7z:   70.3 MB

I thought 7z was an archive format, that included compression information.

Since the compression that makes 7z better then bz2 is lzma, and 'xz' uses lzma
as it's compression format.  (In my experience, .xz is really common on Linux --
7z is only common on Windows.)

I'm not saying don't support .7z, but adding support for .tar.xz and others
would make equal sense to me.  (There are a number of formats out there that
could and likely should be added.)

--Mark

> At present, there is no support for 7-Zip compressed files in Bitbake.
> Various public Git repositories only allow pushing files of certain max size,
> AFAIK Github only allows 100MB, so there are cases where it is desirable
> to use maximum compression possible.
> 
> 
> Juro Bystricky (1):
>   bitbake:fetch2/__init__.py: Add support for 7-Zip
> 
>  bitbake/lib/bb/fetch2/__init__.py | 4 ++++
>  1 file changed, 4 insertions(+)
> 


