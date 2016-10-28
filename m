Return-Path: <joshua.g.lock@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id B7D7E60750
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Oct 2016 09:27:59 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga103.jf.intel.com with ESMTP; 28 Oct 2016 02:28:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,557,1473145200"; d="scan'208";a="895032736"
Received: from jlock-mobl1.ger.corp.intel.com ([10.252.24.131])
	by orsmga003.jf.intel.com with ESMTP; 28 Oct 2016 02:27:59 -0700
Message-ID: <1477646878.3717.83.camel@linux.intel.com>
From: Joshua Lock <joshua.g.lock@linux.intel.com>
To: Olaf Mandel <o.mandel@menlosystems.com>, 
	bitbake-devel@lists.openembedded.org
Date: Fri, 28 Oct 2016 10:27:58 +0100
In-Reply-To: <1477586197-29398-1-git-send-email-o.mandel@menlosystems.com>
References: <1477586197-29398-1-git-send-email-o.mandel@menlosystems.com>
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Subject: Re: [PATCH] toasterui.py: warn if buildstats is missing
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
X-List-Received-Date: Fri, 28 Oct 2016 09:28:01 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Thu, 2016-10-27 at 16:36 +0000, Olaf Mandel wrote:
> Like for buildhistory and INHERIT, warn if buildstats is missing
> from USER_CLASSES.
> 
> Signed-off-by: Olaf Mandel <o.mandel@menlosystems.com>
> ---
>  lib/bb/ui/toasterui.py | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/lib/bb/ui/toasterui.py b/lib/bb/ui/toasterui.py
> index 9808f6b..2687faf 100644
> --- a/lib/bb/ui/toasterui.py
> +++ b/lib/bb/ui/toasterui.py
> @@ -168,6 +168,11 @@ def main(server, eventHandler, params):
>          logger.warning("buildhistory is not enabled. Please enable
> INHERIT += \"buildhistory\" to see image details.")
>          build_history_enabled = False
>  
> +    userclasseslist, _ = server.runCommand(["getVariable",
> "USER_CLASSES"])
> +
> +    if not "buildstats" in userclasseslist.split(" "):
> +        logger.warning("buildstats is not enabled. Please enable
> USER_CLASSES += \"buildstats\" to generate build statistics.")

As USER_CLASSES is an intermediate variable whose value becomes part of
the INHERIT assignment it'd be better to check whether buildstats is in
INHERIT, rather than USER_CLASSES. 

This should better handle configurations which include buildstats in a
different manner.

> +
>      if not params.observe_only:
>          params.updateFromServer(server)
>          params.updateToServer(server, os.environ.copy())
> -- 
> 2.1.4
> 

