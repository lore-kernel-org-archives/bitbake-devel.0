Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 01C5278D2D
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Aug 2018 14:16:56 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	08 Aug 2018 07:16:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,457,1526367600"; d="scan'208";a="253023975"
Received: from aqachmar-mobl.ger.corp.intel.com (HELO localhost.localdomain)
	([10.252.50.207])
	by fmsmga006.fm.intel.com with ESMTP; 08 Aug 2018 07:16:54 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Sitech <developer_agl@xtev.cn>
Date: Wed, 08 Aug 2018 16:16:53 +0200
Message-ID: <12396499.WEjbQBgyTF@localhost.localdomain>
Organization: Intel Corporation
In-Reply-To: <tencent_07BA7069715BCA2F3B76E48D@qq.com>
References: <tencent_07BA7069715BCA2F3B76E48D@qq.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: WARNING: XXXXXX do_fetch: Failed to fetch URL http://xxxxxxx.tar.xz, attempting MIRRORS if available
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
X-List-Received-Date: Wed, 08 Aug 2018 14:16:57 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, 8 August 2018 12:18:32 PM CEST Sitech wrote:
> When I build my yocto project, I often get a  same warning like this : 
> 
>  WARNING: quilt-native-0.65-r0 do_fetch: Failed to fetch URL http://download.savannah.gnu.org/releases/quilt/quilt-0.65.tar.gz, attempting MIRRORS if available
> WARNING: attr-native-2.4.47-r0 do_fetch: Failed to fetch URL http://download.savannah.gnu.org/releases/attr/attr-2.4.47.src.tar.gz, attempting MIRRORS if available
> WARNING: flex-native-2.6.0-r0 do_fetch: Failed to fetch URL http://downloads.sourceforge.net/flex/flex-2.6.0.tar.bz2, attempting MIRRORS if available
> WARNING: xz-native-5.2.3-r0 do_fetch: Failed to fetch URL http://tukaani.org/xz/xz-5.2.3.tar.gz, attempting MIRRORS if available
> WARNING: util-linux-native-2.30-r0 do_fetch: Failed to fetch URL http://cdn.kernel.org/pub/linux/utils/util-linux/v2.30/util-linux-2.30.tar.xz, attempting MIRRORS if available
> WARNING: python3-native-3.5.3-r1.0 do_fetch: Failed to fetch URL http://www.python.org/ftp/python/3.5.3/Python-3.5.3.tar.xz, attempting MIRRORS if available
> WARNING: popt-native-1.16-r3 do_fetch: Failed to fetch URL http://rpm5.org/files/popt/popt-1.16.tar.gz, attempting MIRRORS if available
> WARNING: libpng-native-1.6.31-r0 do_fetch: Failed to fetch URL http://downloads.sourceforge.net/project/libpng/libpng16/1.6.31/libpng-1.6.31.tar.xz, attempting MIRRORS if available
> WARNING: shadow-4.2.1-r0 do_fetch: Failed to fetch URL http://pkg-shadow.alioth.debian.org/releases/shadow-4.2.1.tar.xz, attempting MIRRORS if available
> WARNING: acl-2.2.52-r0 do_fetch: Failed to fetch URL http://download.savannah.gnu.org/releases/acl/acl-2.2.52.src.tar.gz, attempting MIRRORS if available
> WARNING: linux-libc-headers-4.12-r0 do_fetch: Failed to fetch URL http://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.12.tar.xz, attempting MIRRORS if available
> WARNING: freetype-2.8-r0 do_fetch: Failed to fetch URL http://downloads.sourceforge.net/freetype/freetype-2.8.tar.bz2, attempting MIRRORS if available
> WARNING: curl-native-7.58.0-r0 do_fetch: Failed to fetch URL http://curl.haxx.se/download/curl-7.58.0.tar.bz2, attempting MIRRORS if available
> WARNING: perl-native-5.24.1-r0 do_fetch: Failed to fetch URL http://www.cpan.org/src/5.0/perl-5.24.1.tar.xz, attempting MIRRORS if available
> 
> 
> And then, build failed, actually, the target file is accessable,  maybe my
> net connect is to low. So my operation is that remove ${TMPDIR} and rebuild 
> the project by using $bitbake <target> command. But that's really cost to
> much time. Does any friend have other methods or good advices?

What you pasted above are just warnings - there's no need to delete anything.
If the failures are purely fetch failures and they are intermittent, you should just
be able to re-run the build and it will attempt to download the files again.

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre



