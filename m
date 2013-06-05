Return-Path: <rep.dot.nop@gmail.com>
Received: from mail-la0-f41.google.com (mail-la0-f41.google.com
	[209.85.215.41])
	by mail.openembedded.org (Postfix) with ESMTP id 75AE16041D
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  5 Jun 2013 20:51:59 +0000 (UTC)
Received: by mail-la0-f41.google.com with SMTP id fn20so1900813lab.28
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 05 Jun 2013 13:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=llx9P+gH1t/NfhL0vZJE0UYLh09iFU+0LOg614NKe7M=;
	b=mKgN+T/UsnjiTh+IiByhlEIZBdSS45hIUApl6nR75jNK4r101MTpElWZ/2X7HWtrLs
	Eds7NIURnn03Q6/NHfU9xWik536t9WXSPXxpo0XJddtmfo17m2k7X43DLhBKVXy5mXpk
	OwAgNTfimD7/BOYOVU7Gi6APHnpPwqI+OZBAK5sQ+CgHKe37ssAvjZGe0Rpi1EeXc06b
	p55rO2ykj8D3gVHyNFQn+gQbhX78NFmliM8xIzHh+0gpyoQsEOh4njQiPS3ZIyihG8QJ
	71OqqUu9ohkOGnV8j8eo5zmtCQr1rpILK8cqmc6pfvXi7T3L8wHC9OML1ABYPsUq82Yw
	RYYw==
MIME-Version: 1.0
X-Received: by 10.152.116.7 with SMTP id js7mr16298348lab.7.1370465519823;
	Wed, 05 Jun 2013 13:51:59 -0700 (PDT)
Received: by 10.114.63.75 with HTTP; Wed, 5 Jun 2013 13:51:59 -0700 (PDT)
In-Reply-To: <1369998409-16560-3-git-send-email-alexandru.damian@intel.com>
References: <1369998409-16560-1-git-send-email-alexandru.damian@intel.com>
	<1369998409-16560-3-git-send-email-alexandru.damian@intel.com>
Date: Wed, 5 Jun 2013 22:51:59 +0200
Message-ID: <CAC1BbcQQK50A8B4VL6Rt_8iOz0mT-Pi9+C+FegvAh-LQx+Ryig@mail.gmail.com>
From: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
To: Alex DAMIAN <alexandru.damian@intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 3/4] bitbake: fixes in executable
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 05 Jun 2013 20:52:00 -0000
Content-Type: text/plain; charset=ISO-8859-1

On 31 May 2013 13:06, Alex DAMIAN <alexandru.damian@intel.com> wrote:
> From: Alexandru DAMIAN <alexandru.damian@intel.com>
>
> Two fixes in bitbake related to running remote servers -
> * can now specify correctly the bind port
> * the information in print conforms to common server infrastructure
>
> Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
> ---
>  bin/bitbake | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/bin/bitbake b/bin/bitbake
> index f3bbeb4..d263cbd 100755
> --- a/bin/bitbake
> +++ b/bin/bitbake
> @@ -204,7 +204,8 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
>  def start_server(servermodule, configParams, configuration):
>      server = servermodule.BitBakeServer()
>      if configParams.bind:
> -        server.initServer((configParams.bind, 0))
> +        (host, port) = configParams.bind.split(':')

[::]:1025

I.e. Does that work nicely on my v6-only box or did you mean .rsplit(':',2) ?
thanks,
> +        server.initServer((host, int(port)))
>      else:
>          server.initServer()
>
> @@ -313,7 +314,7 @@ def main():
>              bb.event.ui_queue = []
>              server_connection.terminate()
>      else:
> -        print("server address: %s, server port: %s" % (server.serverinfo.host, server.serverinfo.port))
> +        print("server address: %s, server port: %s" % (server.serverImpl.host, server.serverImpl.port))
>
>      return 1
>

