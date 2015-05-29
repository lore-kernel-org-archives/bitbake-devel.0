Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 4FF36755FA;
	Fri, 29 May 2015 01:49:37 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.1/8.15.1) with ESMTPS id t4T1ndUG024739
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 28 May 2015 18:49:39 -0700 (PDT)
Received: from [128.224.162.200] (128.224.162.200) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.224.2;
	Thu, 28 May 2015 18:49:38 -0700
Message-ID: <5567C5B1.7010901@windriver.com>
Date: Fri, 29 May 2015 09:49:37 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To: <openembedded-devel@lists.openembedded.org>,
	<bitbake-devel@lists.openembedded.org>
References: <20150427105100.GB2379@jama>
	<1432309170-5575-1-git-send-email-ashcharles@gmail.com>
In-Reply-To: <1432309170-5575-1-git-send-email-ashcharles@gmail.com>
Subject: Re: [oe] [PATCH] fetch/hg: Disable checksums for archived downloads
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
X-List-Received-Date: Fri, 29 May 2015 01:49:39 -0000
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit


Hello,

I think that the following patch has broken the mirror tarball of hg:

http://lists.openembedded.org/pipermail/bitbake-devel/2015-May/005725.html

I wonder how did you test the patch, please ? Did you revert the patch:
  fetch/hg: support submodules ?

Or other ways, please ?

// Robert


On 05/22/2015 11:39 PM, Ash Charles wrote:
> Like the Git fetcher, the Mercurial fetcher shouldn't expect recipes to
> provide a checksum.  As described [1], recipes using a mercurial
> fetcher that don't provide a checksum will fail in a the repository has
> previously been downloaded and archived.
>
> Credit to Rafaël Carré for figuring out the bug.
>
> [1] https://www.mail-archive.com/openembedded-devel@lists.openembedded.org/msg41328.html
>
> Signed-off-by: Ash Charles <ashcharles@gmail.com>
> ---
>   bitbake/lib/bb/fetch2/hg.py | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/bitbake/lib/bb/fetch2/hg.py b/bitbake/lib/bb/fetch2/hg.py
> index 81592f6..cab371f 100644
> --- a/bitbake/lib/bb/fetch2/hg.py
> +++ b/bitbake/lib/bb/fetch2/hg.py
> @@ -43,6 +43,13 @@ class Hg(FetchMethod):
>           """
>           return ud.type in ['hg']
>
> +    def supports_checksum(self, urldata):
> +        """
> +        Don't require checksums for local archives created from
> +        repository checkouts.
> +        """
> +        return False
> +
>       def urldata_init(self, ud, d):
>           """
>           init hg specific variable within url data
>

