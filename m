Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 760FF65D03
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Jul 2014 07:36:41 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s647abCs021859; Fri, 4 Jul 2014 08:36:37 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id fHmLe1gTVa_Y; Fri,  4 Jul 2014 08:36:37 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s647aVZr021847
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 4 Jul 2014 08:36:33 +0100
Message-ID: <1404459386.6362.94.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>
Date: Fri, 04 Jul 2014 08:36:26 +0100
In-Reply-To: <c16e5647966901f79b9520ba0565220ebcd0fa3d.1404452300.git.liezhi.yang@windriver.com>
References: <cover.1404452300.git.liezhi.yang@windriver.com>
	<c16e5647966901f79b9520ba0565220ebcd0fa3d.1404452300.git.liezhi.yang@windriver.com>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/2] bitbake: update help message for dump-signatures
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
X-List-Received-Date: Fri, 04 Jul 2014 07:36:45 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2014-07-03 at 22:39 -0700, Robert Yang wrote:
> The bitbake -S had been updated which always reuires an argument, so
> update the help info:
> - Add the two args in the help message: none and printdiff
> 
> - Use type="choice" so that we can get more friendly error messages,
>   for example:
>   bitbake: error: option -S: invalid choice: 'printdiffX' (choose from 'none', 'printdiff')
> 
> - dump-signatures=DUMP_SIGNATURES -> dump-signatures=SIGNATURE_HANDLER
> 
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
>  bitbake/bin/bitbake |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/bitbake/bin/bitbake b/bitbake/bin/bitbake
> index b3acbe1..5c25a9d 100755
> --- a/bitbake/bin/bitbake
> +++ b/bitbake/bin/bitbake
> @@ -139,8 +139,8 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
>          parser.add_option("-n", "--dry-run", help = "Don't execute, just go through the motions.",
>                     action = "store_true", dest = "dry_run", default = False)
>  
> -        parser.add_option("-S", "--dump-signatures", help = "Dump out the signature construction information, with no task execution. Parameters are passed to the signature handling code, use 'none' if no specific handler is required.",
> -                   action = "append", dest = "dump_signatures", default = [])
> +        parser.add_option("-S", "--dump-signatures", help = "Dump out the signature construction information, with no task execution. The SIGNATURE_HANDLER can be none or printdiff, while none means only dump the signature, printdiff means compare the dumped signature with the cached one.",
> +                   action = "append", dest = "dump_signatures", default = [], type="choice", choices=("none", "printdiff"), metavar="SIGNATURE_HANDLER")

The problem here is the different options are (or will be) metadata
defined and bitbake can't know which options may or may not be valid :(

Cheers,

Richard


