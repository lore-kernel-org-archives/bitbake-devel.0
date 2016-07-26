Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 1249F606BF
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Jul 2016 07:08:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u6Q78iXl029969; Tue, 26 Jul 2016 08:08:44 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id EgwAmAeWC8Kg; Tue, 26 Jul 2016 08:08:44 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u6Q78g4t029965
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 26 Jul 2016 08:08:43 +0100
Message-ID: <1469516922.23580.92.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>,
	bitbake-devel@lists.openembedded.org
Date: Tue, 26 Jul 2016 08:08:42 +0100
In-Reply-To: <c6d59200973e19d358a2fa1a1e5bec4523894e69.1469504165.git.paul.eggleton@linux.intel.com>
References: <cover.1469504165.git.paul.eggleton@linux.intel.com>
	<c6d59200973e19d358a2fa1a1e5bec4523894e69.1469504165.git.paul.eggleton@linux.intel.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: Re: [PATCH 1/1] lib/bb/checksum: avoid exception on broken symlinks
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
X-List-Received-Date: Tue, 26 Jul 2016 07:08:49 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2016-07-26 at 15:36 +1200, Paul Eggleton wrote:
> If using OE's externalsrc with a source tree that is not tracked by
> git
> and contains broken symlinks, you can receive "TypeError: unorderable
> types: NoneType() < str()" within the file checksum code due to:
> 
>  checksums.sort(key=operator.itemgetter(1))
> 
> Don't add files with no checksum to the checksums list in order to
> avoid
> this.

In some of the cache code we have to note whether files were checked
for but didn't exist. This means that if they then do exist in a later
run, we know to invalidate the cache.

Does this change break that?

Cheers,

Richard

> Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
> ---
>  lib/bb/checksum.py | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/bb/checksum.py b/lib/bb/checksum.py
> index be4ab68..8428920 100644
> --- a/lib/bb/checksum.py
> +++ b/lib/bb/checksum.py
> @@ -120,13 +120,15 @@ class FileChecksumCache(MultiProcessCache):
>                              checksums.extend(checksum_dir(f))
>                      else:
>                          checksum = checksum_file(f)
> -                        checksums.append((f, checksum))
> +                        if checksum:
> +                            checksums.append((f, checksum))
>              elif os.path.isdir(pth):
>                  if not os.path.islink(pth):
>                      checksums.extend(checksum_dir(pth))
>              else:
>                  checksum = checksum_file(pth)
> -                checksums.append((pth, checksum))
> +                if checksum:
> +                    checksums.append((pth, checksum))
>  
>          checksums.sort(key=operator.itemgetter(1))
>          return checksums
> -- 
> 2.5.5
> 

