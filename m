Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id B08EF6022E;
	Tue, 27 Sep 2016 12:25:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u8RCPojd000648; Tue, 27 Sep 2016 13:25:50 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Cj4R5OuXVCoa; Tue, 27 Sep 2016 13:25:50 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u8RCPkbj000643
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 27 Sep 2016 13:25:47 +0100
Message-ID: <1474979146.30475.19.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Juro Bystricky <juro.bystricky@intel.com>,
	openembedded-core@lists.openembedded.org
Date: Tue, 27 Sep 2016 13:25:46 +0100
In-Reply-To: <1474923193-25918-1-git-send-email-juro.bystricky@intel.com>
References: <1474923193-25918-1-git-send-email-juro.bystricky@intel.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] build.py: fix os.getcwd() exception
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
X-List-Received-Date: Tue, 27 Sep 2016 12:25:55 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Mon, 2016-09-26 at 13:53 -0700, Juro Bystricky wrote:
> When trying to obtain the current directory from a directory
> that does not exist anymore, an exception is raised.
> This patch handles such exception.

This should have gone to bitbake-devel, I've cc'd there and queued in
master-next for testing.

Cheers,

Richard

> [YOCTO #10331]
> 
> Signed-off-by: Juro Bystricky <juro.bystricky@intel.com>
> ---
>  bitbake/lib/bb/build.py | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/bitbake/lib/bb/build.py b/bitbake/lib/bb/build.py
> index 2ed0441..249f7d6 100644
> --- a/bitbake/lib/bb/build.py
> +++ b/bitbake/lib/bb/build.py
> @@ -261,9 +261,14 @@ def exec_func(func, d, dirs = None,
> pythonexception=False):
>          else:
>              exec_func_shell(func, d, runfile, cwd=adir)
>  
> -    if oldcwd and os.getcwd() != oldcwd:
> +    try:
> +        curcwd = os.getcwd()
> +    except:
> +        curcwd = None
> +
> +    if oldcwd and curcwd != oldcwd:
>          try:
> -            bb.warn("Task %s changed cwd to %s" % (func,
> os.getcwd()))
> +            bb.warn("Task %s changed cwd to %s" % (func, curcwd))
>              os.chdir(oldcwd)
>          except:
>              pass

