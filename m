Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id C4AB96AC37
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Aug 2017 12:14:35 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v78CEYe8014506
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Tue, 8 Aug 2017 13:14:35 +0100
Message-ID: <1502194474.18633.245.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>,
	bitbake-devel@lists.openembedded.org
Date: Tue, 08 Aug 2017 13:14:34 +0100
In-Reply-To: <c75315a4930a447c156f55e1ce80f4354e1507e6.1502183410.git.liezhi.yang@windriver.com>
References: <cover.1502183410.git.liezhi.yang@windriver.com>
	<c75315a4930a447c156f55e1ce80f4354e1507e6.1502183410.git.liezhi.yang@windriver.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Tue, 08 Aug 2017 13:14:35 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
Subject: Re: [WIP][RFC PATCH 2/5] bitbake: main: add log handler when status-only
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
X-List-Received-Date: Tue, 08 Aug 2017 12:14:36 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Tue, 2017-08-08 at 02:12 -0700, Robert Yang wrote:
> The ui is not a must for logger, and use logger when status-only is
> very good
> for debugging.
> 
> e.g.:
> $ bitbake --status
> NOTE: bitbake server is not running.
> 
> $ bitbake --server-only -B localhost:-1
> $ bitbake --status
> NOTE: Reconnecting to bitbake server...
> 
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
>  bitbake/lib/bb/main.py | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/bitbake/lib/bb/main.py b/bitbake/lib/bb/main.py
> index 62f9e1eacf1..fb082e7e0f3 100755
> --- a/bitbake/lib/bb/main.py
> +++ b/bitbake/lib/bb/main.py
> @@ -397,9 +397,7 @@ def bitbake_main(configParams, configuration):
>  def setup_bitbake(configParams, configuration, extrafeatures=None,
> setup_logging=True):
>      # Ensure logging messages get sent to the UI as events
>      handler = bb.event.LogHandler()
> -    if setup_logging and not configParams.status_only:
> -        # In status only mode there are no logs and no UI
> -        logger.addHandler(handler)
> +    logger.addHandler(handler)
>  
>      # Clear away any spurious environment variables while we stoke
> up the cooker
>      cleanedvars = bb.utils.clean_environment()

The patch doesn't seem to apply, there is no setup_logging parameter on
master?

Cheers,

Richard

