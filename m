Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id ED05578400
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  5 Feb 2018 09:39:35 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	w159dYT4012682
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Mon, 5 Feb 2018 09:39:35 GMT
Message-ID: <1517823574.3090.79.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>,
	bitbake-devel@lists.openembedded.org
Date: Mon, 05 Feb 2018 09:39:34 +0000
In-Reply-To: <48f4881a33e65e2162ca1df077982561058f040c.1517497731.git.liezhi.yang@windriver.com>
References: <cover.1517497731.git.liezhi.yang@windriver.com>
	<48f4881a33e65e2162ca1df077982561058f040c.1517497731.git.liezhi.yang@windriver.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
X-Virus-Scanned: clamav-milter 0.99.3 at dan
X-Virus-Status: Clean
Subject: Re: [PATCH 4/8] bitbake: cooker: don't preserve BB_CONSOLELOG
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
X-List-Received-Date: Mon, 05 Feb 2018 09:39:36 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Thu, 2018-02-01 at 23:15 +0800, Robert Yang wrote:
> Fixed:
> $ bitbake --server-only -T -1
> Set MACHINE = "qemux86" in conf/local.conf
> $ bitbake quilt
> Set MACHINE = "qemuppc" in conf/local.conf
> $ bitbake quilt
> 
> The log still goes into tmp/log/cooker/qemux86 in the second run,
> this is
> incorrect (should be tmp/log/cooker/qemuppc). I checked the code, the
> ui
> initializes it every time when it starts, so let it use the up-to-
> date
> one rather than old one.
> 
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
>  bitbake/lib/bb/cooker.py | 8 --------
>  1 file changed, 8 deletions(-)

This effectively reverts:

http://git.yoctoproject.org/cgit.cgi/poky/commit/bitbake/lib/bb/cooker.py?id=3ebf7617d6c869f798807792918e1030b3ab66de

Sadly I didn't put a bug number in that commit message but I do
remember there being a good reason to do this.

I think the problem is a "UI" can run multiple commands with reset
events within that command stream and it would only have one console
log. I also believe there may have been issues where toaster would have
been unable to find the logs if they kept moving around.

The console log handling probably needs more thought as there are
clearly multiple issues here. We may want to move it out of a directory
which is machine specific?

Cheers,

Richard

> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> index af482f9..3f113ae 100644
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> @@ -326,11 +326,6 @@ class BBCooker:
>          self.state = state.initial
>          self.caches_array = []
>  
> -        # Need to preserve BB_CONSOLELOG over resets
> -        consolelog = None
> -        if hasattr(self, "data"):
> -            consolelog = self.data.getVar("BB_CONSOLELOG")
> -
>          if CookerFeatures.BASEDATASTORE_TRACKING in self.featureset:
>              self.enableDataTracking()
>  
> @@ -358,9 +353,6 @@ class BBCooker:
>          self.data_hash = self.databuilder.data_hash
>          self.extraconfigdata = {}
>  
> -        if consolelog:
> -            self.data.setVar("BB_CONSOLELOG", consolelog)
> -
>          self.data.setVar('BB_CMDLINE', self.ui_cmdline)
>  
>          #
> -- 
> 2.7.4
> 

