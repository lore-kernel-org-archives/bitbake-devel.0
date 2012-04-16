Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <mark.hatle@windriver.com>) id 1SJumY-0007sJ-Jq
	for bitbake-devel@lists.openembedded.org;
	Tue, 17 Apr 2012 00:52:26 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q3GMh02h011885
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Apr 2012 15:43:00 -0700 (PDT)
Received: from msp-dhcp23.wrs.com (172.25.34.23) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Mon, 16 Apr 2012 15:42:42 -0700
Message-ID: <4F8CA062.4030202@windriver.com>
Date: Mon, 16 Apr 2012 17:42:42 -0500
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6;
	rv:11.0) Gecko/20120327 Thunderbird/11.0.1
MIME-Version: 1.0
To: <bitbake-devel@lists.openembedded.org>
References: <1334615518-6809-1-git-send-email-paul.eggleton@linux.intel.com>
In-Reply-To: <1334615518-6809-1-git-send-email-paul.eggleton@linux.intel.com>
Subject: Re: [PATCH] bitbake-layers: hide deprecation warnings
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 16 Apr 2012 22:52:27 -0000
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

On 4/16/12 5:31 PM, Paul Eggleton wrote:
> There are a number of DeprecationWarnings within BitBake code which
> bitbake itself filters out; bitbake-layers was not doing this, resulting
> in a stream of warnings printed out when used with Python<  2.7 (these
> warnings default to disabled on version 2.7 and above.)
>
> Signed-off-by: Paul Eggleton<paul.eggleton@linux.intel.com>

Verified this fix on CentOS 6.2

Tested-by: Mark Hatle <mark.hatle@windriver.com>

> ---
>   bin/bitbake-layers |    2 ++
>   1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/bin/bitbake-layers b/bin/bitbake-layers
> index bbd56fe..6d35386 100755
> --- a/bin/bitbake-layers
> +++ b/bin/bitbake-layers
> @@ -9,6 +9,7 @@
>
>   import cmd
>   import logging
> +import warnings
>   import os
>   import sys
>   import fnmatch
> @@ -28,6 +29,7 @@ import bb.fetch2
>
>   logger = logging.getLogger('BitBake')
>
> +warnings.filterwarnings("ignore", category=DeprecationWarning)
>
>   def main(args):
>       # Set up logging



