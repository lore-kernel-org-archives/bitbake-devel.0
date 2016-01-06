Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 690B560588
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Jan 2016 11:22:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u06BMj25019184; Wed, 6 Jan 2016 11:22:45 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id SY1GXqUESJ_G; Wed,  6 Jan 2016 11:22:45 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u06BMg1D019171
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 6 Jan 2016 11:22:44 GMT
Message-ID: <1452079362.7598.67.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Chen Qi <Qi.Chen@windriver.com>, bitbake-devel@lists.openembedded.org
Date: Wed, 06 Jan 2016 11:22:42 +0000
In-Reply-To: <1452069127-13245-1-git-send-email-Qi.Chen@windriver.com>
References: <1452069127-13245-1-git-send-email-Qi.Chen@windriver.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: Re: [PATCH] bitbake: clean up stamp-base related codes
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
X-List-Received-Date: Wed, 06 Jan 2016 11:22:45 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2016-01-06 at 16:32 +0800, Chen Qi wrote:
> The 'stamp-base' related codes are no longer useful, clean them up.
> 
> [YOCTO #8468]
> 
> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
> ---
>  bitbake/lib/bb/build.py | 4 ++--
>  bitbake/lib/bb/cache.py | 3 ---
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
> index 22428a6..b84338b 100644
> --- a/bitbake/lib/bb/build.py
> +++ b/bitbake/lib/bb/build.py
> @@ -582,10 +582,10 @@ def stamp_internal(taskname, d, file_name,
> baseonly=False):
>          taskflagname = taskname.replace("_setscene", "")
>  
>      if file_name:
> -        stamp = d.stamp_base[file_name].get(taskflagname) or
> d.stamp[file_name]
> +        stamp = d.stamp[file_name]
>          extrainfo = d.stamp_extrainfo[file_name].get(taskflagname)
> or ""
>      else:
> -        stamp = d.getVarFlag(taskflagname, 'stamp-base', True) or
> d.getVar('STAMP', True)
> +        stamp = d.getVar('STAMP', True)
>          file_name = d.getVar('BB_FILENAME', True)
>          extrainfo = d.getVarFlag(taskflagname, 'stamp-extra-info',
> True) or ""
>  
> diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
> index 521f758..0ec4057 100644
> --- a/bitbake/lib/bb/cache.py
> +++ b/bitbake/lib/bb/cache.py
> @@ -129,7 +129,6 @@ class CoreRecipeInfo(RecipeInfoCommon):
>          self.not_world = self.getvar('EXCLUDE_FROM_WORLD', metadata)
>          self.stamp = self.getvar('STAMP', metadata)
>          self.stampclean = self.getvar('STAMPCLEAN', metadata)       
> -        self.stamp_base = self.flaglist('stamp-base', self.tasks,
> metadata)
>          self.stamp_base_clean = self.flaglist('stamp-base-clean',


Ok, but what about stamp_base_clean?

Cheers,

Richard


> self.tasks, metadata)
>          self.stamp_extrainfo = self.flaglist('stamp-extra-info',
> self.tasks, metadata)
>          self.file_checksums = self.flaglist('file-checksums',
> self.tasks, metadata, True)
> @@ -158,7 +157,6 @@ class CoreRecipeInfo(RecipeInfoCommon):
>  
>          cachedata.stamp = {}
>          cachedata.stampclean = {}
> -        cachedata.stamp_base = {}
>          cachedata.stamp_base_clean = {}
>          cachedata.stamp_extrainfo = {}
>          cachedata.file_checksums = {}
> @@ -192,7 +190,6 @@ class CoreRecipeInfo(RecipeInfoCommon):
>          cachedata.pkg_dp[fn] = self.defaultpref
>          cachedata.stamp[fn] = self.stamp
>          cachedata.stampclean[fn] = self.stampclean
> -        cachedata.stamp_base[fn] = self.stamp_base
>          cachedata.stamp_base_clean[fn] = self.stamp_base_clean
>          cachedata.stamp_extrainfo[fn] = self.stamp_extrainfo
>          cachedata.file_checksums[fn] = self.file_checksums
> -- 
> 1.9.1
> 

