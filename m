Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 98DD977139
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Aug 2016 10:40:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u7AAeVHa029731; Wed, 10 Aug 2016 11:40:31 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id VY1aqt6GXSjy; Wed, 10 Aug 2016 11:40:31 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u7AAeO80029717
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 10 Aug 2016 11:40:26 +0100
Message-ID: <1470825624.18638.1.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Matt Madison <matt@madison.systems>, bitbake-devel@lists.openembedded.org
Date: Wed, 10 Aug 2016 11:40:24 +0100
In-Reply-To: <1470696223-9260-1-git-send-email-matt@madison.systems>
References: <1470696223-9260-1-git-send-email-matt@madison.systems>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: Re: [PATCH] fetch2: save/restore cwd for mirror URL downloads
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
X-List-Received-Date: Wed, 10 Aug 2016 10:40:33 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2016-08-08 at 15:43 -0700, Matt Madison wrote:
> Fixes "changed cwd" warnings from setscene tasks when the
> packages are downloaded from a shared-state mirror.
> 
> Signed-off-by: Matt Madison <matt@madison.systems>
> ---
>  lib/bb/fetch2/__init__.py | 5 +++++
>  1 file changed, 5 insertions(+)

bitbake-selftest doesn't seem to like this change:

https://autobuilder.yoctoproject.org/main/builders/nightly/builds/973/steps/BitbakeSelftest/logs/stdio

I do wonder if we need to fix the individual fetcher modules...

Cheers,

Richard

> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index 9054b2e..c0017a8 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -928,6 +928,8 @@ def try_mirror_url(fetch, origud, ud, ld, check =
> False):
>      if ud.lockfile and ud.lockfile != origud.lockfile:
>          lf = bb.utils.lockfile(ud.lockfile)
>  
> +    save_cwd = os.getcwd()
> +
>      try:
>          if check:
>              found = ud.method.checkstatus(fetch, ud, ld)
> @@ -995,6 +997,7 @@ def try_mirror_url(fetch, origud, ud, ld, check =
> False):
>              pass
>          return False
>      finally:
> +        os.chdir(save_cwd)
>          if ud.lockfile and ud.lockfile != origud.lockfile:
>              bb.utils.unlockfile(lf)
>  
> @@ -1558,6 +1561,7 @@ class Fetch(object):
>  
>          network = self.d.getVar("BB_NO_NETWORK", True)
>          premirroronly = (self.d.getVar("BB_FETCH_PREMIRRORONLY",
> True) == "1")
> +        save_cwd = os.getcwd()
>  
>          for u in urls:
>              ud = self.ud[u]
> @@ -1635,6 +1639,7 @@ class Fetch(object):
>              finally:
>                  if ud.lockfile:
>                      bb.utils.unlockfile(lf)
> +        os.chdir(save_cwd)
>  
>      def checkstatus(self, urls=None):
>          """
> -- 
> 2.7.4
> 

