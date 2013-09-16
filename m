Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id BFAF5605F2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Sep 2013 12:14:31 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8GCSV2i010302; Mon, 16 Sep 2013 13:28:31 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id cuwHd5geA_B9; Mon, 16 Sep 2013 13:28:31 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	r8GCSOh7010294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT); Mon, 16 Sep 2013 13:28:26 +0100
Message-ID: <1379333649.3484.286.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Alex DAMIAN <alexandru.damian@intel.com>
Date: Mon, 16 Sep 2013 13:14:09 +0100
In-Reply-To: <a5db8806dc326f93d8e0bb36ff1c7b83d1d77e6a.1379332511.git.alexandru.damian@intel.com>
References: <cover.1379332511.git.alexandru.damian@intel.com>
	<3a7c387d904ea3ea0ad4e493b95bf456a7b10c24.1379332511.git.alexandru.damian@intel.com>
	<a5db8806dc326f93d8e0bb36ff1c7b83d1d77e6a.1379332511.git.alexandru.damian@intel.com>
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 5/8] bitbake: build: add logfile path for all Task events
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
X-List-Received-Date: Mon, 16 Sep 2013 12:14:33 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2013-09-16 at 12:56 +0100, Alex DAMIAN wrote:
> From: Alexandru DAMIAN <alexandru.damian@intel.com>
> 
> We add the path to the logfile for all Task events, so
> that we can record the logfile locations during the run.
> 
> This is needed because the logfile symlinks will point
> only to the last build logs, and there is no other link
> between a certain build and the log file it produces.
> 
> Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
> ---
>  bitbake/lib/bb/build.py | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

a) you might as well modify TaskBase intead of each Task 
b) You didn't fix up all the original Task* references e.g. TaskInvalid.

I gave up and merged my own version of this.

Cheers,

Richard
 


