Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 93B01608B7
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Apr 2016 19:59:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u3JJwXLu014999; Tue, 19 Apr 2016 20:59:01 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ISK_l27AiS5E; Tue, 19 Apr 2016 20:59:01 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u3JJwucM015106
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 19 Apr 2016 20:58:58 +0100
Message-ID: <1461095936.31320.27.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Ed Bartosh <ed.bartosh@linux.intel.com>,
	bitbake-devel@lists.openembedded.org
Date: Tue, 19 Apr 2016 20:58:56 +0100
In-Reply-To: <1461076236-9289-1-git-send-email-ed.bartosh@linux.intel.com>
References: <1461076236-9289-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: Re: [PATCH] bitbake: main: add 2 environment variables
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
X-List-Received-Date: Tue, 19 Apr 2016 19:59:06 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2016-04-19 at 17:30 +0300, Ed Bartosh wrote:
> Bitbake uses set of environment variables to set command line
> options, e.g. seeting BBTOKEN variable has the same effect
> as using --token command line option.
> 
> Added new environment variables BBPRECONF and BBPOSTCONF that
> are equivalents of --read and --postread command line options.
> They can be used by high level scripts to append or prepend
> configuration files to conf/local.conf
> 
> [YOCTO #9235]
> 
> Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
> ---
>  bitbake/lib/bb/main.py | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/bitbake/lib/bb/main.py b/bitbake/lib/bb/main.py
> index e302173..1dd7877 100755
> --- a/bitbake/lib/bb/main.py
> +++ b/bitbake/lib/bb/main.py
> @@ -250,6 +250,12 @@ class
> BitBakeConfigParameters(cookerdata.ConfigParameters):
>          if "BBEVENTLOG" in os.environ:
>              options.writeeventlog = os.environ["BBEVENTLOG"]
>  
> +        if "BBPRECONF" in os.environ:
> +            option.prefile = os.environ["BBPRECONF"]
> +
> +        if "BBPOSTCONF" in os.environ:
> +            option.postfile = os.environ["BBPOSTCONF"]
> +

I think for principle of least surprise the commandline should override
the environment, append to the environment (but then which order?) or
it should just error and tell the user if they specify both the
commandline and environment options at the same time.

Cheers,

Richard

