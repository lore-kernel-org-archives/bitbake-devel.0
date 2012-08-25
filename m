Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1T5BFy-0003yu-P6 for bitbake-devel@lists.openembedded.org;
	Sat, 25 Aug 2012 09:58:10 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7P7jxAN019863;
	Sat, 25 Aug 2012 08:45:59 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 17462-05; Sat, 25 Aug 2012 08:45:45 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q7P7jdU0019850
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 25 Aug 2012 08:45:42 +0100
Message-ID: <1345880741.14369.95.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Kang Kai <kai.kang@windriver.com>
Date: Sat, 25 Aug 2012 08:45:41 +0100
In-Reply-To: <b081443c18a09548804fe39eb718355e0f067ff5.1345799414.git.kai.kang@windriver.com>
References: <cover.1345799414.git.kai.kang@windriver.com>
	<b081443c18a09548804fe39eb718355e0f067ff5.1345799414.git.kai.kang@windriver.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: Re: [PATCH 3/3] bitbake.conf: add variable IMAGE_TYPES_MAP
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sat, 25 Aug 2012 07:58:11 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2012-08-24 at 17:15 +0800, Kang Kai wrote:
> Add variable IMAGE_TYPES_MAP to replace the hob2 hard-coded image types
> map.
> 
> The format of IMAGE_TYPES_MAP is:
> "image_type1:realname_extend1 image_type2:realname_extend2,extend3 ..."
> 
> Signed-off-by: Kang Kai <kai.kang@windriver.com>
> ---
>  meta/conf/bitbake.conf |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/meta/conf/bitbake.conf b/meta/conf/bitbake.conf
> index ad98756..7d2a9b9 100644
> --- a/meta/conf/bitbake.conf
> +++ b/meta/conf/bitbake.conf
> @@ -770,3 +770,6 @@ BB_SIGNATURE_EXCLUDE_FLAGS ?= "doc defaultval _append _prepend deps depends lock
>  
>  MLPREFIX ??= ""
>  MULTILIB_VARIANTS ??= ""
> +
> +# Used by to Hob to filter image files
> +IMAGE_TYPES_MAP = "btrfs:btrfs cpio.gz:cpio.gz cpio.lzma:cpio.lzma cpio.xz:cpio.xz cpio:cpio cramfs:cramfs elf:elf ext2.bz2:ext2.bz2 ext2.gz:ext2.gz ext2.lzma:ext2.lzma ext2:ext2 ext3.gz:ext3.gz ext3:ext3 jffs2:jffs2 live:hddimg,iso squashfs-lzma:squashfs-lzma squashfs:squashfs sum.jffs2:sum.jffs2 tar.bz2:tar.bz2 tar.gz:tar.gz tar.xz:tar.xz tar:tar ubi:ubi vmdk:vmdk"

I think this still overcomplicates things. Firstly, can't we assume the
names map 1:1 with some exceptions.

For the exceptions, lets just add something like:

IMAGE_EXTENSION_live = "hddimg iso"

to image_types.bbclass (or image-live.bbclass)

and then the UI can query that variable name and assume a 1:1 mapping if
its not present.

Cheers,

Richard



