Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 4499077C2A
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Apr 2017 15:16:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTP id v3BFGgkI028980; 
	Tue, 11 Apr 2017 16:16:42 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id d73GYZAoNzmP; Tue, 11 Apr 2017 16:16:42 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v3BElHSa025632
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Tue, 11 Apr 2017 15:47:18 +0100
Message-ID: <1491922037.12091.20.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Zhixiong Chi <zhixiong.chi@windriver.com>,
	bitbake-devel@lists.openembedded.org
Date: Tue, 11 Apr 2017 15:47:17 +0100
In-Reply-To: <1491816164-18274-1-git-send-email-zhixiong.chi@windriver.com>
References: <1491816164-18274-1-git-send-email-zhixiong.chi@windriver.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
Subject: Re: bitbake-layers: add signal hander to avoid exception
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
X-List-Received-Date: Tue, 11 Apr 2017 15:16:42 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Mon, 2017-04-10 at 17:22 +0800, Zhixiong Chi wrote:
> Fixed:
> bitbake-layers show-recipes | less
> press "q" to exit
> 
> There will be a Broken pipe error output as follows:
> "BrokenPipeError: [Errno 32] Broken pipe"
> 
> Signed-off-by: Zhixiong Chi <zhixiong.chi@windriver.com>
> ---
>  bin/bitbake-layers | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/bin/bitbake-layers b/bin/bitbake-layers
> index 390ad05..d58022d 100755
> --- a/bin/bitbake-layers
> +++ b/bin/bitbake-layers
> @@ -20,6 +20,7 @@
>  # with this program; if not, write to the Free Software Foundation,
> Inc.,
>  # 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>  
> +from signal import signal, SIGPIPE, SIG_DFL

Stylistically, we tend to do:

import signal

signal.signal(signal.SIGPIPE, signal.SIG_DFL)

so I've a small preference for that. I discussed this with Paul and we
think other bitbake tools may also have this issue. We wondered if it
was possible to do something more centrally in bitbake, and/or fix the
other tools at the same time.

Any thoughts on that?

Cheers,

Richard

>  import logging
>  import os
>  import sys
> @@ -35,6 +36,7 @@ import bb.msg
>  logger = bb.msg.logger_create('bitbake-layers', sys.stdout)
>  
>  def main():
> +    signal(SIGPIPE, SIG_DFL)
>      parser = argparse.ArgumentParser(
>          description="BitBake layers utility",
>          epilog="Use %(prog)s <subcommand> --help to get help on a
> specific command",
> -- 
> 1.9.1
> 

