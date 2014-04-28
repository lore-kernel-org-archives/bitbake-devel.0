Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by mail.openembedded.org (Postfix) with ESMTP id 1C07E65ECD
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 28 Apr 2014 11:23:18 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by azsmga101.ch.intel.com with ESMTP; 28 Apr 2014 04:23:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,943,1389772800"; d="scan'208";a="522310326"
Received: from unknown (HELO peggleto-mobl5.ger.corp.intel.com)
	([10.252.122.52])
	by fmsmga001.fm.intel.com with ESMTP; 28 Apr 2014 04:23:17 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Jacob Kroon <jacob.kroon@mikrodidakt.se>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Mon, 28 Apr 2014 12:23:16 +0100
Message-ID: <4256087.6AVRx8IQuU@peggleto-mobl5.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.12.4 (Linux/3.13.10-200.fc20.x86_64; KDE/4.12.4; x86_64; ;
	)
In-Reply-To: <1398522738-8979-1-git-send-email-jacob.kroon@mikrodidakt.se>
References: <1398522738-8979-1-git-send-email-jacob.kroon@mikrodidakt.se>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] fetch2: Cleanup file checksum generation
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
X-List-Received-Date: Mon, 28 Apr 2014 11:23:23 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 26 April 2014 16:32:18 Jacob Kroon wrote:
> Cleanup the fix done in f9416e76e272ba3249abff099f6f3a47fe82e03e.
> 
> Instead of adding continue statements we can just move the last
> statements into the final else-clause.
> 
> Signed-off-by: Jacob Kroon <jacob.kroon@mikrodidakt.se>
> ---
>  lib/bb/fetch2/__init__.py | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index 5a03a0e..bc4e8fd 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -985,15 +985,12 @@ def get_file_checksums(filelist, pn):
>                      checksum = checksum_file(f)
>                      if checksum:
>                          checksums.append((f, checksum))

Note the above, then see below.

> -            continue
>          elif os.path.isdir(pth):
>              checksums.extend(checksum_dir(pth))
> -            continue
>          else:
>              checksum = checksum_file(pth)
> -
> -        if checksum:
> -            checksums.append((pth, checksum))
> +            if checksum:
> +                checksums.append((pth, checksum))
> 
>      checksums.sort(key=operator.itemgetter(1))
>      return checksums

This cleanup seems innocuous but unfortunately it does cause a change in 
behaviour - now for the glob case we will get the last item duplicated because 
it will be added to the list a second time at the end.

Richard can you please revert this?

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

