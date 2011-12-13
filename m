Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1RaVTv-0001o9-0G
	for bitbake-devel@lists.openembedded.org;
	Tue, 13 Dec 2011 17:45:31 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 13 Dec 2011 08:38:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="101726412"
Received: from unknown (HELO [10.255.12.215]) ([10.255.12.215])
	by fmsmga002.fm.intel.com with ESMTP; 13 Dec 2011 08:38:34 -0800
Message-ID: <4EE77F8A.5030900@linux.intel.com>
Date: Tue, 13 Dec 2011 08:38:34 -0800
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:8.0) Gecko/20111115 Thunderbird/8.0
MIME-Version: 1.0
To: bitbake-devel@lists.openembedded.org
References: <cover.1323656120.git.dongxiao.xu@intel.com>
	<5e6bb33f07469e4ee3925104c8ee4e3036a3cee4.1323656120.git.dongxiao.xu@intel.com>
In-Reply-To: <5e6bb33f07469e4ee3925104c8ee4e3036a3cee4.1323656120.git.dongxiao.xu@intel.com>
Subject: Re: [PATCH 05/10] command.py: add parseConfigurationFiles API
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
X-List-Received-Date: Tue, 13 Dec 2011 16:45:31 -0000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 11/12/11 18:20, Dongxiao Xu wrote:
> The parseConfigurationFiles API calls the related function in
> cooker.py to parse config files.
> 
> Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
> ---
>  lib/bb/command.py |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/lib/bb/command.py b/lib/bb/command.py
> index 701b286..6b4a598 100644
> --- a/lib/bb/command.py
> +++ b/lib/bb/command.py
> @@ -326,3 +326,13 @@ class CommandsAsync:
>          else:
>              command.finishAsyncCommand()
>      compareRevisions.needcache = True
> +
> +    def parseConfigurationFiles(self, command, params):
> +        """
> +        Parse the configuration files
> +        """
> +        prefiles = params[0]
> +        postfiles = params[1]

Should we be able to use this method without having prefiles and
postfiles set in the params container?

A common pattern throughout this module is to check the size of the
params container [using len(params)] and set appropriate (empty)
defaults if all required parameters aren't passed.

Cheers,
Joshua
-- 
Joshua Lock
        Yocto Project "Johannes factotum"
        Intel Open Source Technology Centre


