Return-Path: <mark.hatle@kernel.crashing.org>
Received: from kernel.crashing.org (kernel.crashing.org [76.164.61.194])
	by mail.openembedded.org (Postfix) with ESMTP id 58A047F3E7
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Oct 2019 20:54:05 +0000 (UTC)
Received: from Marks-MacBook-Pro.local ([76.164.61.198]) (authenticated bits=0)
	by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id x98Ks09T012191
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NO) for <bitbake-devel@lists.openembedded.org>;
	Tue, 8 Oct 2019 15:54:06 -0500
To: bitbake-devel@lists.openembedded.org
References: <20191008184512.20130-1-anibal.limon@linaro.org>
From: Mark Hatle <mark.hatle@kernel.crashing.org>
Message-ID: <19592357-2257-5c87-b3e9-5653bd224e9b@kernel.crashing.org>
Date: Tue, 8 Oct 2019 15:53:59 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
	Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191008184512.20130-1-anibal.limon@linaro.org>
Subject: Re: [RFC][WIP][PATCHv1] lib/bb/checksum.py: Speed-up checksum gen when directory is git
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
X-List-Received-Date: Tue, 08 Oct 2019 20:54:06 -0000
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit



On 10/8/19 1:45 PM, Aníbal Limón wrote:
> In some cases people/organizations are using a SRC_URI with
> file:///PATH_TO_DIR that contains a git repository for different
> reasons, it is useful when want to do an internal build without
> clone sources from outside.
> 
> This could consume a lot of CPU time because the current taskhash
> generation mechanism didn't identify that the folder is a VCS
> (git, svn, cvs) and makes the cksum for every file including the
> .git repository in this case.
> 
> There are different ways to improve the situation,
> 
> * Add protocol=gitscm in file:// SRC_URI but the taskhash is
>   calculated before the fetcher identifies the protocol, will require
>   some changes in bitbake codebase.

When I have done this before, I've -always- defined it as a git repository by
SRCURI:

git://<local file path>;protocol=file

Then it does exactly what this patch appears to do and uses the git logic to
handle everything automatically.  (The file protocol is already implemented.)

Wouldn't this be better then specifying file:// and then attempting to infer
what file refers to?

--MArk

> * This patch: When directory is a git repository (contains .git)
>   use HEAD rev + git diff to calculate checksum instead of do it
>   in every file, that is hackish because make some assumptions about
>   .git directory contents.
> * Variant of this patch: Make a list of VCS directories (.git, .svn,
>   .cvs) and take out for cksum calculations, same as before making
>   assumptions about the . folders content.
> 
> Signed-off-by: Aníbal Limón <anibal.limon@linaro.org>
> ---
>  lib/bb/checksum.py | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/lib/bb/checksum.py b/lib/bb/checksum.py
> index 5bc8a8fc..ee125cb5 100644
> --- a/lib/bb/checksum.py
> +++ b/lib/bb/checksum.py
> @@ -86,6 +86,19 @@ class FileChecksumCache(MultiProcessCache):
>              return checksum
>  
>          def checksum_dir(pth):
> +            git_dir = os.path.join(pth, '.git')
> +            if os.path.exists(git_dir):
> +                import subprocess, hashlib
> +                m = hashlib.md5()
> +                head = subprocess.check_output("cd %s && git rev-parse HEAD" % pth, shell=True)
> +                diff = subprocess.check_output("cd %s && git diff" % pth, shell=True)
> +                m.update(head)
> +                if diff:
> +                    m.update(diff)
> +
> +                return [(pth, m.hexdigest())]
> +
> +
>              # Handle directories recursively
>              if pth == "/":
>                  bb.fatal("Refusing to checksum /")
> 

