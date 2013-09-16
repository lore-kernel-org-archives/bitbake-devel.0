Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 666586C7A7
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Sep 2013 12:21:57 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8GCZuXb010439; Mon, 16 Sep 2013 13:35:56 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id zV1UkScCnoBH; Mon, 16 Sep 2013 13:35:56 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8GCZrlh010430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Mon, 16 Sep 2013 13:35:54 +0100
Message-ID: <1379334098.3484.292.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alex DAMIAN <alexandru.damian@intel.com>
Date: Mon, 16 Sep 2013 13:21:38 +0100
In-Reply-To: <b26fb58fcbdece4c7f36407045c1100a0d3fd8fb.1379332511.git.alexandru.damian@intel.com>
References: <cover.1379332511.git.alexandru.damian@intel.com>
	<3a7c387d904ea3ea0ad4e493b95bf456a7b10c24.1379332511.git.alexandru.damian@intel.com>
	<b26fb58fcbdece4c7f36407045c1100a0d3fd8fb.1379332511.git.alexandru.damian@intel.com>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 6/8] bitbake: cooker, command: add a command to return global data
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
X-List-Received-Date: Mon, 16 Sep 2013 12:21:59 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2013-09-16 at 12:56 +0100, Alex DAMIAN wrote:
> From: Alexandru DAMIAN <alexandru.damian@intel.com>
> 
> Adding the 'getDataDump' read-only command that will
> return a dump of the global data state.
> 
> This will be used by UI clients to get the build configuration.
> 
> Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
> ---
>  bitbake/lib/bb/command.py |  8 ++++++++
>  bitbake/lib/bb/cooker.py  | 15 +++++++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
> index f1abaf7..84136f1 100644
> --- a/bitbake/lib/bb/command.py
> +++ b/bitbake/lib/bb/command.py
> @@ -145,6 +145,14 @@ class CommandsSync:
>          """
>          command.cooker.shutdown(True)
>  
> +    def getDataDump(self, command, params):
> +        """
> +        Returns a dump of the global state. Call with
> +        variable flags to be retrieved as params.
> +        """
> +        return command.cooker.getGlobalExpandedData(params)

To be blunt, this *sucks* as an API call. "getDataDump" tells me nothing
about what it does. "getGlobalExpandedData" doesn't do much better.

"getAllKeyFlags"?

and please pass in a list as param[0] so there is a:

flaglist = params[0]

in there. This means we can add other parameters if we ever need to and
we don't have complete lock in to the API.

Cheers,

Richard



