Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id A701C731E5
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 Jan 2016 13:23:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u0BDNLVn027918; Mon, 11 Jan 2016 13:23:21 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id F3g7nWMrSnsj; Mon, 11 Jan 2016 13:23:21 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u0BDNGg0027912
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 11 Jan 2016 13:23:18 GMT
Message-ID: <1452518596.7598.173.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>,
	bitbake-devel@lists.openembedded.org
Date: Mon, 11 Jan 2016 13:23:16 +0000
In-Reply-To: <11cf5052016496de57d2253aff35c20c62d90703.1451902509.git.liezhi.yang@windriver.com>
References: <cover.1451902509.git.liezhi.yang@windriver.com>
	<11cf5052016496de57d2253aff35c20c62d90703.1451902509.git.liezhi.yang@windriver.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: Re: [PATCH 1/1] fetch2/local.py: avoid using PREMIRROR
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
X-List-Received-Date: Mon, 11 Jan 2016 13:23:24 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2016-01-04 at 02:15 -0800, Robert Yang wrote:
> The PREMIRROR isn't useful for "file://", so avoid using it, this is
> good for searching speed and can reduce useless lines in
> log.do_fetch.
> 
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
>  bitbake/lib/bb/fetch2/local.py |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/bitbake/lib/bb/fetch2/local.py
> b/bitbake/lib/bb/fetch2/local.py
> index 2d921f7..7245651 100644
> --- a/bitbake/lib/bb/fetch2/local.py
> +++ b/bitbake/lib/bb/fetch2/local.py
> @@ -126,3 +126,8 @@ class Local(FetchMethod):
>      def clean(self, urldata, d):
>          return
>  
> +    def try_premirror(self, urldata, d):
> +        """
> +        Should premirrors be used?
> +        """
> +        return False

Hi Robert,

I applied this but I think I'm going to have to revert this since it is
in fact a valid use case.

The sstate.bbclass code sets up SSTATE_MIRRORS as PREMIRRORS. Its quite
common to map those file:// urls to remote http:// urls and with the
above change, this no longer works.

Cheers,

Richard



